Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbeDTN6X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:58:23 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:55853 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDTN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:58:18 -0400
X-Google-Smtp-Source: AIpwx49LWnabJOjhYGeMqNMkVuwUteiq7KSfLqCAcihFLtiHbPQkelgJD9cERie4HaCSlowJGqGTVHx8Nw==
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 15:57:30 +0200
Message-Id: <20180420135730.44921-1-jannh@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH net] tcp: don't read out-of-bounds opsize
From: Jann Horn <jannh@google.com>
To: davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 net/ipv4/tcp_input.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 367def6ddeda..e51c644484dc 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3868,11 +3868,8 @@ const u8 *tcp_parse_md5sig_option(const struct tcphdr *th)
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
 
-- 
2.17.0.484.g0c8726318c-goog
