Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519957954; cv=none;
        d=google.com; s=arc-20160816;
        b=U7PdW3M+HtSIQq9UvWrNlYC0JhxSbf3xwB4j5ci+3MaYxnb5TigTgoURTQBQ4naIJL
         8sJj6X2sT/nLUiGb6es7b7QdOoKrev+72m5GfekykIcJFb/cpU/HWMtOy6NsIuysIH/+
         yY8xM+8/OqoZpy1Y93hWDMGREAYmkiVFtDkOvEndhxLJe90kayW7Tg7Igk6aHLaBvX50
         pyRFgOWNeVwwXGg8pAkvvysQz0/TzmVL2lM4j8VmDJld0yAMx1jEvHGe2+/vt5EqYdNX
         h4Vw1YSXGtQ8Ka9L3Nr4hcpDHUm3GxFMbjDMjS6l9wUWw4Il1HxGYslaylEidtrZ6s7u
         scJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Z2dsUOwyJVJGwOVIKgNI2Jx/Y2GK4+SA8ZvYdGtMf1Q=;
        b=FmMtNrcnX55VJOcCOb7mX1DjTzcL5YLqYQKIBtWDSHd6xhZAwtj17MSHHaFUqIEXkP
         EI10njEaM27zzi9xMRjubEnwkdvxyg4nA9bjzwWlJvl4rTb3g+SM/qjeMyUnlrc3UZoT
         rbskJP5fEffAqKMiWjDmLh+OTGdhJuughjDQUTGVvAqgwcR3ejwF8wi1BLynnZ9T2ABI
         ZTjf3JY48CvJ2ZbKQjmM6JPgNroDrM94XodHO7mjvdiDKfrAtIicnSQGOltph4ZwKoJD
         bln5OXkq6Icl+nGSag7cBx1W1PNt1ZUcLloDV2tR7P296eDNXXTx36UBOT0UzmAh5fuX
         ZUaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=lsegCvYw;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=lsegCvYw;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsxIbvparsjqgHqc+cFfd+bJcXcJjmLprPc8/SMKsOV2Zb8D5Pv8lg8brdLeesMAqURfPzlDA==
Date: Thu, 1 Mar 2018 18:32:30 -0800
From: Brian Norris <briannorris@chromium.org>
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, dtor@google.com,
	dianders@google.com,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
Message-ID: <20180302023229.GA164361@rodete-desktop-imager.corp.google.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-2-jeffy.chen@rock-chips.com>
 <20180212221309.GA66974@ban.mtv.corp.google.com>
 <5A8FE726.6080903@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8FE726.6080903@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1593791432077327236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Fri, Feb 23, 2018 at 06:04:22PM +0800, Jeffy Chen wrote:
> On 02/13/2018 06:13 AM, Brian Norris wrote:
> > > >
> > > >  	if (bdata->gpiod) {
> > > >+		int active_low = gpiod_is_active_low(bdata->gpiod);
> > > >+
> > > >  		if (button->debounce_interval) {
> > > >  			error = gpiod_set_debounce(bdata->gpiod,
> > > >  					button->debounce_interval * 1000);
> > > >@@ -568,6 +572,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
> > > >  		isr = gpio_keys_gpio_isr;
> > > >  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
> > > >
> > > >+		switch (button->wakeup_event_action) {
> > > >+		case EV_ACT_ASSERTED:
> > > >+			bdata->wakeup_trigger_type = active_low ?
> > > >+				IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
> > > >+			break;
> > > >+		case EV_ACT_DEASSERTED:
> > > >+			bdata->wakeup_trigger_type = active_low ?
> > > >+				IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> > > >+			break;
> > What about EV_ACT_ANY? And default case? I think for ANY, we're OK
> > letting suspend/resume not reconfigure the trigger type, but maybe a
> > comment here to note that?
> right, will add comment in the next version.
> > 
> > > >+		}
> > > >  	} else {
> > What about the 'else' case? Shouldn't we try to handle that?
> i think the else case is for irq key, which would generate down and up
> events in one irq, so it would use the same trigger type for all these 3
> cases.

Not necessarily. It uses whatever trigger was provided in
platform/DT/etc. data. You could retrieve that with
irq_get_trigger_type() and try to interpret that. Or you could just
outlaw using that combination (e.g., in the binding documentation).

Brian

> i'll add comment in the next version too.
> > 
> > Brian
> > 
> 
> 
