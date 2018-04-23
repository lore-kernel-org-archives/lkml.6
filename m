Return-Path: <david@lechnology.com>
X-Google-Smtp-Source: AB8JxZp/HdNs8n5rUu3X6XRGB1HYe0xZpMP5TICCb/vufq3SmBn6vEc8TZAcRORVty2MQcP1ynRc
ARC-Seal: i=1; a=rsa-sha256; t=1524519516; cv=none;
        d=google.com; s=arc-20160816;
        b=c6WKiP/Tz7eC76XTGqDJ7eVg1zav8R0RNB/tOx15VBXE0MuzcQGEltIGUKgA4Y+CCC
         nXVCT444pucgM11Ajs0WAVRhvzOt/I04hvqceB7dYyQ0Rbg2NoDIipOkMGRAZQz5z3E+
         EO7FEEqzDLROPR6OJTPsjTMDccx1HOTIQ5keAXOOKD+5T7paFLOf5+odZqctDo90lW83
         fCF5jzUbIRjTrg4F+40XZ1tv/RztQ+xwP9XGYNNewyeBy7qjXEpDLbt24ZBRqg2nhaJe
         TbsMS3aG/Jk0M9pv/TqQEl+ktae5q9UC2R1YKWDIXSxVBu/Xi4QDIugSjrnv1AqsWnIJ
         BLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=SyLrgC94B/1G5YVLTKIDYltHaCdZkz3H4svXnzENLZY=;
        b=jFmpdixBLasKrdGc2qdlKcuvOpeumRdqguO9DOwCKTpFy+WCCquDGRlTyFcg6ZdFQG
         N6is5ksqDJR1ry7J9KdYozJolgLdeLQ0CdZ8I+lNKJtQ2lRwEy1JzGNeo/d2I0o9nfdJ
         J+ZMy5QmVwnFczU6fjqNi/UavmZ8Q8DTqq4dkhXjG1ec9VcSVYzoLs6m2723SETmpvU6
         npYSCoBiHwfaaz9RnVhPYgRkGg5sY7hqbM+wJ/lTpGPUze758yexPXdZlevY/hMYTqBg
         eHi4xYKZrTpwULnHjEhVOqzouGbcWVlQ972pJFwDdsV6TqINzxwNe/Yeqr6UWopxYR4U
         RUIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=D9VU2OL6;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=D9VU2OL6;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
Subject: Re: [RFC work-in-progress 0/7] of: platform: use early platform
 routines instead of OF_DECLARE
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
References: <20180423183814.20615-1-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <b50d1a0d-4585-5c2b-bfc7-4f2ad023b753@lechnology.com>
Date: Mon, 23 Apr 2018 16:38:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423183814.20615-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598563237980894406?=
X-GMAIL-MSGID: =?utf-8?q?1598574576438030237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

FYI: It looks like the CC for Stephen and Arnd was messed up, so I
fixed.

On 04/23/2018 01:38 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Hi David, Sekhar,
> 
> since platform devices are generally considered more desirable than
> CLK_OF_DECLARE, TIMER_OF_DECLARE etc. and we need to figure out how to
> handle the clocks that need to be initialized early in the boot
> process on DaVinci, I thought that I could give the early_platform
> mechanism a try.
> 
> This API is only used on one architecture (sh) but seems to work just
> fine on ARM. It allows to register early platform drivers and then
> probe them early in the boot process. So far only machine code is
> supported but with a bit of hacking I was able to probe a DT device.
> 
> This is a very dirty and far-from-upstream proof of concept that allows
> to probe the (so far dummy) davinci timer platform device during the
> call to init_time (from machine_desc).
> 
> The idea is to have a special compatible fallback string: "earlydev"
> that similarily to "syscon" would be added to device nodes that need
> early probing. Then we'd call the of_early_platform_populate()
> function that would find all compatible nodes and populate them
> long before all the "normal" nodes.

FWIW, "earlydev" sounds like a driver implementation detail, so not
something that should be included in the device tree. We only need
this because Linux needs a clocksource early on, but that doesn't
mean that all device tree users need to do the same.

I'm sure it makes things easier for a proof of concept though. :-)

> 
> This would allow us to make the davinci timer a normal platform device
> and possibly also probe the psc and pll drivers earlier than we do now.
> 
> The early platform API even allows us to check if we're being probed
> early in probe() so we can possibly probe the driver twice if needed:
> only doing the critical stuff first and then completing the process
> later.
> 
> If you think this is a good idea, I would like to continue on that
> and eventually make it an alternative to OF_DECLARE macros.
> 
> For a quick conversion of the davinci timer to a platform driver
> I image we'd need to use platform data lookup that would be passed
> to of_early_platform_populate().

On the surface, it certainly sounds like a good idea to me. Do we have
access to struct device of the platform device when using this early
platform device? I remember when I was working on the clock drivers, I
tried registering a platform device in the init_time callback but the
kernel crashed because kobj stuff was not initialized yet. I'm guessing
that the early platform device somehow works around this.
