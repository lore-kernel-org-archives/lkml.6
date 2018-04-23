Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524476255; cv=none;
        d=google.com; s=arc-20160816;
        b=xa0PGgskqE3LZWoIPkuJyI1jvWyN6tele+IjBgOoGRGVA6oj4xB6GRag+7wr0yxDyB
         h9syF2aQUyzbS0zm+hE0qBMqsE229vw1w0LFc1dZokVSmwLSVtv5qqPNrziRVTUdjrbj
         6nSaIcWZb3qR3VViucquU0HvVqL1+VhnnHMRHu3cHFVWA8GpvUpekJ+rkKPvQ/DJ6hSD
         f/YPqX2Tk1qzP0HZ51O9I3S9Ej5r6x7Iay+dv8WWAzH+o/zUbr3bP9XGCnfo3Iedyctb
         9CuwqnLF67YoFJPtG/3L53ZQTtgKe9S+Md1i47zvKb1vdAClfbScJW9ouDQIjbyHJdzW
         PArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eCm+6lWtI2CVi5E4EKVmQ/Co30KUPXb84wc3rLzso04=;
        b=ZA+LdOiRyeUR1xB6iiE+akrOomxUStEArJljhA67bHYRMoPahJAunhCK5MuTKq7Kes
         HGYZ7+NLTiZdM2jrhnj6c4kTW0OZesk4Q/OVObMvLF5Vw1ZenNA92/fqltmaqGQFaF+9
         pJU/oYUw0Dsyi7dpOX5dNBI7xylDlpg8glZD1OYqezrCFZD+RXK+Cvu7mA7Mz1lQSmDA
         c/BRAGSu+c2q3NjyPokno79Oz4kjjcwXcPhwHVU/2aEtMBDTWVBq+b1L8o69ndL+zQ9v
         GX0iimc6okOe9Sclz0rEmV5+XRY3v467inWcQHx+pJsjFL7XdGYjLmqVQuVvsonT4qKr
         R2cA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GOH/9ZiE;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GOH/9ZiE;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AIpwx48tmg9mJGyBqdMdvjYjniMJKYdTNBzcWn9KN/YZFLsWgEY3KdAw+wnXtIFWseeKMY2gxQgOSuNYkH5IZFbgb/k=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAMuHMdWtf+AAb0i4Xu9o-LF7dym4jd9UxFZ-jKMbJcnuyQU3Fg@mail.gmail.com>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
 <1792056.cK5O20Fh4U@aspire.rjw.lan> <CAMuHMdWtf+AAb0i4Xu9o-LF7dym4jd9UxFZ-jKMbJcnuyQU3Fg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Apr 2018 11:37:35 +0200
X-Google-Sender-Auth: jigewwrj-Yjt-dYuxNhwQE1qBIg
Message-ID: <CAJZ5v0jOk0pLegJK0-LwK3WEA5A560eNd32O5jK+PzQL9ZRofA@mail.gmail.com>
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change notification
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912192574352449?=
X-GMAIL-MSGID: =?utf-8?q?1598529214698192270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:32 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rafael,
>
> On Mon, Apr 23, 2018 at 11:18 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, March 14, 2018 12:26:24 PM CEST Geert Uytterhoeven wrote:
>>> Add a callback to inform a device that his wake-up setting has been
>>> changed.  This allows a device to synchronize device configuration with
>>> an external user action.
>>>
>>> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
>>> switch, the system suspend procedure is:
>>>   1. Configure PMIC for DDR backup mode, which changes the role of the
>>>      accessory power switch from a power to a wake-up switch,
>>>   2. Switch accessory power switch off, to prepare for system suspend,
>>>   3. Suspend system.
>>>
>>> Hence step 1 cannot be done in the PMIC's suspend callback,
>>
>> I don't quite understand this, so can you please explain?
>>
>> What can't it be done from ->prepare() or even from a suspend notifier?
>>
>>> but it can be done in the new callback, in response to the user writing "enabled"
>>> to the PMIC's wakeup virtual file in sysfs.
>
> Step 2 (flip a switch on the board) is a manual step, to be done by the user.
> So it cannot be done from any suspend callback or notifier.

I still find it somewhat difficult to follow you here. :-)

How is this expected to work?  Is the user expected to flip the switch
on the board and then write to "wakeup" or is that the other way
around?
