Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8CEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094F220842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfB0JU1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:20:27 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37303 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfB0JU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:20:27 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 64411FF805;
        Wed, 27 Feb 2019 09:20:24 +0000 (UTC)
Date:   Wed, 27 Feb 2019 10:20:23 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Subject: Re: Banana Pi-R1 stabil
Message-ID: <20190227092023.nvr34byfjranujfm@flea>
References: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 09:04:57AM +0100, Gerhard Wiesinger wrote:
> Hello,
> 
> I've 3 Banana Pi R1, one running with self compiled kernel
> 4.7.4-200.BPiR1.fc24.armv7hl and old Fedora 25 which is VERY STABLE, the 2
> others are running with Fedora 29 latest, kernel 4.20.10-200.fc29.armv7hl. I
> tried a lot of kernels between of around 4.11
> (kernel-4.11.10-200.fc25.armv7hl) until 4.20.10 but all had crashes without
> any output on the serial console or kernel panics after a short time of
> period (minutes, hours, max. days)
> 
> Latest known working and stable self compiled kernel: kernel
> 4.7.4-200.BPiR1.fc24.armv7hl:
> 
> https://www.wiesinger.com/opensource/fedora/kernel/BananaPi-R1/
> 
> With 4.8.x the DSA b53 switch infrastructure has been introduced which
> didn't work (until ca8931948344c485569b04821d1f6bcebccd376b and kernel
> 4.18.x):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/dsa/b53?h=v4.20.12
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/dsa/b53?h=v4.20.12
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/net/dsa/b53?h=v4.20.12&id=ca8931948344c485569b04821d1f6bcebccd376b
> 
> I has been fixed with kernel 4.18.x:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/dsa/b53?h=linux-4.18.y
> 
> 
> So current status is, that kernel crashes regularly, see some samples below.
> It is typically a "Unable to handle kernel paging request at virtual addres"
> 
> Another interesting thing: A Banana Pro works well (which has also an
> Allwinner A20 in the same revision) running same Fedora 29 and latest
> kernels (e.g. kernel 4.20.10-200.fc29.armv7hl.).
> 
> Since it happens on 2 different devices and with different power supplies
> (all with enough power) and also the same type which works well on the
> working old kernel) a hardware issue is very unlikely.
> 
> I guess it has something to do with virtual memory.
> 
> Any ideas?

> [47322.960193] Unable to handle kernel paging request at virtual addres 5675d0

That line is a bit suspicious

Anyway, cpufreq is known to cause those kind of errors when the
voltage / frequency association is not correct.

Given the stack trace and that the BananaPro doesn't have cpufreq
enabled, my first guess would be that it's what's happening. Could you
try using the performance governor and see if it's more stable?

If it is, then using this:
https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test

will help you find the offending voltage-frequency couple.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
