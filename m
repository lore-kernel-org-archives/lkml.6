Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsTjZZRrP9vRsPDv5LLKfb+bH7aHVHdIK7VNwgwcUvsx2UxR2zrUSRSMx7UO+FC1I+ebrrK
ARC-Seal: i=1; a=rsa-sha256; t=1521483007; cv=none;
        d=google.com; s=arc-20160816;
        b=OXtHjI7A9HZfiNbhJsX8u1oGFxaYdWq5QAZPiHuA4EOJBxqx5McWm30Q7lLfPFo+D8
         eNwrQcY9lxb/6pnxXLD4O755jDtvGAOjEsR4P+tuZYmedZLJ4mNOrASk4HvxneFKStB5
         YV5gXA6mGVSIO1fkznYcruzV/gObAm2ViP23Ll40FiOXBtPAd8llg5sQ+fZm2xr6Po37
         TcaXfnpVxzXPS/pdpeSTjZAsv7h4w5gTUhsPwrEKaM7vNJNKncT1fgARk9ieldoY4JGG
         R7CgJ2mW5E3bWluorz8gts5QUQYgUewmCXHBz00/2ESspyYkG89aBziLp2xZZlIK13Kn
         qz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0fiNQ5Uf3q6Aesj17ky96pMD2wC+oYgf9NjLmXhhr50=;
        b=KNcMDsfOAudKTz9j6sIgko6KRhOXhClmn3YA1+Ol3Vjhv2zdgLX+529LoQ86/HzsyH
         0sevkSiX2XkWSH53R5zUTbLdgW7IKIo8fhBq1K0c4jgj+J+SutucelwP7TEiAQmXRx6H
         TODNzEewdvXtyxNFZrImJNGRuObcqQosV00bcqcvP3gKKixLDHEJjDzk+RmHWafJqiv6
         Q3WL1zFYPNqoPQMrfHA/BFT6tFWOEOIkk2sYjCHoIibMxlwcoUmeWeeBkqyAlkbM7EsB
         jafGG372s3DkSkoTbZG6mnZrOS9AWB1ylCwLWLGcq6luHrck06mepQBEN9E68ZtMIqW+
         DDnw==
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
Subject: [PATCH 3.18 32/68] video: ARM CLCD: fix dma allocation size
Date: Mon, 19 Mar 2018 19:06:10 +0100
Message-Id: <20180319171832.268160999@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390565607100523?=
X-GMAIL-MSGID: =?utf-8?q?1595390565607100523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -757,8 +757,8 @@ static int clcdfb_of_dma_setup(struct cl
 	if (err)
 		return err;
 
-	framesize = fb->panel->mode.xres * fb->panel->mode.yres *
-			fb->panel->bpp / 8;
+	framesize = PAGE_ALIGN(fb->panel->mode.xres * fb->panel->mode.yres *
+			fb->panel->bpp / 8);
 	fb->fb.screen_base = dma_alloc_coherent(&fb->dev->dev, framesize,
 			&dma, GFP_KERNEL);
 	if (!fb->fb.screen_base)
