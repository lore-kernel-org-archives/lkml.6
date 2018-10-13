Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878D3C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1128C20659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cBeC8I3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1128C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJNBQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 21:16:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46980 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJNBQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 21:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pTDXmUPG8c4e99/rYsvjtbRK7ZcFXK+9eRnSRCVNQPE=; b=cBeC8I3o6cddvS1BH6QHd5Vbc4
        9rLG7Zuh1jEpn8TIwpvMeg1INPmxaV0o2783z9dy4KXIqyWXIWiJ68wly8vmTMIToTNN6lQHgqmpi
        SAyWnZ4CcBzQRgAIxmaV1oV09TfAvPUNUcOGVZs7GJnEqrJNaD5CI8PCvpB6jHjlFziZrhEpXtMfS
        75eP8WW1wEz1VWKOX6nktiw1u9Yj8U5Bf8lXPcRPtP1VrnCt8BzL/cYliuRqWH5tOB35gLc/Ik9HH
        PnqKzS9rG0YQkNTuJKIaxvDEJw7E10MafNZREEwvpwnUWrqTb6qCgaWbdPq4j/Sy+WYAvpiXOsA9/
        LW+3ASpQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBNrR-0008Jl-5Z; Sat, 13 Oct 2018 17:37:57 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Karol Kosik <karo9@interia.eu>,
        Igor Kotrasinski <i.kotrasinsk@samsung.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: usbip_vudc: BUG kmalloc-2048 (Not tainted): Poison overwritten
Message-ID: <d70534ec-85a7-6249-449e-2fb3401e1d48@infradead.org>
Date:   Sat, 13 Oct 2018 10:37:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 4.19-rc7, on x86_64:

Load usbip_vudc module, then unload (rmmod) it.
Load it again:


[  169.042156] calling  init+0x0/0x1000 [usbip_vudc] @ 1697
[  169.042396] =============================================================================
[  169.043678] probe of usbip-vudc.0 returned 1 after 350 usecs
[  169.044508] BUG kmalloc-2048 (Not tainted): Poison overwritten
[  169.044509] -----------------------------------------------------------------------------
[  169.044509] 
[  169.044510] Disabling lock debugging due to kernel taint
[  169.044512] INFO: 0x0000000012a0ffa1-0x0000000012a0ffa1. First byte 0x6a instead of 0x6b
[  169.044517] INFO: Allocated in platform_device_alloc+0x20/0x70 age=10318 cpu=0 pid=1686
[  169.044521] 	__kmalloc+0x16e/0x1e0
[  169.044524] 	platform_device_alloc+0x20/0x70
[  169.045588] initcall init+0x0/0x1000 [usbip_vudc] returned 0 after 2439 usecs
[  169.046607] 	0xffffffffc0c2e987
[  169.046610] 	init+0x75/0x1000 [usbip_vudc]
[  169.046613] 	do_one_initcall+0x47/0x19a
[  169.046616] 	do_init_module+0x51/0x1da
[  169.046621] 	load_module+0x1707/0x1d40
[  169.057841] 	__do_sys_finit_module+0xbd/0xe0
[  169.057843] 	do_syscall_64+0x60/0x180
[  169.057846] 	entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  169.057849] INFO: Freed in device_release+0x2b/0x80 age=4223 cpu=3 pid=1693
[  169.057852] 	kobject_put+0x86/0x1b0
[  169.057853] 	0xffffffffc0c30a96
[  169.057855] 	__x64_sys_delete_module+0x157/0x240
[  169.057856] 	do_syscall_64+0x60/0x180
[  169.057858] 	entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  169.057859] INFO: Slab 0x000000004c31e13a objects=13 used=13 fp=0x          (null) flags=0x17ffffc0008100
[  169.057861] INFO: Object 0x000000002a22de42 @offset=4776 fp=0x          (null)
[  169.057861] 
[  169.057863] Redzone 0000000002f46029: bb bb bb bb bb bb bb bb                          ........
[  169.057864] Object 000000002a22de42: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.057865] Object 00000000edbf0821: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.057866] Object 000000009d5b8893: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.057867] Object 00000000f2f186d4: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.057868] Object 000000004376e653: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.057870] Object 00000000c3c4b95e: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkjkkkkkkk
[  169.079582] Object 00000000f96ac71d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.079583] Object 00000000fcdf955d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.079584] Object 0000000095afc904: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.079586] Object 0000000005bee7bd: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.086257] Object 00000000f2c428c4: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.086258] Object 00000000ea1a3eec: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.086259] Object 0000000034e41a8a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.086260] Object 00000000081ff914: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.086261] Object 000000001472f162: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.086262] Object 000000007819f712: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.086264] Object 00000000528e0351: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.097929] Object 000000009e64b28f: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.097930] Object 00000000f4597206: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.097931] Object 0000000074bb3ae9: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.097933] Object 0000000033df96ca: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104603] Object 00000000e74cedcd: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104604] Object 00000000e1fee902: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104605] Object 000000005393677e: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104606] Object 00000000108a6e1d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104607] Object 00000000a7cc6bab: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104608] Object 00000000032cdef1: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104609] Object 00000000594dc790: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104610] Object 000000006248724d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104611] Object 000000001702a405: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104612] Object 00000000bb2dffad: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104613] Object 000000005abc0694: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104614] Object 0000000085d75148: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104615] Object 000000007be315f5: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104616] Object 00000000a1ed433a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104617] Object 00000000a6b0353d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104618] Object 000000004dbcc646: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104619] Object 00000000ea46c2f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104620] Object 000000009e663f09: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104621] Object 0000000003061746: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104621] Object 00000000fece59fa: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104622] Object 000000005dd2c759: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104623] Object 000000001447295a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104624] Object 00000000b703d712: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104625] Object 000000000b43737f: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.104627] Object 00000000e1089c01: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.146281] Object 000000003a17619c: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.146282] Object 000000001fd6e01f: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.146285] Object 00000000cdbc09b5: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.151290] Object 0000000040280d7d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.151291] Object 000000007b278838: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.151292] Object 0000000018198f71: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.151294] Object 00000000540047e6: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.157963] Object 0000000071344eaf: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.157964] Object 00000000fd641b55: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.157965] Object 00000000f3633830: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.157966] Object 00000000d6079d27: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.157967] Object 00000000037e33e9: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.157968] Object 00000000d36999a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.157970] Object 00000000869541bf: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.169636] Object 00000000cbcff052: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.169637] Object 0000000018c2988d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.169638] Object 000000006b495021: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.169640] Object 00000000d3676a93: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176311] Object 0000000052a667f6: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176312] Object 00000000a20cc3af: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176313] Object 00000000c58773cb: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176314] Object 00000000cc245197: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176315] Object 00000000cc2bf73f: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176316] Object 00000000ad6b111a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176317] Object 00000000aac9497a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176318] Object 00000000bc3bd6e7: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176319] Object 000000007e182405: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176320] Object 00000000c32b315d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176321] Object 000000005a23a3f2: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176322] Object 0000000026874b83: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176323] Object 00000000b9408868: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176324] Object 000000007d80fb7d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176325] Object 00000000cef92180: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176326] Object 0000000092ec8a14: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176327] Object 00000000a95323b3: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176328] Object 0000000078701e8a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176328] Object 00000000def3e0d9: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176329] Object 000000006682fd1e: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176330] Object 000000005d87fe14: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176331] Object 000000003cc29d9e: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176332] Object 00000000123f9822: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176333] Object 0000000016a34075: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176334] Object 000000006fbf59e5: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176335] Object 000000002e4fc388: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176336] Object 000000000860065d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176337] Object 000000003788d668: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176338] Object 0000000091383825: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.176340] Object 000000008539f8b7: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.226328] Object 000000000400e774: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.226329] Object 00000000610ea6bc: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.226330] Object 00000000496c40dd: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.226332] Object 0000000037cd2905: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.233001] Object 000000007ade669f: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.233002] Object 00000000b8567f30: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.233003] Object 00000000e6010bd5: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.233004] Object 00000000b3852f2a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.233005] Object 000000004de50231: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.233006] Object 000000004ee4266f: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.233008] Object 0000000089092c0a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.244675] Object 000000007bce2211: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.244676] Object 00000000ac619d1e: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.244677] Object 00000000374c1057: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.244679] Object 00000000a360cef0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251348] Object 000000001bcfc367: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251349] Object 000000008b54c6d4: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251350] Object 00000000df87e082: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251351] Object 0000000046777410: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251352] Object 00000000b1ae5a63: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251353] Object 000000001679e587: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251354] Object 000000009115175b: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251355] Object 00000000605e7f2a: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251356] Object 0000000006875707: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251357] Object 000000001b93ecc2: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251358] Object 000000006fb509e2: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251359] Object 00000000d0bfbacc: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251360] Object 0000000029bf5e7b: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251361] Object 00000000793ab8ee: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251362] Object 000000006232fdcf: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.251364] Object 0000000057b14dfc: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.278021] Object 0000000037afcc32: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.278022] Object 0000000092cffac1: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[  169.278024] Object 00000000328b4b28: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
[  169.283029] Redzone 000000001a0e0da2: bb bb bb bb bb bb bb bb                          ........
[  169.283030] Padding 00000000a8cbcf3e: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
[  169.283033] CPU: 0 PID: 170 Comm: systemd-udevd Tainted: G    B             4.19.0-rc7mod #2
[  169.283034] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[  169.283035] Call Trace:
[  169.289493]  dump_stack+0x5c/0x7b
[  169.289495]  check_bytes_and_report+0xbd/0x100
[  169.290828]  check_object+0x218/0x260
[  169.290832]  ? sk_prot_alloc+0x77/0x120
[  169.290834]  alloc_debug_processing+0xf9/0x1a0
[  169.290836]  ___slab_alloc+0x576/0x600
[  169.290839]  ? sk_prot_alloc+0x77/0x120
[  169.290842]  ? __lock_acquire.isra.32+0x169/0x850
[  169.290845]  ? sk_prot_alloc+0x77/0x120
[  169.290847]  ? __slab_alloc.isra.88+0x22/0x40
[  169.290850]  __slab_alloc.isra.88+0x22/0x40
[  169.297190]  __kmalloc+0x16e/0x1e0
[  169.297194]  sk_prot_alloc+0x77/0x120
[  169.298398]  sk_alloc+0x31/0x390
[  169.298402]  __netlink_create+0x2d/0xe0
[  169.298405]  netlink_create+0x10e/0x230
[  169.300272]  __sock_create+0x185/0x260
[  169.300276]  __sys_socket+0x40/0xb0
[  169.301481]  __x64_sys_socket+0x11/0x20
[  169.301483]  do_syscall_64+0x60/0x180
[  169.301485]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  169.301487] RIP: 0033:0x7f6fb97c3c17
[  169.301489] Code: 73 01 c3 48 8b 0d 81 a2 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 a2 2b 00 f7 d8 64 89 01 48
[  169.301490] RSP: 002b:00007fff8baa7e88 EFLAGS: 00000286 ORIG_RAX: 0000000000000029
[  169.301492] RAX: ffffffffffffffda RBX: 000055c6530c3ed0 RCX: 00007f6fb97c3c17
[  169.301494] RDX: 000000000000000f RSI: 0000000000080803 RDI: 0000000000000010
[  169.301495] RBP: 000055c6530b7d40 R08: 000055c6530c3ed0 R09: 0000000000000021
[  169.301496] R10: 000055c6530b29e0 R11: 0000000000000286 R12: 00000000ffffffff
[  169.301497] R13: 0000000000000000 R14: 000055c6530f83b0 R15: 000055c6530b7c70
[  169.301502] FIX kmalloc-2048: Restoring 0x0000000012a0ffa1-0x0000000012a0ffa1=0x6b
[  169.301502] 
[  169.301503] FIX kmalloc-2048: Marking all objects used


-- 
~Randy
