Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC69BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E4C208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E4C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbeFQWMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 18:12:21 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48036 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeFQWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 18:12:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fUfuD-0001DD-Rz; Sun, 17 Jun 2018 23:12:18 +0100
Message-ID: <1529273537.2289.239.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 229/268] media: cx23885: Set subdev host data to
 clk_freq pointer
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date:   Sun, 17 Jun 2018 23:12:17 +0100
In-Reply-To: <20180528100229.115203250@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100229.115203250@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:03 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Brad Love <brad@nextdimension.cc>
> 
> [ Upstream commit 5ceade1d97fc6687e050c44c257382c192f56276 ]
> 
> Currently clk_freq is ignored entirely, because the cx235840 driver
> configures the xtal at the chip defaults. This is an issue if a
> board is produced with a non-default frequency crystal. If clk_freq
> is not zero the cx25840 will attempt to use the setting provided,
> or fall back to defaults otherwise.

This depends on (at least):

commit 3ee9bc12342cf546313d300808ff47d7dbb8e7db
Author: Brad Love <brad@nextdimension.cc>
Date:   Tue Mar 6 14:15:34 2018 -0500

    media: cx25840: Use subdev host data for PLL override

Ben.

> Signed-off-by: Brad Love <brad@nextdimension.cc>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/pci/cx23885/cx23885-cards.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/drivers/media/pci/cx23885/cx23885-cards.c
> +++ b/drivers/media/pci/cx23885/cx23885-cards.c
> @@ -2124,6 +2124,10 @@ void cx23885_card_setup(struct cx23885_d
>  				&dev->i2c_bus[2].i2c_adap,
>  				"cx25840", 0x88 >> 1, NULL);
>  		if (dev->sd_cx25840) {
> +			/* set host data for clk_freq configuration */
> +			v4l2_set_subdev_hostdata(dev->sd_cx25840,
> +						&dev->clk_freq);
> +
>  			dev->sd_cx25840->grp_id = CX23885_HW_AV_CORE;
>  			v4l2_subdev_call(dev->sd_cx25840, core, load_fw);
>  		}

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
