Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDFB21872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503384AbfBNWY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:24:28 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:1934 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440502AbfBNWX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:23:29 -0500
Received: from [77.22.253.72] (helo=[192.168.1.154])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jan@schnhrr.de>)
        id 1guPPa-0003LH-Ux; Thu, 14 Feb 2019 23:23:19 +0100
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jan@schnhrr.de>
Subject: Re: [PATCH v2] x86/tsc: Allow quick PIT calibration despite
 interruptions
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20190214214608.8672-1-jan@schnhrr.de>
Message-ID: <941a61ed-d122-0c1a-4cc3-0f3f60339cd7@schnhrr.de>
Date:   Thu, 14 Feb 2019 23:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214214608.8672-1-jan@schnhrr.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Df-Sender: am5Ac2Nobmhyci5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.02.19 um 22:46 schrieb Jan H. Schönherr:
> Some systems experience regular interruptions (60 Hz SMI?), that prevent
> the quick PIT calibration from succeeding: individual interruptions can be
> so long, that the PIT MSB is observed to decrement by 2 or 3 instead of 1.
> The existing code cannot recover from this.
> 
> The system in question is an AMD Ryzen Threadripper 2950X, microcode
> 0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.
> 
> Change the code to handle (almost) arbitrary interruptions, as long
> as they happen only once in a while and they do not take too long.
> Specifically, also cover an interruption during the very first reads.

Here is some debug output on how the PIT behaves on my system during
a calibration with the patch applied.

The patch generating the output is at the bottom of this mail.

[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./X399 Professional Gaming, BIOS P3.30 08/14/2018
[    0.000000] tsc: pit_expect_msb: val=0xff cval=0xfe tsc=0x000000122fc5d195 delta=000000000000847b count=43
[    0.000000] tsc: pit_expect_msb: val=0xfe cval=0xfd tsc=0x000000122fd12a95 delta=0000000000008412 count=41
[    0.000000] tsc: pit_expect_msb: val=0xfd cval=0xfc tsc=0x000000122fdcc62a delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0xfc cval=0xfb tsc=0x000000122fe81ffc delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xfb cval=0xfa tsc=0x000000122ff378fc delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xfa cval=0xf9 tsc=0x000000122fff1491 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0xf9 cval=0xf8 tsc=0x00000012300a6ea9 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xf8 cval=0xf7 tsc=0x000000123015c87b delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xf7 cval=0xf6 tsc=0x0000001230216410 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0xf6 cval=0xf5 tsc=0x00000012302cbd10 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xf5 cval=0xf4 tsc=0x00000012303816e2 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xf4 cval=0xf3 tsc=0x000000123043b29a delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0xf3 cval=0xf2 tsc=0x00000012304f0c8f delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xf2 cval=0xf1 tsc=0x00000012305a656c delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xf1 cval=0xf0 tsc=0x0000001230660101 delta=0000000000008458 count=42
[    0.000000] tsc: pit_expect_msb: val=0xf0 cval=0xef tsc=0x0000001230715b19 delta=000000000000831d count=41
[    0.000000] tsc: pit_expect_msb: val=0xef cval=0xee tsc=0x00000012307cb4eb delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0xee cval=0xed tsc=0x0000001230885080 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xed cval=0xec tsc=0x000000123093a980 delta=0000000000008412 count=41
[    0.000000] tsc: pit_expect_msb: val=0xec cval=0xeb tsc=0x00000012309f0398 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xeb cval=0xea tsc=0x0000001230aa9ee7 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xea cval=0xe9 tsc=0x0000001230b5f7e7 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xe9 cval=0xe8 tsc=0x0000001230c151ff delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xe8 cval=0xe7 tsc=0x0000001230cced94 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xe7 cval=0xe6 tsc=0x0000001230d8464e delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xe6 cval=0xe5 tsc=0x0000001230e3a066 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xe5 cval=0xe4 tsc=0x0000001230ef3bfb delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xe4 cval=0xe3 tsc=0x0000001230fa94d8 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xe3 cval=0xe2 tsc=0x000000123105eef0 delta=000000000000831d count=41
[    0.000000] tsc: pit_expect_msb: val=0xe2 cval=0xe1 tsc=0x0000001231118a85 delta=000000000000831d count=42
[    0.000000] tsc: pit_expect_msb: val=0xe1 cval=0xe0 tsc=0x00000012311ce457 delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0xe0 cval=0xdf tsc=0x0000001231283d57 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xdf cval=0xde tsc=0x000000123133d8ec delta=0000000000008412 count=42
[    0.000000] tsc: pit_expect_msb: val=0xde cval=0xdd tsc=0x00000012313f3304 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xdd cval=0xdc tsc=0x00000012314a8cd6 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xdc cval=0xdb tsc=0x000000123156286b delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0xdb cval=0xda tsc=0x000000123161816b delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xda cval=0xd9 tsc=0x00000012316cdb3d delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xd9 cval=0xd8 tsc=0x00000012317876d2 delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0xd8 cval=0xd7 tsc=0x000000123183d0ea delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xd7 cval=0xd6 tsc=0x00000012318f29a4 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xd6 cval=0xd5 tsc=0x00000012319ac539 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xd5 cval=0xd4 tsc=0x0000001231a61f51 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xd4 cval=0xd3 tsc=0x0000001231b17851 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xd3 cval=0xd2 tsc=0x0000001231bd13c3 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xd2 cval=0xd1 tsc=0x0000001231c86db8 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xd1 cval=0xd0 tsc=0x0000001231d40970 delta=0000000000008412 count=42
[    0.000000] tsc: pit_expect_msb: val=0xd0 cval=0xcf tsc=0x0000001231df6270 delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0xcf cval=0xce tsc=0x0000001231eabc42 delta=0000000000008412 count=41
[    0.000000] tsc: pit_expect_msb: val=0xce cval=0xcd tsc=0x0000001231f657d7 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0xcd cval=0xcc tsc=0x000000123201b0d7 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xcc cval=0xcb tsc=0x00000012320d0aa9 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xcb cval=0xca tsc=0x000000123218a63e delta=000000000000831d count=42
[    0.000000] tsc: pit_expect_msb: val=0xca cval=0xc9 tsc=0x0000001232240056 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xc9 cval=0xc8 tsc=0x00000012322f5910 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xc8 cval=0xc7 tsc=0x00000012323af4a5 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xc7 cval=0xc6 tsc=0x0000001232464ebd delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xc6 cval=0xc5 tsc=0x000000123251a88f delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xc5 cval=0xc4 tsc=0x00000012325d4424 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xc4 cval=0xc3 tsc=0x0000001232689d47 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xc3 cval=0xc2 tsc=0x000000123273f73c delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xc2 cval=0xc1 tsc=0x00000012327f92ae delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0xc1 cval=0xc0 tsc=0x00000012328aeca3 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xc0 cval=0xbf tsc=0x00000012329645c6 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xbf cval=0xbe tsc=0x0000001232a1e15b delta=0000000000008458 count=42
[    0.000000] tsc: pit_expect_msb: val=0xbe cval=0xbd tsc=0x0000001232ad3b2d delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xbd cval=0xba tsc=0x0000001232b7ce35 delta=000000000019e745 count=38
[    0.000000] tsc: pit_expect_msb: val=0xbc cval=0xba tsc=0x0000001232d1b692 delta=0000001232d1e9d7 count=0
[    0.000000] tsc: pit_expect_msb: val=0xbb cval=0xba tsc=0x0000001232d23572 delta=0000001232d26de9 count=0
[    0.000000] tsc: pit_expect_msb: val=0xba cval=0xb9 tsc=0x0000001232daf0cc delta=0000000000008363 count=32
[    0.000000] tsc: pit_expect_msb: val=0xb9 cval=0xb8 tsc=0x0000001232e64ae4 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xb8 cval=0xb7 tsc=0x0000001232f1e679 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0xb7 cval=0xb6 tsc=0x0000001232fd3f79 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xb6 cval=0xb5 tsc=0x000000123308994b delta=000000000000831d count=41
[    0.000000] tsc: pit_expect_msb: val=0xb5 cval=0xb4 tsc=0x00000012331434e0 delta=000000000000831d count=42
[    0.000000] tsc: pit_expect_msb: val=0xb4 cval=0xb3 tsc=0x00000012331f8ef8 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xb3 cval=0xb2 tsc=0x00000012332ae7b2 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xb2 cval=0xb1 tsc=0x000000123336836a delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0xb1 cval=0xb0 tsc=0x000000123341dd5f delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xb0 cval=0xaf tsc=0x00000012334d3731 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xaf cval=0xae tsc=0x000000123358d2e9 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xae cval=0xad tsc=0x0000001233642be9 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xad cval=0xac tsc=0x00000012336f85bb delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0xac cval=0xab tsc=0x00000012337b2150 delta=0000000000008458 count=42
[    0.000000] tsc: pit_expect_msb: val=0xab cval=0xaa tsc=0x0000001233867a50 delta=0000000000008412 count=41
[    0.000000] tsc: pit_expect_msb: val=0xaa cval=0xa9 tsc=0x000000123391d468 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xa9 cval=0xa8 tsc=0x00000012339d6fb7 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xa8 cval=0xa7 tsc=0x0000001233a8c8b7 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xa7 cval=0xa6 tsc=0x0000001233b422cf delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xa6 cval=0xa5 tsc=0x0000001233bfbe64 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0xa5 cval=0xa4 tsc=0x0000001233cb171e delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xa4 cval=0xa3 tsc=0x0000001233d67136 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0xa3 cval=0xa2 tsc=0x0000001233e20ccb delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0xa2 cval=0xa1 tsc=0x0000001233ed669d delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0xa1 cval=0xa0 tsc=0x0000001233f8bf9d delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0xa0 cval=0x9f tsc=0x0000001234045b55 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0x9f cval=0x9e tsc=0x00000012340fb527 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x9e cval=0x9d tsc=0x00000012341b50bc delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0x9d cval=0x9c tsc=0x000000123426aad4 delta=0000000000008412 count=41
[    0.000000] tsc: pit_expect_msb: val=0x9c cval=0x9b tsc=0x00000012343203d4 delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0x9b cval=0x9a tsc=0x00000012343d9f23 delta=0000000000008458 count=42
[    0.000000] tsc: pit_expect_msb: val=0x9a cval=0x99 tsc=0x000000123448f93b delta=000000000000831d count=41
[    0.000000] tsc: pit_expect_msb: val=0x99 cval=0x98 tsc=0x0000001234545353 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x98 cval=0x97 tsc=0x00000012345feea2 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x97 cval=0x96 tsc=0x00000012346b47a2 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x96 cval=0x95 tsc=0x000000123476a1ba delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x95 cval=0x94 tsc=0x0000001234823d4f delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x94 cval=0x93 tsc=0x00000012348d9609 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x93 cval=0x92 tsc=0x000000123498f021 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x92 cval=0x91 tsc=0x0000001234a48bb6 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x91 cval=0x90 tsc=0x0000001234afe493 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x90 cval=0x8f tsc=0x0000001234bb3e88 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x8f cval=0x8e tsc=0x0000001234c6da40 delta=0000000000008412 count=42
[    0.000000] tsc: pit_expect_msb: val=0x8e cval=0x8d tsc=0x0000001234d23340 delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0x8d cval=0x8c tsc=0x0000001234dd8d12 delta=0000000000008340 count=41
[    0.000000] tsc: pit_expect_msb: val=0x8c cval=0x8b tsc=0x0000001234e928a7 delta=000000000000831d count=42
[    0.000000] tsc: pit_expect_msb: val=0x8b cval=0x8a tsc=0x0000001234f482bf delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x8a cval=0x89 tsc=0x0000001234ffdb79 delta=0000000000008412 count=41
[    0.000000] tsc: pit_expect_msb: val=0x89 cval=0x88 tsc=0x00000012350b770e delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0x88 cval=0x87 tsc=0x000000123516d126 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x87 cval=0x86 tsc=0x0000001235222af8 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x86 cval=0x85 tsc=0x00000012352dc68d delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x85 cval=0x84 tsc=0x0000001235391f8d delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x84 cval=0x83 tsc=0x000000123544795f delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x83 cval=0x82 tsc=0x00000012355014f4 delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0x82 cval=0x81 tsc=0x00000012355b6f0c delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x81 cval=0x80 tsc=0x000000123566c80c delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x80 cval=0x7f tsc=0x000000123572637e delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x7f cval=0x7e tsc=0x00000012357dbd73 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x7e cval=0x7d tsc=0x0000001235891696 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x7d cval=0x7c tsc=0x000000123594b22b delta=0000000000008458 count=42
[    0.000000] tsc: pit_expect_msb: val=0x7c cval=0x7b tsc=0x0000001235a00bfd delta=0000000000008412 count=41
[    0.000000] tsc: pit_expect_msb: val=0x7b cval=0x7a tsc=0x0000001235ab64fd delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0x7a cval=0x79 tsc=0x0000001235b70092 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x79 cval=0x78 tsc=0x0000001235c25a64 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x78 cval=0x77 tsc=0x0000001235cdb364 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x77 cval=0x76 tsc=0x0000001235d94ef9 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x76 cval=0x75 tsc=0x0000001235e4a8cb delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x75 cval=0x74 tsc=0x0000001235f002e3 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x74 cval=0x73 tsc=0x0000001235fb9e78 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0x73 cval=0x72 tsc=0x000000123606f732 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x72 cval=0x71 tsc=0x000000123612514a delta=000000000000831d count=41
[    0.000000] tsc: pit_expect_msb: val=0x71 cval=0x70 tsc=0x00000012361decdf delta=000000000000831d count=42
[    0.000000] tsc: pit_expect_msb: val=0x70 cval=0x6f tsc=0x00000012362946f7 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x6f cval=0x6d tsc=0x0000001236444a56 delta=000000000017c488 count=11
[    0.000000] tsc: pit_expect_msb: val=0x6e cval=0x6d tsc=0x000000123644ea4c delta=0000001236452ce1 count=0
[    0.000000] tsc: pit_expect_msb: val=0x6d cval=0x6c tsc=0x00000012364b9eaa delta=0000000000008458 count=24
[    0.000000] tsc: pit_expect_msb: val=0x6c cval=0x6b tsc=0x000000123656f87c delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x6b cval=0x6a tsc=0x0000001236629411 delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0x6a cval=0x69 tsc=0x00000012366dee29 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x69 cval=0x68 tsc=0x00000012367946e3 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x68 cval=0x67 tsc=0x000000123684e278 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x67 cval=0x66 tsc=0x0000001236903c90 delta=000000000000831d count=41
[    0.000000] tsc: pit_expect_msb: val=0x66 cval=0x65 tsc=0x00000012369b9662 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x65 cval=0x64 tsc=0x0000001236a731f7 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x64 cval=0x63 tsc=0x0000001236b28af7 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x63 cval=0x62 tsc=0x0000001236bde50f delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x62 cval=0x61 tsc=0x0000001236c98081 delta=0000000000008363 count=42
[    0.000000] tsc: pit_expect_msb: val=0x61 cval=0x60 tsc=0x0000001236d4da99 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x60 cval=0x5f tsc=0x0000001236e03399 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x5f cval=0x5e tsc=0x0000001236ebcf2e delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x5e cval=0x5d tsc=0x0000001236f72900 delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0x5d cval=0x5c tsc=0x0000001237028200 delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0x5c cval=0x5b tsc=0x00000012370e1d95 delta=0000000000008458 count=42
[    0.000000] tsc: pit_expect_msb: val=0x5b cval=0x5a tsc=0x0000001237197767 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x5a cval=0x59 tsc=0x000000123724d067 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x59 cval=0x58 tsc=0x0000001237306bfc delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0x58 cval=0x57 tsc=0x00000012373bc5ce delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x57 cval=0x56 tsc=0x0000001237471ece delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x56 cval=0x55 tsc=0x000000123752ba63 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0x55 cval=0x54 tsc=0x00000012375e147b delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x54 cval=0x53 tsc=0x0000001237696e4d delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x53 cval=0x52 tsc=0x00000012377509e2 delta=0000000000008435 count=42
[    0.000000] tsc: pit_expect_msb: val=0x52 cval=0x51 tsc=0x0000001237806305 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x51 cval=0x50 tsc=0x00000012378bbcb4 delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x50 cval=0x4f tsc=0x000000123797586c delta=000000000000831d count=42
[    0.000000] tsc: pit_expect_msb: val=0x4f cval=0x4e tsc=0x0000001237a2b284 delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0x4e cval=0x4d tsc=0x0000001237ae0b3e delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x4d cval=0x4c tsc=0x0000001237b9a6d3 delta=0000000000008458 count=42
[    0.000000] tsc: pit_expect_msb: val=0x4c cval=0x4b tsc=0x0000001237c500eb delta=0000000000008363 count=41
[    0.000000] tsc: pit_expect_msb: val=0x4b cval=0x4a tsc=0x0000001237d05abd delta=0000000000008458 count=41
[    0.000000] tsc: pit_expect_msb: val=0x4a cval=0x49 tsc=0x0000001237dbf652 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x49 cval=0x48 tsc=0x0000001237e74f52 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x48 cval=0x47 tsc=0x0000001237f2a96a delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x47 cval=0x46 tsc=0x0000001237fe44b9 delta=000000000000847b count=42
[    0.000000] tsc: pit_expect_msb: val=0x46 cval=0x45 tsc=0x0000001238099db9 delta=0000000000008435 count=41
[    0.000000] tsc: pit_expect_msb: val=0x45 cval=0x44 tsc=0x000000123814f7d1 delta=000000000000847b count=41
[    0.000000] tsc: pit_expect_msb: val=0x44 cval=0x43 tsc=0x0000001238209366 delta=000000000000847b count=42
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3493.693 MHz processor
...
[    2.343483] tsc: Refined TSC clocksource calibration: 3493.436 MHz


diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index aced427371f7..1678e7c77abf 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -500,6 +500,8 @@ static inline int pit_expect_msb(unsigned char val, u64 *tscp, unsigned long *de
          * We require _some_ success, but the quality control
          * will be based on the error terms on the TSC values.
          */
+inb(0x42);
+pr_info("%s: val=0x%02x cval=0x%02x tsc=0x%016llx delta=%016lx count=%d\n", __func__, val, inb(0x42), tsc, *deltap, count);
         return count > 0 && pit_verify_msb(val - 1);
  }


