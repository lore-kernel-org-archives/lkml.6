Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520F9C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AB120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AB120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeIDMgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:36:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeIDMgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:36:12 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pH2VgAipDmoF; Tue,  4 Sep 2018 10:11:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32DE81EC0424;
        Tue,  4 Sep 2018 10:11:52 +0200 (CEST)
Date:   Tue, 4 Sep 2018 10:11:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     linux-crypto@vger.kernel.org, thomas.lendacky@amd.com,
        Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH crypto-2.6] crypto: ccp: add timeout support in the SEV
 command
Message-ID: <20180904081151.GC32615@zn.tnic>
References: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
 <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 04:11:25PM -0500, Brijesh Singh wrote:
> Currently, the CCP driver assumes that the SEV command issued to the PSP
> will always return (i.e. it will never hang).  But recently, firmware bugs
> have shown that a command can hang.  Since of the SEV commands are used
> in probe routines, this can cause boot hangs and/or loss of virtualization
> capabilities.
> 
> To protect against firmware bugs, add a timeout in the SEV command
> execution flow.  If a command does not complete within the specified
> timeout then return -ETIMEOUT and stop the driver from executing any
> further commands since the state of the SEV firmware is unknown.
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Gary Hook <Gary.Hook@amd.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  drivers/crypto/ccp/psp-dev.c | 46 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index 218739b..72790d8 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -38,6 +38,17 @@ static DEFINE_MUTEX(sev_cmd_mutex);
>  static struct sev_misc_dev *misc_dev;
>  static struct psp_device *psp_master;
>  
> +static int psp_cmd_timeout = 100;
> +module_param(psp_cmd_timeout, int, 0644);
> +MODULE_PARM_DESC(psp_cmd_timeout, " default timeout value, in seconds, for PSP commands");
> +
> +static int psp_probe_timeout = 5;
> +module_param(psp_probe_timeout, int, 0644);
> +MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during PSP device probe");

Just a question: what prevents the user from supplying non-sensical
values here?

I think we should clamp them to only allowed values because I don't want
to be debugging some strange bugs due to that.

> +
> +static bool psp_dead;
> +static int psp_timeout;
> +
>  static struct psp_device *psp_alloc_struct(struct sp_device *sp)
>  {
>  	struct device *dev = sp->dev;
> @@ -82,10 +93,19 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static void sev_wait_cmd_ioc(struct psp_device *psp, unsigned int *reg)
> +static int sev_wait_cmd_ioc(struct psp_device *psp,
> +			    unsigned int *reg, unsigned int timeout)
>  {
> -	wait_event(psp->sev_int_queue, psp->sev_int_rcvd);
> +	int ret;
> +
> +	ret = wait_event_timeout(psp->sev_int_queue,
> +			psp->sev_int_rcvd, timeout * HZ);

Align args at opening brace.

> +	if (!ret)
> +		return -ETIMEDOUT;
> +
>  	*reg = ioread32(psp->io_regs + psp->vdata->cmdresp_reg);
> +
> +	return 0;
>  }
>  
>  static int sev_cmd_buffer_len(int cmd)
> @@ -133,12 +153,15 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>  	if (!psp)
>  		return -ENODEV;
>  
> +	if (psp_dead)
> +		return -EBUSY;
> +
>  	/* Get the physical address of the command buffer */
>  	phys_lsb = data ? lower_32_bits(__psp_pa(data)) : 0;
>  	phys_msb = data ? upper_32_bits(__psp_pa(data)) : 0;
>  
> -	dev_dbg(psp->dev, "sev command id %#x buffer 0x%08x%08x\n",
> -		cmd, phys_msb, phys_lsb);
> +	dev_dbg(psp->dev, "sev command id %#x buffer 0x%08x%08x timeout %us\n",
> +		cmd, phys_msb, phys_lsb, psp_timeout);
>  
>  	print_hex_dump_debug("(in):  ", DUMP_PREFIX_OFFSET, 16, 2, data,
>  			     sev_cmd_buffer_len(cmd), false);
> @@ -154,7 +177,18 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>  	iowrite32(reg, psp->io_regs + psp->vdata->cmdresp_reg);
>  
>  	/* wait for command completion */
> -	sev_wait_cmd_ioc(psp, &reg);
> +	ret = sev_wait_cmd_ioc(psp, &reg, psp_timeout);
> +	if (ret) {
> +		if (psp_ret)
> +			*psp_ret = 0;
> +
> +		dev_err(psp->dev, "sev command %#x timed out, disabling PSP \n", cmd);
									   ^

Trailing space.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
