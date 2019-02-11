Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D424FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23CE218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lEHdGLTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBKUjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:39:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43464 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfBKUjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:39:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so103747pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7ipRFd0lGsbjldrU5cPVYjS4TXNP1GlOAkJ0yUCCXI=;
        b=lEHdGLTDe+z9XOLq92061yRszuQ30L0Ah2rmiBbRpewl+TcyLhd4uxI4utvOvqyaI2
         aj7uUuX092yr34YJFyYkt43rtb2Dkfumt2dbyWXGRWWzWz+mQH0n4KTPptuX0vmorWcU
         1W/+eazIscUyvxqV3K5ydoWP/wMD9KxZf9OYLLotNpA6ZOOGTYWv10ulE12tdrSoJjen
         a+l3YkwfqqnVqdLyeRlfhC2S4LulZqlNGf3+NZZS6ipLnh30ZGDMnZJfMHV+zx8QMtqX
         yAp75P/0zxF3T+6bl4zNzfa24iMzHvsrXSC5noAUxB++IktCPa99pDvyTnh8U3xFfhyM
         eZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7ipRFd0lGsbjldrU5cPVYjS4TXNP1GlOAkJ0yUCCXI=;
        b=rQ/vlTgUWJPj+Pj7Gf8fVOzBhyhjq0L0wuZmujb1yq36AfLWuE99sPt68i11rnhbYq
         +xEfITbmR6GMYcEYa+BN6OGVvBN4kdJrihBTSxaFP64gikxoysQ3n3nDXKt1FsvkLdMn
         Wht/lQfRfMT3/Xdux05IkVy4s2DTCcd/3jRRiOaI3OBp+DGTnligjSNXA7rFMG5NBeGj
         V6HWX0ArspR/WPBlto/xxOOs5DpSksJTHWwuqC7w7aAMMNvwe80C0QZDr8z+Mj/IsHjw
         04jjOhajYapL2Oyn5KoGamaOwSyQufLf5nsOTn2TSu/Lk4qHQ7nV025woDNP1dZGau0H
         6MEA==
X-Gm-Message-State: AHQUAubHsuf/0btrtp1f3gLOK/GpIPWR9PU23g3FB1IRAyFqdlSXz0pf
        o33OmeEl7+NiUSUNS9BAlxndtQ==
X-Google-Smtp-Source: AHgI3IbMSgV+Og1cgwCH3tEJ/kPJXOw9ltVSJm+RBFJMVVHZk30d9/NcXwyU987scjvfQpHKM+tRtw==
X-Received: by 2002:a63:eb49:: with SMTP id b9mr115173pgk.196.1549917557390;
        Mon, 11 Feb 2019 12:39:17 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b13sm22468326pfj.66.2019.02.11.12.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:39:16 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtIMG-0000kK-7Q; Mon, 11 Feb 2019 13:39:16 -0700
Date:   Mon, 11 Feb 2019 13:39:16 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>, netdev@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
Message-ID: <20190211203916.GA2771@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211201643.7599-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211201643.7599-3-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:16:42PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Users of get_user_pages_fast are not protected against mapping
> pages within FS DAX.  Introduce a call which protects them.
> 
> We do this by checking for DEVMAP pages during the fast walk and
> falling back to the longterm gup call to check for FS DAX if needed.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>  include/linux/mm.h |   8 ++++
>  mm/gup.c           | 102 +++++++++++++++++++++++++++++++++++----------
>  2 files changed, 88 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 80bb6408fe73..8f831c823630 100644
> +++ b/include/linux/mm.h
> @@ -1540,6 +1540,8 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
>  			    unsigned int gup_flags, struct page **pages,
>  			    struct vm_area_struct **vmas);
> +int get_user_pages_fast_longterm(unsigned long start, int nr_pages, bool write,
> +				 struct page **pages);
>  #else
>  static inline long get_user_pages_longterm(unsigned long start,
>  		unsigned long nr_pages, unsigned int gup_flags,
> @@ -1547,6 +1549,11 @@ static inline long get_user_pages_longterm(unsigned long start,
>  {
>  	return get_user_pages(start, nr_pages, gup_flags, pages, vmas);
>  }
> +static inline int get_user_pages_fast_longterm(unsigned long start, int nr_pages,
> +					       bool write, struct page **pages)
> +{
> +	return get_user_pages_fast(start, nr_pages, write, pages);
> +}
>  #endif /* CONFIG_FS_DAX */
>  
>  int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> @@ -2615,6 +2622,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>  #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
>  #define FOLL_COW	0x4000	/* internal GUP flag */
>  #define FOLL_ANON	0x8000	/* don't do file mappings */
> +#define FOLL_LONGTERM	0x10000	/* mapping is intended for a long term pin */

If we are adding a new flag, maybe we should get rid of the 'longterm'
entry points and just rely on the callers to pass the flag?

Jason
