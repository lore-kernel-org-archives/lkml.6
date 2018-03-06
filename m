Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeCFLGU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:06:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:10755 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753024AbeCFLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:06:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="39590256"
Message-ID: <1520334372.7549.2.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] tpm: reduce poll sleep time between send() and
 recv() in tpm_transmit()
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
Date: Tue, 06 Mar 2018 13:06:12 +0200
In-Reply-To: <1520276852.10396.351.camel@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
         <20180228191828.20056-2-nayna@linux.vnet.ibm.com>
         <20180301092222.GC29420@linux.intel.com>
         <6ef601be-5627-6746-bd4a-4f391aba8b04@linux.vnet.ibm.com>
         <20180305105633.GE25377@linux.intel.com>
         <20180305180144.GE5791@linux.intel.com>
         <1520276852.10396.351.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 14:07 -0500, Mimi Zohar wrote:
> On Mon, 2018-03-05 at 20:01 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 05, 2018 at 12:56:33PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Mar 02, 2018 at 12:26:35AM +0530, Nayna Jain wrote:
> > > > 
> > > > 
> > > > On 03/01/2018 02:52 PM, Jarkko Sakkinen wrote:
> > > > > On Wed, Feb 28, 2018 at 02:18:27PM -0500, Nayna Jain wrote:
> > > > > > In tpm_transmit, after send(), the code checks for status in a loop
> > > > > 
> > > > > Maybe cutting hairs now but please just use the actual function name
> > > > > instead of send(). Just makes the commit log more useful asset.
> > > > 
> > > > Sure, will do.
> > > > > 
> > > > > > -		tpm_msleep(TPM_TIMEOUT);
> > > > > > +		tpm_msleep(TPM_TIMEOUT_POLL);
> > > > > 
> > > > > What about just calling schedule()?
> > > > 
> > > > I'm not sure what you mean by "schedule()".  Are you suggesting instead
> > > > of
> > > > using usleep_range(),  using something with an even finer grain
> > > > construct?
> > > > 
> > > > Thanks & Regards,
> > > >      - Nayna
> > > 
> > > kernel/sched/core.c
> > 
> > The question I'm trying ask to is: is it better to sleep such a short
> > time or just ask scheduler to schedule something else after each
> > iteration?
> 
> I still don't understand why scheduling some work would be an
> improvement.  We still need to loop, testing for the TPM command to
> complete.
> 
> According to the schedule_hrtimeout_range() function comment,
> schedule_hrtimeout_range() is both power and performance friendly.
>  What we didn't realize is that the hrtimer *uses* the maximum range
> to calculate the sleep time, but *may* return earlier based on the
> minimum time.
> 
> This patch minimizes the tpm_msleep().  The subsequent patch in this
> patch set shows that 1 msec isn't fine enough granularity.  I still
> think calling usleep_range() is the right solution, but it needs to be
> at a finer granularity than tpm_msleep() provides.
> 
> Mimi

We can move to usleep_range() in call sites where it makes sense instead
of adjusting tpm_msleep() implementation...

/Jarkko
