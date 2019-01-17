Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45185C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103C820859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfAQXZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:25:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726913AbfAQXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:25:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HNJKek015869
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:25:23 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q3359gbst-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:25:23 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 17 Jan 2019 23:25:21 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 23:25:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HNPEjE35651746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 23:25:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4392A42045;
        Thu, 17 Jan 2019 23:25:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4C9F42041;
        Thu, 17 Jan 2019 23:25:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.54])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 23:25:12 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Thu, 17 Jan 2019 18:25:01 -0500
In-Reply-To: <20190116101654.7288-3-kasong@redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
         <20190116101654.7288-3-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011723-0016-0000-0000-00000246F2F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011723-0017-0000-0000-000032A118F5
Message-Id: <1547767501.3931.60.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> With KEXEC_BZIMAGE_VERIFY_SIG enabled, kexec_file_load will need to
> verify the kernel image. 

The kexec_file_load syscall can verify the PE signed kernel image
signature, the kernel image signature stored as an xattr, or both.

Anyone booting the system with the "appraise_tcb" policy or with a
similar appraise policy rule, wanting to only verifying the PE signed
kernel image, will need to include a "dont_appraise
func=KEXEC_KERNEL_CHECK" rule in their custom policy.

> The image might be signed with third part keys,
> and the keys could be stored in firmware, then got loaded into the
> .platform keyring. Now we have a symbol .platform_trusted_keyring as the
> reference to .platform keyring, this patch makes use if it and allow
> kexec_file_load to verify the image against keys in .platform keyring.

There's no need to introduce the concept of "third party" or "firmware
keys" here.  Referring to them as the "preboot" keys, can simplify the
above paragraph.

> 
> This commit adds a VERIFY_USE_PLATFORM_KEYRING similar to previous
> VERIFY_USE_SECONDARY_KEYRING indicating that verify_pkcs7_signature
> should verify the signature using platform keyring. Also, decrease
> the error message log level when verification failed with -ENOKEY,
> so that if called tried multiple time with different keyring it
> won't generate extra noises.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed/Tested-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
>  certs/system_keyring.c            | 13 ++++++++++++-
>  include/linux/verification.h      |  1 +
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7d97e432cbbc..2c007abd3d40 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -534,9 +534,16 @@ static int bzImage64_cleanup(void *loader_data)
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len,
> -				       VERIFY_USE_SECONDARY_KEYRING,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	int ret;
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +				      VERIFY_USE_SECONDARY_KEYRING,
> +				      VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +					      VERIFY_USE_PLATFORM_KEYRING,
> +					      VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
>  }
>  #endif
>  
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 4690ef9cda8a..7085c286f4bd 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -240,11 +240,22 @@ int verify_pkcs7_signature(const void *data, size_t len,
>  #else
>  		trusted_keys = builtin_trusted_keys;
>  #endif
> +	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +		trusted_keys = platform_trusted_keys;
> +#else
> +		trusted_keys = NULL;
> +#endif
> +		if (!trusted_keys) {
> +			ret = -ENOKEY;
> +			pr_devel("PKCS#7 platform keyring is not available\n");
> +			goto error;
> +		}
>  	}
>  	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
>  	if (ret < 0) {
>  		if (ret == -ENOKEY)
> -			pr_err("PKCS#7 signature not signed with a trusted key\n");
> +			pr_devel("PKCS#7 signature not signed with a trusted key\n");
>  		goto error;
>  	}
>  
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index cfa4730d607a..018fb5f13d44 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -17,6 +17,7 @@
>   * should be used.
>   */
>  #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
> +#define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
>  
>  /*
>   * The use to which an asymmetric key is being put.

