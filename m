Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F412145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdfboDlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F412145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeKUMTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:19:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40747 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 07:19:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so3000262pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NQhDUiRdx+ni6DnegyCIvUwQH41AOZN7l3quC8qClOE=;
        b=CdfboDlTmfJPTp44yOLj2Rk/WxPrQ34XpH8zLG56fbhnerG1nFY7bKwrUqT5OsYz8E
         GSmYWx2Q08ny+q+AJoijmv2TQJbMDhjDeH0H0Hg/9qPsBhvzcPs8dTUjadkIfX+fSJ0l
         XRFKx7O8FtIBf4MtvyvnlJoBpc3dprtJff1O6JCPbUE3wsyYXE1KCpTt1bZb75QVGzPM
         INExqyqNkc7AbxTwvpEMgWaE07s5PVbKmGUcpVIkf6B68tQvYBdioh3fRKSwCVbGgC9P
         Oak9doFUYGbZxYOxb9OztmHaVjzJVNqJ9mWFHDzQZYJ4CjSB3ilR9oizqh8jlnoNrSeg
         3tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NQhDUiRdx+ni6DnegyCIvUwQH41AOZN7l3quC8qClOE=;
        b=BFxY1TozX2zv+xQ8yprVfreAp7s4MRCeT5myGgK8eOzYQuEOxcGIIwqeCKOCVIZamb
         D1q56+cBPk7utgXitL5sND7oHhLUYzEC+h1KWHWvLguqWLJmRldYxqltqrAqQqgnzz9h
         740LrdjHYdswARCIrFLdLitL15m1zhFJSBD7IuNHQrI23/XjmbxOxeJQCIpCbUxDUaLy
         dVZaDLeoVteR9IYf+MlIA2+NCSJg4dHgARdCzvwzvZdqjjwZ0dQ+16XI11AghFlTYTeA
         8COPL4kI/1Zn9e+CxCXS5iiR7DsMxdsNOtc3/XSJJ15zlyvNntd1a1o/ZBLaFxubUdOx
         nnzQ==
X-Gm-Message-State: AGRZ1gK1XuRjG9ITXSdYLCKDl9K6IjXTZT7RxxIkFAGIHF65KsuEcnme
        ry7wXfmUx0ofgo9+Z+4gsOfkhQ==
X-Google-Smtp-Source: AJdET5cWChM+hbXYJXmqZ+AfDa3prXsccYljjq+UNJiIb9UtxIxk/bcXUyg/Dx4LLNOUbR+lFMPckg==
X-Received: by 2002:a62:ed09:: with SMTP id u9-v6mr4630060pfh.188.1542764843686;
        Tue, 20 Nov 2018 17:47:23 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id h17-v6sm63357489pfj.125.2018.11.20.17.47.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 17:47:22 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:47:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Michal Hocko <mhocko@kernel.org>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
In-Reply-To: <20181120134323.13007-4-mhocko@kernel.org>
Message-ID: <alpine.LSU.2.11.1811201721470.2061@eggly.anvils>
References: <20181120134323.13007-1-mhocko@kernel.org> <20181120134323.13007-4-mhocko@kernel.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> filemap_map_pages takes a speculative reference to each page in the
> range before it tries to lock that page. While this is correct it
> also can influence page migration which will bail out when seeing
> an elevated reference count. The faultaround code would bail on
> seeing a locked page so we can pro-actively check the PageLocked
> bit before page_cache_get_speculative and prevent from pointless
> reference count churn.
> 
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Hugh Dickins <hughd@google.com>

though I think this patch is more useful to the avoid atomic ops,
and unnecessary dirtying of the cacheline, than to avoid the very
transient elevation of refcount, which will not affect page migration
very much.

> ---
>  mm/filemap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 81adec8ee02c..c76d6a251770 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2553,6 +2553,9 @@ void filemap_map_pages(struct vm_fault *vmf,
>  			goto next;
>  
>  		head = compound_head(page);
> +
> +		if (PageLocked(head))
> +			goto next;
>  		if (!page_cache_get_speculative(head))
>  			goto next;
>  
> -- 
> 2.19.1
