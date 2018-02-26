Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519642793; cv=none;
        d=google.com; s=arc-20160816;
        b=e6IdfYk9aSdvTuA3Cic7ZJN2NlfxHDWnCo0H7Q3IXzvpGl8i9pjFOzlitpovEkVXUy
         UCDRdL2ZAYZe6dp65PsHS0gxH7V9SeHytuvwhiGhVMU5dlXTWO0IogYy2Did1anfrhaZ
         rU7rtYy034S8PvPPikHa13DsoWqpr90/fghZo2N3YIcOzFBGrKj3qtDz7qAlOk/cFkO1
         UAY3i943qfydPZOEsRqqR7h3f8QJp60YeRz38+oIWYQ15jmJ9T2YVjhAUE6gsE7w/IOI
         8j6EDezSKPNfO6f5q47XGuBBtX+1Lc6e74UfKQHqO4f5ObwTzg59O7LnKIOjPLBU/XQ3
         mXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=rx9U50RFottajo1wNq5eBhZ6uwnDcUkjfiDRLLUUkQ4=;
        b=zfA5MfAHR1jUYbwEuQVrP/nBKEBwAGvXljhVCPYXnuAmPMBKBBbLnVh4kHk03KN0Vw
         G5U2HwjNkV19CswHCYrMXuf/8xmPZXidef8hQ2E/9wqSr4YBoCM35+i3Hlkt6s6LJ4ch
         JkepblYvZdw1piw2kd5Fqnf1+GMP14o6MxxTmvcZ8t708Q/5TPUFy4lb1gwojWMVm4tn
         Drm2T8OBAjR8brEdjSsddZ/JKLFOzkGg4q5PbpjeaQKeMBHmig8eRrVkPErlX/lYDAB7
         AykA3ef0BrOdtnlmmkEXPIDRWpKIueD++WRKC5c9M6a0a3Mu9jZkEn9Yrp4vMRnbht8g
         aQBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gpd/UjBk;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gpd/UjBk;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsK9fG7YWsxu2Lm+QcBxPDedVX8TxnSmGNTuwxhfa8hIxCUBq2rXNLJJc7kMq1405S0CbcMFOL5GGiWgUu4o8I=
MIME-Version: 1.0
In-Reply-To: <20180226090925.29436-1-hdegoede@redhat.com>
References: <20180226090925.29436-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 12:59:52 +0200
Message-ID: <CAHp75VevNQB_8BTaazq94RHQ_Nbs=CcjJwfw+Ph9iLunLYb9kg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] USB Type-C device-connection, mux and switch support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454016298840899?=
X-GMAIL-MSGID: =?utf-8?q?1593460961395572371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 11:09 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Here is version 3 of Heikki's and my USB Type-C device-connection, mux and
> switch support series. Version 2 and 3 bring various small code and style
> fixes based on review (no major changes).
>
> Here is the original cover-letter of v1:
>
> Some devices with an USB Type-C connector have a bunch of muxes
> behind that connector which need to be controlled by the kernel (rather
> then having them controlled by firmware as on most devices).
>
> Quite a while back I submitted a patch-series to tie together these muxes
> and the Type-C Port Manager (tcpm) code, using the then new drivers/mux
> framework. But the way I used the mux framework went against what it was
> designed for, so in the end that series got nowhere.
>
> Heikki Krogerus from Intel, who maintains the USB TYPEC subsystem, has
> recently been working on solving the same problem for some boards he is
> doing hardware-enablement for.
>
> Heikki has come up with a number of infrastructure patches for this.
> The first one is a new device-connection framework. This solves the
> problem of describing non bus device-links on x86 in what in my experience
> with this problematic area is a really nice simple, clean and *generic*
> way. This could for example in the near future also replace the custom
> lookup code in the pwm subsys and the custom pwm_add_table() /
> pwm_remove_table() functions.
>
> The other 3 patches add a framework for the different type of Type-C /
> USB "muxes".
>
> Heikki and I have gone through a number of iterations of these patches
> together and we believe these are now ready for merging. Since merging
> infrastructure patches without users is not done and Heikki's own use-case
> for these is not yet ready for merging, the rest of this series consists
> of patches by me to make the Type-C connector found on some Cherry Trail
> devices (finally) be able to actually work as an USB port and not just
> a charge port.
>
> The last patch uses the new usb-role-switch framework to also do proper
> devcie / host switching on CHT devices with a USB micro AB connector.
> This is also a big feature for CHT users, because before this they had
> to do a reboot to get an OTG-host cable recognized (on some devices).
>
> Part of this series is an usb-role-switch driver for the role-switch
> found inside the xhci controller on e.g. CHT devices, this is currently
> implemented as the generic xhci controller instantiating a platform
> child-device for this, since this really is a separate chunk of HW
> which happens to sit in the XHCI mmio space. This approach may not be
> universally liked, given that in this new series the role-switch driver
> is much smaller and does not have any external deps anymore we could
> just integrate it into the xhci code if that is preferred.
>
> About merging this series (once everything is reviewed, etc.), there are
> quite some interdependencies in it esp. a lot of the patches depend on
> the first patch. Luckily patches 1-10 all apply to subsystems which are
> maintained by Greg (most to the USB subsys). Which just leaves patches
> 11 and 12 once 1-10 are merged. Greg, can you create an immutable branch
> for the platform/x86 and extcon maintainers to merge once this is done?

Didn't have time to comment on v2, so here we are:
you are using in even the same file two styles, i.e. IS_ERR_OR_NULL
vs. !x || IS_ERR(x) (and negative ones).

Otherwise, take mine

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Regards,
>
> Hans



-- 
With Best Regards,
Andy Shevchenko
