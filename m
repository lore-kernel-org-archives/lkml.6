Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeDHEnD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 00:43:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41144 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeDHEnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 00:43:02 -0400
Date: Sun, 8 Apr 2018 05:42:09 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Use struct page for filename
Message-ID: <20180408044152.GG30522@ZenIV.linux.org.uk>
References: <001a114467482dbc4b05692df8f9@google.com>
 <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
 <20180408031646.GB32632@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408031646.GB32632@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 08:16:46PM -0700, Matthew Wilcox wrote:
> On Fri, Apr 06, 2018 at 03:33:36PM +0200, Dmitry Vyukov wrote:
> > On Fri, Apr 6, 2018 at 3:24 PM, syzbot
> > <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com> wrote:
> > > cache_from_obj: Wrong slab cache. names_cache but object is from kmalloc-96
> > 
> > Al, do you see how this can happen?
> 
> I don't see how it happened, but when looking at this bug, I thought
> "This is very complicated, I think there's a simpler way to handle this".
> 
> Here's a proposal.  It won't apply to any existing tree (depends on a
> couple of local commits), but I think you'll get the general flavour
> of it.  It's mostly compile-tested (build still running, but fs/ and
> kernel/ compiled without issue).

> +struct audit_names;
> +
> +struct filename {
> +	const char		*name;	/* pointer to actual string */
> +	const __user char	*uptr;	/* original userland pointer */
> +	struct audit_names	*aname;
> +};
>  
>  /*
>   * Each physical page in the system has a struct page associated with
> @@ -188,6 +195,7 @@ struct page {
>  			spinlock_t ptl;
>  #endif
>  		};
> +		struct filename filename;
>  	};

Oh, lovely - extra 24 bytes into each struct page.  Plus the delta to
performance due to switching from kmem_cache_alloc to alloc_page.
Negative one, that is...
