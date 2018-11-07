Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481DEC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127DC204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127DC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeKGPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:46:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbeKGPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:46:45 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA76Eaif131108
        for <linux-kernel@vger.kernel.org>; Wed, 7 Nov 2018 01:17:51 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nks4db852-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 01:17:50 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 7 Nov 2018 06:17:50 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Nov 2018 06:17:48 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA76Hllg19202132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 06:17:47 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32FBF6A054;
        Wed,  7 Nov 2018 06:17:47 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CB8B6A04F;
        Wed,  7 Nov 2018 06:17:45 +0000 (GMT)
Received: from [9.124.31.41] (unknown [9.124.31.41])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  7 Nov 2018 06:17:44 +0000 (GMT)
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Wed, 7 Nov 2018 11:44:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181106150159.1136-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18110706-0004-0000-0000-000014AE451B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010001; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01113835; UDB=6.00577421; IPR=6.00893935;
 MB=3.00024054; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-07 06:17:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110706-0005-0000-0000-0000896D6A5F
Message-Id: <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811070057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2018 08:31 PM, Roberto Sassu wrote:
> This patch removes the hard-coded limit of the active_banks array size.


The hard-coded limit in static array active_banks[] represents the 
maximum possible banks.
A TPM might have three banks, but only one bank may be active.

To confirm my understanding, is the idea for this patch is to 
dynamically identify the number of possible banks or the number of 
active banks ?


> It stores in the tpm_chip structure the number of active PCR banks,
> determined in tpm2_get_pcr_allocation(), and replaces the static array
> with a pointer to a dynamically allocated array.
>
> As a consequence of the introduction of nr_active_banks, tpm_pcr_extend()
> does not check anymore if the algorithm stored in tpm_chip is equal to
> zero. The active_banks array always contains valid algorithms.
>
> Fixes: 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
> PCR banks")
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   drivers/char/tpm/tpm-chip.c      |  1 +
>   drivers/char/tpm/tpm-interface.c | 19 ++++++++++++-------
>   drivers/char/tpm/tpm.h           |  3 ++-
>   drivers/char/tpm/tpm2-cmd.c      | 17 ++++++++---------
>   4 files changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 46caadca916a..2a9e8b744436 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -160,6 +160,7 @@ static void tpm_dev_release(struct device *dev)
>   	kfree(chip->log.bios_event_log);
>   	kfree(chip->work_space.context_buf);
>   	kfree(chip->work_space.session_buf);
> +	kfree(chip->active_banks);
>   	kfree(chip);
>   }
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1a803b0cf980..ba7ca6b3e664 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1039,8 +1039,7 @@ static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
>   int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>   {
>   	int rc;
> -	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
> -	u32 count = 0;
> +	struct tpm2_digest *digest_list;
>   	int i;
>
>   	chip = tpm_find_get_ops(chip);
> @@ -1048,16 +1047,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
>   		return -ENODEV;
>
>   	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		memset(digest_list, 0, sizeof(digest_list));
> +		digest_list = kmalloc_array(chip->nr_active_banks,
> +					    sizeof(*digest_list), GFP_KERNEL);
> +		if (!digest_list)
> +			return -ENOMEM;
>
> -		for (i = 0; i < ARRAY_SIZE(chip->active_banks) &&
> -			    chip->active_banks[i] != TPM2_ALG_ERROR; i++) {
> +		memset(digest_list, 0,
> +		       chip->nr_active_banks * sizeof(*digest_list));
> +
> +		for (i = 0; i < chip->nr_active_banks; i++) {
>   			digest_list[i].alg_id = chip->active_banks[i];
>   			memcpy(digest_list[i].digest, hash, TPM_DIGEST_SIZE);
> -			count++;
>   		}
>
> -		rc = tpm2_pcr_extend(chip, pcr_idx, count, digest_list);
> +		rc = tpm2_pcr_extend(chip, pcr_idx, chip->nr_active_banks,
> +				     digest_list);
> +		kfree(digest_list);
>   		tpm_put_ops(chip);
>   		return rc;
>   	}
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f3501d05264f..98368c3a6ff7 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -248,7 +248,8 @@ struct tpm_chip {
>   	const struct attribute_group *groups[3];
>   	unsigned int groups_cnt;
>
> -	u16 active_banks[7];
> +	u32 nr_active_banks;
> +	u16 *active_banks;
>   #ifdef CONFIG_ACPI
>   	acpi_handle acpi_dev_handle;
>   	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index c31b490bd41d..533089cede07 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -242,7 +242,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, int pcr_idx, u32 count,
>   	int i;
>   	int j;
>
> -	if (count > ARRAY_SIZE(chip->active_banks))
> +	if (count > chip->nr_active_banks)
>   		return -EINVAL;
>
>   	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
> @@ -859,7 +859,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>   	void *marker;
>   	void *end;
>   	void *pcr_select_offset;
> -	unsigned int count;
>   	u32 sizeof_pcr_selection;
>   	u32 rsp_len;
>   	int rc;
> @@ -878,11 +877,14 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>   	if (rc)
>   		goto out;
>
> -	count = be32_to_cpup(
> +	chip->nr_active_banks = be32_to_cpup(
>   		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);


As per my understanding, the count in the TPML_PCR_SELECTION represent 
the number of possible banks and not the number of active banks.
TCG Structures Spec for TPM 2.0 - Table 102 mentions this as explanation 
of #TPM_RC_SIZE.

Thanks & Regards,
     - Nayna


>
> -	if (count > ARRAY_SIZE(chip->active_banks)) {
> -		rc = -ENODEV;
> +	chip->active_banks = kmalloc_array(chip->nr_active_banks,
> +					   sizeof(*chip->active_banks),
> +					   GFP_KERNEL);
> +	if (!chip->active_banks) {
> +		rc = -ENOMEM;
>   		goto out;
>   	}
>
> @@ -891,7 +893,7 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>   	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
>   	end = &buf.data[rsp_len];
>
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < chip->nr_active_banks; i++) {
>   		pcr_select_offset = marker +
>   			offsetof(struct tpm2_pcr_selection, size_of_select);
>   		if (pcr_select_offset >= end) {
> @@ -908,9 +910,6 @@ static ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>   	}
>
>   out:
> -	if (i < ARRAY_SIZE(chip->active_banks))
> -		chip->active_banks[i] = TPM2_ALG_ERROR;
> -
>   	tpm_buf_destroy(&buf);
>
>   	return rc;

