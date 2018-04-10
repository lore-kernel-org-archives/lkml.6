Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeDJAX2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 20:23:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeDJAX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 20:23:27 -0400
Date: Mon, 9 Apr 2018 17:23:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ram Pai <linuxram@us.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Michael Henders <hendersm@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] resource: Fix integer overflow at reallocation
Message-Id: <20180409172326.944143fd13db2601e4dee9b0@linux-foundation.org>
In-Reply-To: <20180408072026.27365-1-tiwai@suse.de>
References: <20180408072026.27365-1-tiwai@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Apr 2018 09:20:26 +0200 Takashi Iwai <tiwai@suse.de> wrote:

> We've got a bug report indicating a kernel panic at booting on an
> x86-32 system, and it turned out to be the invalid resource assigned
> after PCI resource reallocation.  __find_resource() first aligns the
> resource start address and resets the end address with start+size-1
> accordingly, then checks whether it's contained.  Here the end address
> may overflow the integer, although resource_contains() still returns
> true because the function validates only start and end address.  So
> this ends up with returning an invalid resource (start > end).
> 
> There was already an attempt to cover such a problem in the commit
> 47ea91b4052d ("Resource: fix wrong resource window calculation"), but
> this case is an overseen one.
> 
> This patch adds the validity check in resource_contains() to see
> whether the given resource has a valid range for avoiding the integer
> overflow problem.
> 
> ...
>
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -212,6 +212,9 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
>  		return false;
>  	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
>  		return false;
> +	/* sanity check whether it's a valid resource range */
> +	if (r2->end < r2->start)
> +		return false;
>  	return r1->start <= r2->start && r1->end >= r2->end;
>  }

This doesn't look like the correct place to handle this?  Clearly .end
< .start is an invalid state for a resource and we should never have
constructed such a thing in the first place?  So adding a check at the
place where this resource was initially created seems to be the correct
fix?
