Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZocy+x1hvO1fr+WJRq0OTXGuVEn9es3umX16gieG7WvHcrBpycaOUrdVSTdorLBHlps+2pw
ARC-Seal: i=1; a=rsa-sha256; t=1526052346; cv=none;
        d=google.com; s=arc-20160816;
        b=OKmPLIseQftRlPjMJ9BCm7QCSVfw9Ie+ZDdFBHM71BmOso4nLHoWq3JEIv8bBbA0eB
         TilNOxj6+KOWs0KAJS0I4Sde0DjkrCsCHfEBl/qSaudb01wIYRgrq729vRTT/pLFwb0H
         YIhInb9Mtrk9MfR0pWcVWEJu/2wsl3za/vntGRxhJh6i2gRBWrvgXLSDHnw7O2HTUE4U
         bDU3qqx3VHP+vI6YhrjAj/FM8qjB7N9MQ1Wei00L91jyCpHrfHuxOjJZMG19bSxkBwL1
         kusae8fwQ3LQ8+EuQxYf8tqq+cGe8ZqB/rBkIbOZpm1PZrqNgG6if0zZ34BNSVzygxRQ
         ACIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=wdaGZprSM3iEdT/R4D7GLPMY3Sk3xUfa7B7Inb/vfBI=;
        b=GN+JU0xN0jPjT/1g2vMKtpV4hoD8M68LwYke3it4PaoIeYpbsu9G8yCq5OoO5aysDr
         xdLxy1BeKvZ5mU1N6YrI5l7zHGttJF9ZrIbCniYimDFfuQgDIIcP7sh1oXUpG1JpoGMr
         NbHDzmAaOnMsG6MYa12OwUFaUlaoICw6/ulajcRUmMJfqXdey79t5RbKpxcBH2zZ0R85
         VANfp9TAHmjY5JYFSlw0RGMDc/+wlChM2hYrSF3Oy+DxPBS3q7/GRym2/K7bS+KeeYrk
         n0zr1xfUczI58Xs3uNG0umEmfobJ+GH4Wj7kVpVpKqnmiAgLkcpa2QFl2+vIBj6aHsao
         PT4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	ruslan.bilovol@gmail.com,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v4 0/4] ALSA: usb: UAC3 new features.
Date: Fri, 11 May 2018 16:25:33 +0100
Message-Id: <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285487756615401?=
X-GMAIL-MSGID: =?utf-8?q?1600181865375874656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

v4 Updates:
 - Removes already applied patch from v2 of this patchset.
 - Adds small patch to parse Feature Unit number of channels.
 - Rebased onto latest linux-next tag as today.

Now that the UAC3 patch [1] has made it to linux-next I have some extra
features to make a UAC3 devices fully work in Linux. Including Jack 
insertion control that I have put on top of this other patch [2] for 
UAC2. Also adding support for the UAC3 Mixer Unit which is most likely
to appear in most headset type devices.

UAC3 devices also require to have a Basic Audio Device (BADD) in a separate 
config for which both Ruslan Bilovol and myself have submited different 
approaches[3][4]. After an ongoing discussion between Ruslan and myself
we have decided that the patch from Ruslan[3] implements a simpler and
yet more robust BADD driver.

All this features are tested with an actual UAC3 device that is still in
development. For this patch series, only the legacy config (#1. UAC1/UAC2)
and the UAC3 config have been tested. The BADD config will come in
a different patch from Ruslan.

[1]: https://patchwork.kernel.org/patch/10298179/
[2]: https://patchwork.kernel.org/patch/10305847/
[3]: https://patchwork.kernel.org/patch/10340851/
[4]: https://www.spinics.net/lists/alsa-devel/msg71617.html

Based on linux-next tag: next-20180510

Jorge Sanjuan (4):
  ALSA: usb-audio: UAC3. Add support for mixer unit.
  ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
  ALSA: usb-audio: UAC3 Add support for connector insertion.
  ALSA: usb-audio: UAC3: Parse Input Terminal number of channels.

 include/linux/usb/audio-v2.h   |   7 ++
 include/linux/usb/audio-v3.h   |  14 +++
 include/uapi/linux/usb/audio.h |  19 +++-
 sound/usb/mixer.c              | 200 ++++++++++++++++++++++++++++++++++++-----
 sound/usb/stream.c             |   9 +-
 5 files changed, 222 insertions(+), 27 deletions(-)

-- 
2.11.0
