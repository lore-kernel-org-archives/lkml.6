Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965837AbeCHR5v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:57:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:44568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbeCHR5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:57:49 -0500
Date: Thu, 8 Mar 2018 17:57:47 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/6] sysctl: Add flags to support min/max range
 clamping
Message-ID: <20180308175747.GD4449@wotan.suse.de>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <1519926220-7453-4-git-send-email-longman@redhat.com>
 <20180301133117.1d4b27e327f8e51275c82489@linux-foundation.org>
 <20180308175109.GA4449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308175109.GA4449@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 05:51:09PM +0000, Luis R. Rodriguez wrote:
> On Thu, Mar 01, 2018 at 01:31:17PM -0800, Andrew Morton wrote:
> > On Thu,  1 Mar 2018 12:43:37 -0500 Waiman Long <longman@redhat.com> wrote:
> > 
> > > When minimum/maximum values are specified for a sysctl parameter in
> > > the ctl_table structure with proc_dointvec_minmax() handler, update
> > > to that parameter will fail with error if the given value is outside
> > > of the required range.
> > > 
> > > There are use cases where it may be better to clamp the value of
> > > the sysctl parameter to the given range without failing the update,
> > > especially if the users are not aware of the actual range limits.
> > > Reading the value back after the update will now be a good practice
> > > to see if the provided value exceeds the range limits.
> > > 
> > > To provide this less restrictive form of range checking, a new flags
> > > field is added to the ctl_table structure. The new field is a 16-bit
> > > value that just fits into the hole left by the 16-bit umode_t field
> > > without increasing the size of the structure.
> > > 
> > > When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table entry,
> > > any update from the userspace will be clamped to the given range
> > > without error.
> > > 
> > > ...
> > >
> > > --- a/include/linux/sysctl.h
> > > +++ b/include/linux/sysctl.h
> > > @@ -116,6 +116,7 @@ struct ctl_table
> > >  	void *data;
> > >  	int maxlen;
> > >  	umode_t mode;
> > > +	uint16_t flags;
> > 
> > It would be nice to make this have type `enum ctl_table_flags', but I
> > guess there's then no reliable way of forcing it to be 16-bit.
> > 
> > I guess this is the best we can do...
> > 
> 
> We can add this to the enum:
> 
> enum ctl_table_flags {                                                                                                                                                                       
>        CTL_FLAGS_CLAMP_RANGE           = BIT(0),                                                                                                                                             
> +	__CTL_FLAGS_CLAMP_MAX          = BIT(16),
> }; 
> 
> 
> Then also:
> 
> #define CTL_TABLE_FLAGS_ALL	((BIT(__CTL_FLAGS_CLAMP_MAX + 1))-1)
> 
> at the end of the definition, then a helper which can be used during
> parsing:
> 
> static int check_ctl_table_flags(u16 flags)
> {
> 	if (flags & ~(CTL_TABLE_FLAGS_ALL))
> 		return -ERANGE;
> 	return 0;
> }
> 
> Waiman please evaluate and add.

Also, I guess we have ... max bit used and max allowed (16) really, where one is the
max allowed bit field given current definitions, the other is the max flag possible
setting in the future. We might as well go with the smaller one, which is the current
max, so it can just be

enum ctl_table_flags {
	CTL_FLAGS_CLAMP_RANGE	 = BIT(0),
	__CTL_FLAGS_CLAMP_MAX    = BIT(1),
};


#define CTL_TABLE_FLAGS_ALL	((BIT(__CTL_FLAGS_CLAMP_MAX))-1)

That way we just check against the actual max defined, now the max allowed on
the entire flag setting.

  Luis
