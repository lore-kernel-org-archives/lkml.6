Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC25C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E764620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DRudgOqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E764620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbeGSNXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:23:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbeGSNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bMfjhplHgyJiSqJ4C4/yhqPF1PNMzPmQs2IiDqUXDcU=; b=DRudgOqWrKSQ7UuyeC7fd/ZQ+
        OQRcYCYoNPcY96epICGouhmWRpcOP8pTMBBKfY7zumgAc/h7yj5yzywiHJs2AKhK00Ci/m1pDkBWZ
        qApu/CnreeYDKhacbfkAw39MtSJho3DuSET5yJ+9wmZ4oPvbgGbHde25eYP0/bnb39BmZg3dXdbPh
        sRtAsxhUsql2PxJbqOD6FQLDO5NRGZPa/Eu1jbxJi57bwIqVRjSTjRlADEXQ0o/532/bR1h+oRXQh
        N0lOw1L+QhERUC51uxMsWgQ0x9JXAybsfTEglLzUF/5hLnoZfPGL0/rHrhOyn6xDo8m/cJt6nGRuS
        4oZXzHODA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8EA-0000iw-3M; Thu, 19 Jul 2018 12:40:14 +0000
Date:   Thu, 19 Jul 2018 05:40:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v3 4/8] swap: Unify normal/huge code path in
 swap_page_trans_huge_swapped()
Message-ID: <20180719124013.GB28522@infradead.org>
References: <20180719084842.11385-1-ying.huang@intel.com>
 <20180719084842.11385-5-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719084842.11385-5-ying.huang@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static inline bool cluster_is_huge(struct swap_cluster_info *info)
>  {
> -	return info->flags & CLUSTER_FLAG_HUGE;
> +	if (IS_ENABLED(CONFIG_THP_SWAP))
> +		return info->flags & CLUSTER_FLAG_HUGE;
> +	else
> +		return false;

Nitpick: no need for an else after a return:

	if (IS_ENABLED(CONFIG_THP_SWAP))
		return info->flags & CLUSTER_FLAG_HUGE;
	return false;
