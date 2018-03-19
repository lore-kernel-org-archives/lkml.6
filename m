Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvUxQrnlhCqkOgkbtG8WP3jHjMlJ9jr/aJier5OpqM4L+WZgm/np4rD/QJJ5wWuCIsvM8/a
ARC-Seal: i=1; a=rsa-sha256; t=1521483261; cv=none;
        d=google.com; s=arc-20160816;
        b=Q0w5ai2JHMhqbq9wRJJgUa6Xm/LO02dGzxRmDjaBJJToSaMDKefSqRS9zQxLn0i3Fv
         yemntbCcwBRSqYwutFYFHv9D+ObwilqHCK2OasqmdcjU63O7s3YcqGZzQ1tUkfq813iY
         ff5mdg6iT2+IlEtfHsClyzgClcbDWJusgK8UsfouYQQYGEzF2ODL7UKQVHl6AG+9bhgS
         ww6NsncQaJCGxGaP0LBTEIcQYzbk0Tq1sEVK0uzRXu0f387FxJOrSKlWU4gnwka68q3H
         I/bVvHpMOgsZ9p0tDMK59snmhCf5DBIuwbLvFQIj5kECybQRuN/2Mt1LQgTDGJLuoXD8
         Q1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jh46KTMCAJeOJq/n6EhoObJYCICHGLgkX9ZFQYRmx48=;
        b=r5RsA4p426EXBOZ8fScJFRBa9GHPfyIWIFloxsvIQwOhk82NI0qx69V/MjEnDuQsR8
         cIl43gzhs4n11AsUyF0KOrX7jCc7St8dkqT4xE7QamHyVtOxFNPn31+mEB7COyADLsGF
         A3pk5aC/iTFcMPeY/J/+gERIz/US8WkbxsmQsMLKWjbjUiJkYQG0+8F871JazTUXszon
         3D2XuSlrWJVamy3R00X5qe+cYWnDOzG+hQZMFuWOxdO2AfOP5QsFSeph75ru8tH4y74K
         9iNheL9wIlV+Alp1l++uIQYw0kza7hBdCXLFk9kh09he/WYIoa0AlxTSqE04x9k8dHOG
         NbLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liam Beguin <lbeguin@tycoint.com>,
	Sylvain Lemieux <slemieux@tycoint.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 058/134] video: ARM CLCD: fix dma allocation size
Date: Mon, 19 Mar 2018 19:05:41 +0100
Message-Id: <20180319171857.710685292@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390565607100523?=
X-GMAIL-MSGID: =?utf-8?q?1595390832049216457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam Beguin <lbeguin@tycoint.com>


[ Upstream commit 9a1c779e6b06855e41099caa6f15b3b584dfa88c ]

This patch forces the frambuffer size to be aligned on kernel pages.

During the board startup, the splash screed did appear;
the "ts_test" program or our application were not able to start.

The following error message was reported:
error: failed to map framebuffer device to memory.
LinuxFB: driver cannot connect

The issue was discovered, on the LPC32xx platform, during the migration
of the LCD definition from the board file to the device tree.

Signed-off-by: Liam Beguin <lbeguin@tycoint.com>
Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/amba-clcd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -759,8 +759,8 @@ static int clcdfb_of_dma_setup(struct cl
 	if (err)
 		return err;
 
-	framesize = fb->panel->mode.xres * fb->panel->mode.yres *
-			fb->panel->bpp / 8;
+	framesize = PAGE_ALIGN(fb->panel->mode.xres * fb->panel->mode.yres *
+			fb->panel->bpp / 8);
 	fb->fb.screen_base = dma_alloc_coherent(&fb->dev->dev, framesize,
 			&dma, GFP_KERNEL);
 	if (!fb->fb.screen_base)
