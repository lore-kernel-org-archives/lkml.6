Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC1C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1514B20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1514B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbeKGAnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:43:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387887AbeKGAns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:43:48 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6F5Fdp077822
        for <linux-kernel@vger.kernel.org>; Tue, 6 Nov 2018 10:18:06 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nkaek117y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 10:18:04 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.ibm.com>;
        Tue, 6 Nov 2018 15:18:03 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Nov 2018 15:17:59 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA6FHx3o26214556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 15:17:59 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE1FB124055;
        Tue,  6 Nov 2018 15:17:58 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E17912405E;
        Tue,  6 Nov 2018 15:17:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Nov 2018 15:17:58 +0000 (GMT)
Subject: Re: [PATCH v3 09/16] tpm: encapsulate tpm_dev_transmit()
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
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
 <20181105014552.20262-10-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Date:   Tue, 6 Nov 2018 10:17:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181105014552.20262-10-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18110615-0040-0000-0000-0000048DB415
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009997; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113535; UDB=6.00577119; IPR=6.00893635;
 MB=3.00024046; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-06 15:18:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110615-0041-0000-0000-00000896B8C0
Message-Id: <a002bb09-4a94-5c5b-b468-94ca028cd3f6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/18 8:45 PM, Jarkko Sakkinen wrote:
> Encapsulate tpm_transmit() call pattern to tpm_dev_transmit() because it
> is identically used from two places. Use unlocked version of
> tpm_transmit() so that we are able to move the calls to
> tpm2_prepare_space() and tpm2_commit_space() later on to this new
> function.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   drivers/char/tpm/tpm-dev-common.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 99b5133a9d05..cbb0ee30b511 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -27,7 +27,19 @@
>   static struct workqueue_struct *tpm_dev_wq;
>   static DEFINE_MUTEX(tpm_dev_wq_lock);
>
> -static void tpm_async_work(struct work_struct *work)
> +static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
> +				u8 *buf, size_t bufsiz)
> +{
> +	ssize_t ret;
> +
> +	mutex_lock(&chip->tpm_mutex);
> +	ret = tpm_transmit(chip, space, buf, bufsiz, TPM_TRANSMIT_UNLOCKED);
> +	mutex_unlock(&chip->tpm_mutex);
> +
> +	return ret;
> +}
> +
> +static void tpm_dev_async_work(struct work_struct *work)
>   {
>   	struct file_priv *priv =
>   			container_of(work, struct file_priv, async_work);
> @@ -35,9 +47,8 @@ static void tpm_async_work(struct work_struct *work)
>
>   	mutex_lock(&priv->buffer_mutex);
>   	priv->command_enqueued = false;
> -	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> -			   sizeof(priv->data_buffer), 0);
> -
> +	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
> +			       sizeof(priv->data_buffer));
>   	tpm_put_ops(priv->chip);
>   	if (ret > 0) {
>   		priv->data_pending = ret;
> @@ -78,7 +89,7 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
>   	mutex_init(&priv->buffer_mutex);
>   	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
>   	INIT_WORK(&priv->timeout_work, tpm_timeout_work);
> -	INIT_WORK(&priv->async_work, tpm_async_work);
> +	INIT_WORK(&priv->async_work, tpm_dev_async_work);
>   	init_waitqueue_head(&priv->async_wait);
>   	file->private_data = priv;
>   }
> @@ -163,8 +174,8 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   		return size;
>   	}
>
> -	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> -			   sizeof(priv->data_buffer), 0);
> +	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
> +			       sizeof(priv->data_buffer));
>   	tpm_put_ops(priv->chip);
>
>   	if (ret > 0) {


