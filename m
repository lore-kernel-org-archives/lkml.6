Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F91C282C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9910D21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBHACz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:02:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43137 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfBHACy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:02:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so2034986qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6cLJLbQb0VziB+gnBxS+tInLo6bk7ARyPS9DuV0K2fc=;
        b=QYAk74QIInpSVyEgrz+7P5rlRs3kMOPM+CsqZ6XUe8Ck+kgEDu6F+JshRLDg5geh4Y
         mKsRKq05KmmwW1yy9VU2s8J05v+JHvpO6dIjhkl6+42IulaafkHtNyXuHhcHYi01EgfP
         QEGvfFPBZGqwhLYd4cvwyf8RSSj1MpxK9TFx2zdKRFvqkpqhBPkXBZbtgNh0sLtvWaCF
         zeXXpITHKDXTKeJPnXYl22exf7PYekQBwCZ8xp6rtsOSpejpyLwqY9IV/lHDFTH+h6zv
         z6zMQ3sXQGkVn9klTTZMYQwOfg/xE0bipNnoW49gOGkDpbA5fgRrqdqRbgkm8wCb6ood
         uymg==
X-Gm-Message-State: AHQUAuaMZgrmF/koMbt1ZtKePQPiWTYXomQdL1h/cAzy1EE6ujL3CR5x
        so8Pukr/E8Zq4v/0XlCPuq823Q==
X-Google-Smtp-Source: AHgI3Ias+PeWQp4+/8EmAyOrkcql3Zdh7KCs01nCMrFpxaY0mgqN/FzV4Jir2tUlIAE5EyIeBUxJbQ==
X-Received: by 2002:a0c:8542:: with SMTP id n60mr14056210qva.205.1549584173122;
        Thu, 07 Feb 2019 16:02:53 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id m20sm506468qkk.66.2019.02.07.16.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:02:52 -0800 (PST)
Date:   Thu, 7 Feb 2019 17:02:51 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v11 15/16] tpm: take TPM chip power gating out of
 tpm_transmit()
Message-ID: <20190208000251.4g5gnsalxh7i5dva@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190205224723.19671-16-jarkko.sakkinen@linux.intel.com>
 <dfb224e4-82b8-26c0-e69a-c72d19712d48@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfb224e4-82b8-26c0-e69a-c72d19712d48@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 07 19, Stefan Berger wrote:
>On 2/5/19 5:47 PM, Jarkko Sakkinen wrote:
>>Call tpm_chip_start() and tpm_chip_stop() in
>>
>>* tpm_try_get_ops() and tpm_put_ops()
>>* tpm_chip_register()
>>* tpm2_del_space()
>>
>>And remove these calls from tpm_transmit(). The core reason for this
>>change is that in tpm_vtpm_proxy a locality change requires a virtual
>>TPM command (a command made up just for that driver).
>>
>>The consequence of this is that this commit removes the remaining nested
>>calls.
>>
>>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>Tested-by: Stefan Berger <stefanb@linux.ibm.com>
>>Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>>Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>>---
>>  drivers/char/tpm/tpm-chip.c       | 25 ++++++++++++-------------
>>  drivers/char/tpm/tpm-interface.c  |  6 ------
>>  drivers/char/tpm/tpm.h            |  9 ---------
>>  drivers/char/tpm/tpm2-space.c     |  5 ++++-
>>  drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
>>  5 files changed, 17 insertions(+), 31 deletions(-)
>>
>>diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>index 65f1561eba81..7ad4d9045e4c 100644
>>--- a/drivers/char/tpm/tpm-chip.c
>>+++ b/drivers/char/tpm/tpm-chip.c
>>@@ -41,9 +41,6 @@ static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
>>  {
>>  	int rc;
>>
>>-	if (flags & TPM_TRANSMIT_NESTED)
>>-		return 0;
>>-
>>  	if (!chip->ops->request_locality)
>>  		return 0;
>>
>>@@ -59,9 +56,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
>>  {
>>  	int rc;
>>
>>-	if (flags & TPM_TRANSMIT_NESTED)
>>-		return;
>>-
>>  	if (!chip->ops->relinquish_locality)
>>  		return;
>>
>>@@ -74,9 +68,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
>>
>>  static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
>>  {
>>-	if (flags & TPM_TRANSMIT_NESTED)
>>-		return 0;
>>-
>>  	if (!chip->ops->cmd_ready)
>>  		return 0;
>>
>>@@ -85,9 +76,6 @@ static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
>>
>>  static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
>>  {
>>-	if (flags & TPM_TRANSMIT_NESTED)
>>-		return 0;
>>-
>>  	if (!chip->ops->go_idle)
>>  		return 0;
>>
>>@@ -166,11 +154,17 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>>
>>  	down_read(&chip->ops_sem);
>>  	if (!chip->ops)
>>-		goto out_lock;
>>+		goto out_ops;
>>
>>  	mutex_lock(&chip->tpm_mutex);
>>+	rc = tpm_chip_start(chip, 0);
>>+	if (rc)
>>+		goto out_lock;
>>+
>>  	return 0;
>>  out_lock:
>>+	mutex_unlock(&chip->tpm_mutex);
>>+out_ops:
>>  	up_read(&chip->ops_sem);
>>  	put_device(&chip->dev);
>>  	return rc;
>>@@ -186,6 +180,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>>   */
>>  void tpm_put_ops(struct tpm_chip *chip)
>>  {
>>+	tpm_chip_stop(chip, 0);
>>  	mutex_unlock(&chip->tpm_mutex);
>>  	up_read(&chip->ops_sem);
>>  	put_device(&chip->dev);
>>@@ -563,7 +558,11 @@ int tpm_chip_register(struct tpm_chip *chip)
>>  {
>>  	int rc;
>>
>>+	rc = tpm_chip_start(chip, 0);
>>+	if (rc)
>>+		return rc;
>>  	rc = tpm_auto_startup(chip);
>>+	tpm_chip_stop(chip, 0);
>>  	if (rc)
>>  		return rc;
>>
>>diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>>index f7b7e4e75fcf..f20c78055731 100644
>>--- a/drivers/char/tpm/tpm-interface.c
>>+++ b/drivers/char/tpm/tpm-interface.c
>>@@ -168,13 +168,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>>  	memcpy(save, buf, save_size);
>>
>>  	for (;;) {
>>-		ret = tpm_chip_start(chip, flags);
>>-		if (ret)
>>-			return ret;
>>-
>>  		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
>>-
>>-		tpm_chip_stop(chip, flags);
>>  		if (ret < 0)
>>  			break;
>>  		rc = be32_to_cpu(header->return_code);
>>diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>index 2d6d934f1c8b..53e4208759ee 100644
>>--- a/drivers/char/tpm/tpm.h
>>+++ b/drivers/char/tpm/tpm.h
>>@@ -485,15 +485,6 @@ extern const struct file_operations tpm_fops;
>>  extern const struct file_operations tpmrm_fops;
>>  extern struct idr dev_nums_idr;
>>
>>-/**
>>- * enum tpm_transmit_flags - flags for tpm_transmit()
>>- *
>>- * %TPM_TRANSMIT_NESTED:	discard setup steps (power management, locality)
>>- */
>>-enum tpm_transmit_flags {
>>-	TPM_TRANSMIT_NESTED      = BIT(0),
>>-};
>>-
>>  ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>>  		     unsigned int flags);
>>  ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
>>diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
>>index 9c9ccf2c0681..6c6ad2d4d31b 100644
>>--- a/drivers/char/tpm/tpm2-space.c
>>+++ b/drivers/char/tpm/tpm2-space.c
>>@@ -60,7 +60,10 @@ int tpm2_init_space(struct tpm_space *space)
>>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>>  {
>>  	mutex_lock(&chip->tpm_mutex);
>>-	tpm2_flush_sessions(chip, space);
>>+	if (!tpm_chip_start(chip, 0)) {
>>+		tpm2_flush_sessions(chip, space);
>>+		tpm_chip_stop(chip, 0);
>>+	}
>>  	mutex_unlock(&chip->tpm_mutex);
>>  	kfree(space->context_buf);
>>  	kfree(space->session_buf);
>>diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>>index e8a1da2810a9..a4bb60e163cc 100644
>>--- a/drivers/char/tpm/tpm_vtpm_proxy.c
>>+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>>@@ -417,8 +417,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
>>
>>  	proxy_dev->state |= STATE_DRIVER_COMMAND;
>>
>>-	rc = tpm_transmit_cmd(chip, &buf, 0, TPM_TRANSMIT_NESTED,
>>-			      "attempting to set locality");
>>+	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to set locality");
>>
>>  	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
>>
>This patch seems to be missing a hunk along these lines here
>
>diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>index e74c5b7b64bf..52afe20cc8a1 100644
>--- a/drivers/char/tpm/tpm2-cmd.c
>+++ b/drivers/char/tpm/tpm2-cmd.c
>@@ -799,7 +799,9 @@ int tpm2_probe(struct tpm_chip *chip)
>     tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
>     tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
>     tpm_buf_append_u32(&buf, 1);
>+    tpm_chip_start(chip, 0);
>     rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
>+    tpm_chip_stop(chip, 0);
>     /* We ignore TPM return codes on purpose. */
>     if (rc >=  0) {
>         out = (struct tpm_header *)buf.data;
>
>
>Of course you need to check the error from tpm_chip_start().
>

Reproduced here with discrete chip. Will test fix in a bit.
