Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeC2SQ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:16:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754046AbeC2SQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:16:55 -0400
Date: Thu, 29 Mar 2018 18:16:53 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v5 2/9] proc/sysctl: Provide additional ctl_table.flags
 checks
Message-ID: <20180329181653.GM30543@wotan.suse.de>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
 <1521224030-2185-3-git-send-email-longman@redhat.com>
 <20180317005458.GA4449@wotan.suse.de>
 <d616e759-368f-6287-3492-a970d2e8f77a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d616e759-368f-6287-3492-a970d2e8f77a@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 11:35:19AM -0400, Waiman Long wrote:
> On 03/16/2018 08:54 PM, Luis R. Rodriguez wrote:
> > On Fri, Mar 16, 2018 at 02:13:43PM -0400, Waiman Long wrote:
> >> Checking code is added to provide the following additional
> >> ctl_table.flags checks:
> >>
> >>  1) No unknown flag is allowed.
> >>  2) Minimum of a range cannot be larger than the maximum value.
> >>  3) The signed and unsigned flags are mutually exclusive.
> >>  4) The proc_handler should be consistent with the signed or unsigned
> >>     flags.
> >>
> >> Two new flags are added to indicate if the min/max values are signed
> >> or unsigned - CTL_FLAGS_SIGNED_RANGE & CTL_FLAGS_UNSIGNED_RANGE.
> >> These 2 flags can be optionally enabled for range checking purpose.
> >> But either one of them must be set with CTL_FLAGS_CLAMP_RANGE.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> >> index e446e1f..088f032 100644
> >> --- a/include/linux/sysctl.h
> >> +++ b/include/linux/sysctl.h
> >> @@ -134,14 +134,26 @@ struct ctl_table
> >>   *	the input value. No lower bound or upper bound checking will be
> >>   *	done if the corresponding minimum or maximum value isn't provided.
> >>   *
> >> + * @CTL_FLAGS_SIGNED_RANGE: Set to indicate that the extra1 and extra2
> >> + *	fields are pointers to minimum and maximum signed values of
> >> + *	an allowable range.
> >> + *
> >> + * @CTL_FLAGS_UNSIGNED_RANGE: Set to indicate that the extra1 and extra2
> >> + *	fields are pointers to minimum and maximum unsigned values of
> >> + *	an allowable range.
> >> + *
> >>   * At most 16 different flags are allowed.
> >>   */
> >>  enum ctl_table_flags {
> >>  	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
> >> -	__CTL_FLAGS_MAX			= BIT(1),
> >> +	CTL_FLAGS_SIGNED_RANGE		= BIT(1),
> >> +	CTL_FLAGS_UNSIGNED_RANGE	= BIT(2),
> >> +	__CTL_FLAGS_MAX			= BIT(3),
> >>  };
> > You are adding new flags which the user can set, and yet these are used
> > internally.
> >
> > It would be best if internal flags are just that, not flags that a user can set.
> >
> > This patch should be folded with the first one.
> >
> > I'm starting to loose hope on these patch sets.
> >
> >   Luis
> 
> In order to do the correct min > max check, I need to know if the
> quantity is signed or not. Just looking at the proc_handler alone is not
> a reliable indicator if it is signed or unsigned.
> 
> Yes, I can put the signed bit into the previous patch.

Do that and also remove the unused flags. It is confusing as a reviewer
why a flag was added and then you use another flag later. Seriously, please
take a bit more time to review your own patches prior to submission. Each
change should make sense and have use in the patch series.

  Luis
