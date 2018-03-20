Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeCTWfj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:35:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35745 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCTWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:35:35 -0400
Date: Tue, 20 Mar 2018 23:35:30 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [RFC PATCH 7/8] x86: mpx: pass atomic parameter to do_munmap()
In-Reply-To: <1521581486-99134-8-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1803202307330.1714@nanos.tec.linutronix.de>
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com> <1521581486-99134-8-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018, Yang Shi wrote:

Please CC everyone involved on the full patch set next time. I had to dig
the rest out from my lkml archive to get the context.

> Pass "true" to do_munmap() to not do unlock/relock to mmap_sem when
> manipulating mpx map.

> This is API change only.

This is wrong. You cannot change the function in one patch and then clean
up the users. That breaks bisectability.

Depending on the number of callers this wants to be a single patch changing
both the function and the callers or you need to create a new function
which has the extra argument and switch all users over to it and then
remove the old function.

> @@ -780,7 +780,7 @@ static int unmap_entire_bt(struct mm_struct *mm,
>  	 * avoid recursion, do_munmap() will check whether it comes
>  	 * from one bounds table through VM_MPX flag.
>  	 */
> -	return do_munmap(mm, bt_addr, mpx_bt_size_bytes(mm), NULL);
> +	return do_munmap(mm, bt_addr, mpx_bt_size_bytes(mm), NULL, true);

But looking at the full context this is the wrong approach.

First of all the name of that parameter 'atomic' is completely
misleading. It suggests that this happens in fully atomic context, which is
not the case.

Secondly, conditional locking is frowned upon in general and rightfully so.

So the right thing to do is to leave do_munmap() alone and add a new
function do_munmap_huge() or whatever sensible name you come up with. Then
convert the places which are considered to be safe one by one with a proper
changelog which explains WHY this is safe.

That way you avoid the chasing game of all existing do_munmap() callers and
just use the new 'free in chunks' approach where it is appropriate and
safe. No suprises, no bisectability issues....

While at it please add proper kernel doc documentation to both do_munmap()
and the new function which explains the intricacies.

Thanks,

	tglx
