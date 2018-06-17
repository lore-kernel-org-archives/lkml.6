Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C696CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C77C208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C77C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbeFQXnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 19:43:33 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48262 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbeFQXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 19:43:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fUhKR-0002cw-Vu; Mon, 18 Jun 2018 00:43:28 +0100
Message-ID: <1529279007.2289.246.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 246/268] media: cx25821: prevent out-of-bounds read
 on array card
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc:     stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 18 Jun 2018 00:43:27 +0100
In-Reply-To: <20180528100231.196118373@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100231.196118373@linuxfoundation.org>
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
> From: Colin Ian King <colin.king@canonical.com>
> 
> [ Upstream commit 67300abdbe9f1717532aaf4e037222762716d0f6 ]
> 
> Currently an out of range dev->nr is detected by just reporting the
> issue and later on an out-of-bounds read on array card occurs because
> of this. Fix this by checking the upper range of dev->nr with the size
> of array card (removes the hard coded size), move this check earlier
> and also exit with the error -ENOSYS to avoid the later out-of-bounds
> array read.

I don't think this is a correct fix.

The card[] array and module parameter appear to be completely
redundant.  Instead of arbitrarily limiting the number of cards that
the driver can bind to, we should remove them.

Ben.

> Detected by CoverityScan, CID#711191 ("Out-of-bounds-read")
> 
> Fixes: commit 02b20b0b4cde ("V4L/DVB (12730): Add conexant cx25821 driver")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> [hans.verkuil@cisco.com: %ld -> %zd]
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/pci/cx25821/cx25821-core.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- a/drivers/media/pci/cx25821/cx25821-core.c
> +++ b/drivers/media/pci/cx25821/cx25821-core.c
> @@ -871,6 +871,10 @@ static int cx25821_dev_setup(struct cx25
>  	dev->nr = ++cx25821_devcount;
>  	sprintf(dev->name, "cx25821[%d]", dev->nr);
>  
> +	if (dev->nr >= ARRAY_SIZE(card)) {
> +		CX25821_INFO("dev->nr >= %zd", ARRAY_SIZE(card));
> +		return -ENODEV;
> +	}
>  	if (dev->pci->device != 0x8210) {
>  		pr_info("%s(): Exiting. Incorrect Hardware device = 0x%02x\n",
>  			__func__, dev->pci->device);
> @@ -886,9 +890,6 @@ static int cx25821_dev_setup(struct cx25
>  		dev->channels[i].sram_channels = &cx25821_sram_channels[i];
>  	}
>  
> -	if (dev->nr > 1)
> -		CX25821_INFO("dev->nr > 1!");
> -
>  	/* board config */
>  	dev->board = 1;		/* card[dev->nr]; */
>  	dev->_max_num_decoders = MAX_DECODERS;

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
