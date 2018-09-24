Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455BEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16E820684
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16E820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbeIXScK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:32:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbeIXScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:32:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 496E11098;
        Mon, 24 Sep 2018 12:30:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Maynard Johnson <maynard@us.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 060/235] perf powerpc: Fix callchain ip filtering
Date:   Mon, 24 Sep 2018 13:50:46 +0200
Message-Id: <20180924113111.050137565@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan@linux.ibm.com>

[ Upstream commit c715fcfda5a08edabaa15508742be926b7ee51db ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -250,7 +250,7 @@ int arch_skip_callchain_idx(struct threa
 	if (!chain || chain->nr < 3)
 		return skip_slot;
 
-	ip = chain->ips[2];
+	ip = chain->ips[1];
 
 	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 


