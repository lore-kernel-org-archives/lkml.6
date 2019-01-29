Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CF220844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfA2KzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:55:00 -0500
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:12047 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfA2Ky7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:54:59 -0500
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by mgwym02.jp.fujitsu.com with smtp
         id 17e9_c2bd_78713a2e_2048_498d_b459_0dcef26d700c;
        Tue, 29 Jan 2019 19:54:54 +0900
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
        by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 031FBAC00D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 19:54:54 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
        by g01jpfmpwkw02.exch.g01.fujitsu.local (Postfix) with ESMTP id CDA043286EE;
        Tue, 29 Jan 2019 19:54:52 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Tue, 29 Jan 2019
 19:54:52 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Catalin Marinas' <catalin.marinas@arm.com>
CC:     'Mark Rutland' <mark.rutland@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdSyLRrS1IDcSdJoRF6WCq7/B3VdwACYGWwAAMw1BtA=
Date:   Tue, 29 Jan 2019 10:54:51 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2C03E0@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A2A32D6@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A6A2A32EB@G01JPEXMBKW03>
 <20190125180813.GM25901@arrakis.emea.arm.com>
In-Reply-To: <20190125180813.GM25901@arrakis.emea.arm.com>
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

Hi Catalin,
> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> Catalin Marinas
> Sent: Saturday, January 26, 2019 3:08 AM
> To: Zhang, Lei/張 雷
> Cc: 'Mark Rutland'; 'will.deacon@arm.com';
> 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'
> Subject: Re: [PATCH v2 1/1] arm64: Add workaround for Fujitsu A64FX
> erratum 010001
> 
> IIUC, this can happen very early when the errata framework isn't yet
> ready. Given that this is not on a fast path (you already took a fault),
> I don't think it's worth optimising for cpus_have_cap() (and
> ARM64_WORKAROUND_FUJITSU_A64FX_0100001). I've seen Mark's comments on
> why checking MIDR in a preemptible context is not a good idea but I
> suspect your platform is homogeneous (i.e. not big.LITTLE).
Thanks for comment.
I will post a new patch to resolve fast path problem in today.
By the way our platform is homogeneous.


Best Regards,
Lei Zhang
zhang.lei@jp.fujitsu.com

 

