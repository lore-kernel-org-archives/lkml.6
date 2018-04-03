Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeDCDb3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 23:31:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50069 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751368AbeDCDb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 23:31:28 -0400
X-ME-Sender: <xms:j_XCWoOK2OJnQWX-FHsXiFE_NIUcgD7cQ1UFfDMNPDVR9cOuFPZFvg>
Date: Tue, 3 Apr 2018 13:31:23 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] list_debug: Print unmangled addresses
Message-ID: <20180403033123.GB781@eros>
References: <20180401223237.GV13332@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180401223237.GV13332@bombadil.infradead.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2018 at 03:32:37PM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> The entire point of printing the pointers in list_debug is to see if
> there's any useful information in them (eg poison values, ASCII, etc);
> obscuring them to see if they compare equal makes them much less useful.
> If an attacker can force this message to be printed, we've already lost.

Is this because CONFIG_DEBUG_LIST should not be enabled on production
kernels so an attacker should never hit this?

I'm inclined to agree, if there is already a memory corruption bug,
causing this code to execute, the extra address is probably not making
the situation any worse.

(I am in no way a security expert.)

> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Reviewed-by: Tobin C. Harding <me@tobin.cc>

> diff --git a/lib/list_debug.c b/lib/list_debug.c
> index a34db8d27667..5d5424b51b74 100644
> --- a/lib/list_debug.c
> +++ b/lib/list_debug.c
> @@ -21,13 +21,13 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
>  		      struct list_head *next)
>  {
>  	if (CHECK_DATA_CORRUPTION(next->prev != prev,
> -			"list_add corruption. next->prev should be prev (%p), but was %p. (next=%p).\n",
> +			"list_add corruption. next->prev should be prev (%px), but was %px. (next=%px).\n",
>  			prev, next->prev, next) ||
>  	    CHECK_DATA_CORRUPTION(prev->next != next,
> -			"list_add corruption. prev->next should be next (%p), but was %p. (prev=%p).\n",
> +			"list_add corruption. prev->next should be next (%px), but was %px. (prev=%px).\n",
>  			next, prev->next, prev) ||
>  	    CHECK_DATA_CORRUPTION(new == prev || new == next,
> -			"list_add double add: new=%p, prev=%p, next=%p.\n",
> +			"list_add double add: new=%px, prev=%px, next=%px.\n",
>  			new, prev, next))
>  		return false;
>  
> @@ -43,16 +43,16 @@ bool __list_del_entry_valid(struct list_head *entry)
>  	next = entry->next;
>  
>  	if (CHECK_DATA_CORRUPTION(next == LIST_POISON1,
> -			"list_del corruption, %p->next is LIST_POISON1 (%p)\n",
> +			"list_del corruption, %px->next is LIST_POISON1 (%px)\n",
>  			entry, LIST_POISON1) ||
>  	    CHECK_DATA_CORRUPTION(prev == LIST_POISON2,
> -			"list_del corruption, %p->prev is LIST_POISON2 (%p)\n",
> +			"list_del corruption, %px->prev is LIST_POISON2 (%px)\n",
>  			entry, LIST_POISON2) ||
>  	    CHECK_DATA_CORRUPTION(prev->next != entry,
> -			"list_del corruption. prev->next should be %p, but was %p\n",
> +			"list_del corruption. prev->next should be %px, but was %px\n",
>  			entry, prev->next) ||
>  	    CHECK_DATA_CORRUPTION(next->prev != entry,
> -			"list_del corruption. next->prev should be %p, but was %p\n",
> +			"list_del corruption. next->prev should be %px, but was %px\n",
>  			entry, next->prev))
>  		return false;
>  
