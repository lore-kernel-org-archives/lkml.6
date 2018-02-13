Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935463AbeBMOhk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:37:40 -0500
Received: from foss.arm.com ([217.140.101.70]:58720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933651AbeBMOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:37:38 -0500
Date: Tue, 13 Feb 2018 14:37:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Channa <ckadabi@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, sboyd@codeaurora.org, kyan@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
Message-ID: <20180213143733.ts3dlcnhcf7jzbbm@lakrids.cambridge.arm.com>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
 <20180201104434.7j27fl2hb4glqd3v@lakrids.cambridge.arm.com>
 <d2751939f5813c296cdcb7a92d5698bf@codeaurora.org>
 <20180202110532.n2eez3zqbmf2jelr@lakrids.cambridge.arm.com>
 <2801cac8583d56260a9df0cdf7f41f47@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2801cac8583d56260a9df0cdf7f41f47@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:56:50AM -0800, Channa wrote:
> On 2018-02-02 03:05, Mark Rutland wrote:
> > On Thu, Feb 01, 2018 at 12:39:09PM -0800, Channa wrote:
> > > On 2018-02-01 02:44, Mark Rutland wrote:
> > > > On Thu, Jan 25, 2018 at 03:55:12PM -0800, Channagoud Kadabi wrote:
> > > > > +- llcc-bank-off:
> > > > > +	Usage: required
> > > > > +	Value Type: <u32 array>
> > > > > +	Definition: Offsets of llcc banks from llcc base address starting
> > > > > from
> > > > > +		    LLCC bank0.
> > > > > +
> > > > > +- llcc-broadcast-off:
> > > > > +	Usage: required
> > > > > +	Value Type: <u32>
> > > > > +	Definition: Offset of broadcast register from LLCC bank0 address.
> > > >
> > > > Please could we use "offset" rather than "off" for both of these? That
> > > > way it's obvious these aren't properties for disabling some feature.
> > > >
> > > > How variable are these offsets in practice? Is the memory map not fixed?
> > > 
> > > The offsets depends on the number of LLCC HW blocks. These number of
> > > HW
> > > blocks vary from
> > > chipset to chipset and new registers could be added that changes the
> > > offset.
> > 
> > Surely if new registers are added, we need a new compatible string?
> > 
> > Can't we encode the number of LLCC HW blocks, instead? Presumably that
> > would give enough information to cover both llcc-bank-off and
> > llcc-broadcast-off.
> > 
> > [...]
> 
> Are you suggesting to move these offset handing out of DTS files and manage
> in the driver?

Something like that, though it depends on how exactly the offsets can be
derived.

Using reg entries, as Matt suggested, sounds better though.

> > > > > +compatible devices:
> > > > > +		qcom,sdm845-llcc
> > > >
> > > > Huh? The "qcom,sdm845-llcc" bindings wasn't described above, and it's
> > > > not clear what this means.
> > > >
> > > > > +
> > > > > +Example:
> > > > > +
> > > > > +	qcom,system-cache@1300000 {
> > > > > +		compatible = "qcom,llcc-core", "syscon", "simple-mfd";
> > > >
> > > > This looks very wrong. Why do you need syscon and simple-mfd?
> > > 
> > > LLCC HW block has 3 functionalities:
> > > System cache core, ECC & AMON drivers for debugging.
> > > All three drivers use the same register space for configuration,
> > > status etc.
> > > In order to avoid remapping the same address region across multiple
> > > drivers,
> > > I have implemented this driver as a syncon and simple-mfd.
> > 
> > Please don't do that; that's completely dependent on Linux
> > implementation details.
> 
> Why do you think simple-mfd is not good here? The LLCC HW clock is outside
> of CPUSS and has
> multiple functional blocks.

For one thing, there's no need for this to be a syscon *and* a
simple-mfd.

W.R.T. simple-mfd, I think it would bet better to decompose the device
in a top-level driver, as I described in my prior reply, rather than
describing a set of drivers (which are not themselves HW).

> > > > > +- cache-slices:
> > > > > +	Usage: required
> > > > > +	Value type: <prop-encoded-array>
> > > > > +	Definition: The tuple has phandle to llcc device as the first
> > > > > argument and the
> > > > > +		    second argument is the usecase id of the client.
> > > >
> > > > What is a "usecase id" ?
> > > 
> > > Usecase id for use case that wants to use system cache for eg:
> > > video-encode
> > > and video-decode
> > 
> > Sure, but how is the value used? Is it the index of a slice? Or
> > something more abstract?
> 
> This is used as an index to the SCT (System cache Table) configuration
> data that controls the behavior of each cache slice.

Ok. Where does that SCT live? Is that in HW? Is it programmed by SW, or
statically configured for a given platform?

Thanks,
Mark.
