Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/z6Nq20IHCdyM3DVCVar6BIIJ29X9Wn9FwX/fsCgb7AnzRfcZIBXHD55AtV8WuA0HR1icG
ARC-Seal: i=1; a=rsa-sha256; t=1523399266; cv=none;
        d=google.com; s=arc-20160816;
        b=L96PWhP4k1K0eARoaynplb8+INBF8HSfRJEB0MjOqvJvfsxN99SLdIs76cUgtedIpJ
         WqNsB/I1bEzhoYOXKqYeT0M41HdcldQrTcRJViAYRB8ey5EweCsY24DOjFhJuvXY+1U5
         +eZrMMyxPeyOnw3OEi6FsceQdhu6XX78KCWY4steE9zpPp3NjkXmbtGBk42M8bf6WE7c
         S3yP7TWVK8k1RHHOdkNmYqyxEp8UCrr4HYscb9y1BGyhm5o0w9jT60pNSgOqfHuZWNjH
         zNfQbsp/FK04Ynfj3Nw52TMZuOMuJbp7mnMTApBmhOsU/NFmyL+8TzWiewG3jRcBrSmi
         g2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HSqusLhNT4uWbUCPY+cFsU6daGfxQe+0I0i/PqFFyUg=;
        b=bEMUFhIY2Xmh6ktovB+GYeOktRT8Qm5zFkdSdi+HHMIaYN058OmITxBvq7HEIfnnX0
         NUuMTF4gMdndX+sMZDFsyie4I45HFVdrgBWRSSBGGW9DZLAR07/FR9vXPyCB+nST9zC0
         +V+KGgdgBpcaP7OS+A0lH4FT83Orxlca5Y9SmjtLywJXSntstrQ28YblCsG7a7rSEh4F
         jPpyuIwGTQxMJXcXiI86sOUMAJgA5L7tcRrHalxwzpElP/WLzn7aVGnwOVWqxbIlhU/b
         OEy3u/NvQCiuCp3ppZ4feYCzh5lNG7UYx+/H/iUyvg0+p3Ls5lB1U0eAwtJBmrtfT1MR
         vtjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 046/168] vfb: fix video mode and line_length being set when loaded
Date: Wed, 11 Apr 2018 00:23:08 +0200
Message-Id: <20180410212802.165706545@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399909803770777?=
X-GMAIL-MSGID: =?utf-8?q?1597399909803770777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Pieter \\\"PoroCYon\\\" Sluys" <pcy@national.shitposting.agency>


[ Upstream commit 7b9faf5df0ac495a1a3d7cdb64921c179f9008ac ]

Currently, when loading the vfb module, the newly created fbdev
has a line_length of 0, and its video mode would be PSEUDOCOLOR
regardless of color depth. (The former could be worked around by
calling the FBIOPUT_VSCREENINFO ioctl with having the FBACTIVIATE_FORCE
flag set.) This patch automatically sets the line_length correctly,
and the video mode is derived from the bit depth now as well.

Thanks to Geert Uytterhoeven for confirming the bug and helping me with
the patch.

Output of `fbset -i' before the patch:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 0                    <-- note this
    Accelerator : No

After:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 5464
    Accelerator : No

Signed-off-by: "Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
[b.zolnierkie: minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/vfb.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -239,8 +239,23 @@ static int vfb_check_var(struct fb_var_s
  */
 static int vfb_set_par(struct fb_info *info)
 {
+	switch (info->var.bits_per_pixel) {
+	case 1:
+		info->fix.visual = FB_VISUAL_MONO01;
+		break;
+	case 8:
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+	case 24:
+	case 32:
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
 	info->fix.line_length = get_line_length(info->var.xres_virtual,
 						info->var.bits_per_pixel);
+
 	return 0;
 }
 
@@ -450,6 +465,8 @@ static int vfb_probe(struct platform_dev
 		goto err2;
 	platform_set_drvdata(dev, info);
 
+	vfb_set_par(info);
+
 	fb_info(info, "Virtual frame buffer device, using %ldK of video memory\n",
 		videomemorysize >> 10);
 	return 0;
