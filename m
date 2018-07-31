Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E0CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4D9208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4D9208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbeGaQww convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:52:52 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:54034 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeGaQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:52:51 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2018 12:52:49 EDT
Received: from [192.168.20.11] (port=34915 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1fkWDu-0005kN-29; Tue, 31 Jul 2018 17:06:06 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Tue, 31 Jul
 2018 17:06:06 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Tue, 31 Jul 2018 17:06:06 +0200
From:   Marcel Hellwig <mhellwig@mut-group.com>
To:     "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzg==
Date:   Tue, 31 Jul 2018 15:06:06 +0000
Message-ID: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.21.69]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

we are facing a problem the UDP Stack in our embedded device based on a LPC3250.

We discovered the bug the first place in the 2.6.39.2 kernel provided by lpc[0].
We tried different newer versions of the kernel until 3.4.113 and the error still occurs.
Newer versions of the kernel have not been tested (yet).

We have a simple program that listens on a multicast address and uses select to query the socket.
We read the data, validate it and process it further (put it into some shared memory via shm_open).
The bandwidth of the traffic is approximately 100Mbit/s.

We tried to debug the error with gdb and printfs, but all the pointer in the relevant section looked sane and a printf of the values did not trigger a panic.
The bug occurs after approximately 15 minutes under high network load, but cannot be triggered reliably. 

We found two relevant topics [1][2], but the first one didn't helped and the second one has no answer, but looks promising. 

Because this bug affects a lot of our products, we want to develop an intermediate patch, but we need some help to locate the error.
In the long term we want to migrate to a newer kernel, but at the moment we need this fix for our customers.

Can anybody help us to spot out the error so that we can develop a patch for this problem?
Perhaps this is a known issue and a solution is already available.



Further information:
https://gist.github.com/hellow554/6b11c6c0827d5db80a7e66f71f5636ff

/proc/version:
Linux version 3.4.113.7 (buildroot@buildroot) (gcc version 4.9.4 (Buildroot 2018.02.1) ) #1 PREEMPT Mon Apr 9 23:40:00 CEST 2018

Kernel oops:
[ 1125.090000] Unable to handle kernel paging request at virtual address c14fe63a
[ 1125.100000] pgd = c14d8000
[ 1125.100000] [c14fe63a] *pgd=8140041e(bad)
[ 1125.100000] Internal error: Oops: 1 [#1] PREEMPT ARM
[ 1125.100000] Modules linked in:
[ 1125.100000] CPU: 0    Not tainted  (3.4.113.7 #1)
[ 1125.100000] PC is at udp_recvmsg+0x284/0x33c
[ 1125.100000] LR is at 0x0
[ 1125.100000] pc : [<c0228adc>]    lr : [<00000000>]    psr: a0000013
[ 1125.100000] sp : c1e67d10  ip : 00000000  fp : 0000004a
[ 1125.100000] r10: c1e67d34  r9 : 0000004a  r8 : 00000000
[ 1125.100000] r7 : 000005c0  r6 : c1e10220  r5 : c1e67f7c  r4 : c14f4640
[ 1125.100000] r3 : c14fe62e  r2 : c1e67ec0  r1 : 00000008  r0 : c1e67ec8
[ 1125.100000] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[ 1125.100000] Control: 0005317f  Table: 814d8000  DAC: 00000015
[ 1125.100000] Process trdp.release (pid: 132, stack limit = 0xc1e66270)
[ 1125.100000] Stack: (0xc1e67d10 to 0xc1e68000)
[ 1125.100000] 7d00:                                     c1e67d34 00004348 00000001 0000004a
[ 1125.100000] 7d20: 00000000 c1e67ec0 c1e10220 00000000 00000000 00000000 c022aea4 c1e67f7c
[ 1125.100000] 7d40: 00000000 00000000 00000000 000005c0 00000000 c1e67f7c c1e67ec0 c02306e0
[ 1125.100000] 7d60: 00000000 00000000 c1e67d74 00000000 c1e10220 00000000 c1e67d90 00000000
[ 1125.100000] 7d80: c3483000 c01d2c38 00000000 00000001 00000001 00000000 00000000 000005c0
[ 1125.100000] 7da0: c3483000 c005c5d4 00000000 c1e67f7c 00000000 c03482b8 c1e66000 c1e67ee0
[ 1125.100000] 7dc0: c1e67e4c 0001424f c0345ba0 c035fca0 c035fca8 c005c6a8 00000000 00000001
[ 1125.100000] 7de0: ffffffff 00000000 00000000 00000000 00000000 00000000 c3887700 c0022608
[ 1125.100000] 7e00: 00000000 00000000 c01e59b4 00000001 c1e67d90 00000000 00000000 beca3b78
[ 1125.100000] 7e20: 00000004 00000000 00000004 c00b05b0 c1e67e48 c1e67e4c c1e67e50 00000001
[ 1125.100000] 7e40: c1e67f7c c3483000 beca35bc c1e67e80 c1e67f7c c1e67e80 c01d2b90 c3483000
[ 1125.100000] 7e60: beca35bc 00000000 c1e67e80 c01d3fac beca35d8 00000008 beca35c0 beca359c
[ 1125.100000] 7e80: b6ab34aa 00000576 00000001 c0022128 c025ce20 c1e49a80 00000009 0001424e
[ 1125.100000] 7ea0: 40008000 c1e66008 0000001d 00000000 c1e67f14 c3887700 c1e66008 0000001d
[ 1125.100000] 7ec0: b0040002 1714010a 00000000 00000000 c00189a8 00000013 f4008000 c000dbf4
[ 1125.100000] 7ee0: 81e68000 c1e49180 00000000 00000000 c1e1e000 c003c2f8 c1e1e000 00000002
[ 1125.100000] 7f00: c036092c c0346700 00000000 00000000 ffffffff 00000000 ffffffff 00000000
[ 1125.100000] 7f20: c1e67f78 c1e66000 c1e67f78 beca3cc0 00000001 beca3cc0 00000008 beca35bc
[ 1125.100000] 7f40: 00000000 c3483000 beca35bc 00000000 00000129 c000e188 c1e66000 00000000
[ 1125.100000] 7f60: beca37e0 c01d4fbc 00000000 beca3860 beca3938 00000000 fffffff7 c1e67ec0
[ 1125.100000] 7f80: 00000000 c1e67e80 00000001 beca359c 00000020 00000000 beca359c b6ab3460
[ 1125.100000] 7fa0: 00000000 c000dfe0 beca359c b6ab3460 00000004 beca35bc 00000000 00000020
[ 1125.100000] 7fc0: beca359c b6ab3460 00000000 00000129 beca37f4 00000000 00056178 beca37e0
[ 1125.100000] 7fe0: 00000004 beca33d0 0001a904 b6f6d8dc 60000010 00000004 83ffe831 83ffec31
[ 1125.100000] [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c)
[ 1125.100000] [<c02306e0>] (inet_recvmsg+0x38/0x4c) from [<c01d2c38>] (sock_recvmsg+0xa8/0xcc)
[ 1125.100000] [<c01d2c38>] (sock_recvmsg+0xa8/0xcc) from [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc)
[ 1125.100000] [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc) from [<c01d4fbc>] (__sys_recvmsg+0x50/0x80)
[ 1125.100000] [<c01d4fbc>] (__sys_recvmsg+0x50/0x80) from [<c000dfe0>] (ret_fast_syscall+0x0/0x2c)
[ 1125.100000] Code: e1d330b0 e3a01008 e1c230b2 e5943080 (e593300c)
[ 1125.430000] ---[ end trace f0b7642b14562089 ]---
[ 1125.440000] ------------[ cut here ]------------
[ 1125.450000] WARNING: at net/ipv4/af_inet.c:153 inet_sock_destruct+0x188/0x1a8()
[ 1125.460000] Modules linked in:
[ 1125.460000] [<c0013ac8>] (unwind_backtrace+0x0/0xec) from [<c001c588>] (warn_slowpath_common+0x4c/0x64)
[ 1125.470000] [<c001c588>] (warn_slowpath_common+0x4c/0x64) from [<c001c63c>] (warn_slowpath_null+0x1c/0x24)
[ 1125.480000] [<c001c63c>] (warn_slowpath_null+0x1c/0x24) from [<c0230888>] (inet_sock_destruct+0x188/0x1a8)
[ 1125.490000] [<c0230888>] (inet_sock_destruct+0x188/0x1a8) from [<c01d75f4>] (__sk_free+0x18/0x154)
[ 1125.500000] [<c01d75f4>] (__sk_free+0x18/0x154) from [<c0230aa0>] (inet_release+0x44/0x70)
[ 1125.510000] [<c0230aa0>] (inet_release+0x44/0x70) from [<c01d3714>] (sock_release+0x20/0xc8)
[ 1125.510000] [<c01d3714>] (sock_release+0x20/0xc8) from [<c01d37d0>] (sock_close+0x14/0x2c)
[ 1125.520000] [<c01d37d0>] (sock_close+0x14/0x2c) from [<c00a0044>] (fput+0xb4/0x27c)
[ 1125.530000] [<c00a0044>] (fput+0xb4/0x27c) from [<c009d64c>] (filp_close+0x64/0x88)
[ 1125.540000] [<c009d64c>] (filp_close+0x64/0x88) from [<c001fb28>] (put_files_struct+0x80/0xe0)
[ 1125.550000] [<c001fb28>] (put_files_struct+0x80/0xe0) from [<c0020388>] (do_exit+0x4c8/0x748)
[ 1125.560000] [<c0020388>] (do_exit+0x4c8/0x748) from [<c0011894>] (die+0x214/0x240)
[ 1125.560000] [<c0011894>] (die+0x214/0x240) from [<c0256160>] (__do_kernel_fault.part.0+0x54/0x74)
[ 1125.570000] [<c0256160>] (__do_kernel_fault.part.0+0x54/0x74) from [<c0015188>] (do_bad_area+0x88/0x8c)
[ 1125.580000] [<c0015188>] (do_bad_area+0x88/0x8c) from [<c00173dc>] (do_alignment+0xf0/0x938)
[ 1125.590000] [<c00173dc>] (do_alignment+0xf0/0x938) from [<c000862c>] (do_DataAbort+0x34/0x98)
[ 1125.600000] [<c000862c>] (do_DataAbort+0x34/0x98) from [<c000db98>] (__dabt_svc+0x38/0x60)
[ 1125.610000] Exception stack(0xc1e67cc8 to 0xc1e67d10)
[ 1125.610000] 7cc0:                   c1e67ec8 00000008 c1e67ec0 c14fe62e c14f4640 c1e67f7c
[ 1125.620000] 7ce0: c1e10220 000005c0 00000000 0000004a c1e67d34 0000004a 00000000 c1e67d10
[ 1125.630000] 7d00: 00000000 c0228adc a0000013 ffffffff
[ 1125.640000] [<c000db98>] (__dabt_svc+0x38/0x60) from [<c0228adc>] (udp_recvmsg+0x284/0x33c)
[ 1125.650000] [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c)
[ 1125.650000] [<c02306e0>] (inet_recvmsg+0x38/0x4c) from [<c01d2c38>] (sock_recvmsg+0xa8/0xcc)
[ 1125.660000] [<c01d2c38>] (sock_recvmsg+0xa8/0xcc) from [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc)
[ 1125.670000] [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc) from [<c01d4fbc>] (__sys_recvmsg+0x50/0x80)
[ 1125.680000] [<c01d4fbc>] (__sys_recvmsg+0x50/0x80) from [<c000dfe0>] (ret_fast_syscall+0x0/0x2c)
[ 1125.690000] ---[ end trace f0b7642b1456208a ]---
[ 1125.700000] ------------[ cut here ]------------
[ 1125.700000] WARNING: at net/ipv4/af_inet.c:156 inet_sock_destruct+0x158/0x1a8()
[ 1125.710000] Modules linked in:
[ 1125.710000] [<c0013ac8>] (unwind_backtrace+0x0/0xec) from [<c001c588>] (warn_slowpath_common+0x4c/0x64)
[ 1125.720000] [<c001c588>] (warn_slowpath_common+0x4c/0x64) from [<c001c63c>] (warn_slowpath_null+0x1c/0x24)
[ 1125.730000] [<c001c63c>] (warn_slowpath_null+0x1c/0x24) from [<c0230858>] (inet_sock_destruct+0x158/0x1a8)
[ 1125.740000] [<c0230858>] (inet_sock_destruct+0x158/0x1a8) from [<c01d75f4>] (__sk_free+0x18/0x154)
[ 1125.750000] [<c01d75f4>] (__sk_free+0x18/0x154) from [<c0230aa0>] (inet_release+0x44/0x70)
[ 1125.760000] [<c0230aa0>] (inet_release+0x44/0x70) from [<c01d3714>] (sock_release+0x20/0xc8)
[ 1125.770000] [<c01d3714>] (sock_release+0x20/0xc8) from [<c01d37d0>] (sock_close+0x14/0x2c)
[ 1125.780000] [<c01d37d0>] (sock_close+0x14/0x2c) from [<c00a0044>] (fput+0xb4/0x27c)
[ 1125.780000] [<c00a0044>] (fput+0xb4/0x27c) from [<c009d64c>] (filp_close+0x64/0x88)
[ 1125.790000] [<c009d64c>] (filp_close+0x64/0x88) from [<c001fb28>] (put_files_struct+0x80/0xe0)
[ 1125.800000] [<c001fb28>] (put_files_struct+0x80/0xe0) from [<c0020388>] (do_exit+0x4c8/0x748)
[ 1125.810000] [<c0020388>] (do_exit+0x4c8/0x748) from [<c0011894>] (die+0x214/0x240)
[ 1125.820000] [<c0011894>] (die+0x214/0x240) from [<c0256160>] (__do_kernel_fault.part.0+0x54/0x74)
[ 1125.830000] [<c0256160>] (__do_kernel_fault.part.0+0x54/0x74) from [<c0015188>] (do_bad_area+0x88/0x8c)
[ 1125.840000] [<c0015188>] (do_bad_area+0x88/0x8c) from [<c00173dc>] (do_alignment+0xf0/0x938)
[ 1125.850000] [<c00173dc>] (do_alignment+0xf0/0x938) from [<c000862c>] (do_DataAbort+0x34/0x98)
[ 1125.850000] [<c000862c>] (do_DataAbort+0x34/0x98) from [<c000db98>] (__dabt_svc+0x38/0x60)
[ 1125.860000] Exception stack(0xc1e67cc8 to 0xc1e67d10)
[ 1125.870000] 7cc0:                   c1e67ec8 00000008 c1e67ec0 c14fe62e c14f4640 c1e67f7c
[ 1125.880000] 7ce0: c1e10220 000005c0 00000000 0000004a c1e67d34 0000004a 00000000 c1e67d10
[ 1125.880000] 7d00: 00000000 c0228adc a0000013 ffffffff
[ 1125.890000] [<c000db98>] (__dabt_svc+0x38/0x60) from [<c0228adc>] (udp_recvmsg+0x284/0x33c)
[ 1125.900000] [<c0228adc>] (udp_recvmsg+0x284/0x33c) from [<c02306e0>] (inet_recvmsg+0x38/0x4c)
[ 1125.910000] [<c02306e0>] (inet_recvmsg+0x38/0x4c) from [<c01d2c38>] (sock_recvmsg+0xa8/0xcc)
[ 1125.920000] [<c01d2c38>] (sock_recvmsg+0xa8/0xcc) from [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc)
[ 1125.930000] [<c01d3fac>] (___sys_recvmsg.part.4+0xe0/0x1bc) from [<c01d4fbc>] (__sys_recvmsg+0x50/0x80)
[ 1125.940000] [<c01d4fbc>] (__sys_recvmsg+0x50/0x80) from [<c000dfe0>] (ret_fast_syscall+0x0/0x2c)
[ 1125.940000] ---[ end trace f0b7642b1456208b ]--- 


[0]: http://git.lpclinux.com/?p=linux-2.6.39.2-lpc.git;a=summary
[1]: http://lists.openwall.net/netdev/2009/03/09/28
[2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/176757.html


Mit freundlichen Grüßen / With kind regards 

Marcel Hellwig
B. Sc. Informatik
Entwickler

m-u-t GmbH
Am Marienhof 2
22880 Wedel
Germany

Phone:	+49 4103 9308 - 474
Fax:  	+49 4103 9308 - 99
mailto:mhellwig@mut-group.com

http://www.mut-group.com

Geschäftsführer (Managing Director): Fabian Peters
Amtsgericht Pinneberg (Commercial Register No.): HRB 10304 PI
USt-IdNr. (VAT-No.): DE228275390
WEEE-Reg-Nr.: DE 72271808

