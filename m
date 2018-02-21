Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224eW+odyUFtXPhrydHAujBmy4f3PbLL3al3zJuk5S7IU+VrJHL93wyVfMITOqce/Oz6Irwc
ARC-Seal: i=1; a=rsa-sha256; t=1519217137; cv=none;
        d=google.com; s=arc-20160816;
        b=BA1tjxl0VufKsgktYZ6YHpXAcTw/Yt+VnUx34Ktvig/OCvz2b5BUfSi7+/SFSx+JCh
         wjcNnZ06uxpRK7VSFwousl8PDth9jLZncmk48ipYfWBbfegDDZ8Tn5ySKg6CRGpbx8fh
         2gPMgYisJbBYgg733Gam3Ao7LLH8XgpsL1KwG327eovQmrR0tptLgy3hhjd0nJL5c27+
         PTfoNHZuUD/RA/LHT5JVLPzqdetF8620mjyd+60eJAbU+UNG6oYnaNMTtsoS+EvR9FZA
         Ed5hrx4hQLJ9TiRpug0OeCn6ceLzqvvnCmO8m3E8wFdqW+9Xe/dcz0Y8Jnt+K7qT/o8J
         gShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WGmxsMTspuHAjsL1mpAhbThYnVErAElHevzNBSblK5Y=;
        b=bmnzTxkwsPjeyjXtkzdrzYYNxWeFFacwvo6BKvcGHzq7TrHkTysECMAyCX4m3enYNS
         ErRhbc1GOrqfT4wIKu30rMfFvMRtq4g2qG9S8Ho6uHeXZ/bpF7WdZTw0E2Cg5B3Hgku3
         sbTR/xV9rxU+Lomkz1p/8GN/cIOSQigRjm3qb2RFaMK1ov0AWZdcPx40u5Ipim6RAUSX
         M3L+UpQolAyxPXoKsIryMctX1+99qApZKaaufOQ5710ZHjbxLqB1CUo598LRgoVvjvlV
         7wfBg/oh4xI0DABg9xO53tsqb1fiq2+n5U+banCSbrY4kb+hA97dcu+O5pvXiKC7eUlF
         Ov6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Johan Hovold <johan@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.4 16/33] video: fbdev: atmel_lcdfb: fix display-timings lookup
Date: Wed, 21 Feb 2018 13:44:59 +0100
Message-Id: <20180221124410.482540641@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014629325392076?=
X-GMAIL-MSGID: =?utf-8?q?1593014629325392076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 9cb18db0701f6b74f0c45c23ad767b3ebebe37f6 upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent display node was also prematurely
freed.

Note that the display and timings node references are never put after a
successful dt-initialisation so the nodes would leak on later probe
deferrals and on driver unbind.

Fixes: b985172b328a ("video: atmel_lcdfb: add device tree suport")
Cc: stable <stable@vger.kernel.org>     # 3.13
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/atmel_lcdfb.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1120,7 +1120,7 @@ static int atmel_lcdfb_of_init(struct at
 		goto put_display_node;
 	}
 
-	timings_np = of_find_node_by_name(display_np, "display-timings");
+	timings_np = of_get_child_by_name(display_np, "display-timings");
 	if (!timings_np) {
 		dev_err(dev, "failed to find display-timings node\n");
 		ret = -ENODEV;
@@ -1141,6 +1141,12 @@ static int atmel_lcdfb_of_init(struct at
 		fb_add_videomode(&fb_vm, &info->modelist);
 	}
 
+	/*
+	 * FIXME: Make sure we are not referencing any fields in display_np
+	 * and timings_np and drop our references to them before returning to
+	 * avoid leaking the nodes on probe deferral and driver unbind.
+	 */
+
 	return 0;
 
 put_timings_node:
