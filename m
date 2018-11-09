Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D41C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E192086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E192086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=csclub.uwaterloo.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeKJBto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:49:44 -0500
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:36729 "EHLO
        caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbeKJBto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:49:44 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2018 20:49:44 EST
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 20367)
        id ABEEB460AAF; Fri,  9 Nov 2018 10:59:34 -0500 (EST)
Date:   Fri, 9 Nov 2018 10:59:34 -0500
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 052/144] ARM: dra7xx: Fix counter frequency drift
 for AM572x errata i856
Message-ID: <20181109155934.bbk6s3p2m5tairgz@csclub.uwaterloo.ca>
References: <20181108215054.826084593@linuxfoundation.org>
 <20181108215058.607934222@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108215058.607934222@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
From:   lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:50:23PM -0800, Greg Kroah-Hartman wrote:
> 3.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> [ Upstream commit afc9d590b8a150cfeaac0078ef5de6fb21a5ea6a ]
> 
> Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz external
> crystal is not enabled at power up.  Instead the CPU falls back to using
> an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is usually
> 20MHz on boards so far (which gives an emulated frequency of 32.786KHz),
> but can also be 19.2 or 27MHz which result in much larger drift.
> 
> Since this is used to drive the master counter at 32.768KHz * 375 /
> 2 = 6.144MHz, the emulated speed for 20MHz is of by 570ppm, or about 43
> seconds per day, and more than the 500ppm NTP is able to tolerate.
> 
> Checking the CTRL_CORE_BOOTSTRAP register can determine if the CPU
> is using the real 32.768KHz crystal or the emulated SYSCLK1/610, and
> by known that the real counter frequency can be determined and used.
> The real speed is then SYSCLK1 / 610 * 375 / 2 or SYSCLK1 * 75 / 244.

I certainly can't see a problem including it.  Of course I doubt there
really are any DRA7 systems running that old a kernel (certainly the
beaglebone X15 seems to require a newer kernel to even have a DTB
included).  The RuggedCom RX1400 might still be running 3.14 kernel,
but already has the patch applied (because I did it).

So certainly nothing wrong with adding the patch, but I doubt anyone
will notice.

-- 
Len Sorensen
