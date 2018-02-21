Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966028AbeBUPYK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:24:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936132AbeBUPYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:24:06 -0500
Subject: Re: [PATCH 2/3] sysctl: Warn when a clamped sysctl parameter is set
 out of range
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <1519059231-2456-1-git-send-email-longman@redhat.com>
 <1519059231-2456-3-git-send-email-longman@redhat.com>
 <20180220151705.8b4519f105db8f5c119015f0@linux-foundation.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <60a7ee3c-d6f9-c124-b0a0-e31bafa7a62e@redhat.com>
Date: Wed, 21 Feb 2018 10:24:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180220151705.8b4519f105db8f5c119015f0@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 06:17 PM, Andrew Morton wrote:
> On Mon, 19 Feb 2018 11:53:50 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> Even with clamped sysctl parameters, it is still not that straight
>> forward to figure out the exact range of those parameters. One may
>> try to write extreme parameter values to see if they get clamped.
>> To make it easier, a warning with the expected range will now be
>> printed in the kernel ring buffer when a clamped sysctl parameter
>> receives an out of range value.
> This assumes that do_proc_dointvec_minmax_conv() and
> do_proc_douintvec_minmax_conv() are only ever called by privileged
> userspace.  Because we mustn't give unprivileged applications a way to
> spam the kernel logs.
>
> That's presumably true in the case of the caller you just added, but I
> don't see what we can do to guarantee this in the future, so perhaps we
> should add some permission check to the pr_warn()?
>
Good point. Beside adding security check, another alternative is to use
some kind of warn_once() for each sysctl parameter. That will limit the
amount of spamming that is possible. It will require adding a flag to
the ctl_table to mark an  entry as warned. I think that will be less
tricky than adding permission check.

I can also use the new flag to designate that a sysctl parameter need to
be clamped to the range instead of failing when out of range. With that,
I don't need to introduce new clamping APIs. I can use the existing
ones. I will work on v2 patch with that change.

Thanks,
Longman
