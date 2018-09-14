Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68BEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E4320861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QKJE5EBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E4320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeINW1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:27:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46901 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1536945146; x=1568481146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwdILCVkbfsxrXAdNjSGJsrrcFbynueWGNHGkoo82EQ=;
  b=QKJE5EBbNksh+10VtfPrbxryeHExgCAtmLqcQgsbKLrnCaWGQg++Akxp
   eC0GxXNgWpXhz2Tfk98MpJdkOxCcdipXg848193ydMwN3Mr0zLmTjEk9i
   5T5LRIEx1HJGV+V88SMVrIXb81tbSGC9ty61DJw1SObep7RszPhN1Ij+5
   E=;
X-IronPort-AV: E=Sophos;i="5.53,374,1531785600"; 
   d="scan'208";a="630665092"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2018 17:12:23 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8EHCJNm126655
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 14 Sep 2018 17:12:23 GMT
Received: from EX13D07UEB001.ant.amazon.com (10.43.60.203) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 17:12:22 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D07UEB001.ant.amazon.com (10.43.60.203) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 17:12:22 +0000
Received: from localhost (10.85.19.144) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 14 Sep 2018 17:12:22 +0000
Date:   Fri, 14 Sep 2018 10:12:22 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4.14 103/115] x86/xen: dont write ptes directly in 32-bit
 PV guests
Message-ID: <20180914171222.GA30580@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180913131823.327472833@linuxfoundation.org>
 <20180913131829.701763608@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180913131829.701763608@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 13, 2018 at 03:32:03PM +0200, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Juergen Gross <jgross@suse.com>
> 
> commit f7c90c2aa4004808dff777ba6ae2c7294dd06851 upstream.
> 
> In some cases 32-bit PAE PV guests still write PTEs directly instead of
> using hypercalls. This is especially bad when clearing a PTE as this is
> done via 32-bit writes which will produce intermediate L1TF attackable
> PTEs.
> 
> Change the code to use hypercalls instead.
> 

Good that we got this in. Should we also take this one:
b2d7a075a1cc ("x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear")

Which is under the line of the same issue?

> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/x86/xen/mmu_pv.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -425,14 +425,13 @@ static void xen_set_pud(pud_t *ptr, pud_
>  static void xen_set_pte_atomic(pte_t *ptep, pte_t pte)
>  {
>  	trace_xen_mmu_set_pte_atomic(ptep, pte);
> -	set_64bit((u64 *)ptep, native_pte_val(pte));
> +	__xen_set_pte(ptep, pte);
>  }
>  
>  static void xen_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>  {
>  	trace_xen_mmu_pte_clear(mm, addr, ptep);
> -	if (!xen_batched_set_pte(ptep, native_make_pte(0)))
> -		native_pte_clear(mm, addr, ptep);
> +	__xen_set_pte(ptep, native_make_pte(0));
>  }
>  
>  static void xen_pmd_clear(pmd_t *pmdp)
> @@ -1543,7 +1542,7 @@ static void __init xen_set_pte_init(pte_
>  		pte = __pte_ma(((pte_val_ma(*ptep) & _PAGE_RW) | ~_PAGE_RW) &
>  			       pte_val_ma(pte));
>  #endif
> -	native_set_pte(ptep, pte);
> +	__xen_set_pte(ptep, pte);
>  }
>  
>  /* Early in boot, while setting up the initial pagetable, assume
> 
> 
> 

-- 
All the best,
Eduardo Valentin
