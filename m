Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1071AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE772086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfAOPrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:47:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728841AbfAOPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:47:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FFifZb119770
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:47:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q1huvacmx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:47:19 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 15 Jan 2019 15:47:17 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Jan 2019 15:47:13 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0FFlBeu2949616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 15:47:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64B495205A;
        Tue, 15 Jan 2019 15:47:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.167])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EFE085204E;
        Tue, 15 Jan 2019 15:47:08 +0000 (GMT)
Subject: Re: [RFC PATCH v2 2/2] kexec, KEYS: Make use of platform keyring
 for signature verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Date:   Tue, 15 Jan 2019 10:46:58 -0500
In-Reply-To: <20190115094542.17129-3-kasong@redhat.com>
References: <20190115094542.17129-1-kasong@redhat.com>
         <20190115094542.17129-3-kasong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011515-0020-0000-0000-00000306D858
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011515-0021-0000-0000-00002157F07D
Message-Id: <1547567218.4156.289.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901150131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:

> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7d97e432cbbc..a06b04065bb1 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -534,9 +534,18 @@ static int bzImage64_cleanup(void *loader_data)
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len,
> -				       VERIFY_USE_SECONDARY_KEYRING,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	int ret;
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +			VERIFY_USE_SECONDARY_KEYRING,
> +			VERIFYING_KEXEC_PE_SIGNATURE);
> +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING

Consider using IS_ENABLED() or IS_BUILTIN().

Mimi

> +	if (ret == -ENOKEY) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +				VERIFY_USE_PLATFORM_KEYRING,
> +				VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +#endif
> +	return ret;
>  }
>  #endif

