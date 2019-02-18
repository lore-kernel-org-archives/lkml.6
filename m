Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57638C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C72218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550479315;
	bh=fL0uYYfci/48qrV+CrwzgpjTrhkEDs1bQIXdB9JE1Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AYbKL7rjtYo5d4t0Jm9JiTOri49otcxx7QxXXbfAkcbUTBiDT+mg+zYeQytuTsPJn
	 ltDbxC/0mNrme4nFjDP47LOo2kjfjUQ0eD4LSvLMIET9gPcfCg7SiANZEZb+PObnUM
	 YjAkCIZ0aid7qGwiQjEAZJb+KOh5UpfPVHcoG6mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfBRIlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBRIlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:41:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F2D2184E;
        Mon, 18 Feb 2019 08:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550479312;
        bh=fL0uYYfci/48qrV+CrwzgpjTrhkEDs1bQIXdB9JE1Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p51+4tqL4rj426RN4XnaRt3AxBSDqRpjfioIDRD5lVoArg2s6+/E9Bu+7BMulsAcL
         9bstOUJxjHBQ74juxF4rzCCVIaR+1bGCuMlZjMwnDbe3nMQ/9EmuzNXYlfYAUBTWhU
         aWf4ERMnDJdr2Zg2FkK0SmtL/Ze4ILKMrjQF3i0s=
Date:   Mon, 18 Feb 2019 09:41:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in
 genpd_dev_pm_attach_by_name()
Message-ID: <20190218084148.GD24924@kroah.com>
References: <20190214181249.2749-1-dianders@chromium.org>
 <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
 <CAD=FV=WH9zg62ME5Atk2NDXX8rLn0qMY3-P1U8jqDr4Th_BX_Q@mail.gmail.com>
 <20190218041514.yn76qm65k77etedr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218041514.yn76qm65k77etedr@vireshk-i7>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:45:14AM +0530, Viresh Kumar wrote:
> On 15-02-19, 07:47, Doug Anderson wrote:
> > Hi,
> > On Thu, Feb 14, 2019 at 7:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 14-02-19, 10:12, Douglas Anderson wrote:
> > > > The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> > > > to of_property_match_string() where the argument is "const char *".
> > > > Adding a const here allows a later patch to add a const to
> > > > dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> > > > that was declared "const" in a driver.
> > > >
> > > > Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
> > >
> > > Not sure if this should be counted as a fix.
> > 
> > I'm OK if the "Fixes" is stripped when applying or if someone tells me
> > to re-post without the Fixes--just let me know.  In general I do a lot
> > of cherry-picks from upstream and I appreciate the Fixes tag helping
> > to link patches together.  In this case if I picked the original patch
> > I'd definitely want this one too.  Certainly, though, CCing stable
> > would make no sense in this case.  ;-)
> 
> I am not sure if this is being done right now or not, but I read/heard
> somewhere that stable has started picking "Fixes" patches directly as
> well even if they aren't cc'd to stable.

It's random, not always happening, and nothing you can rely on.

If you know this is a patch for older kernels, then always add the cc:
stable line, as the documentation says you have to do!

thanks,

greg k-h
