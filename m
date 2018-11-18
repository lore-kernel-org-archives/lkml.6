Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2A3C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BE420869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BE420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeKSJO2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:14:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:15513 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbeKSJO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:14:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2018 14:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,250,1539673200"; 
   d="scan'208";a="86926246"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2018 14:52:51 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 18 Nov 2018 14:52:51 -0800
Received: from lcsmsx152.ger.corp.intel.com (10.186.165.231) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 18 Nov 2018 14:52:50 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.165]) by
 LCSMSX152.ger.corp.intel.com ([10.186.165.231]) with mapi id 14.03.0415.000;
 Mon, 19 Nov 2018 00:52:47 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Thread-Topic: [PATCH v9 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Thread-Index: AQHUfz1kjDc6O/MrFEGwY/E2owDDkKVWI+9Q
Date:   Sun, 18 Nov 2018 22:52:46 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DA225B9@hasmsx108.ger.corp.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-17-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181118124753.18613-17-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjAyNTlmMjctM2NjMS00OTYxLTg2Y2QtNTg2YWI4ZWNmYzBjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSDFtWDRMUWQ3UUlYekJDUG1tSGUzeVJaZFlVbVJ0em52TUNDN3VRQmJscGZSM0Z6dmMzV3ZVQ2lDbzlhMmlGWSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.255.200.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> Call tpm_chip_start() and tpm_chip_stop() in
> 
> * tpm_try_get_ops() and tpm_put_ops()
> * tpm_chip_register()
> * tpm2_del_space()
> 
> And remove these calls from tpm_transmit(). The core reason for this change
> is that in tpm_vtpm_proxy a locality change requires a virtual TPM command
> (a command made up just for that driver).
> 
> The consequence of this is that this commit removes the remaining nested
> calls.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

This is still NACK from my side
Tomas

> ---
>  drivers/char/tpm/tpm-chip.c       | 25 ++++++++++++-------------
>  drivers/char/tpm/tpm-interface.c  |  4 ----
>  drivers/char/tpm/tpm.h            |  9 ---------
>  drivers/char/tpm/tpm2-space.c     |  5 ++++-
>  drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
>  5 files changed, 17 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c index
> 65f1561eba81..7ad4d9045e4c 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -41,9 +41,6 @@ static int tpm_request_locality(struct tpm_chip *chip,
> unsigned int flags)  {
>  	int rc;
> 
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
>  	if (!chip->ops->request_locality)
>  		return 0;
> 
> @@ -59,9 +56,6 @@ static void tpm_relinquish_locality(struct tpm_chip
> *chip, unsigned int flags)  {
>  	int rc;
> 
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return;
> -
>  	if (!chip->ops->relinquish_locality)
>  		return;
> 
> @@ -74,9 +68,6 @@ static void tpm_relinquish_locality(struct tpm_chip
> *chip, unsigned int flags)
> 
>  static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)  {
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
>  	if (!chip->ops->cmd_ready)
>  		return 0;
> 
> @@ -85,9 +76,6 @@ static int tpm_cmd_ready(struct tpm_chip *chip,
> unsigned int flags)
> 
>  static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)  {
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
>  	if (!chip->ops->go_idle)
>  		return 0;
> 
> @@ -166,11 +154,17 @@ int tpm_try_get_ops(struct tpm_chip *chip)
> 
>  	down_read(&chip->ops_sem);
>  	if (!chip->ops)
> -		goto out_lock;
> +		goto out_ops;
> 
>  	mutex_lock(&chip->tpm_mutex);
> +	rc = tpm_chip_start(chip, 0);
> +	if (rc)
> +		goto out_lock;
> +
>  	return 0;
>  out_lock:
> +	mutex_unlock(&chip->tpm_mutex);
> +out_ops:
>  	up_read(&chip->ops_sem);
>  	put_device(&chip->dev);
>  	return rc;
> @@ -186,6 +180,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>   */
>  void tpm_put_ops(struct tpm_chip *chip)  {
> +	tpm_chip_stop(chip, 0);
>  	mutex_unlock(&chip->tpm_mutex);
>  	up_read(&chip->ops_sem);
>  	put_device(&chip->dev);
> @@ -563,7 +558,11 @@ int tpm_chip_register(struct tpm_chip *chip)  {
>  	int rc;
> 
> +	rc = tpm_chip_start(chip, 0);
> +	if (rc)
> +		return rc;
>  	rc = tpm_auto_startup(chip);
> +	tpm_chip_stop(chip, 0);
>  	if (rc)
>  		return rc;
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 2c79284ffd4e..21ac8da94d90 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -168,11 +168,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8
> *buf, size_t bufsiz,
>  	memcpy(save, buf, save_size);
> 
>  	for (;;) {
> -		ret = tpm_chip_start(chip, flags);
> -		if (ret)
> -			return ret;
>  		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
> -		tpm_chip_stop(chip, flags);
>  		if (ret < 0)
>  			break;
>  		rc = be32_to_cpu(header->return_code); diff --git
> a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h index
> c42a75710b70..f9d56dfd0d20 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -485,15 +485,6 @@ extern const struct file_operations tpm_fops;
> extern const struct file_operations tpmrm_fops;  extern struct idr
> dev_nums_idr;
> 
> -/**
> - * enum tpm_transmit_flags - flags for tpm_transmit()
> - *
> - * %TPM_TRANSMIT_NESTED:	discard setup steps (power management,
> locality)
> - */
> -enum tpm_transmit_flags {
> -	TPM_TRANSMIT_NESTED      = BIT(0),
> -};
> -
>  ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  		     unsigned int flags);
>  ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf, diff -
> -git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index ced1dc91ba6f..d913715d30aa 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -60,7 +60,10 @@ int tpm2_init_space(struct tpm_space *space)  void
> tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)  {
>  	mutex_lock(&chip->tpm_mutex);
> -	tpm2_flush_sessions(chip, space);
> +	if (!tpm_chip_start(chip, 0)) {
> +		tpm2_flush_sessions(chip, space);
> +		tpm_chip_stop(chip, 0);
> +	}
>  	mutex_unlock(&chip->tpm_mutex);
>  	kfree(space->context_buf);
>  	kfree(space->session_buf);
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c
> b/drivers/char/tpm/tpm_vtpm_proxy.c
> index e8a1da2810a9..a4bb60e163cc 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -417,8 +417,7 @@ static int vtpm_proxy_request_locality(struct
> tpm_chip *chip, int locality)
> 
>  	proxy_dev->state |= STATE_DRIVER_COMMAND;
> 
> -	rc = tpm_transmit_cmd(chip, &buf, 0, TPM_TRANSMIT_NESTED,
> -			      "attempting to set locality");
> +	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to set locality");
> 
>  	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
> 
> --
> 2.19.1

