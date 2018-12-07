Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5582C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B249208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="QcMnNVhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B249208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGPFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:05:00 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:27862 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544195097;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=B89yBndVyqnBFRB3ChSJvKEiBIpiN0+3fBMJx4Olq5g=;
        b=QcMnNVhyxoKRX/ei24ihURkLufEdMIH06+KCU46zJnu65B6Aab+R24uJHoIRvBG1BO
        soW7cOrGUnAnsJKw3pezJ8QY+yUT+mwQ+hqedAb1C0BrOB1mH6vSOxICc6yf63/Z2Ldn
        aCS+l+IkC4PkxYYN+XHnPRywzFw6uEmxwZmaDzKN+jW2vY1zAW+AnqErQmCP3tdZkg+g
        mfuSf1mrLkZv544CK2fpMbCtV4QzpbKEmmdZK95Q8vD4CFto/53PPXjwZsE7P1D1zcIU
        TRNIW1KtDX7OmoPu+UQSyjpGLnQqPU/Y6VZJGInv+Rt7Y8EBl9+F4Ri2D/a/FRoc4w+u
        wv2A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr44+gKiZpmhkMNrXaTDU="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.26]
        by smtp.strato.de (RZmta 44.6 DYNA|AUTH)
        with ESMTPSA id 404b20uB7F4HtiQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Dec 2018 16:04:17 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 01/34] powerpc: use mm zones more sensibly
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20181207140910.GA23609@lst.de>
Date:   Fri, 7 Dec 2018 16:04:16 +0100
Cc:     Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <037E87F4-38C7-4E5F-A132-B7BB30E3D69D@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181114082314.8965-2-hch@lst.de> <20181206140948.GB29741@infradead.org> <87sgz9jzsl.fsf@concordia.ellerman.id.au> <20181207140910.GA23609@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will work at the weekend to figure out where the problematic commit is.

=E2=80=94 Christian

Sent from my iPhone

> On 7. Dec 2018, at 15:09, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Fri, Dec 07, 2018 at 11:18:18PM +1100, Michael Ellerman wrote:
>> Christoph Hellwig <hch@infradead.org> writes:
>>=20
>>> Ben / Michael,
>>>=20
>>> can we get this one queued up for 4.21 to prepare for the DMA work later=

>>> on?
>>=20
>> I was hoping the PASEMI / NXP regressions could be solved before
>> merging.
>>=20
>> My p5020ds is booting fine with this series, so I'm not sure why it's
>> causing problems on Christian's machine.
>>=20
>> The last time I turned on my PASEMI board it tripped some breakers, so I
>> need to investigate that before I can help test that.
>>=20
>> I'll see how things look on Monday and either merge the commits you
>> identified or the whole series depending on if there's any more info
>> from Christian.
>=20
> Christian just confirmed everything up to at least
> "powerpc/dma: stop overriding dma_get_required_mask" works for his
> setups.
