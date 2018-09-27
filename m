Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2DFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07F52159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07F52159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeI1Dur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeI1Dur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:50:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EE843086249;
        Thu, 27 Sep 2018 21:30:30 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-200-20.brq.redhat.com [10.40.200.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DAC3600C5;
        Thu, 27 Sep 2018 21:30:28 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     syzbot+001516d86dbe88862cec@syzkaller.appspotmail.com,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in __dev_mc_add
Date:   Thu, 27 Sep 2018 23:30:26 +0200
Message-Id: <20180927213026.16863-1-vdronov@redhat.com>
In-Reply-To: <0000000000005e2e530576c6f9ce@google.com>
References: <0000000000005e2e530576c6f9ce@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.14.4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 27 Sep 2018 21:30:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2.14.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

Hello,

This report is actually for the same bug which was reported in:

https://syzkaller.appspot.com/bug?id=088efeac32fdde781038a777a63e436c0d4d7036

The note there that the bug was fixed by "Commits: net: fix uninit-value in
__hw_addr_add_ex()" is wrong. A C-reproducer from the 2nd syzkaller report
can trigger the bug from this one.

I've researched this and a result is a proposed patch, the problem is the tun
device code allowing to set an arbitrary link type.

https://lkml.org/lkml/2018/9/26/416
https://lore.kernel.org/lkml/20180926093018.6646-1-vdronov@redhat.com/T/#u
https://marc.info/?l=linux-netdev&m=153795423320016&w=2

A simplified reproducer is attached.

Best regards,
Vladis Dronov

--------------2.14.4
Content-Type: text/plain; name="kmsan-hw_addr_add_ex.c"; charset=UTF-8;
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="kmsan-hw_addr_add_ex.c"

#define _GNU_SOURCE
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/futex.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <unistd.h>

#include <errno.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
  int ret, sockfd, tunfd;

  syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);

  // socket(AF_PACKET, SOCK_DGRAM|SOCK_NONBLOCK, 0)
  sockfd = syscall(__NR_socket, 0x11, 0x100000802, 0);
  if (sockfd < 0) {
    perror("socket()");
    ret = 1;
    goto exit_end;
  }

  memcpy((void*)0x20000240, "/dev/net/tun", 13);
  tunfd = open((char *)0x20000240, 0);
  if (tunfd < 0) {
    perror("open()");
    ret = 2;
    goto exit_sock_close;
  }

  memcpy((void*)0x200000c0, "\x69\x67\x62\x30\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", 16);
  *(uint16_t*)0x200000d0 = 0x4012;
  ret = syscall(__NR_ioctl, tunfd, 0x400454ca, 0x200000c0); // TUNSETIFF _IOW('T', 202, int)
  if (ret < 0) {
    perror("ioctl(TUNSETIFF)");
    ret = 3;
    goto exit_tun_close;
  }

  // TUNSETLINK _IOW('T', 205, int) / 0x30a = 778 = ARPHRD_IPGRE
  if (argc < 2)
    ret = syscall(__NR_ioctl, tunfd, 0x400454cd, 0x30a);
  else
    ret = syscall(__NR_ioctl, tunfd, 0x400454cd, atoi(argv[1]));
  if (ret < 0) {
    perror("ioctl(TUNSETLINK)");
    ret = 4;
    goto exit_tun_close;
  }

  memcpy((void*)0x20000040, "\x69\x67\x62\x30\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", 16);
  *(uint16_t*)0x20000050 = 0xa201;
  ret = syscall(__NR_ioctl, sockfd, 0x8914, 0x20000040); // SIOCSIFFLAGS 0x8914
  if (ret < 0) {
    perror("ioctl(SIOCSIFFLAGS)");
    ret = 5;
    goto exit_tun_close;
  }

  printf("done:\n");
  system("/usr/sbin/ip -details link show igb0");

exit_tun_close:
  close(tunfd);
exit_sock_close:
  close(sockfd);
exit_end:
  munmap((void *)0x20000000, 0x1000000);
  return 0;
}
--------------2.14.4--
