Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3589C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3662087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDLna32I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3662087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbeGISV0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:21:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33426 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeGISVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:21:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69IIub5125505;
        Mon, 9 Jul 2018 18:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/d8SZ1vFv6nJ3LbFu+hPI3kiF0uCxsQBmjHFGtTQEEc=;
 b=NDLna32ItyZ3OpG3gHT3tUAE7VoIyGOr5FmpOIlDuxKcGDRBsFoQz8UCOBj1SzKrO85r
 iPsoMgNhK6uFQQdqFPXqX9/VawiR3Tu0jcyxokoANeQCANq7S97ia1+x+h+Kw9D/Qerb
 9zmCLzTdf4fj/P7jRCSVYJ8I7gOh0TqtqHS6J/u1RDuhYWPWlwnjJQogYMqDRbZg7daD
 K87syH+3r4yJI1aZvDxxhGiScwABpl5z0/mDXR3Si4Sk2Gukg772yDGXWFsR3HkXIL1Z
 LUAh7E0EKCpfyPPP6M3DZf17BDHicD1RjPa4FlAb4c3UhqM/HuViNWcojQRAHdy3V/aE mg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7dnd5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 18:20:59 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w69IKw3E016956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 18:20:58 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w69IKvqa001613;
        Mon, 9 Jul 2018 18:20:57 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 11:20:57 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id B87706A00C3; Mon,  9 Jul 2018 14:20:55 -0400 (EDT)
Date:   Mon, 9 Jul 2018 14:20:55 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 13/18] x86/mm: Allow to disable MKTME after enumeration
Message-ID: <20180709182055.GI6873@char.US.ORACLE.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626142245.82850-14-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=705
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:22:40PM +0300, Kirill A. Shutemov wrote:
> The new helper mktme_disable() allows to disable MKTME even if it's
> enumerated successfully. MKTME initialization may fail and this
> functionality allows system to boot regardless of the failure.
> 
> MKTME needs per-KeyID direct mapping. It requires a lot more virtual
> address space which may be a problem in 4-level paging mode. If the
> system has more physical memory than we can handle with MKTME.

.. then what should happen?
> The feature allows to fail MKTME, but boot the system successfully.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/mktme.h | 2 ++
>  arch/x86/kernel/cpu/intel.c  | 5 +----
>  arch/x86/mm/mktme.c          | 9 +++++++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
> index 44409b8bbaca..ebbee6a0c495 100644
> --- a/arch/x86/include/asm/mktme.h
> +++ b/arch/x86/include/asm/mktme.h
> @@ -6,6 +6,8 @@
>  
>  struct vm_area_struct;
>  
> +void mktme_disable(void);
> +
>  #ifdef CONFIG_X86_INTEL_MKTME
>  extern phys_addr_t mktme_keyid_mask;
>  extern int mktme_nr_keyids;
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index efc9e9fc47d4..75e3b2602b4a 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -591,10 +591,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
>  		 * Maybe needed if there's inconsistent configuation
>  		 * between CPUs.
>  		 */
> -		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> -		mktme_keyid_mask = 0;
> -		mktme_keyid_shift = 0;
> -		mktme_nr_keyids = 0;
> +		mktme_disable();
>  	}
>  #endif
>  
> diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
> index 1194496633ce..bb6210dbcf0e 100644
> --- a/arch/x86/mm/mktme.c
> +++ b/arch/x86/mm/mktme.c
> @@ -13,6 +13,15 @@ static inline bool mktme_enabled(void)
>  	return static_branch_unlikely(&mktme_enabled_key);
>  }
>  
> +void mktme_disable(void)
> +{
> +	physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> +	mktme_keyid_mask = 0;
> +	mktme_keyid_shift = 0;
> +	mktme_nr_keyids = 0;
> +	static_branch_disable(&mktme_enabled_key);
> +}
> +
>  int page_keyid(const struct page *page)
>  {
>  	if (!mktme_enabled())
> -- 
> 2.18.0
> 
