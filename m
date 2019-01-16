Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612202086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RjZk/1ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392306AbfAPLBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:01:42 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13799 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfAPLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:01:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3f0ef70000>; Wed, 16 Jan 2019 03:01:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Jan 2019 03:01:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Jan 2019 03:01:40 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 16 Jan
 2019 11:01:39 +0000
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
To:     Mark Brown <broonie@kernel.org>,
        Martin Sperl <kernel@martin.sperl.org>
CC:     linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
 <20190115212539.GK5522@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b6d6585b-86ce-5eae-842e-83561beefa61@nvidia.com>
Date:   Wed, 16 Jan 2019 11:01:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115212539.GK5522@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547636471; bh=Dr44vRq7v4s7XlHq7f/P6pICuugqkWSjqBeTxrhGIZw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RjZk/1gapRYznJYQ+Oi9IJwa4h/ZEcdQYc7tyTrqknXPPr51ovvRNCT2rv/gtni3g
         smEh3X1BQ3Jn/06sooeLcahmcjmZw1d+cwqzZ8mn2f6JK1iqXMa7r27qzE5rlBxrRs
         wVMbrka3MB6c9b/sRhSids/l7gZVSy5hRKRzJfSVklSw0gA2iBRrH6hQuSVib3I5Hg
         IJtId64GHNjfbTBbExio9YocvCubmGPXzl25B1DQdNKHfZ1VaJHt2BRE2CDIjXZIqW
         MTR2nZ4euXCVgOC0AtTq3CYTDJnwQJl7Bt3xoIRkcuipzTAUyNZfnw2VlUsh9UOMGt
         3O1EO8PLyMvIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/01/2019 21:25, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 09:58:55PM +0100, Martin Sperl wrote:
>=20
>> Maybe a bigger change to the reduce the complexity of
>> the state machine would solve that problem and also
>> reduce code complexity...=20
>=20
> Yeah, that's where I was getting to with that test patch I posted.
>=20
>> I may find some time over the weekend if no solution
>> has been found until then.
>=20
> Thanks for volunteering :)
>=20
>> The way I would envision it it would have a =E2=80=9Cstate=E2=80=9D
>> as a level (0=3Dshutdown, 1=3Dhw enabled, 2=3Din pump,=20
>> 3=3Din transfer, 4=3Din hw-mode,...) and a complete
>> to allow waking the shutdown thread (and by this
>> avoiding the busy wait loop we have now).
>> This would replace those idling, busy, and running flags.
>=20
> That's a good idea, yes - a single enum much more reflects what we can
> actually do in terms of transitions.
>=20
>> Drawback: it is invasive, but let us see what it
>> really looks like...
>=20
> I think we need to either drop your change (which would be bad since it
> is a big performance improvement, I'd punted it for later when I did the
> original refactoring to push the work into the caller threads then never
> got around to it) or have a invasive changes to make the new situation
> clearer.  Right now things are just far too complex to reason about
> which isn't helping anyone.

What I am seeing on Tegra is that the SPI controller is no longer
runtime-pm suspended and so while this may improve performance, I think
that this change is going to have a negative impact on idle power.

I would be surprised if this problem is specific to Tegra because I
don't see how the controller's busy state can ever be cleared :-(

Cheers
Jon

--=20
nvpublic
