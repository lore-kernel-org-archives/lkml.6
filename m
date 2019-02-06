Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE35C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3061217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549442558;
	bh=Bau3v10/Vt8Y81oqOlrnH3EznqJG2Yu4PBK/974FP94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=R6xx5TQxamGCt+DZkaGIBtYtyB3XQNxkv1efSqZgSTukCCaj97D9ZT/WG3XXPSZuV
	 paz1TLdext+jlSKP5ZfAkU+tBdH7noXIdWgTCpQSB0Wt+ZGWG5mkLNu/XK6GALV0fJ
	 5QzXkcDF+6jXFwMdnFowBGPjS35CS80HP4pa8ykQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfBFImh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfBFImg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:42:36 -0500
Received: from localhost (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9B92073D;
        Wed,  6 Feb 2019 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549442555;
        bh=Bau3v10/Vt8Y81oqOlrnH3EznqJG2Yu4PBK/974FP94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xF4XjsJaKry+RPXfvvQRROGC8Ml71pGnrb3+Ko9He5rqptqwX0aAy1QZOKQnWg781
         op1bumk+QaV4N8XYOrElP4DKMXvhEXwjxNUxZBnUn+hvwJSwGHuZ1tL07sFpCgR8tC
         BOuKKLv+w1UFw0MeyqjeUYB6vgCQdOzrE5Fgy0Fc=
Date:   Wed, 6 Feb 2019 09:42:26 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     <han.xu@nxp.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: gpmi: fix MX28 bus master lockup
 problem
Message-ID: <20190206094226.1dadbf61@kernel.org>
In-Reply-To: <20190205155251.18733-1-martin.kepplinger@ginzinger.com>
References: <20190205155251.18733-1-martin.kepplinger@ginzinger.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, 5 Feb 2019 16:52:51 +0100
Martin Kepplinger <martin.kepplinger@ginzinger.com> wrote:

> Disable BCH soft reset according to MX23 erratum #2847 ("BCH soft
> reset may cause bus master lock up") for MX28 too. It has the same
> problem.
>=20
> Observed problem: once per 100,000+ MX28 reboots NAND read failed on
> DMA timeout errors:
> [    1.770823] UBI: attaching mtd3 to ubi0
> [    2.768088] gpmi_nand: DMA timeout, last DMA :1
> [    3.958087] gpmi_nand: BCH timeout, last DMA :1
> [    4.156033] gpmi_nand: Error in ECC-based read: -110
> [    4.161136] UBI warning: ubi_io_read: error -110 while reading 64
> bytes from PEB 0:0, read only 0 bytes, retry
> [    4.171283] step 1 error
> [    4.173846] gpmi_nand: Chip: 0, Error -1
>=20
> Without BCH soft reset we successfully executed 1,000,000 MX28 reboots.
>=20
> I have a quote from NXP regarding this problem, from July 18th 2016:
>=20
> "As the i.MX23 and i.MX28 are of the same generation, they share many
> characteristics. Unfortunately, also the erratas may be shared.
> In case of the documented erratas and the workarounds, you can also
> apply the workaround solution of one device on the other one. This have
> been reported, but I=E2=80=99m afraid that there are not an estimated dat=
e for
> updating the Errata documents.
> Please accept our apologies for any inconveniences this may cause."
>=20
> Fixes: 6f2a6a52560a ("mtd: nand: gpmi: reset BCH earlier, too, to avoid
> NAND startup problems")

Please make sure this Fixes line is not wrapped next time.

Thanks,

Boris
