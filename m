Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EB5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420582070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546534117;
	bh=AFMp4FyVdmQLAURxu4avKBF2wrBP4YASkgohRRTXfDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FgbV4cPhMpa6GGwFjAk14byn4uHrdMK7c0ImCGOoPkSTRe7wTPlgk34yPmyAgrRhB
	 K8EJrfjjHSsseFEoaAYXBOyIy0t1R/j+jPzq860uU06Zs8199zYV+u5HYs1/qhWcA/
	 lj35O7D23QuWLv9QqkXtDVY+wU3ZMzdzfff7icPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfACQsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732387AbfACQsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:48:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8C9208E3;
        Thu,  3 Jan 2019 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546534113;
        bh=AFMp4FyVdmQLAURxu4avKBF2wrBP4YASkgohRRTXfDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wpoGftzSIQpUBN7RSDqpClHoY7SMtQaUehuKaYB5ABIKDX/tDepKIxnPnlGXmkRg0
         SHca9FplUDhPUhfZEK+pJvLjUpt38GPi/8wjYUvrILiENGSxzVfjIwb4aokyaLqacq
         m4o6jgS3gElpn+39DhNV9Q3t29/8BIm57HsuTSl8=
Date:   Thu, 3 Jan 2019 17:48:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, marc.zyngier@arm.com, suzuki.poulose@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, steven.price@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190103164831.GF14994@kroah.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103093858.GA10794@kroah.com>
 <c9e08010-3ca0-cb03-e5ad-ab19342ff63b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e08010-3ca0-cb03-e5ad-ab19342ff63b@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 10:38:16AM -0600, Jeremy Linton wrote:
> On 01/03/2019 03:38 AM, Greg Kroah-Hartman wrote:
> > On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> > > There is a lot of variation in the Arm ecosystem. Because of this,
> > > there exist possible cases where the kernel cannot authoritatively
> > > determine if a machine is vulnerable.
> > 
> > Really?  Why not?  What keeps you from "knowing" this?  Can't the
> > developer of the chip tell you?
> 
> There tends to be a few cases, possibly incomplete white/black lists,

Then fix the lists :)

> firmware that isn't responding correctly, or the user didn't build in the
> code to check the mitigation (possibly because its an embedded system and
> they know its not vulnerable?).

If the firmware doesn't respond, that would imply it is vulnerable :)

And if the code isn't built in, again, it's vulnerable.

> I would hope that it is an exceptional case.

Then have the default be vulnerable, don't give people false hope.

> > > Rather than guess the vulnerability status in cases where
> > > the mitigation is disabled or the firmware isn't responding
> > > correctly, we need to display an "Unknown" state.
> > 
> > Shouldn't "Unknown" really be the same thing as "Vulnerable"?  A user
> > should treat it the same way, "Unknown" makes it feel like "maybe I can
> > just ignore this and hope I really am safe", which is not a good idea at
> > all.
> 
> I tend to agree its not clear what to do with "unknown".
> 
> OTOH, I think there is a hesitation to declare something vulnerable when it
> isn't. Meltdown for example, is fairly rare given that it currently only
> affects a few arm parts, so declaring someone vulnerable when they likely
> aren't is going to be just as difficult to explain.

If you know it is rare, then you know how to properly detect it so
"unknown" is not needed, correct?

Again, "unknown" is not going to help anyone out here, please don't do
it.

thanks,

greg k-h
