Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeBTXDO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:03:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:32736 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeBTXDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:03:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="19567001"
Date: Wed, 21 Feb 2018 01:03:01 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180220230301.fdvczohdtp635kav@linux.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
 <20180214134319.4400-2-tomas.winkler@intel.com>
 <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B942240B1@hasmsx108.ger.corp.intel.com>
 <1519138649.26293.1.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94224C36@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94224C36@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 08:26:45PM +0000, Winkler, Tomas wrote:
> > 
> > On Mon, 2018-02-19 at 11:43 +0000, Winkler, Tomas wrote:
> > > > All local variable declarations must be in the beginning of the
> > > > function.
> > >
> > > Who says?
> > 
> > It is coherent how we have everything else.
>  I will have to care about its value out of the scope where the variable existence is not relevant.
> 
> > It is much easier to see the stack allocation this way when the allocation is
> > only done in the beginning of each function. If you really need to do such
> > pattern, then it would be a better idea to consider an additional helper
> > function.
> The code block decides whether to modify 'rc'. I'm not sure if additional function will make
>  the code cleaner, on the opposite.
> > 
> > > > Your comment about not overriding error code is incorrect.
> > >
> > > Please explain?
> > 
> > 'l_rc' overrides 'rc' in the case when both are non-zero.
> 
> Yes, that's been the intention, we cannot return more than one value. 
> l_rc if set it has hire priority. 
> 
> > 
> > > > The value of 'rc' should be never overridden, which kind of supports
> > > > to "just print" behavior that we had for a locality error.
> > >
> > > You are not consistent, you've agreed with propagating it to user
> > > space.  The error will  be propagated in case of an error in locality
> > > relinquish the device is pretty much in non functional state and
> > > provious errors do not matter much, but rc value won't be modified if
> > > locality_reliquish succeeds.
> > 
> > Well, sometimes you fail to notice things and I failed to notice the collision
> > above. The commit message does not describe why 'l_rc'
> > overrides 'rc' in the case when both are non-zero. What was the reasoning,
> > which made you end up with this priority order?  Why is 'l_rc' more
> > important than 'rc'?
> 
> Because, it's fatal. I'm not sure it's matter much what the previous error was, it cannot be recovered
> That's my understanding of this flow.
> 
>  
> > My take is that does it really make sense have this change as part of a high
> > priority bug fix that should be as localized as possible?
> > Seems like a non-trivial problem by itself.
> 
> Yes, the issue here is that also an error path can fail. Now what is the correct return value.. 
> 
> In any case, in order to resolve this dispute, I will post a version when the error is just prints out,
> Once, however fatal the error is, it's very unlikely that it will happen.
> Second the driver will find the device not responding in a subsequent command.
> 
> Not perfect, but at least we will have functional driver.
> 
> Thanks
> Tomas
> 

Please add my tested by to next version. Thanks.

/Jarkko
