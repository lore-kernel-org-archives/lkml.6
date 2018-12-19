Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73EBC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A0E218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545214819;
	bh=ttyVGbaKN7UlnKfxv94c4qCrFzxY9A4xv3HTQSoT5S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f+O/yygyw/85BYrogm+NIg6kc+jMgbR1OLKfhLbKMz6lACi+AF9BctBOv0qX5M5UV
	 4CfWQM/FzXWjvXlEKtCzNInh0QUi4dCDs3osIPey4Tw02qLE8nHKu2aHwrxeV8DKKW
	 OJ4zEGBJHVCqUs7P2smvi0uaE2A/2J+1Vb/+pyrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeLSKUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:20:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:42582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728570AbeLSKUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:20:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D610B038;
        Wed, 19 Dec 2018 10:20:11 +0000 (UTC)
Date:   Wed, 19 Dec 2018 11:20:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        mgorman@techsingularity.net, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip checking poison pattern for page_to_nid()
Message-ID: <20181219102010.GF5758@dhcp22.suse.cz>
References: <1545172285.18411.26.camel@lca.pw>
 <20181219015732.26179-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219015732.26179-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 20:57:32, Qian Cai wrote:
[...]
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5411de93a363..f083f366ea90 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -985,9 +985,7 @@ extern int page_to_nid(const struct page *page);
>  #else
>  static inline int page_to_nid(const struct page *page)
>  {
> -	struct page *p = (struct page *)page;
> -
> -	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
> +	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
>  }
>  #endif

I didn't get to think about a proper fix but this is clearly worng. If
the page is still poisoned then flags are clearly bogus and the node you
get is a garbage as well. Have you actually tested this patch?
-- 
Michal Hocko
SUSE Labs
