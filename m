Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FCC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfAVCGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:06:05 -0500
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:37390 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfAVCGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:06:04 -0500
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by mgwkm04.jp.fujitsu.com with smtp
         id 4693_85dc_e8214886_fecc_4033_a015_d5e8aae9d6c7;
        Tue, 22 Jan 2019 11:05:59 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 489B4AC01BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:05:33 +0900 (JST)
Received: from G01JPEXCHKW15.g01.fujitsu.local (G01JPEXCHKW15.g01.fujitsu.local [10.0.194.54])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 3AF60BD6675;
        Tue, 22 Jan 2019 11:05:27 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw15 ([10.0.194.54]) with mapi id 14.03.0415.000; Tue, 22 Jan 2019
 11:05:26 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Mark Rutland' <mark.rutland@arm.com>
CC:     "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Topic: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Index: AdSvK6W0/Nm6810RQFa/OOuw1JbhXP//gw+A//n57fA=
Date:   Tue, 22 Jan 2019 02:05:26 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
In-Reply-To: <20190118141758.GC12256@lakrids.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark

Thanks for your comments, and sorry for late.

> -----Original Message-----
> * Under what conditions can the fault occur? e.g. is this in place of
>   some other fault, or completely spurious?
This fault can occur completely spurious under
a specific hardware condition and instructions order.
 
> * Does this only occur for data abort? i.e. not instruction aborts?
Yes. This fault only occurs for data abort.

> * How often does this fault occur?
In my test, this fault occurs once every several times 
in the OS boot sequence, and after the completion of OS boot, 
this fault have never occurred.
In my opinion, this fault rarely occurs 
after the completion of OS boot.

> * Does this only apply to Stage-1, or can the same faults be taken at
>   Stage-2?
This fault can be taken only at Stage-1.

> I'm a bit surprised by the single retry. Is there any guarantee that a
> thread will eventually stop delivering this fault code?
I guarantee that a thread will stop delivering this 
fault code by the this patch.
The hardware condition which cause this fault is 
reset at exception entry, therefore execution of at 
least one instruction is guaranteed by this single retry.

> Note that all CPUs and threads share the do_bad_ignore_first variable,
> so this is going to behave non-deterministically and kill threads in
> some cases.
> 
> This code is also preemptible, so checking the MIDR here doesn't make
> much sense. Either this is always uniform (and we can check once in the
> errata framework), or it's variable (e.g. on a big.LITTLE system) and
> we
> need to avoid preemption up until this point.
> 
> Rather than dynamically checking the MIDR, this should use the errata
> framework, and if any A64FX CPU is discovered, set an erratum cap like
> ARM64_WORKAROUND_CONFIG_FUJITSU_ERRATUM_010001, so we can do something
> like:
I try to provide a new patch to reflect your comments in today.
Unfortunately this bug may occurs before 
init_cpu_hwcaps_indirect_list called.
It is means maybe errata cap is not available. I am trying to
figure out best way to resolve this problem.

---
Best regards,
Lei Zhang
zhang.lei@jp.fujitsu.com

