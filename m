Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id s2oMJ/IiHltkbgAAmS7hNA
	; Mon, 11 Jun 2018 07:21:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 792F7607A4; Mon, 11 Jun 2018 07:21:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DBF8660385;
	Mon, 11 Jun 2018 07:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBF8660385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754126AbeFKHVT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:21:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36117 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754035AbeFKHVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:21:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C055DADE3;
        Mon, 11 Jun 2018 07:21:16 +0000 (UTC)
Date: Mon, 11 Jun 2018 09:21:16 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: add error handling for pcmcia_enable_device
Message-ID: <20180611072116.vaz4xff4pd6qxtj7@linux-x5ow.site>
References: <1528694152-31724-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528694152-31724-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 01:15:50PM +0800, Zhouyang Jia wrote:
> When pcmcia_enable_device fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling pcmcia_enable_device.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/scsi/pcmcia/qlogic_stub.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/pcmcia/qlogic_stub.c b/drivers/scsi/pcmcia/qlogic_stub.c
> index 0556054..9287d52 100644
> --- a/drivers/scsi/pcmcia/qlogic_stub.c
> +++ b/drivers/scsi/pcmcia/qlogic_stub.c
> @@ -254,8 +254,14 @@ static void qlogic_release(struct pcmcia_device *link)
>  static int qlogic_resume(struct pcmcia_device *link)
>  {
>  	scsi_info_t *info = link->priv;
> +	int ret;
> +
> +	ret = pcmcia_enable_device(link);
> +	if (ret) {
> +		pcmcia_disable_device(link);
> +		return -ENODEV;
> +	}

pcmcia_enable_device() can fail for three reasons:
1) the socket is not present
2) the configuration is locked
3) setting the socket's power control fails

In all three cases I think it's actually an error to call
pcmcia_disable_device().

Imagine the following scenario:
pcmcia_enable_device() failed because the device configuration is
locked by another driver, then you call pcmcia_disable_device() which
calls pcmcia_release_configuration(). pcmcia_release_configuration()
checks if the device is locked, decrements the lock counter, clears
the CONFIG_LOCKED bit in the PCMCIA config and sets the voltage to 0
without the first driver every noticing it.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
