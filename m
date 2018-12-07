Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B54EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515F20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="pFvpPGWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3515F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLGSdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:33:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:31247 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGSdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544207588;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Wkw19Cqf4hXWDcjQ+2bw2bd7HLuPWYMYHX+Xuy1WZ3Y=;
        b=pFvpPGWxLkvM2Kui+K8bpvOSVqCEQ+3QkH5GnpO/LPJWRf98iuCvBgZ6/ncnNukAU8
        eClx0afbcWkw7DhKp4xwYdBtAsuyaLQIoJbjoQ/w8v7ijPp2CveO3OQCy5AGq9IjkGTq
        Nm6FFCjt7z4261zh801b9wv621KLl7rs48PumUeFLx0Txhx1gGr8CZd4UuZzXBTryi8b
        CwCdo1bd6siDvdqJwvhZy5IdwPOQJ31YHEg7jvSK2gexsA7qSeo0GX/OivHxGwPdRr4d
        qyoxzwLdVjrGHtTB1iw/LP+tq+YOEROQUvLn0JIDb8NjPs6laMtxbMlWHawVJEzmd1CM
        SVYQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4Ql+BpvNtdS8exnpkxv5RWQRrXFM8omzsUn7bjeY="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:dc6:b3f:e87f:7227]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uB7IX2uea
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Dec 2018 19:33:02 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
Date:   Fri, 7 Dec 2018 19:33:01 +0100
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
References: <20181129170351.GC27951@lst.de> <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de> <20181130105346.GB26765@lst.de> <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de> <20181204142426.GA2743@lst.de> <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de> <20181205140550.GA27549@lst.de> <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de> <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next step: 13c1fdec5682b6e13257277fa16aa31f342d167d (powerpc/dma: move pci_d=
ma_dev_setup_swiotlb to fsl_pci.c)

git checkout 13c1fdec5682b6e13257277fa16aa31f342d167d

Result: The PASEMI onboard ethernet works and the X5000 boots.

=E2=80=94 Christian

Sent from my iPhone

> On 7. Dec 2018, at 14:45, Christian Zigotzky <chzigotzky@xenosoft.de> wrot=
e:
>=20
>> On 06 December 2018 at 11:55AM, Christian Zigotzky wrote:
>>> On 05 December 2018 at 3:05PM, Christoph Hellwig wrote:
>>>=20
>>> Thanks.  Can you try a few stepping points in the tree?
>>>=20
>>> First just with commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>>> (the first one) applied?
>>>=20
>>> Second with all commits up to 5da11e49df21f21dac25a2491aa788307bdacb6b
>>>=20
>>> And if that still works with commits up to
>>> c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a
>>>=20
>> Hi Christoph,
>>=20
>> I undid the commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6 with the foll=
owing command:
>>=20
>> git checkout 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>>=20
>> Result: PASEMI onboard ethernet works again and the P5020 board boots.
>>=20
>> I will test the other commits in the next days.
>>=20
>> @All
>> It is really important, that you also test Christoph's work on your PASEM=
I and NXP boards. Could you please help us with solving the issues?
>>=20
>> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'=

>>=20
>> Thanks,
>> Christian
>>=20
>>=20
> Today I tested the commit 5da11e49df21f21dac25a2491aa788307bdacb6b.
>=20
> git checkout 5da11e49df21f21dac25a2491aa788307bdacb6b
>=20
> The PASEMI onboard ethernet works and the P5020 board boots.
>=20
> -- Christian
>=20
