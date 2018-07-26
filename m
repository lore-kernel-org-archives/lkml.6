Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E3C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DF720857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cpCES0zJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DF720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbeGZUSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:18:21 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:38346 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbeGZUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:18:21 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 485D824E104F;
        Thu, 26 Jul 2018 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532631613; bh=8puS66e3KGJE4iUc+538sswuuBR9VdzshS7G7FsFs9s=;
        h=From:To:CC:Subject:Date:References:From;
        b=cpCES0zJZ9Z3WRpRNUK68ss79CTQ+oUamwfrWnKbHlb1MWkpM8dSGZLUST1ebg7T1
         it+FCe5PVgzWX10EjSPtDAjpJRp0e/JeQxw+1RtQ5ZIAEV5knLtSx2gPRTn9tl8q4Y
         Jrv9rBNnFtaSKEB/UuuqIHhnVI4id3PD9BrecFU1MfyUqyKssY1OEmXaKVEKRg416X
         pKAy5ntwYqyas+f7yfVpllsK94C0470yEyiWLWOgUauLX3xeEoo0K8EMtg84jXV2Hb
         05IsBwxaVHtyW4eytMUAzsFFvrXLPHAyN+gCkaJ+b3O7PdIirofWjws13b/NW7Vqr9
         h0FJmY58jK+Lw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id DF40B5F26;
        Thu, 26 Jul 2018 12:00:12 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu, 26
 Jul 2018 12:00:11 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Christoph Hellwig <hch@lst.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: fix broken noncoherent cache ops
Thread-Topic: [PATCH] ARC: fix broken noncoherent cache ops
Thread-Index: AQHUI1hxAX2+V/l89Ei+Glv9aIIiNQ==
Date:   Thu, 26 Jul 2018 19:00:10 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B084089@us01wembx1.internal.synopsys.com>
References: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
 <20180726091155.GA24209@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 02:08 AM, Christoph Hellwig wrote:=0A=
> On Tue, Jul 24, 2018 at 05:13:02PM +0300, Eugeniy Paltsev wrote:=0A=
>> All DMA devices on ARC haven't worked with SW cache control=0A=
>> since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
>> This happens because we don't check direction argument at all in=0A=
>> new implementation. Fix that.=0A=
>>=0A=
>> Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
>> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> Looks sensible.  Might be worth explaining that ARC can speculate=0A=
> into the areas under DMA, which is why this is required.=0A=
>=0A=
=0A=
ARC CPUs do prefetch, but I doubt if they are doing so, so aggressively, sp=
ecially=0A=
when the region around DMA buffers is unlikely to be used for normal LD/ST=
=0A=
bleeding into DMA buffers. The issue here seems to be less technical and a =
bit of=0A=
snafu in implementation details.=0A=
=0A=
1. originally=0A=
    dma_map_single(@dir)  =3D> honored @dir, and did inv, wback or both dep=
ending on it=0A=
=0A=
    sync_for_device(@dir) =3D> forced @dir DMA_TO_DEV =3D > cache wback=0A=
    sync_for_cpu(@dir)     =3D> forced @dir DMA_FROM_DEV =3D > cache inv=0A=
=0A=
2. After commit a8eb92d02dd7, dma_map_single() starting callingsync_for_dev=
ice( )=0A=
which as noted above didn't respect @dir, only doing cache wback, and thus =
would=0A=
fail for DMA_FROM_DEV/BIDIR cases where cpu needs to read from buffer and t=
hus=0A=
requires cache inv as well. Likewise dma_unmap_single() would unconditional=
ly do=0A=
cache inv, given usage of sync_for_cpu() which would be wrong for the TO_DE=
VICE cases.=0A=
=0A=
Too bad I didn't spot this in the code review myself at the time.=0A=
=0A=
-Vineet=0A=
=0A=
=0A=
=0A=
=0A=
