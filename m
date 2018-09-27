Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFC2215EB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFC2215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeI0Rvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:51:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbeI0Rvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:51:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RBOWLR092106
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:33:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrx798nh2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:33:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Sep 2018 12:33:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 12:33:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8RBXlGj60555432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 11:33:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3667A404D;
        Thu, 27 Sep 2018 14:33:27 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A0B2A405D;
        Thu, 27 Sep 2018 14:33:26 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.85.160])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 14:33:26 +0100 (BST)
Subject: Re: [PATCH v4 2/6] ima: prevent kexec_load syscall based on runtime
 secureboot flag
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, Seth Forshee <seth.forshee@canonical.com>,
        kexec <kexec@lists.infradead.org>
Date:   Thu, 27 Sep 2018 07:33:35 -0400
In-Reply-To: <20180926122210.14642-3-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
         <20180926122210.14642-3-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092711-4275-0000-0000-000002C14823
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092711-4276-0000-0000-000037CC4AF4
Message-Id: <1538048015.3459.76.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc'ing the kexec mailing list, and Seth]

On Wed, 2018-09-26 at 17:52 +0530, Nayna Jain wrote:
> When CONFIG_KEXEC_VERIFY_SIG is enabled, the kexec_file_load syscall
> requires the kexec'd kernel image to be signed. Distros are concerned
> about totally disabling the kexec_load syscall. As a compromise, the
> kexec_load syscall will only be disabled when CONFIG_KEXEC_VERIFY_SIG
> is configured and the system is booted with secureboot enabled.
> 
> This patch disables the kexec_load syscall only for systems booted with
> secureboot enabled.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

Nice!

Mimi

> ---
>  security/integrity/ima/ima_main.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index dce0a8a217bb..bdb6e5563d05 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -505,20 +505,24 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   */
>  int ima_load_data(enum kernel_load_data_id id)
>  {
> -	bool sig_enforce;
> +	bool ima_enforce, sig_enforce;
>  
> -	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
> -		return 0;
> +	ima_enforce =
> +		(ima_appraise & IMA_APPRAISE_ENFORCE) == IMA_APPRAISE_ENFORCE;
>  
>  	switch (id) {
>  	case LOADING_KEXEC_IMAGE:
> -		if (ima_appraise & IMA_APPRAISE_KEXEC) {
> +#ifdef CONFIG_KEXEC_VERIFY_SIG
> +		if (arch_ima_get_secureboot())
> +			return -EACCES;
> +#endif
> +		if (ima_enforce && (ima_appraise & IMA_APPRAISE_KEXEC)) {
>  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
>  		break;
>  	case LOADING_FIRMWARE:
> -		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
> +		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE)) {
>  			pr_err("Prevent firmware sysfs fallback loading.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
> @@ -526,7 +530,8 @@ int ima_load_data(enum kernel_load_data_id id)
>  	case LOADING_MODULE:
>  		sig_enforce = is_module_sig_enforced();
>  
> -		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
> +		if (ima_enforce && (!sig_enforce
> +				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
>  			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}

