Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC28C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C16722B53
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C16722B53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbeGFO0g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:26:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932819AbeGFO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:26:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66ENwjq036962
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 10:26:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k28f4cjnu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:26:34 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 6 Jul 2018 15:26:29 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 15:26:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w66EQPAT26738734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 14:26:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FB8252052;
        Fri,  6 Jul 2018 17:26:49 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.111])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 48F205204E;
        Fri,  6 Jul 2018 17:26:48 +0100 (BST)
Subject: Re: [PATCH v6 09/21] s390: vfio-ap: structure for storing mdev matrix
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-10-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Fri, 6 Jul 2018 16:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530306683-7270-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070614-4275-0000-0000-00000295ECAF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070614-4276-0000-0000-0000379D7A76
Message-Id: <8a708a2e-3961-bd0c-9354-705070ada83d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/29/2018 11:11 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new structure for storing the AP matrix configured
> for the mediated matrix device via its sysfs attributes files.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     |   12 ++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |   24 ++++++++++++++++++++++++
>   2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 4e61e33..bf7ed9f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -20,6 +20,17 @@
>   DEFINE_SPINLOCK(mdev_list_lock);
>   LIST_HEAD(mdev_list);
> 
> +static void vfio_ap_matrix_init(struct ap_matrix *matrix)
> +{
> +	/* Test if PQAP(QCI) instruction is available */
> +	if (test_facility(12))
> +		ap_qci(&matrix->info);
> +
> +	matrix->apm_max = matrix->info.apxa ? matrix->info.Na : 63;
> +	matrix->aqm_max = matrix->info.apxa ? matrix->info.Nd : 15;
> +	matrix->adm_max = matrix->info.apxa ? matrix->info.Nd : 15;
> +}
> +
>   static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   {
>   	struct ap_matrix_dev *matrix_dev =
> @@ -31,6 +42,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>   		return -ENOMEM;
> 
>   	matrix_mdev->name = dev_name(mdev_dev(mdev));
> +	vfio_ap_matrix_init(&matrix_mdev->matrix);
>   	mdev_set_drvdata(mdev, matrix_mdev);
> 
>   	if (atomic_dec_if_positive(&matrix_dev->available_instances) < 0) {
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 3de1275..ae771f5 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -29,9 +29,33 @@ struct ap_matrix_dev {
>   	atomic_t available_instances;
>   };
> 
> +/**
> + * The AP matrix is comprised of three bit masks identifying the adapters,
> + * queues (domains) and control domains that belong to an AP matrix. The bits i
> + * each mask, from least significant to most significant bit, correspond to IDs
> + * 0 to 255. When a bit is set, the corresponding ID belongs to the matrix.
> + *
> + * @apm identifies the AP adapters in the matrix
> + * @apm_max: max adapter number in @apm
> + * @aqm identifies the AP queues (domains) in the matrix
> + * @aqm_max: max domain number in @aqm
> + * @adm identifies the AP control domains in the matrix
> + * @adm_max: max domain number in @adm
> + */
> +struct ap_matrix {
> +	unsigned long apm_max;
> +	DECLARE_BITMAP(apm, 256);
> +	unsigned long aqm_max;
> +	DECLARE_BITMAP(aqm, 256);
> +	unsigned long adm_max;
> +	DECLARE_BITMAP(adm, 256);
> +	struct ap_config_info info;

Why do we maintain (and populate by doing a QCI) the info member on a
per mdev device basis?

> +};
> +
>   struct ap_matrix_mdev {
>   	const char *name;
>   	struct list_head list;
> +	struct ap_matrix matrix;
>   };
> 
>   static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
> 

