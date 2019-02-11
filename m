Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B797DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87376222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WEPt/Rhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfBKNr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:47:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfBKNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ws/C2hqYk0iRt2PTm35SBSRz42ARtcD8YeknfLTSmcQ=; b=WEPt/RhgKU3FIaV5Ev/81DgzH
        UQoVtvtDN3m4/VyfHhpBG2fRmCOwkZLeYoyw6v98loraNonK4JcGe8wWuF0qkSPAkT72fS4ZqiPeJ
        +wxYpM/CM9YxU//P662NsBKqqEjBhuPwyEibVYEa2mV79kYs1HVGfCrCd1vXAW8jbNmIIzbyslflj
        /mZLMXBW1UexkZPloEUQZdIRzyjsrduPjuqHHiJHTpHQ1zP8DnVdEz7gn1zx56D9x15jpVdEBA4ZI
        NecWKaQUmolv3P1O+wI6Pz0sTnApZNBgJ8QZlYt4HLbgpQ6vmKNa6R0RWE25A0LpoTpGjFHA8U9aY
        GCuYa06JQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBw8-0007aU-5p; Mon, 11 Feb 2019 13:47:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B38F420D0E3CE; Mon, 11 Feb 2019 14:47:50 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:47:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chintan Pandya <chintan.pandya@oneplus.com>
Cc:     Linux Upstream <linux.upstream@oneplus.com>,
        "hughd@google.com" <hughd@google.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC 2/2] page-flags: Catch the double setter of page flags
Message-ID: <20190211134750.GB32511@hirez.programming.kicks-ass.net>
References: <20190211125337.16099-1-chintan.pandya@oneplus.com>
 <20190211125337.16099-3-chintan.pandya@oneplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211125337.16099-3-chintan.pandya@oneplus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:53:55PM +0000, Chintan Pandya wrote:
> Some of the page flags, like PG_locked is not supposed to
> be set twice. Currently, there is no protection around this
> and many callers directly tries to set this bit. Others
> follow trylock_page() which is much safer version of the
> same. But, for performance issues, we may not want to
> implement wait-until-set. So, at least, find out who is
> doing double setting and fix them.
> 
> Change-Id: I1295fcb8527ce4b54d5d11c11287fc7516006cf0
> Signed-off-by: Chintan Pandya <chintan.pandya@oneplus.com>
> ---
>  include/linux/page-flags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index a56a9bd4bc6b..e307775c2b4a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -208,7 +208,7 @@ static __always_inline int Page##uname(struct page *page)		\
>  
>  #define SETPAGEFLAG(uname, lname, policy)				\
>  static __always_inline void SetPage##uname(struct page *page)		\
> -	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
> +	{ WARN_ON(test_and_set_bit(PG_##lname, &policy(page, 1)->flags)); }

You forgot to make this depend on CONFIG_DEBUG_VM. Also, I'm not
convinced this is always wrong, inefficient sure, but not wrong in
general.
