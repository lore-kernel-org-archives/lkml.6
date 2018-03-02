Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423958AbeCBI5B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:57:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49424 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423929AbeCBI44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:56:56 -0500
Date: Fri, 2 Mar 2018 09:56:54 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH 000/100] rtc: remove cargo culted code
Message-ID: <20180302085654.GA1479@piout.net>
References: <6ED8E3B22081A4459DAC7699F3695FB701941570C7@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB701941570C7@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2018 at 08:46:48 +0000, Steve Twiss wrote:
> On Wed, Feb 21, 2018 at 8:54 PM, Alexandre Belloni wrote:
>  
> > subject:	[PATCH 000/100] rtc: remove cargo culted code
> > mailing list:	linux-kernel@vger.kernel.org Filter messages from this mailing list
> >
> > Hello,
> >
> > This series:
> >  - removes useless calls to rtc_valid_tm in .read_time, .set_time and
> >    .set_alarm
> >  - removes code setting default values for RTCs (and lets the core
> >    handle it)
> >  - removes useless "time is invalid" messages at probe time
> >  - removes useless indirect calls
> >
> > Those were mostly copy pasted from other drivers
> 
> Hi Alexandre,
> 
> Acked for:
>   rtc: da9063: stop validating rtc_time in .read_time
>   rtc: da9052: stop validating rtc_time in .read_time
>   rtc: da9055: stop validating rtc_time in .read_time
> 
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Agreed -- rtc_valid_tm() call is cargo cult for the above.
> 
> (By definition) for DA9063 I was trying to be rigorous.
> The .read_time function is slightly different here because I can make a copy the alarm time into the RTC time
> structure to solve an RTC synchronisation problem internally to the DA9063.
> https://elixir.bootlin.com/linux/v4.5.6/source/drivers/rtc/rtc-da9063.c#L253
> 
> But after some further looking, I have not got any explicit case of how the time read directly from the DA9063
> registers can be incorrectly represented. So there should be no need to check this.
> 

My point is that it is checked later in the core anyway so you end up
doing:

da9063_rtc_read_time()
	return rtc_valid_tm(tm);

__rtc_read_time()
	if (err < 0)
		return err;
	err = rtc_valid_tm(tm);

	return err;

So the check in da9063_rtc_read_time is always pointless.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
