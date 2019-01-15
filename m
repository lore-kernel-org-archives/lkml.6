Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C1D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547564557;
	bh=wHmf28uW9OQOmNVh/i0FjaHWdDEu5/NUpQ+B0sdBq/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E3tE8IDj/+ymf0+hFKBh1iMYU87WeKjbZUlBIps6rT7fXuqKtA3PoXjuOlyoQUTrF
	 8rnYhbvM7NWEULq67Q0A+I2IiB5wK6SMdLdG1Vr8hqacOQHMNgnKsYxhqxUVFoMvtL
	 2BCrtgS9QZKh5eRqwLZU39gLBnM4QB3gQODAl3W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfAOPCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfAOPCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:02:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87A6220656;
        Tue, 15 Jan 2019 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547564554;
        bh=wHmf28uW9OQOmNVh/i0FjaHWdDEu5/NUpQ+B0sdBq/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IGPfbT9Xxdy/ZmIWFzBUm+hRgreJ+VRw3TUyLw8fHvH/BiPCVByA6VDzufPuU+XmR
         HSN313Ebd2WjxaYUsRNoJXxnLpH6WpBkD6D7WgxGCSDDEBIedkAiVdBk3puBLAWUu6
         IpwEEcqPqyckBcO+KXZJUD8bRDhAvTc0dzjNEOPQ=
Date:   Tue, 15 Jan 2019 16:02:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>,
        linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Felix Siegel <felix.siegel@stud.uni-hannover.de>,
        Matthias Wolf <der_wolf_@web.de>, linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Radek =?iso-8859-1?Q?Dost=E1l?= 
        <radek.dostal@streamunlimited.com>,
        Renato Soma <renatoys08@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Tim Cofala <cofala@stud.uni-hannover.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] Staging: fbtft: Switch to the gpio descriptor
 interface
Message-ID: <20190115150231.GA3418@kroah.com>
References: <20190115044704.GA20989@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115044704.GA20989@nishad>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:17:09AM +0530, Nishad Kamdar wrote:
> This switches the fbtft driver to use GPIO descriptors
> rather than numerical gpios:
> 
> Utilize the GPIO library's intrinsic handling of OF GPIOs
> and polarity. If the line is flagged active low, gpiolib
> will deal with this.
> 
> Remove gpios from platform device structure. Neither assign
> statically numbers to gpios in platform device nor allow
> gpios to be parsed as module parameters.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Changes in v2:
>  - Merge all patches in a single patch. This is because the
>    first patch changes par->gpio from an int to a pointer
>    so all the checks have to be updated in the same patch.
>    Otherwie it breaks 'git bisect'.

The "v2" information goes below the --- line please.

Also, I got 2 copies of this, both different, so I have no idea which to
apply.  Please fix up and resend a v3.

thanks,

greg k-h
