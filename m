Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B5DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBCF2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H8M+0psL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBCF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeGISDu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:03:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53384 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeGISDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:03:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69HwgOm073594;
        Mon, 9 Jul 2018 18:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vEbXPdLd/EB/uYSoG3C7AtTsIdsOVmqxw0llF2kMniY=;
 b=H8M+0psLmRoVRYwP8y7mDfwUApMiln0Qfphqn2kASQFB1XiBMlTer7Wr3WmOF4ccyR/M
 6+Zovza927ZfP2e+o0uCop6CxYIkb/wwjmoTE1egVfEK1ACiVjHpdTrNJQyOzm5NLufX
 0Zbv2v7zhxpdBmChfwb3CpoBXa/9h4qsUALlDre0hPaWj8084hz75AtJ+gkmhIFHuXgs
 Q2p5qJBMVGjabcNYWlvC11cjXT6SkE8+ogBhr6uZVB5/HGxR4vD5KS9z1ccshCnWsCPq
 kwCqkOcylgoGHz7oNkIIhiqGcUubIKEpr6lwcsWQOecCx0ptmLdFJgWS2A9zCnCrKu1S NA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k2p7v5abv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 18:03:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w69I3MCO016924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 18:03:22 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w69I3LRC020873;
        Mon, 9 Jul 2018 18:03:21 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 11:03:21 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 312E96A00C3; Mon,  9 Jul 2018 14:03:20 -0400 (EDT)
Date:   Mon, 9 Jul 2018 14:03:20 -0400
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
Subject: Re: [PATCHv4 02/18] mm/ksm: Do not merge pages with different KeyIDs
Message-ID: <20180709180320.GG6873@char.US.ORACLE.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
 <20180626142245.82850-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626142245.82850-3-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:22:29PM +0300, Kirill A. Shutemov wrote:
> Pages encrypted with different encryption keys are not subject to KSM

Perhaps not allowed instead of subject?
> merge. Otherwise it would cross security boundary.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/mm.h | 7 +++++++
>  mm/ksm.c           | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ebf4bd8bd0bf..406a28cadfcf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1548,6 +1548,13 @@ static inline int vma_keyid(struct vm_area_struct *vma)
>  }
>  #endif
>  
> +#ifndef page_keyid
> +static inline int page_keyid(struct page *page)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_SHMEM
>  /*
>   * The vma_is_shmem is not inline because it is used only by slow
> diff --git a/mm/ksm.c b/mm/ksm.c
> index a6d43cf9a982..1bd7b9710e29 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1214,6 +1214,9 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>  	if (!PageAnon(page))
>  		goto out;
>  
> +	if (page_keyid(page) != page_keyid(kpage))
> +		goto out;
> +
>  	/*
>  	 * We need the page lock to read a stable PageSwapCache in
>  	 * write_protect_page().  We use trylock_page() instead of
> -- 
> 2.18.0
> 
