Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AD5246C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTOpBE/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AD5246C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934010AbeFVR1h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933200AbeFVR1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:27:35 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C7E246BC;
        Fri, 22 Jun 2018 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529688455;
        bh=9EVKOURewIDTrohhIROu1nmkNE/tgNlzdNn38Pk+IpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTOpBE/IeLsHNA4jgBYW1DLhCWllL+ybRV7em0hDVvA+J3jw6M87DoDbUlKzKT1In
         6b/z8K2JQngeKtz1lgE+hklBC8XeD7ZIduGXoFn7AmrSXdAFFqSiRiaCUAEdI0toq7
         mXFGzr1eNIIzMsMK1wZNxyfqndyf6VkU1L5fX+6g=
Date:   Fri, 22 Jun 2018 12:27:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tyler Baicar <tbaicar@codeaurora.org>
Cc:     rajatxjain@gmail.com, Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>
Subject: Re: [PATCH v5 3/5] PCI/AER: Add sysfs attributes to provide
 breakdown of AERs
Message-ID: <20180622172734.GA215961@bhelgaas-glaptop.roam.corp.google.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180620234147.48438-1-rajatja@google.com>
 <20180620234147.48438-3-rajatja@google.com>
 <20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com>
 <CAA93t1rz6YGmvvORDB0ehr7Gwp-W+0HDYxEDgjtgYmGm3qMgCw@mail.gmail.com>
 <a16746f0-351f-276e-2a66-3ebf2c267507@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a16746f0-351f-276e-2a66-3ebf2c267507@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:38:50PM -0400, Tyler Baicar wrote:
> On 6/21/2018 5:25 PM, Rajat Jain wrote:
> > On Thu, Jun 21, 2018 at 11:48 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > [+cc Tyler for AER dmesg decoding]
> > > 
> > > - Tyler posted a patch [1] to update those dmesg strings so they match
> > >    the way lspci decodes them.  I really liked that update, but we
> > >    never quite finished it.  If we're going to do that, it would be
> > >    nice to do it first, so we don't publish new sysfs files, then
> > >    immediately change the labels used in them.
> > Sure, I guess you can push them in the right order.
> The way the prints are handled has already been unified in 4.18rc1:
> 
> https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/pci/pcie/aer.c#L636
> 
> So that patch isn't needed anymore in it's entirety.
> > > - IIRC, Tyler's patch had the nice property of changing the strings so
> > >    each error name had no spaces, which would make it a little easier
> > >    to parse this sysfs file: each line would be a single identifier
> > >    followed by a single number (I would probably remove the "=" from
> > >    the middle).
> > 
> > Will do.
> Would you like me to send a patch with just the string changes?

That would be awesome!  Sorry, I didn't realize that half of that got
done via another route.

Bjorn
