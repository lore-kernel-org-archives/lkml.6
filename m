Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37DDC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773BB20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773BB20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbeGYV6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:58:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37665 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbeGYV6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:58:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKj6QX500669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:45:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKj6Nn500666;
        Wed, 25 Jul 2018 13:45:06 -0700
Date:   Wed, 25 Jul 2018 13:45:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-c715fcfda5a08edabaa15508742be926b7ee51db@git.kernel.org>
Cc:     sandipan@linux.ibm.com, tglx@linutronix.de, hpa@zytor.com,
        ravi.bangoria@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com,
        mingo@kernel.org, jolsa@redhat.com, maynard@us.ibm.com,
        acme@redhat.com
Reply-To: naveen.n.rao@linux.vnet.ibm.com, hpa@zytor.com,
          ravi.bangoria@linux.vnet.ibm.com, sandipan@linux.ibm.com,
          tglx@linutronix.de, acme@redhat.com, maynard@us.ibm.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          sukadev@linux.vnet.ibm.com
In-Reply-To: <24bb726d91ed173aebc972ec3f41a2ef2249434e.1530724939.git.sandipan@linux.ibm.com>
References: <24bb726d91ed173aebc972ec3f41a2ef2249434e.1530724939.git.sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf powerpc: Fix callchain ip filtering
Git-Commit-ID: c715fcfda5a08edabaa15508742be926b7ee51db
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c715fcfda5a08edabaa15508742be926b7ee51db
Gitweb:     https://git.kernel.org/tip/c715fcfda5a08edabaa15508742be926b7ee51db
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Tue, 10 Jul 2018 19:28:13 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:50:10 -0300

perf powerpc: Fix callchain ip filtering

For powerpc64, redundant entries in the callchain are filtered out by
determining the state of the return address and the stack frame using
DWARF debug information.

For making these filtering decisions we must analyze the debug
information for the location corresponding to the program counter value,
i.e. the first entry in the callchain, and not the LR value; otherwise,
perf may filter out either the second or the third entry in the
callchain incorrectly.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

Case 1 - Attaching a probe at inet_pton+0x8 (binary offset 0x15af28).
         Return address is still in LR and a new stack frame is not yet
         allocated. The LR value, i.e. the second entry, should not be
	 filtered out.

  # objdump -d /usr/lib64/libc-2.26.so | less
  ...
  000000000010eb10 <gaih_inet.constprop.7>:
  ...
    10fa48:       78 bb e4 7e     mr      r4,r23
    10fa4c:       0a 00 60 38     li      r3,10
    10fa50:       d9 b4 04 48     bl      15af28 <inet_pton+0x8>
    10fa54:       00 00 00 60     nop
    10fa58:       ac f4 ff 4b     b       10ef04 <gaih_inet.constprop.7+0x3f4>
  ...
  0000000000110450 <getaddrinfo>:
  ...
    1105a8:       54 00 ff 38     addi    r7,r31,84
    1105ac:       58 00 df 38     addi    r6,r31,88
    1105b0:       69 e5 ff 4b     bl      10eb18 <gaih_inet.constprop.7+0x8>
    1105b4:       78 1b 71 7c     mr      r17,r3
    1105b8:       50 01 7f e8     ld      r3,336(r31)
  ...
  000000000015af20 <inet_pton>:
    15af20:       0b 00 4c 3c     addis   r2,r12,11
    15af24:       e0 c1 42 38     addi    r2,r2,-15904
    15af28:       a6 02 08 7c     mflr    r0
    15af2c:       f0 ff c1 fb     std     r30,-16(r1)
    15af30:       f8 ff e1 fb     std     r31,-8(r1)
  ...

  # perf probe -x /usr/lib64/libc-2.26.so -a inet_pton+0x8
  # perf record -e probe_libc:inet_pton -g ping -6 -c 1 ::1
  # perf script

Before:

  ping  4507 [002] 514985.546540: probe_libc:inet_pton: (7fffa7dbaf28)
              7fffa7dbaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
              7fffa7d705b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
                 13fb52d70 _init+0xbfc (/usr/bin/ping)
              7fffa7c836a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc-2.26.so)
              7fffa7c83898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

After:

  ping  4507 [002] 514985.546540: probe_libc:inet_pton: (7fffa7dbaf28)
              7fffa7dbaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
              7fffa7d6fa54 gaih_inet.constprop.7+0xf44 (/usr/lib64/libc-2.26.so)
              7fffa7d705b4 getaddrinfo+0x164 (/usr/lib64/libc-2.26.so)
                 13fb52d70 _init+0xbfc (/usr/bin/ping)
              7fffa7c836a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc-2.26.so)
              7fffa7c83898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

Case 2 - Attaching a probe at _int_malloc+0x180 (binary offset 0x9cf10).
         Return address in still in LR and a new stack frame has already
         been allocated but not used. The caller's caller, i.e. the third
	 entry, is invalid and should be filtered out and not the second
	 one.

  # objdump -d /usr/lib64/libc-2.26.so | less
  ...
  000000000009cd90 <_int_malloc>:
     9cd90:       17 00 4c 3c     addis   r2,r12,23
     9cd94:       70 a3 42 38     addi    r2,r2,-23696
     9cd98:       26 00 80 7d     mfcr    r12
     9cd9c:       f8 ff e1 fb     std     r31,-8(r1)
     9cda0:       17 00 e4 3b     addi    r31,r4,23
     9cda4:       d8 ff 61 fb     std     r27,-40(r1)
     9cda8:       78 23 9b 7c     mr      r27,r4
     9cdac:       1f 00 bf 2b     cmpldi  cr7,r31,31
     9cdb0:       f0 ff c1 fb     std     r30,-16(r1)
     9cdb4:       b0 ff c1 fa     std     r22,-80(r1)
     9cdb8:       78 1b 7e 7c     mr      r30,r3
     9cdbc:       08 00 81 91     stw     r12,8(r1)
     9cdc0:       11 ff 21 f8     stdu    r1,-240(r1)
     9cdc4:       4c 01 9d 41     bgt     cr7,9cf10 <_int_malloc+0x180>
     9cdc8:       20 00 a4 2b     cmpldi  cr7,r4,32
  ...
     9cf08:       00 00 00 60     nop
     9cf0c:       00 00 42 60     ori     r2,r2,0
     9cf10:       e4 06 ff 7b     rldicr  r31,r31,0,59
     9cf14:       40 f8 a4 7f     cmpld   cr7,r4,r31
     9cf18:       68 05 9d 41     bgt     cr7,9d480 <_int_malloc+0x6f0>
  ...
  000000000009e3c0 <tcache_init.part.4>:
  ...
     9e420:       40 02 80 38     li      r4,576
     9e424:       78 fb e3 7f     mr      r3,r31
     9e428:       71 e9 ff 4b     bl      9cd98 <_int_malloc+0x8>
     9e42c:       00 00 a3 2f     cmpdi   cr7,r3,0
     9e430:       78 1b 7e 7c     mr      r30,r3
  ...
  000000000009f7a0 <__libc_malloc>:
  ...
     9f8f8:       00 00 89 2f     cmpwi   cr7,r9,0
     9f8fc:       1c ff 9e 40     bne     cr7,9f818 <__libc_malloc+0x78>
     9f900:       c9 ea ff 4b     bl      9e3c8 <tcache_init.part.4+0x8>
     9f904:       00 00 00 60     nop
     9f908:       e8 90 22 e9     ld      r9,-28440(r2)
  ...

  # perf probe -x /usr/lib64/libc-2.26.so -a _int_malloc+0x180
  # perf record -e probe_libc:_int_malloc -g ./test-malloc
  # perf script

Before:

  test-malloc  6554 [009] 515975.797403: probe_libc:_int_malloc: (7fffa6e6cf10)
              7fffa6e6cf10 _int_malloc+0x180 (/usr/lib64/libc-2.26.so)
              7fffa6dd0000 [unknown] (/usr/lib64/libc-2.26.so)
              7fffa6e6f904 malloc+0x164 (/usr/lib64/libc-2.26.so)
              7fffa6e6f9fc malloc+0x25c (/usr/lib64/libc-2.26.so)
                  100006b4 main+0x38 (/home/testuser/test-malloc)
              7fffa6df36a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc-2.26.so)
              7fffa6df3898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

After:

  test-malloc  6554 [009] 515975.797403: probe_libc:_int_malloc: (7fffa6e6cf10)
              7fffa6e6cf10 _int_malloc+0x180 (/usr/lib64/libc-2.26.so)
              7fffa6e6e42c tcache_init.part.4+0x6c (/usr/lib64/libc-2.26.so)
              7fffa6e6f904 malloc+0x164 (/usr/lib64/libc-2.26.so)
              7fffa6e6f9fc malloc+0x25c (/usr/lib64/libc-2.26.so)
                  100006b4 main+0x38 (/home/sandipan/test-malloc)
              7fffa6df36a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc-2.26.so)
              7fffa6df3898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Maynard Johnson <maynard@us.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Fixes: a60335ba3298 ("perf tools powerpc: Adjust callchain based on DWARF debug info")
Link: http://lkml.kernel.org/r/24bb726d91ed173aebc972ec3f41a2ef2249434e.1530724939.git.sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index ef5d59a5742e..264fc0158100 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -246,7 +246,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	if (!chain || chain->nr < 3)
 		return skip_slot;
 
-	ip = chain->ips[2];
+	ip = chain->ips[1];
 
 	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 
