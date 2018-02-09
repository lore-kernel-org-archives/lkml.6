Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeBIVgQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:36:16 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38949 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeBIVgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:36:14 -0500
X-Google-Smtp-Source: AH8x225wsUi0bNf3N6+8twTPaNmfgf93VIeQXpN79K9i2JHXv7lNk3oMeG01fRkcpSy33Z1OMlKBKQ==
Subject: Re: [PATCH] led: core: Fix race on software blink cancellation
To: Pavel Machek <pavel@ucw.cz>
References: <1516223562-3837-1-git-send-email-jacek.anaszewski@gmail.com>
 <57a6d1f7-c1d0-3871-fed8-84d094dd079f@gmail.com> <20180208215041.GA31216@amd>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        craig.mcqueen@innerrange.com.au, Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        Dan Murphy <dmurphy@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Alan Mizrahi <alan@mizrahi.com.ve>,
        Vadim Pasternak <vadimp@mellanox.com>, David Lin <dtwlin@google.com>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Willy Tarreau <w@1wt.eu>, Andrew Jeffery <andrew@aj.id.au>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Colin King <colin.king@canonical.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1010
Message-ID: <d078e26a-6250-72c5-b9ba-28d8787fcd51@gmail.com>
Date: Fri, 9 Feb 2018 22:35:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180208215041.GA31216@amd>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2018 10:50 PM, Pavel Machek wrote:
> Hi!
> 
>> Any comments? I'd like to have some acks before applying
>> this patch.
> 
> I can't say I like it.

Please point out the bits you don't like and spot any risks.

>>> Commit d23a22a74fde ("leds: delay led_set_brightness if stopping soft-blink")
>>> made a modifications to the LED core allowing for led_set_brightness() to be
>>> called from hard-irq context when soft blink is being handled in soft-irq.
>>>
>>> Since that time LED core has undergone modifications related to addition of
>>> generic support for delegating brightness setting to a workqueue as well as
>>> subsequent fixes for blink setting use cases.
>>>
>>> After that the LED core code became hard to maintain and analyze, especially
>>> due to the imposed hard-irq context compatibility. It also turned out that
>>> in some cases a LED remained off after executing following sequence of commands:
>>>
>>> 1. echo timer > trigger
>>> 2. echo 0 > brightness
>>> 3. echo 100 > brightness
>>>
>>> The reason was LED_BLINK_DISABLE operation delegated to a set_brightness_work,
>>> triggered in 2., which was handled after 3. took effect.
> 
> Could we wait for delayed work to be done before setting the
> brightness to fix this one?

Without mutually exclusive section you can always be preempted
after wait test succeeds and before requesting new brightness.
Then the other process can jump in, request other brightness
(and change it in struct led_classdev via led_set_brightness_nosleep()),
which causes we end up with non deterministic LED class device
state after that.

Every solution without mutually exclusive section is prone to races
here.

-- 
Best regards,
Jacek Anaszewski
