Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqRaCczTVKPSmwfxMsBBxAhHTQSipbrf90+flmSl33sTB6q+HKJQpnIzkS9h1EA5GFMk9Qh
ARC-Seal: i=1; a=rsa-sha256; t=1524837942; cv=none;
        d=google.com; s=arc-20160816;
        b=fcErcDSRexerRDg7r1zsqJplKSumaCOJAy59LbU5QpV+QINY3Es254JLhe5HRM6WvO
         II7fO5okQjZus+B0EauL1cVnUqHBoDAr9ZUEo+EX3MGfQlsSB90SsqhJoDtMQdCzwcck
         ROhZj0YOiC3F1v2OyfwykPAkn5zQt6cr1/aerDkOKhagW+8+DC1tipr4ke7jJVlHHu13
         NTXYyEnx6B6+D5UKo8WfPqVIobeK6nnpV++iKLL3KWz/Sky5veG91eVf5jy36wKH8FK3
         2srJnbfc4SvD/L3ImV8GEm9qzVLeiUGWqWUIl1oWbvVry5IG93nhcycahSDfYBCnkg4j
         mzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=LvxbVAX/1PmarsGSnTtHfzo4pqynewlAkzT2ZsjzuyE=;
        b=VrwRCxKVS5TXbatEWK/FiyybVD8b2+LX1KbRbQYs/vVqxzuo4ASCTc3Iou3Pyv/SeK
         YeLjWMkvJkcwtes6d1AUQgtJy4H9hSHK4fRbmsM4nIVyhHBh5tBPXPHRpqJTIYdOBIxa
         SFdwbWNoMOLIC3zqiAJNF+VcWmdDbTQptVuBRA3DM1+49MXX78p60pT8sKfGzHyyFvkS
         CNd1e2ArR9PE22f/5NrwI+roV/YnfNai72z/YE/ZRDMQgKDBgMpHLszyOWbIutH8qqyB
         8ZAEPHjnPo1UkAehhEuKBTTxMciRb21sxCynkTjqr17bgplGE0jYZQmShtM7RuVeRoy5
         UrkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A422189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 52/74] tcp: dont read out-of-bounds opsize
Date: Fri, 27 Apr 2018 15:58:42 +0200
Message-Id: <20180427135712.092695177@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908011900849864?=
X-GMAIL-MSGID: =?utf-8?q?1598908469741473909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>


[ Upstream commit 7e5a206ab686f098367b61aca989f5cdfa8114a3 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3943,11 +3943,8 @@ const u8 *tcp_parse_md5sig_option(const
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
 
