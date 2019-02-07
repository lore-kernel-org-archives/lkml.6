Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E92EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119C121907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBGXc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:32:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbfBGXc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:32:26 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x17NSnlE151877
        for <linux-kernel@vger.kernel.org>; Thu, 7 Feb 2019 18:32:25 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qgx2pgvfb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 18:32:24 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Thu, 7 Feb 2019 23:32:24 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Feb 2019 23:32:20 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x17NWIqH5898256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 23:32:19 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A99CC78069;
        Thu,  7 Feb 2019 23:32:18 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC04778066;
        Thu,  7 Feb 2019 23:32:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  7 Feb 2019 23:32:17 +0000 (GMT)
Subject: Re: [PATCH v11 15/16] tpm: take TPM chip power gating out of
 tpm_transmit()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190205224723.19671-16-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 7 Feb 2019 18:32:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190205224723.19671-16-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 19020723-8235-0000-0000-00000E584CB9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010556; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157809; UDB=6.00604069; IPR=6.00938340;
 MB=3.00025484; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-07 23:32:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020723-8236-0000-0000-000044619E9D
Message-Id: <dfb224e4-82b8-26c0-e69a-c72d19712d48@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 5:47 PM, Jarkko Sakkinen wrote:
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
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>   drivers/char/tpm/tpm-chip.c       | 25 ++++++++++++-------------
>   drivers/char/tpm/tpm-interface.c  |  6 ------
>   drivers/char/tpm/tpm.h            |  9 ---------
>   drivers/char/tpm/tpm2-space.c     |  5 ++++-
>   drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
>   5 files changed, 17 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 65f1561eba81..7ad4d9045e4c 100644
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
> @@ -166,11 +154,17 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>
>   	down_read(&chip->ops_sem);
>   	if (!chip->ops)
> -		goto out_lock;
> +		goto out_ops;
>
>   	mutex_lock(&chip->tpm_mutex);
> +	rc = tpm_chip_start(chip, 0);
> +	if (rc)
> +		goto out_lock;
> +
>   	return 0;
>   out_lock:
> +	mutex_unlock(&chip->tpm_mutex);
> +out_ops:
>   	up_read(&chip->ops_sem);
>   	put_device(&chip->dev);
>   	return rc;
> @@ -186,6 +180,7 @@ EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>    */
>   void tpm_put_ops(struct tpm_chip *chip)
>   {
> +	tpm_chip_stop(chip, 0);
>   	mutex_unlock(&chip->tpm_mutex);
>   	up_read(&chip->ops_sem);
>   	put_device(&chip->dev);
> @@ -563,7 +558,11 @@ int tpm_chip_register(struct tpm_chip *chip)
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
> index f7b7e4e75fcf..f20c78055731 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -168,13 +168,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>   	memcpy(save, buf, save_size);
>
>   	for (;;) {
> -		ret = tpm_chip_start(chip, flags);
> -		if (ret)
> -			return ret;
> -
>   		ret = tpm_try_transmit(chip, buf, bufsiz, flags);
> -
> -		tpm_chip_stop(chip, flags);
>   		if (ret < 0)
>   			break;
>   		rc = be32_to_cpu(header->return_code);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2d6d934f1c8b..53e4208759ee 100644
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
> index 9c9ccf2c0681..6c6ad2d4d31b 100644
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
This patch seems to be missing a hunk along these lines here

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e74c5b7b64bf..52afe20cc8a1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -799,7 +799,9 @@ int tpm2_probe(struct tpm_chip *chip)
      tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
      tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
      tpm_buf_append_u32(&buf, 1);
+    tpm_chip_start(chip, 0);
      rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
+    tpm_chip_stop(chip, 0);
      /* We ignore TPM return codes on purpose. */
      if (rc >=  0) {
          out = (struct tpm_header *)buf.data;


Of course you need to check the error from tpm_chip_start().

