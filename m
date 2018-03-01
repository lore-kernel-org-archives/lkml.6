Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162302AbeCAViP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:38:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161622AbeCAViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:38:08 -0500
Date: Thu, 1 Mar 2018 13:38:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 4/6] sysctl: Warn when a clamped sysctl parameter is
 set out of range
Message-Id: <20180301133807.f5beb1bf1d1391f23e95ce63@linux-foundation.org>
In-Reply-To: <1519926220-7453-5-git-send-email-longman@redhat.com>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
        <1519926220-7453-5-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Mar 2018 12:43:38 -0500 Waiman Long <longman@redhat.com> wrote:

> Even with clamped sysctl parameters, it is still not that straight
> forward to figure out the exact range of those parameters. One may
> try to write extreme parameter values to see if they get clamped.
> To make it easier, a warning with the expected range will now be
> printed in the kernel ring buffer when a clamped sysctl parameter
> receives an out of range value.
> 
> ...
>
> +		if (clamped && param->name &&
> +		   !(*param->flags & CTL_FLAGS_OOR_WARNED)) {
> +			proc_ctl_warn(d, param->name,
> +				param->min ? *param->min : -INT_MAX,
> +				param->max ? *param->max :  INT_MAX, val);
> +			*param->flags |= CTL_FLAGS_OOR_WARNED;
> +		}

The handling of ctl_table.flags looks racy on SMP or preemptible. 
That's not at all a serious problem in this usage, but such handling of
ctl_table.flags may be a problem in the future.  Which means that if
some future user of this field *is* sensitive to races then people are
going to have to come back to this code and add the needed locking.

So we should at least think about what that locking is to be, and
document it in some fashion.  Do we already hold an appropriate lock at
this time?  If so, what is it?

If some such future user of ctl_table.flags has to add a new lock to
the ctl_table for this purpose then we just eliminated your use-16-bit
space saving trick and we may as well use a ulong and operate on it
with bitops.
