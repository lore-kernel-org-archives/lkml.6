Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9816EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDB72087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDB72087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbeKQDPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:15:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbeKQDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:15:36 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAGGx9fY067666
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:02:25 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nsy5vfry3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:02:24 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Fri, 16 Nov 2018 17:02:23 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Nov 2018 17:02:18 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAGH2HX143384858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 17:02:17 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B68E4AC05F;
        Fri, 16 Nov 2018 17:02:17 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ED6BAC065;
        Fri, 16 Nov 2018 17:02:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 16 Nov 2018 17:02:17 +0000 (GMT)
Subject: Re: [PATCH v8 16/17] tpm: take TPM chip power gating out of
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
References: <20181116123845.15705-1-jarkko.sakkinen@linux.intel.com>
 <20181116123845.15705-17-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 16 Nov 2018 12:02:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181116123845.15705-17-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18111617-0040-0000-0000-00000493A89E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010062; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118355; UDB=6.00577119; IPR=6.00898464;
 MB=3.00024196; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 17:02:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111617-0041-0000-0000-0000089CB510
Message-Id: <fdfb4ac9-14ed-9a42-c5fb-69d59208875a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 7:38 AM, Jarkko Sakkinen wrote:
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
>   drivers/char/tpm/tpm-chip.c       | 21 ++++++++-------------
>   drivers/char/tpm/tpm-interface.c  |  4 ----
>   drivers/char/tpm/tpm.h            |  9 ---------
>   drivers/char/tpm/tpm2-space.c     |  5 ++++-
>   drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
>   5 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 65f1561eba81..837d44fa0797 100644
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
> @@ -169,7 +157,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>   		goto out_lock;
>
>   	mutex_lock(&chip->tpm_mutex);
> -	return 0;
> +	rc = tpm_chip_start(chip, 0);
> +	if (rc)
> +		mutex_unlock(&chip->tpm_mutex);

This cannot be right to fall through to up_read() etc.


>   out_lock:
>   	up_read(&chip->ops_sem);
>   	put_device(&chip->dev);
> @@ -186,6 +176,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>    */
>   void tpm_put_ops(struct tpm_chip *chip)
>   {
> +	tpm_chip_stop(chip, 0);
>   	mutex_unlock(&chip->tpm_mutex);
>   	up_read(&chip->ops_sem);
>   	put_device(&chip->dev);
> @@ -563,7 +554,11 @@ int tpm_chip_register(struct tpm_chip *chip)
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
> index 2c79284ffd4e..21ac8da94d90 100644
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
>   		if (ret < 0)
>   			break;
>   		rc = be32_to_cpu(header->return_code);
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

