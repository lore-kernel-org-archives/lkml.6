Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA0BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE904217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfAVPiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:38:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728633AbfAVPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:38:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0MFVXMJ004720
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:38:00 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q658qabpq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:37:59 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 22 Jan 2019 15:37:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 15:37:52 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0MFbp1g6160754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 15:37:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDEE54C040;
        Tue, 22 Jan 2019 15:37:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E04664C04A;
        Tue, 22 Jan 2019 15:37:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.23])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jan 2019 15:37:48 +0000 (GMT)
Subject: Re: [PATCH v5 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Tue, 22 Jan 2019 10:37:38 -0500
In-Reply-To: <20190121095929.26915-3-kasong@redhat.com>
References: <20190121095929.26915-1-kasong@redhat.com>
         <20190121095929.26915-3-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012215-0028-0000-0000-0000033C9566
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012215-0029-0000-0000-000023F9CFB8
Message-Id: <1548171458.4038.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 17:59 +0800, Kairui Song wrote:
> This patch let kexec_file_load makes use of .platform keyring as fall
> back if it failed to verify a PE signed image against secondary or
> builtin key ring, make it possible to verify kernel image signed with
> preboot keys as well.
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

