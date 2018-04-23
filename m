Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524475933; cv=none;
        d=google.com; s=arc-20160816;
        b=JVTWJdq5E4LVw3fRbr0h8RYPUmCl5TJIVcQK1IJiBUPApuJg7ShntK/R0NPEff+wkH
         1Ddi55YOYJPeRmvMO8Y50s0KKUoev/5f9yi8C3uqFHczys0pPga8lwUYiEI1PnT2IMXC
         z+OnlXrxYM1mfUYsBz1kYNbYlkz8AyX1FTKCnBp60Z8vZPrmb/uL85rDRLcGdD/1W0Ie
         /pBjcRx/vM9erxApfBCC6i0BV+Vboi+ku6rJLx7W8Mh8Ea922XGL3nqRzDVhBTBMmep6
         wINNnPvaVZJZlEBkFKw3fjBNptk3TfGxyz6k9Jgm0YncnmBmwUHEfA8+dgR9cuLGM1jJ
         fZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=jYPCf8ilwQfRLxQHsPRW1xkG+BDSoYMr5ySZXXbSDtc=;
        b=iDHBmyxm0IuIwZNmBN3BOId+3hGB5Hrlz/adcl9dpANx5LpT37vp2L/yuT7zurjGCC
         FVz6BRbNr7jv3+m1fZlwJ/Izgef8VQZRoFSoEpB4NLOEI0lkyKy/DUuQ9kaDGofSiA0W
         u6S1Jz2PDZvDxq+L4/d68ELxSgOqSAM7kfCt8oKV0QGUt5WMVPoPu1V5d22dYH2I405S
         tNHo1I5h33d9ahpNvcjMqgDYoI/+UzNsJa63fj2kU1kyGeJbpRMM0O+qhWnhqAEeHj41
         4mduCQQjBxW6FKMJK/n7sjzMT3g9AZMX8nDEu6ifgcV7N4nzX7p4HvsBFsshoRTJM4qe
         XNZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FQ154Caf;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FQ154Caf;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx4/9mGf1EnV9HgY+2AIrxkRG1rFy30rUFty80WEbhTbAJ6YPCkia0J9e6iFb6EUpK0sP2MFGYgQDEr7W2lvPsOc=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1792056.cK5O20Fh4U@aspire.rjw.lan>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <1521026785-26456-2-git-send-email-geert+renesas@glider.be> <1792056.cK5O20Fh4U@aspire.rjw.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 11:32:13 +0200
X-Google-Sender-Auth: 2BDd6PFn2ndz2MOfmGFzPNhrTtw
Message-ID: <CAMuHMdWtf+AAb0i4Xu9o-LF7dym4jd9UxFZ-jKMbJcnuyQU3Fg@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change notification
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912192574352449?=
X-GMAIL-MSGID: =?utf-8?q?1598528876651533533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rafael,

On Mon, Apr 23, 2018 at 11:18 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, March 14, 2018 12:26:24 PM CEST Geert Uytterhoeven wrote:
>> Add a callback to inform a device that his wake-up setting has been
>> changed.  This allows a device to synchronize device configuration with
>> an external user action.
>>
>> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
>> switch, the system suspend procedure is:
>>   1. Configure PMIC for DDR backup mode, which changes the role of the
>>      accessory power switch from a power to a wake-up switch,
>>   2. Switch accessory power switch off, to prepare for system suspend,
>>   3. Suspend system.
>>
>> Hence step 1 cannot be done in the PMIC's suspend callback,
>
> I don't quite understand this, so can you please explain?
>
> What can't it be done from ->prepare() or even from a suspend notifier?
>
>> but it can be done in the new callback, in response to the user writing "enabled"
>> to the PMIC's wakeup virtual file in sysfs.

Step 2 (flip a switch on the board) is a manual step, to be done by the user.
So it cannot be done from any suspend callback or notifier.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
