Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEECECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831F820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831F820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeGTIdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:33:01 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42351 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeGTIdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:33:01 -0400
Received: from [192.168.0.5] (ip5f5bd29d.dynamic.kabel-deutschland.de [95.91.210.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id ACF4D2012BA076;
        Fri, 20 Jul 2018 09:46:01 +0200 (CEST)
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel+linux-netdev@molgen.mpg.de>
Subject: UBSAN: Undefined behaviour in ./include/net/route.h:239:2: member
 access within null pointer of type 'struct rtable'
Message-ID: <ef93ce54-1166-355c-73c9-0b91b5f7b638@molgen.mpg.de>
Date:   Fri, 20 Jul 2018 09:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Enabling the undefined behavior sanitizer and building GNU/Linux 
4.18-rc5+ (with some unrelated commits) with GCC 8.1.0 from Debian 
Sid/unstable, the warning below is shown.

> [    8.083532] ================================================================================
> [    8.083781] UBSAN: Undefined behaviour in ./include/net/route.h:239:2
> [    8.083953] member access within null pointer of type 'struct rtable'
> [    8.084128] CPU: 1 PID: 239 Comm: sd-resolve Not tainted 4.18.0-rc5-00316-g4864b68cedf2 #104
> [    8.084131] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
> [    8.084133] Call Trace:
> [    8.084147]  dump_stack+0x55/0x89
> [    8.084154]  ubsan_epilogue+0xb/0x33
> [    8.084158]  handle_null_ptr_deref+0x7f/0x90
> [    8.084163]  __ubsan_handle_type_mismatch_v1+0x55/0x60
> [    8.084170]  udp_sendmsg+0xb05/0xf80
> [    8.084176]  ? ip_reply_glue_bits+0x80/0x80
> [    8.084185]  ? import_iovec+0x4a/0x160
> [    8.084190]  ? udp_lib_get_port+0x810/0x810
> [    8.084194]  inet_sendmsg+0x77/0x1d0
> [    8.084198]  ? inet_sk_set_state+0x110/0x110
> [    8.084203]  sock_sendmsg+0x5a/0xb0
> [    8.084207]  ___sys_sendmsg+0x102/0x390
> [    8.084214]  ? seccomp_run_filters+0x79/0x220
> [    8.084218]  ? ip4_datagram_release_cb+0x5f/0x2a0
> [    8.084222]  ? udp_lib_rehash+0x17c/0x300
> [    8.084228]  ? __fget_light+0x99/0x110
> [    8.084230]  ? __fdget+0x12/0x20
> [    8.084234]  ? sockfd_lookup_light+0x1e/0xc0
> [    8.084238]  __sys_sendmmsg+0xef/0x1d0
> [    8.084244]  ? alloc_file+0x9b/0x1e0
> [    8.084249]  ? __secure_computing+0x41/0x120
> [    8.084253]  ? syscall_trace_enter+0x1e5/0x470
> [    8.084258]  sys_sendmmsg+0x28/0x30
> [    8.084262]  do_fast_syscall_32+0xce/0x3e0
> [    8.084267]  entry_SYSENTER_32+0x4e/0x7c
> [    8.084272] EIP: 0xb7fabbb5
> [    8.084273] Code: 89 e5 8b 55 08 85 d2 8b 80 5c cd ff ff 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 8b 3c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76 
> [    8.084339] EAX: ffffffda EBX: 0000000c ECX: b75d240c EDX: 00000002
> [    8.084342] ESI: 00004000 EDI: 00000000 EBP: 03fdd1f0 ESP: b75d22f0
> [    8.084345] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
> [    8.084349] ================================================================================


Kind regards,

Paul
