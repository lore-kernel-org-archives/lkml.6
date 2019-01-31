Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54943C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C60218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548921665;
	bh=7JwinbU7utDoBTj7TixCC8Sz+VMn0X+ixTaKmW1bMFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=11JP1ruJUBAoMdZlKXPGVeKZaR7m+x1xlluRn04bzUirnf2TdaJTKOpoSsLCO1RU/
	 U6m6DohpqSil+II/ZTkvV4lpISDTuoXeBp5MWWTVGYfjI2qfESuWw06F/Swc5v+foI
	 kYHrCR4YcYFUnUi7KK45E+3jwfUA+6nfvr8GE1g8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfAaIBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaIBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:01:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 504FF2087F;
        Thu, 31 Jan 2019 08:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548921662;
        bh=7JwinbU7utDoBTj7TixCC8Sz+VMn0X+ixTaKmW1bMFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbV1gpfkEzsVL0f1Rluk5kxYKi3PuWD2DU4jg3L1yfqQfEpLD7eYpLNYNlR3xdDxl
         UYki3o4R0A+qogCCzpwAEB5Mv5ouB4YQg+pzTa1AaVNWA0mI3Mv85SZ+deMuFkrP6Z
         9SAgDnyPaNP9Sa537FMS7T8U9WMK8ui/kggQuGmc=
Date:   Thu, 31 Jan 2019 09:01:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        badhri@google.com, Adam.Thomson.Opensource@diasemi.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Correct the PPS out_volt calculation
Message-ID: <20190131080100.GA16000@kroah.com>
References: <20190130031353.100228-1-kyletso@google.com>
 <20190131073125.GM7262@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131073125.GM7262@kuha.fi.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 09:31:25AM +0200, Heikki Krogerus wrote:
> On Wed, Jan 30, 2019 at 11:13:53AM +0800, Kyle Tso wrote:
> > When Sink negotiates PPS, the voltage range of selected PPS APDO might
> > not cover the previous voltage (out_volt). If the previous out_volt is
> > lower than the new min_volt, the output voltage in RDO might be set to
> > an invalid value. For instance, supposed that the previous voltage is
> > 5V, and the new voltage range in the APDO is 7V-12V. Then the output
> > voltage in the RDO should not be set to 5V which is lower than the
> > possible min_volt 7V.
> > 
> > Fix this by choosing the maximal value between the previous voltage and
> > the new min_volt first. And ensure that this value will not exceed the
> > new max_volt. The new out_volt will fall within the new voltage range
> > while being the closest value compared to the previous out_volt.
> > 
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> 
> Fixes: c710d0bb76ff0 ("usb: typec: tcpm: Extend the matching rules on PPS APDO selection")
> Cc: stable...

No need for stable, as c710d0bb76ff ("usb: typec: tcpm: Extend the
matching rules on PPS APDO selection") only showed up in 5.0-rc1.

Note, no need for the extra digit on your sha1 listing, here's the
recommended way to show this:
	git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"

thanks,

greg k-h
