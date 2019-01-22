Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FDFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3260C217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548172501;
	bh=r3p0EaIVIMnOCQTPfUDs+bbuovgRL3D87Gx2fnxZXfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RSjk6wvhI3FgJ3ePy78HF+z36m7SsKnwUbPKbuzS/nudGin4/l3jFPTLjQgx37Diy
	 Yp5I77XBplCrg6De8nnD43xKmwnzWDV9xuwdusZ/XynZ+Gk3fLUtaOL4tfHJDO9JGY
	 Cgcrxv5wvJCWbBcS8jkGZ6fe66iJCwklUN+l3KK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfAVPy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbfAVPy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:54:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0C921726;
        Tue, 22 Jan 2019 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548172498;
        bh=r3p0EaIVIMnOCQTPfUDs+bbuovgRL3D87Gx2fnxZXfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULrlM76vzHITZFmwrBa/YITo6WCh4sw4PTMckMyCrdQLm8z4i4wnacInAcd95E5wU
         Tqn23i091rncrWwKSoRp4axYOpFyYWiijPQU3VJuadimuaEXeXtYZpTWwEdpDA2To/
         xdxvlHwjgenzwaBzml2CSXLFrY7YUWbCGU3XNlvs=
Date:   Tue, 22 Jan 2019 16:54:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rafael@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Expose the Energy Model in debugfs
Message-ID: <20190122155455.GA20697@kroah.com>
References: <20190107122608.21913-1-quentin.perret@arm.com>
 <20190122153412.zuehulqwb7ung43u@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122153412.zuehulqwb7ung43u@queper01-lin>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:34:14PM +0000, Quentin Perret wrote:
> On Monday 07 Jan 2019 at 12:26:08 (+0000), Quentin Perret wrote:
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index d9dc2c38764a..8ef48daa62ff 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/cpu.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/energy_model.h>
> >  #include <linux/sched/topology.h>
> >  #include <linux/slab.h>
> > @@ -23,6 +24,88 @@ static DEFINE_PER_CPU(struct em_perf_domain *, em_data);
> >   */
> >  static DEFINE_MUTEX(em_pd_mutex);
> >  
> > +#ifdef CONFIG_DEBUG_FS
> > +static struct dentry *rootdir;
> > +
> > +static int em_debug_create_cs(struct em_cap_state *cs, struct dentry *pd)
> > +{
> > +	struct dentry *d;
> > +	char name[24];
> > +
> > +	snprintf(name, sizeof(name), "cs:%lu", cs->frequency);
> > +
> > +	d = debugfs_create_dir(name, pd);
> > +	if (!d)
> > +		return -ENOMEM;
> > +
> > +	if (!debugfs_create_ulong("frequency", 0444, d, &cs->frequency))
> > +		return -ENOMEM;
> 
> Looking at the patches Greg just sent I assume all this is wrong.

Yes it is :)

> I'll send a v2 without the 'if' all over.

That would be wonderful, thanks.

greg k-h
