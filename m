Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8843320850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="CdTwhn48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8843320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLGHtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:49:08 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:35133 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLGHtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544168945;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Gl/apHLUTNuZTF2PkweCwxqMX9UEFwiI13ErIHyTfqQ=;
        b=CdTwhn48XWCztcJwzR3WH3Ati/WvVpmdbmEb441ZNLZLKKluZkyf2WyYr6OhUFdlaC
        wfRLzFnQ1RuU3AjYiekOsfiFI/4upqOfH+cXH1R2brvxRMxTAjC2KWHET7JmOfIkBaBW
        SJLzlAHkcOqG5dK3INM1Lan8pTsU658MsWI5ixmL9BjHXVByVPHKDZW/ONZ7M3/tauyf
        N22zM0azIfCEjWk6WD7TV8I9ubBrXBH6itygdZkDXQe8T9JYE4rIeaIWojpSieeWLXjy
        pRkTHxGVXdOU7wj24UcSminBlhqGosR8PFTobkmBY9xsDI3pO5nphibmN5ICoWw2h+gK
        qafA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2dxjbphlye1zJi5qqW3t7PS2NPtwqpneosxQ2GK"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b006:4ca9:e4ab:3cb6:b68f:abb5]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uB77mtqPQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Dec 2018 08:48:55 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20181206193605.GA31255@lst.de>
Date:   Fri, 7 Dec 2018 08:48:54 +0100
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC9C556C-B445-4E55-80DA-D5A04C701044@xenosoft.de>
References: <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de> <20181204142426.GA2743@lst.de> <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de> <20181205140550.GA27549@lst.de> <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de> <9ECD27D6-B039-4253-9FB9-749B41DE4CC6@xenosoft.de> <20181206193605.GA31255@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good to know. Sorry because of the email.

Sent from my iPhone

> On 6. Dec 2018, at 20:36, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Thu, Dec 06, 2018 at 06:10:54PM +0100, Christian Zigotzky wrote:
>> Please don=E2=80=99t merge this code. We are still testing and trying to f=
igure out where the problems are in the code.
>=20
> The ones I sent pings for were either tested successfully by you
> (the zone change) or are trivial cleanups that don't affect your setup.
