Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C9521508
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C9521508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbeHILhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:37:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbeHILhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:37:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 452C912B20;
        Thu,  9 Aug 2018 09:13:42 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2922960A9E;
        Thu,  9 Aug 2018 09:13:42 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B548C4BB78;
        Thu,  9 Aug 2018 09:13:41 +0000 (UTC)
Date:   Thu, 9 Aug 2018 05:13:41 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, jack@suse.cz,
        hch@lst.de, yu c zhang <yu.c.zhang@intel.com>, linux-mm@kvack.org,
        rkrcmar@redhat.com, yi z zhang <yi.z.zhang@intel.com>
Message-ID: <2036397219.889906.1533806021412.JavaMail.zimbra@redhat.com>
In-Reply-To: <d2345e628a697ee17fdd6e360f7a6790caab10d5.1533811181.git.yi.z.zhang@linux.intel.com>
References: <cover.1533811181.git.yi.z.zhang@linux.intel.com> <d2345e628a697ee17fdd6e360f7a6790caab10d5.1533811181.git.yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH V3 1/4] kvm: remove redundant reserved page check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.117.219, 10.4.195.28]
Thread-Topic: remove redundant reserved page check
Thread-Index: eU8Pao8KRqguboLqsHufj9uJmnci1w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 09 Aug 2018 09:13:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> PageReserved() is already checked inside kvm_is_reserved_pfn(),
> remove it from kvm_set_pfn_dirty().
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
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

Acked-by: Pankaj Gupta <pagupta@redhat.com>

>  
> --
> 2.7.4
> 
> 
