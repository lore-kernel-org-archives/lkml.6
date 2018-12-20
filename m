Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QNLE+yq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbeLTSgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:36:40 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:38024 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbeLTSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:36:40 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 895E710C0E7A;
        Thu, 20 Dec 2018 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545330999; bh=26NSlaA2Qc3AuHXy0y+iIwHDb1xHKxAQMXByuyqbqmE=;
        h=From:To:CC:Subject:Date:References:From;
        b=QNLE+yq4uqABGVyquuS4EvhN+SMxDRy+F2pFCn4cjq+6p/gyGg5ApzVraRUFFp9VQ
         Yt75jx5bJDL3ulW3Ky1DgCY3JletyKgDJEyG2P8qEcPi+3ovA/AvkBX0jskGaYWARO
         J5HSs3/CQDHJ5b9ymVYn9wNTkZsXlnFR7IzWVHFgxl2kCVJ2obvoy1iyqhPjJweHuN
         Wp3NcuzZLtP5zPjBRAYWidwXWuH5LbvvjhCGqTSQFfi3W6JyUQHxTRsthGO4BuAcLt
         K+r5UkoVO/ly5+PZ/mgGpI3qNg30xrK7pdiCt7KCY9UDF5SO7p4wBjsOJLG8Gy0dlX
         xO4XtbbC3zZqQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6EA2233B0;
        Thu, 20 Dec 2018 10:36:37 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Thu, 20 Dec 2018 10:36:37 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Topic: [PATCH 1/2] ARC: show_regs: avoid page allocator
Thread-Index: AQHUlwMR8PfsxZ55lUuwqgC40oqmmA==
Date:   Thu, 20 Dec 2018 18:36:36 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642385B@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <1545239047.14089.13.camel@synopsys.com>
 <49f9edc9-87ee-1efc-58f8-b0d9a52c8a49@synopsys.com>
 <e2d2c160-0ef6-5504-7824-032a5c70fa7f@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 5:30 AM, Tetsuo Handa wrote:=0A=
>> |  mmput+0x16/0xb8=0A=
> Then, does mmput_async() help?=0A=
=0A=
Probably, I can try.=0A=
