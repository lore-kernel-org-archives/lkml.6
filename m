Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756106AbeCHSiX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:38:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:47561 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754695AbeCHSiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:38:22 -0500
Date: Thu, 8 Mar 2018 18:38:20 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 0/6] ipc: Clamp *mni to the real IPCMNI limit
Message-ID: <20180308183820.GK4449@wotan.suse.de>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <20180308182335.GH4449@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308182335.GH4449@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 06:23:35PM +0000, Luis R. Rodriguez wrote:
> On Thu, Mar 01, 2018 at 12:43:34PM -0500, Waiman Long wrote:
> > v2->v3:
> >  - Fix kdoc comment errors.
> >  - Incorporate comments and suggestions from Luis R. Rodriguez.
> >  - Add a patch to fix a typo error in fs/proc/proc_sysctl.c.
> > 
> > v1->v2:
> >  - Add kdoc comments to the do_proc_do{u}intvec_minmax_conv_param
> >    structures.
> >  - Add a new flags field to the ctl_table structure for specifying
> >    whether range clamping should be activated instead of adding new
> >    sysctl parameter handlers.
> >  - Clamp the semmni value embedded in the multi-values sem parameter.
> > 
> > v1 patch: https://lkml.org/lkml/2018/2/19/453
> > v2 patch: https://lkml.org/lkml/2018/2/27/627
> > 
> > The sysctl parameters msgmni, shmmni and semmni have an inherent limit
> > of IPC_MNI (32k). However, users may not be aware of that because they
> > can write a value much higher than that without getting any error or
> > notification. Reading the parameters back will show the newly written
> > values which are not real.
> > 
> > Enforcing the limit by failing sysctl parameter write, however, can
> > break existing user applications. To address this delemma, a new flags
> > field is introduced into the ctl_table. The value CTL_FLAGS_CLAMP_RANGE
> > can be added to any ctl_table entries to enable a looser range clamping
> > without returning any error. For example,
> > 
> >   .flags = CTL_FLAGS_CLAMP_RANGE,
> > 
> > This flags value are now used for the range checking of shmmni,
> > msgmni and semmni without breaking existing applications. If any out
> > of range value is written to those sysctl parameters, the following
> > warning will be printed instead.
> > 
> >   Kernel parameter "shmmni" was set out of range [0, 32768], clamped to 32768.
> > 
> > Reading the values back will show 32768 instead of some fake values.
> 
> I don't see any addition of respective tests cases, I thought I asked
> for this. Please add respective tests cases for all the API you are
> adding on lib/test_sysctl.c and respective tests on
> tools/testing/selftests/sysctl/sysctl.sh

Andrew,

If its not too much trouble please only apply the first two patches of this
series. The rest should be dropped. I think it would be a mistake for us to
take start carrying the rest at this point in time.

  Luis
