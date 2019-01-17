Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CC0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA0C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAQNYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:24:18 -0500
Received: from mail.sig21.net ([80.244.240.74]:38280 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfAQNYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:24:17 -0500
X-Greylist: delayed 1088 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2019 08:24:16 EST
Received: from p5780437e.dip0.t-ipconnect.de ([87.128.67.126] helo=zzz.local)
        by mail.sig21.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <js@sig21.net>)
        id 1gk7Mm-00047m-T6; Thu, 17 Jan 2019 14:05:55 +0100
Received: from js by zzz.local with local (Exim 4.92-RC4)
        (envelope-from <js@sig21.net>)
        id 1gk7Mj-0004ND-VF; Thu, 17 Jan 2019 14:05:49 +0100
Date:   Thu, 17 Jan 2019 14:05:49 +0100
From:   Johannes Stezenbach <js@sig21.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dean Wallace <duffydack73@gmail.com>,
        Mogens Jensen <mogens-jensen@protonmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20190117130549.GA16759@sig21.net>
References: <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 01:05:35PM +0100, Hans de Goede wrote:
> On 17-01-19 10:12, Dean Wallace wrote:
> > On 17-01-19, Mogens Jensen wrote:
> > > Kernel is compiled with SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH and the quirk seems to have fixed the problem caused by commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL"), as sound is now working if running "speaker-test" on my system which is clean ALSA.
> 
> Note being "clean ALSA" is really not a good thing now a days,
> for lots of things we depend on pulseaudio (like setting
> up UCM mixer profiles).

FWIW I disagree because PA never worked for me.  I simply used
"alsaucm -c chtcx2072x set _verb HiFi".  But I was surprised
that PA does the ALSA UCM setup but it's not documented well that
you need to do it by other means if you don't use PA.
https://bugzilla.kernel.org/show_bug.cgi?id=115531#c72


Regards,
Johannes
