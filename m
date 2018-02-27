Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeB0J0i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:26:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:29423 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752546AbeB0J0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:26:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,400,1515484800";
   d="scan'208";a="30970032"
Date: Tue, 27 Feb 2018 11:26:27 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jeremy McNicoll <jmcnicol@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [07/18] thunderbolt: Handle rejected Thunderbolt devices
Message-ID: <20180227092627.GD2424@lahna.fi.intel.com>
References: <20180213170018.9780-8-mika.westerberg@linux.intel.com>
 <20180222231736.GA628@mini-rhel.redhat.com>
 <20180226102029.GG27191@lahna.fi.intel.com>
 <20180226133802.GR27191@lahna.fi.intel.com>
 <a3eaf2cd-5820-4ef5-a799-d17a3dc84907@redhat.com>
 <20180226194645.GA3774@lahna.fi.intel.com>
 <6560a597-0075-549e-f723-1bc5eb54c7bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6560a597-0075-549e-f723-1bc5eb54c7bc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:15:28PM -0800, Jeremy McNicoll wrote:
> On 2018-02-26 11:46 AM, Mika Westerberg wrote:
> > On Mon, Feb 26, 2018 at 11:28:16AM -0800, Jeremy McNicoll wrote:
> > > On 2018-02-26 5:38 AM, Mika Westerberg wrote:
> > > > On Mon, Feb 26, 2018 at 12:20:29PM +0200, Mika Westerberg wrote:
> > > > > On Thu, Feb 22, 2018 at 03:17:38PM -0800, Jeremy McNicoll wrote:
> > > > > > > +	if (pkg->link_info & ICM_LINK_INFO_REJECTED) {
> > > > > > > +		tb_info(tb, "switch at %u.%u was rejected by ICM firmware\n",
> > > > > > > +			link, depth);
> > > > > > 
> > > > > > This kind of condition sounds more like an error instead of info.
> > > > > > Please bump this up to tb_WARN/tb_warn ideally tb_err().
> > > > > 
> > > > > No, this is not an error.
> > > > 
> > > > To be more clear, it is totally fine to have the firmware to reject some
> > > > devices. For example in case of the new usbonly security level the
> > > > firmware rejects other devices but the first.
> > > > 
> > > 
> > > Ok. Is that kind of information available to the kernel?  What security
> > > mode we are in?
> > > 
> > > ie) if (LINK_REJECTED && !USB_SECURITY)
> > >         print "Error switch %u was rejected since its not usbonly"
> > >      endif
> > > 
> > > I am sure something like that simplified pseudo code above would
> > > be somewhat useful to users when debugging.
> > 
> > That's why it is on info level so it goes to dmesg but does not scare
> > the user :-)
> > 
> 
> The point I am trying to make is that it would be nice to be able to
> know WHY the link was rejected and not just that it was rejected.

Fair enough. In practice (since we ask the firmware to accept any
device) the only reason for rejection is that the topology limit is
exceeded (too many devices in the chain).

I'm thinking to change the message to something like:

	tb_info(tb, "switch at %u.%u was rejected by ICM firmware because topology limit exceeded\n",
		link, depth);

And do the same for Titan Ridge in patch [18/18]. 

Security level can be read directly from "security" sysfs attribute of
the domain so that information does not need to be duplicated IMHO.

Does that work for you?
