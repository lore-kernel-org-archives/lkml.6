Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeCDT5f (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 14:57:35 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:44163 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeCDT5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 14:57:32 -0500
X-Google-Smtp-Source: AG47ELvOOlkXXEkBlD53cUl0MBaRQQYtm6b4htEF7J+FfQznt9M1m7+v4xihN+S8dVivS8JHed+Sng==
Date: Sun, 4 Mar 2018 20:57:28 +0100
From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] platform/x86: fujitsu-laptop: More accurately
 represent the hotkey ring buffer managed by firmware
Message-ID: <20180304195728.GB1428@kmp-mobile.hq.kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl>
 <20180227211539.5708-7-kernel@kempniu.pl>
 <CAHp75VeANKg+L7GsA=onScQ6mBeWzhthd0cP6=36rFB4KHWr7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeANKg+L7GsA=onScQ6mBeWzhthd0cP6=36rFB4KHWr7w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 27, 2018 at 11:15 PM, Michał Kępień <kernel@kempniu.pl> wrote:
> > The MAX_HOTKEY_RINGBUFFER_SIZE constant is set to 100, which allows up
> > to 100 hotkey events to be drained from the firmware ring buffer upon
> > module load.  However, no known firmware is capable of holding more than
> > 16 hotkey events in its internal ring buffer:
> 
> > The RINGBUFFERSIZE constant is set to 40, which allows the module to
> > queue up to 40 hotkey events for delivery to user space.  As this value
> > seems arbitrarily chosen and 16 should be more than enough for any
> > practical use case, merge the two aforementioned constants into one
> > (HOTKEY_RINGBUFFER_SIZE) in order to simplify code and more accurately
> > represent the underlying data structure.
> 
> > +#define HOTKEY_RINGBUFFER_SIZE         16
> 
> This need the comment or a
> 
> BUILD_BUG_ON(!is_power_of_2(...));

Okay, I will probably take the comment route in v2.

> > -       ret = kfifo_alloc(&priv->fifo, RINGBUFFERSIZE * sizeof(int),
> > +       ret = kfifo_alloc(&priv->fifo, HOTKEY_RINGBUFFER_SIZE * sizeof(int),
> >                           GFP_KERNEL);
> 
> >         while (call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
> >                               0x0, 0x0) != 0 &&
> > -              i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
> > +              i++ < HOTKEY_RINGBUFFER_SIZE)
> >                 ; /* No action, result is discarded */
> 
> This looks horrible.

It sure does!  Hence patch 7/7, which does the following:

-	while (call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
-			      0x0, 0x0) != 0 &&
+	while (fext_buttons(device, OP_GET_EVENTS, 0x0, 0x0) != 0 &&
	       i++ < HOTKEY_RINGBUFFER_SIZE)

In other words, patch 6/7 is just a stopover on the way to shorten
current module code:

-	while (call_fext_func(device, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0 &&
-	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
+	while (fext_buttons(device, OP_GET_EVENTS, 0x0, 0x0) != 0 &&
+	       i++ < HOTKEY_RINGBUFFER_SIZE)

> >         while ((irb = call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
> >                                      0x0, 0x0)) != 0 &&
> > -              i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
> > +              i++ < HOTKEY_RINGBUFFER_SIZE) {
> 
> Ditto.

Similarly, patch 7/7 does the following:

-	while ((irb = call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
-				     0x0, 0x0)) != 0 &&
+	while ((irb = fext_buttons(device, OP_GET_EVENTS, 0x0, 0x0)) != 0 &&
	       i++ < HOTKEY_RINGBUFFER_SIZE) {

The diff against current module code is thus:

-	while ((irb = call_fext_func(device,
-				     FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
-	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
+	while ((irb = fext_buttons(device, OP_GET_EVENTS, 0x0, 0x0)) != 0 &&
+	       i++ < HOTKEY_RINGBUFFER_SIZE) {

-- 
Best regards,
Michał Kępień
