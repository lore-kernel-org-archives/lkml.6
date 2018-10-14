Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F5C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877E120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877E120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeJNXTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:19:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36780 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbeJNXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:19:41 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLx-0004cZ-Dn; Sun, 14 Oct 2018 16:30:49 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000PW-Rd; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Jann Horn" <jannh@google.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.767160924@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 199/366] tcp: don't read out-of-bounds opsize
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 7e5a206ab686f098367b61aca989f5cdfa8114a3 upstream.

The old code reads the "opsize" variable from out-of-bounds memory (first
byte behind the segment) if a broken TCP segment ends directly after an
opcode that is neither EOL nor NOP.

The result of the read isn't used for anything, so the worst thing that
could theoretically happen is a pagefault; and since the physmap is usually
mostly contiguous, even that seems pretty unlikely.

The following C reproducer triggers the uninitialized read - however, you
can't actually see anything happen unless you put something like a
pr_warn() in tcp_parse_md5sig_option() to print the opsize.

====================================
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <stdlib.h>
#include <errno.h>
#include <stdarg.h>
#include <net/if.h>
#include <linux/if.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/in.h>
#include <linux/if_tun.h>
#include <err.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <assert.h>

void systemf(const char *command, ...) {
  char *full_command;
  va_list ap;
  va_start(ap, command);
  if (vasprintf(&full_command, command, ap) == -1)
    err(1, "vasprintf");
  va_end(ap);
  printf("systemf: <<<%s>>>\n", full_command);
  system(full_command);
}

char *devname;

int tun_alloc(char *name) {
  int fd = open("/dev/net/tun", O_RDWR);
  if (fd == -1)
    err(1, "open tun dev");
  static struct ifreq req = { .ifr_flags = IFF_TUN|IFF_NO_PI };
  strcpy(req.ifr_name, name);
  if (ioctl(fd, TUNSETIFF, &req))
    err(1, "TUNSETIFF");
  devname = req.ifr_name;
  printf("device name: %s\n", devname);
  return fd;
}

#define IPADDR(a,b,c,d) (((a)<<0)+((b)<<8)+((c)<<16)+((d)<<24))

void sum_accumulate(unsigned int *sum, void *data, int len) {
  assert((len&2)==0);
  for (int i=0; i<len/2; i++) {
    *sum += ntohs(((unsigned short *)data)[i]);
  }
}

unsigned short sum_final(unsigned int sum) {
  sum = (sum >> 16) + (sum & 0xffff);
  sum = (sum >> 16) + (sum & 0xffff);
  return htons(~sum);
}

void fix_ip_sum(struct iphdr *ip) {
  unsigned int sum = 0;
  sum_accumulate(&sum, ip, sizeof(*ip));
  ip->check = sum_final(sum);
}

void fix_tcp_sum(struct iphdr *ip, struct tcphdr *tcp) {
  unsigned int sum = 0;
  struct {
    unsigned int saddr;
    unsigned int daddr;
    unsigned char pad;
    unsigned char proto_num;
    unsigned short tcp_len;
  } fakehdr = {
    .saddr = ip->saddr,
    .daddr = ip->daddr,
    .proto_num = ip->protocol,
    .tcp_len = htons(ntohs(ip->tot_len) - ip->ihl*4)
  };
  sum_accumulate(&sum, &fakehdr, sizeof(fakehdr));
  sum_accumulate(&sum, tcp, tcp->doff*4);
  tcp->check = sum_final(sum);
}

int main(void) {
  int tun_fd = tun_alloc("inject_dev%d");
  systemf("ip link set %s up", devname);
  systemf("ip addr add 192.168.42.1/24 dev %s", devname);

  struct {
    struct iphdr ip;
    struct tcphdr tcp;
    unsigned char tcp_opts[20];
  } __attribute__((packed)) syn_packet = {
    .ip = {
      .ihl = sizeof(struct iphdr)/4,
      .version = 4,
      .tot_len = htons(sizeof(syn_packet)),
      .ttl = 30,
      .protocol = IPPROTO_TCP,
      /* FIXUP check */
      .saddr = IPADDR(192,168,42,2),
      .daddr = IPADDR(192,168,42,1)
    },
    .tcp = {
      .source = htons(1),
      .dest = htons(1337),
      .seq = 0x12345678,
      .doff = (sizeof(syn_packet.tcp)+sizeof(syn_packet.tcp_opts))/4,
      .syn = 1,
      .window = htons(64),
      .check = 0 /*FIXUP*/
    },
    .tcp_opts = {
      /* INVALID: trailing MD5SIG opcode after NOPs */
      1, 1, 1, 1, 1,
      1, 1, 1, 1, 1,
      1, 1, 1, 1, 1,
      1, 1, 1, 1, 19
    }
  };
  fix_ip_sum(&syn_packet.ip);
  fix_tcp_sum(&syn_packet.ip, &syn_packet.tcp);
  while (1) {
    int write_res = write(tun_fd, &syn_packet, sizeof(syn_packet));
    if (write_res != sizeof(syn_packet))
      err(1, "packet write failed");
  }
}
====================================

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/tcp_input.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3675,11 +3675,8 @@ const u8 *tcp_parse_md5sig_option(const
 	int length = (th->doff << 2) - sizeof(*th);
 	const u8 *ptr = (const u8 *)(th + 1);
 
-	/* If the TCP option is too short, we can short cut */
-	if (length < TCPOLEN_MD5SIG)
-		return NULL;
-
-	while (length > 0) {
+	/* If not enough data remaining, we can short cut */
+	while (length >= TCPOLEN_MD5SIG) {
 		int opcode = *ptr++;
 		int opsize;
 

