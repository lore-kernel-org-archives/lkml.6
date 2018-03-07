Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeCGTC5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:02:57 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35507 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbeCGTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:02:54 -0500
X-Google-Smtp-Source: AG47ELv4hRH9U1HcEg2BRzdmpsrWn7A2H9g1rgBF4HBVzRV0Saupp0Ry752Q6Fgo9pk3OkKlCSURtg==
Date: Wed, 7 Mar 2018 11:02:49 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: introduce Command DB for QCOM SoCs
Message-ID: <20180307190249.GW93895@bjorns-mbp-2.lan>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-3-ilina@codeaurora.org>
 <20180305231455.GJ18510@minitux>
 <20180306155703.GA4930@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306155703.GA4930@codeaurora.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06 Mar 07:57 PST 2018, Lina Iyer wrote:

> On Mon, Mar 05 2018 at 16:15 -0700, Bjorn Andersson wrote:
> > On Mon 26 Feb 09:58 PST 2018, Lina Iyer wrote:
> > 
> > > From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> > > 
> > > Command DB provides information on shared resources like clocks,
> > > regulators etc., probed at boot by the remote subsytem and made
> > > available in shared memory.
> > > 
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > > ---
> > > 
> > > Changes in v4:
> > > 	- Fix unwanted capitalization
> > > 	- Add reg property
> > > ---
> > >  .../devicetree/bindings/arm/msm/cmd-db.txt         | 38 ++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/msm/cmd-db.txt b/Documentation/devicetree/bindings/arm/msm/cmd-db.txt
> > [..]
> > > +	reserved-memory {
> > > +		[...]
> > > +		qcom,cmd-db@c3f000c {
> > > +			reg = <0x0 0xc3f000c 0x0 0x8>,
> > > +			      <0x0 0x85fe0000 0x0 0x20000>;
> > 
> > I'm still concerned about the use of the redirection mapping here,
> > the relocation at 0xc3f000c is used a convenience thing so that the
> > command db can be relocated, but because of how Linux will consume any
> > non-reserved memory the dts would still need to be manually updated.
> > 
> This location is fixed and it is not expected to change between
> different boards. OEMs may change the actual address of the command db
> location, but would not change the dictionary location.
> 

Right, dictionary location is fixed. So to pick another range for
command db one would update the numbers that goes into the dictionary
and expect all software in the system to use this new range.

> > As such I think you should just describe only the 0x85fe0000 + 0x20000
> > region here and to support the dynamic aspect of this from a system
> > point of view you can have the boot loader read the information at
> > 0xc3f000c and adjust the reserved memory. (Or just keep the step of
> > manually update the dts without caring about the indirection)
> > 
> It would be incorrect and very board specific to just use the 0x85fe000
> as the address. It is not how the SoC defines the location. Upon request
> earlier, this memory location was added in DT and the location is
> typical reference platform usage only.
> 

The problem is that as the db resides in a chunk of memory in the middle
of what Linux considers System RAM the DTS must specify this region as
reserved. Which means that as you, like described above, update the
dictionary something (in your scheme a person) has to update the
reserved-memory region as well.

That's why I'm proposing that the appropriate implementation for this
is to have the boot loader to the dictionary part of this and Linux only
care about the actual reserved-memory region. This way you would still
implement the dictionary lookup on a system level, but the Linux
part no longer depend on a human updating the DTS to match the values of
the dictionary.


But if we stick with the approach of describing both these and hoping
that the values in the first region matches the second (or should we add
a sanity check in probe?). The memory reserve defined as 0xc3f000c + 8
looks strange, is this system ram as well and what other things resides
in that same page?

Regards,
Bjorn
