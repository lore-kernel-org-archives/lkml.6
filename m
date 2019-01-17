Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B050C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F2E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547739716;
	bh=Xz9fQIXuQQe0UnxUxNP5rtYpGmjpTeJVtfMuT9DisNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PbottBQVZdUjt7V89ZMy55tX/YPpEPxJ7W69HxiVGsiSi5vhkdUMdlMtwNWWyq5Aj
	 2vjHC9FDd7p8zitKdwGdJQjW/wxtwECHN9LFW9hLFC48KpaopkD1ILqfUH1wpI189U
	 amKLuPR5AlUY8N8pPH6xXrppaQQ61FLbPYj8Li6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfAQPlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfAQPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:41:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7567D20851;
        Thu, 17 Jan 2019 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547739714;
        bh=Xz9fQIXuQQe0UnxUxNP5rtYpGmjpTeJVtfMuT9DisNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jV/HD/VTkFO8yqR4QhbjbJfPBlKvv0+WyGTTJB+6gPURuau+owKtGA8r2HXyZZPXE
         +V36JRrmT852/p+dkcJvyGPc5eiAbmdINq/j3Cuavbm39c6oMUOfDVh0FmGqwf2/9k
         ej0cZW+dihOnrc2EKwp1yXQZbeW7+oyfy3b1EZGA=
Date:   Thu, 17 Jan 2019 16:41:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 07/13] node: Add heterogenous memory access attributes
Message-ID: <20190117154151.GA3970@kroah.com>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-8-keith.busch@intel.com>
 <CAJZ5v0jCEdhKndgZgJ=SdHgFBM1Bcxusm_crYzAOTZDx3s=PdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jCEdhKndgZgJ=SdHgFBM1Bcxusm_crYzAOTZDx3s=PdQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 04:03:42PM +0100, Rafael J. Wysocki wrote:
>  On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Heterogeneous memory systems provide memory nodes with different latency
> > and bandwidth performance attributes. Provide a new kernel interface for
> > subsystems to register the attributes under the memory target node's
> > initiator access class. If the system provides this information, applications
> > may query these attributes when deciding which node to request memory.
> >
> > The following example shows the new sysfs hierarchy for a node exporting
> > performance attributes:
> >
> >   # tree -P "read*|write*" /sys/devices/system/node/nodeY/classZ/
> >   /sys/devices/system/node/nodeY/classZ/
> >   |-- read_bandwidth
> >   |-- read_latency
> >   |-- write_bandwidth
> >   `-- write_latency
> >
> > The bandwidth is exported as MB/s and latency is reported in nanoseconds.
> > Memory accesses from an initiator node that is not one of the memory's
> > class "Z" initiator nodes may encounter different performance than
> > reported here. When a subsystem makes use of this interface, initiators
> > of a lower class number, "Z", have better performance relative to higher
> > class numbers. When provided, class 0 is the highest performing access
> > class.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/base/Kconfig |  8 ++++++++
> >  drivers/base/node.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/node.h | 25 +++++++++++++++++++++++++
> >  3 files changed, 81 insertions(+)
> >
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 3e63a900b330..6014980238e8 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -149,6 +149,14 @@ config DEBUG_TEST_DRIVER_REMOVE
> >           unusable. You should say N here unless you are explicitly looking to
> >           test this functionality.
> >
> > +config HMEM_REPORTING
> > +       bool
> > +       default y

default y is only if the machine will not boot without it.  Please never
make a new option y unless you really really have to have it on all
machines in the world.

Hint, not here.

greg k-h
