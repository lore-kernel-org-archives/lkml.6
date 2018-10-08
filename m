Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8460EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473982087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473982087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJHOop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:44:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33075 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:44:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so8086224wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 00:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJBGN47wKhJjkXSBulUkLOKO2O74M9HZtGADZU0j1NM=;
        b=FlWjT5MEWsf4cCnj1hlCGPuKu15FRDIb7aWrpG8AIKkZYHZaXwQKNd9AJ/1Ht/9pCc
         h3meha54gJbYnMNhLyuTl5nr+3/FpMtm6v1W1gByTH60fsXYVwca+hZmGWrjAkzzEB9n
         qiWH3y8dCNwZf5M6eusm+Jaz30setBy68eSrGlwSWrEGhb2PY40mlmQ3QzcHXJDxB8lg
         +EsEdjU61Lz0kzlHuJC5TwOGWADkUMuGRfC/TKFR9HOLH1752UlJjVCM1RPKwHKB8Vn0
         kM93DF7QpsWeHutE48taNyzgGKLqRDObkNhNVmvvHoPNMegsyqQ+vEnS0QeFXXigLsu5
         bIYg==
X-Gm-Message-State: ABuFfogTWsk4EYCX31vQ522s5yep0TuYacHpMkfmS9XQ9Cd0Mxg9GXvC
        ob7nSZuaIzzJzAIwanVD9Ew=
X-Google-Smtp-Source: ACcGV627II7YLORUProLSmDQmg/MPVhnbTdEWyMWkAxsXALs6tTPMfFVjec/MsnjXCX59Y0zGKkwpQ==
X-Received: by 2002:a1c:7816:: with SMTP id t22-v6mr14895024wmc.46.1538984063636;
        Mon, 08 Oct 2018 00:34:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t143-v6sm7509836wmt.2.2018.10.08.00.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 00:34:22 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 14AC712587F; Mon,  8 Oct 2018 09:34:22 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:34:22 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Arun KS <arunks@codeaurora.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
Message-ID: <20181008073421.GA9703@techadventures.net>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:40:05PM +0530, Arun KS wrote:
> When free pages are done with higher order, time spend on
> coalescing pages by buddy allocator can be reduced. With
> section size of 256MB, hot add latency of a single section
> shows improvement from 50-60 ms to less than 1 ms, hence
> improving the hot add latency by 60%. Modify external
> providers of online callback to align with the change.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>

Looks good to me.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Just one thing below:
  
> @@ -1331,7 +1331,7 @@ void __init __free_pages_bootmem(struct page *page, unsigned long pfn,
>  {
>  	if (early_page_uninitialised(pfn))
>  		return;
> -	return __free_pages_boot_core(page, order);
> +	return __free_pages_core(page, order);

__free_pages_core is void, so I guess we do not need that return there.
Probably the code generated is the same though.
-- 
Oscar Salvador
SUSE L3
