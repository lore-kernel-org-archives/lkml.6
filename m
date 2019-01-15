Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32608C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OA+YRIBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfAOQ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:58:26 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37924 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfAOQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:58:19 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8B2EC24E16F3;
        Tue, 15 Jan 2019 08:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547571498; bh=POsdSu2h1MWWntYZn018yDa8VSmiuZgpPL8E7jdQPwY=;
        h=From:To:CC:Subject:Date:References:From;
        b=OA+YRIBU1/4IAbepfPMkpV5ou17ESTOi90wmECBH1U6YYkhqvk540zFxIBKIyO4L7
         H7Y1COSh9j1q26p4a4jbHE/pjw7UC8ZqqGLCZ3Rd/DmZDlsMpG5e9Ishmr8zkCRN6F
         W3+KjndQq3C1fFH+0xbbamc64RWxEXHBwOivTnnCbyKRFQ9eh4FEfkYXYqE39F0mrG
         WfHWCPP0HgR1uaj475CRp29HEftFt6eaWXcdqAT7PNPNwUFaZU0Xb8eogUQSWnzdZS
         kYYnkHXBAQ2k2L2gHcO8tA4F6zp8iI4Sd71lP2GuIpLL6E4j1QbYmaLOUQmMpnK2M9
         L/1b19ZB4O8wA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4453435CB;
        Tue, 15 Jan 2019 08:58:18 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 15 Jan 2019 08:58:18 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 1/2] ARCv2: LIB: memeset: fix doing prefetchw outside of
 buffer
Thread-Topic: [PATCH 1/2] ARCv2: LIB: memeset: fix doing prefetchw outside
 of buffer
Thread-Index: AQHUrBw2ZJte6r90DkSex+vHyLGaMw==
Date:   Tue, 15 Jan 2019 16:58:17 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642748E@US01WEMBX2.internal.synopsys.com>
References: <20190114151649.32726-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501464272C9@US01WEMBX2.internal.synopsys.com>
 <1547553603.24248.49.camel@synopsys.com>
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

On 1/15/19 4:00 AM, Eugeniy Paltsev wrote:=0A=
>>> -#ifdef PREALLOC_NOT_AVAIL=0A=
>>> -	prefetchw [r3, 64]	;Prefetch the next write location=0A=
>>> -#else=0A=
>>> -	prealloc  [r3, 64]=0A=
>>> -#endif=0A=
>>> +	PREALLOC_INSTR([r3, 64]) ;Prefetch the next write location=0A=
>> These are not solving the issue - I'd break this up and move these bits =
to your=0A=
>> next patch.=0A=
> Actually these are solving another issue - current implementation may cal=
l=0A=
> 'prealloc' instruction for L1 cache line which doesn't fully belongs to=
=0A=
> memeset area in case of 128B L1 D$ line length. As the 'prealloc' fill ca=
che line=0A=
> with zeros this leads to data corruption.=0A=
>=0A=
> So I would better keep these changes in this 'fix' patch.=0A=
=0A=
Fair enough. Although technically it is different bug which we haven't actu=
ally=0A=
hit, found by code review.=0A=
=0A=
> BTW, I've forgot again to add Cc: stable@vger.kernel.org, could you add i=
t for me,=0A=
> when applying patch?=0A=
> Thanks.=0A=
=0A=
Yes, I did that already !=0A=
=0A=
-Vineet=0A=
