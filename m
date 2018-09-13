Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E744C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B08A20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="GQUlokh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B08A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIMN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:29:12 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:49776 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIMN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:29:12 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2c:7d03:949b:de91:81b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 43CDD400065;
        Thu, 13 Sep 2018 10:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1536826847;
        bh=k6Qp03K7G+7I01MC1SelgnPubMHoEdSNa0sDF/mtRHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GQUlokh92+2/KiB9/3czgZtL9eHAvNa0nh6/mqKhSBewxROXUVstV0tJvwc8pg/ot
         M82OwnlgagnZnWIU+AeFsc17AJ49ko356qkajLDm/K+nfraY+qkIssM9ZASNQU2DJE
         as1sC0nhCLQcPX+9zjn5GtqTzTeF7rHPq9KLKKPI=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
Date:   Thu, 13 Sep 2018 10:20:45 +0200
MIME-Version: 1.0
Message-ID: <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
In-Reply-To: <20180913094515.351967bb@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C4=8Dtvrtek 13. z=C3=A1=C5=99=C3=AD 2018 9:45:15 CEST, Thomas Petazzoni w=
rote:
> What about something like the below. I tested it, including the error
> case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
> after pci_unmap_iospace(). Actually, I would prefer to use
> pci_remap_iospace() and pci_unmap_iospace() but for now this API
> doesn't allow overloading the memory type used for the mapping.

Thanks for providing this fix so quickly, Thomas. I can confirm that this=20
patch -- tested on top of 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge=20=

tag 'pci-v4.19-fixes-1' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"). Disclaimer: I=20=

have zero familiarity with Linux' PCI code.

Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

With kind regards,
Jan
