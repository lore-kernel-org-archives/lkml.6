Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FBC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77D3223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77D3223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeKNH0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:26:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbeKNH0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:26:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wADLIbGs130852
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:26:09 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nr3nmq0b8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:26:09 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Tue, 13 Nov 2018 21:26:08 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Nov 2018 21:26:04 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wADLQ35q24182864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 21:26:03 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 846B111206B;
        Tue, 13 Nov 2018 21:26:03 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66CEB112065;
        Tue, 13 Nov 2018 21:26:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Nov 2018 21:26:03 +0000 (GMT)
Subject: Re: [PATCH v7 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181113183620.27447-1-jarkko.sakkinen@linux.intel.com>
 <20181113183620.27447-17-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Tue, 13 Nov 2018 16:26:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181113183620.27447-17-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18111321-0072-0000-0000-000003C83E61
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010043; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117005; UDB=6.00577118; IPR=6.00897113;
 MB=3.00024147; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-13 21:26:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111321-0073-0000-0000-00004A190D0D
Message-Id: <ee6b0c58-bc76-aa98-6e23-74d14ec7e2bc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811130192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 1:36 PM, Jarkko Sakkinen wrote:
> Call tpm_chip_start() and tpm_chip_stop() in
>
> * tpm_try_get_ops() and tpm_put_ops()
> * tpm_chip_register()
> * tpm2_del_space()
>
> And remove these calls from tpm_transmit(). The core reason for this
> change is that in tpm_vtpm_proxy a locality change requires a virtual
> TPM command (a command made up just for that driver).
>
> The consequence of this is that this commit removes the remaining nested
> calls.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-chip.c       | 19 ++++++-------------
>   drivers/char/tpm/tpm-interface.c  |  4 ----
>   drivers/char/tpm/tpm.h            |  9 ---------
>   drivers/char/tpm/tpm2-space.c     |  5 ++++-
>   drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
>   5 files changed, 11 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 65f1561eba81..87570182f75e 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -41,9 +41,6 @@ static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
>   {
>   	int rc;
>
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
>   	if (!chip->ops->request_locality)
>   		return 0;
>
> @@ -59,9 +56,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
>   {
>   	int rc;
>
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return;
> -
>   	if (!chip->ops->relinquish_locality)
>   		return;
>
> @@ -74,9 +68,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
>
>   static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
>   {
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
>   	if (!chip->ops->cmd_ready)
>   		return 0;
>
> @@ -85,9 +76,6 @@ static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
>
>   static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
>   {
> -	if (flags & TPM_TRANSMIT_NESTED)
> -		return 0;
> -
>   	if (!chip->ops->go_idle)
>   		return 0;
>
> @@ -169,7 +157,7 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>   		goto out_lock;
>
>   	mutex_lock(&chip->tpm_mutex);
> -	return 0;
> +	return tpm_chip_start(chip, 0);


If this call fails, you have to clean up. Callers will not do it.


>   out_lock:
>   	up_read(&chip->ops_sem);
>   	put_device(&chip->dev);
> @@ -186,6 +174,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>    */
>   void tpm_put_ops(struct tpm_chip *chip)
>   {
> +	tpm_chip_stop(chip, 0);
>   	mutex_unlock(&chip->tpm_mutex);
>   	up_read(&chip->ops_sem);
>   	put_device(&chip->dev);
> @@ -563,7 +552,11 @@ int tpm_chip_register(struct tpm_chip *chip)
>   {
>   	int rc;
>
> +	rc = tpm_chip_start(chip, 0);
> +	if (rc)
> +		return rc;
>   	rc = tpm_auto_startup(chip);
> +	tpm_chip_stop(chip, 0);
>   	if (rc)
>   		return rc;
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 888c9923fca1..5c04c0d9aaba 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -168,11 +168,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   	memcpy(save, buf, save_size);
>
>   	for (;;) {
> -		ret = tpm_chip_start(chip, flags);
> -		if (ret)
> -			return ret;
>   		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
> -		tpm_chip_stop(chip, flags);
>
>   		rc = be32_to_cpu(header->return_code);
>   		if (rc != TPM2_RC_RETRY && rc != TPM2_RC_TESTING)
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index c42a75710b70..f9d56dfd0d20 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -485,15 +485,6 @@ extern const struct file_operations tpm_fops;
>   extern const struct file_operations tpmrm_fops;
>   extern struct idr dev_nums_idr;
>
> -/**
> - * enum tpm_transmit_flags - flags for tpm_transmit()
> - *
> - * %TPM_TRANSMIT_NESTED:	discard setup steps (power management, locality)
> - */
> -enum tpm_transmit_flags {
> -	TPM_TRANSMIT_NESTED      = BIT(0),
> -};
> -
>   ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   		     unsigned int flags);
>   ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index ced1dc91ba6f..d913715d30aa 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -60,7 +60,10 @@ int tpm2_init_space(struct tpm_space *space)
>   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>   {
>   	mutex_lock(&chip->tpm_mutex);
> -	tpm2_flush_sessions(chip, space);
> +	if (!tpm_chip_start(chip, 0)) {
> +		tpm2_flush_sessions(chip, space);
> +		tpm_chip_stop(chip, 0);
> +	}
>   	mutex_unlock(&chip->tpm_mutex);
>   	kfree(space->context_buf);
>   	kfree(space->session_buf);
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index e8a1da2810a9..a4bb60e163cc 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -417,8 +417,7 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
>
>   	proxy_dev->state |= STATE_DRIVER_COMMAND;
>
> -	rc = tpm_transmit_cmd(chip, &buf, 0, TPM_TRANSMIT_NESTED,
> -			      "attempting to set locality");
> +	rc = tpm_transmit_cmd(chip, &buf, 0, 0, "attempting to set locality");
>
>   	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
>

