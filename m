Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D9C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6822081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6822081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeJXQTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:19:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:27491 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbeJXQTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:19:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 00:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="84004560"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2018 00:52:43 -0700
Received: from tiger-server (unknown [10.239.48.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 442BB580475;
        Wed, 24 Oct 2018 00:52:41 -0700 (PDT)
Date:   Wed, 24 Oct 2018 22:32:11 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, yu.c.zhang@intel.com, pagupta@redhat.com,
        david@redhat.com, jack@suse.cz, hch@lst.de
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, jglisse@redhat.com,
        yi.z.zhang@intel.com
Subject: Re: [PATCH V5 1/4] kvm: remove redundant reserved page check
Message-ID: <20181024143210.GA10874@tiger-server>
Mail-Followup-To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, yu.c.zhang@intel.com, pagupta@redhat.com,
        david@redhat.com, jack@suse.cz, hch@lst.de, linux-mm@kvack.org,
        rkrcmar@redhat.com, jglisse@redhat.com, yi.z.zhang@intel.com
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
 <26f79872e78cc643937059003763b5cfc1333167.1536342881.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26f79872e78cc643937059003763b5cfc1333167.1536342881.git.yi.z.zhang@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-08 at 02:03:28 +0800, Zhang Yi wrote:
> PageReserved() is already checked inside kvm_is_reserved_pfn(),
> remove it from kvm_set_pfn_dirty().
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8b47507f..c44c406 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1690,12 +1690,8 @@ EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
>  
>  void kvm_set_pfn_dirty(kvm_pfn_t pfn)
>  {
> -	if (!kvm_is_reserved_pfn(pfn)) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		if (!PageReserved(page))
> -			SetPageDirty(page);
> -	}
> +	if (!kvm_is_reserved_pfn(pfn))
> +		SetPageDirty(pfn_to_page(pfn));
>  }
>  EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
>  
> -- 
> 2.7.4
>
Hi Paolo,
We will remove the reserved flag in dax pages, then patch 2[3,4]/4 is
unnecessary,  can we queue this 1/4 to next merge? 

Thank you very much.
Yi
