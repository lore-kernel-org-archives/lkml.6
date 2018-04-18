Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524058177; cv=none;
        d=google.com; s=arc-20160816;
        b=k3qIDvp/A2XS6h8jFX154CP7wIYLlz2sPD6mDrRi0RGHvPVoUAqRWCWTEhT810TVaI
         plCv5sx/fqc/KxID8/GKKPNbndY97mbTCBpIglr55PO80ZsNDGFwq6Q7aR1LOQg10ECj
         TNW9m4NXIHYqjH8uSz6qPTq1lss7EMGjpUtxfqVWL+G40jECneX84Ng1RPKWiZ5O+R8s
         mG8X9GdLyVJQFMpsJTH+PVtbVYU5wFIFdli/RL7fhYRamAH4HRBRBbvcA7VkcCScpUrf
         MU1WMlvwWRjL3mtXyb6cvBPDD6UuHjuXvib9NXKJL405lb7NbJQsyXKiur2iTgidG5ox
         gzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HF7UKgn+TvZyoVB4+3aq6VPOWKKlkdl+Qh2ukAmYEu8=;
        b=j7hZOPdAiV1IRFf3Mb73LQEShbyd+9TzTaWlvWg0InZT5j6kMtnzbnJGU/VqiNVEuX
         xj1mOnb1orUwlPaijnaisr/MhfWVfcrgb1CE6S7GOvYs4V1OwoKPPGd1kkhLKl4Wsox5
         2C1Od2I1Gi0KfwtPFFP4BdezvVflG0eB4yYa8o2OlmP9HqPTbnV9CYd4a05gGv9I2771
         Y4hXj5w0dygGLHy72zueuH+2jaWvvdbbn8XF2XQabCzVistERMgxiu2PKOADKg5Au/pg
         iiLOh0WXY0AJgVup/wYwBEtnBP8v+W3l77AKwUGNnt3LHP5QjNoF42ciRxUquh75SlqV
         JSRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IacsrCIv;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IacsrCIv;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx4+Zf4Px5Oq1nNorOZGpmjzK4fz3zcdxmszwbVf9/XtlyjKPFyp7FQ9GeKih/qISxGabc4B80IuxsyAju1VPPZo=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Apr 2018 15:29:36 +0200
X-Google-Sender-Auth: hS5Sm49i565b6LH6W0stGU3QKrU
Message-ID: <CAMuHMdXyWs1v_D4EUd-H75Q3cpQv6yD2V_MptjJP7FjYhu5c3g@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] regulator: bd9571mwv: Add support for toggle
 power switches
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912189945282587?=
X-GMAIL-MSGID: =?utf-8?q?1598090828093515696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

On Wed, Mar 14, 2018 at 12:26 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
> development boards supports DDR Backup Power, which means that the DDR
> power rails can be kept powered while the main SoC is powered down.
>
> This patch series extends the support for DDR backup mode[1] to systems
> with toggle instead of momentary power switches.
>
> With a toggle power switch (or level signal), the following steps must
> be followed exactly:
>    1. Configure PMIC for backup mode, which changes the role of the
>       power switch to a wake-up switch,
>    2. Switch accessory power switch off, to prepare for system suspend,
>       which is a manual step not controlled by software,
>    3. Suspend system,
>    4. Switch accessory power switch on, to resume.
>
> Unlike on systems with a momentary toggle switch, an additional step 2
> must be performed in between step 1 and step 3.  Hence step 1 can no
> longer be handled in the PMIC's suspend callback.
>
> This patch series proposes a new callback for wake-up change
> notification, which allows performing step 1 when the user writes
> "enabled" to the PMIC's "wakeup" virtual file in sysfs, e.g.
>
>     echo enabled > /sys/devices/platform/soc/e60b0000.i2c/i2c-7/7-0030/bd9571mwv-regulator.2.auto/power/wakeup
>
> Conversely, writing "disabled" reverts the role of the accessory switch
> to a power switch.
> Note that unlike with momentary switches, backup mode is not enabled by
> default, as enabling it prevents the board from being powered off using
> the power switch, which may confuse the user.
>
> This has been tested on M3ULCB (thanks Jacopo!), and on Salvator-X(S).
>
> For testing, driver and DTS patches are available in the
> topic/bd9571-ddr-backup-mode-driver-v2 and
> topic/bd9571-ddr-backup-mode-dt-v2 branches of my renesas-drivers git
> repository at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
>
> Thanks for your comments!
>
> [1] https://lkml.org/lkml/2018/3/14/302
>
> Geert Uytterhoeven (2):
>   PM / wakeup: Add callback for wake-up change notification
>   regulator: bd9571mwv: Add support for toggle power switches
>
>  drivers/base/power/wakeup.c             |  4 ++++
>  drivers/regulator/bd9571mwv-regulator.c | 24 ++++++++++++++++++++++++
>  include/linux/pm.h                      |  1 +
>  3 files changed, 29 insertions(+)

Any comments/suggestions?

In case you lost the patches from the thread:
https://www.spinics.net/lists/linux-renesas-soc/msg24955.html

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
