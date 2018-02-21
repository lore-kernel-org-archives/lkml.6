Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224pHx3VY6jddLrBpiuWCXIiPbErsjw8psgGmUAJA1IcpE7NvQd53XCWWWrNqvg6hjCj0Yk8
ARC-Seal: i=1; a=rsa-sha256; t=1519217775; cv=none;
        d=google.com; s=arc-20160816;
        b=kO8h7QPCVBeEZb4dKj4n1pRw2J+zxbhdv0FPWqzbx1uHatOfaXR2/y1agHmLB4wnEz
         Pp63MwvOzFoxIPvAqAC+6PYLRB2zcZsbWQ/XzmsAffUGr25ANzVUBceUiKs4cXTL1LDv
         qb3q3yOMzYWKDkXVQaVlUe3s422syZmZxG6fOjFfrAG3GkRpvVk4ALeb9zUD3yY4G6as
         gADAYhzibLF4yk8Cw+p4yYYhOwSbzAIgzXUrDnZbM/pDPDWP0pHzdLVzQUgbW3KgHs7Z
         +Lf9Z7zh4S8A+eGKMlBeAUTIVtxPf0F4FsB44LsUyK4fC+Jk0pgVx2E/DGao/6lTYf9d
         qgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kfnZTumOzjeDrwFhksVs+aauo7sKDnROKLl38RTK0r8=;
        b=ycoTyDx/hwQPGLjvNmQ5zLAzHTy2172SAVjejc6Ca91OilERzekYUSVvdsT08dqqQ/
         EYyBWGs6UNt9t4BWIUTJUXrK3x0+guerkbBSJUU2OBo5LzeUpJvUHkYUFcaj9FQLYJSL
         rpjOCM0bQyVYVVC+/vwiC4OdT2v9W/vFjNBXF3yynDXdBiyuRK53fmn9RRWYylKE6NW1
         g7wbWqloplHvvKmugzHkjjGE/ZZfGus5OpRifCKC7gvSvY1nhvUyaRVkz+8I5Nxxn4ng
         yktDlQ1pRUQQDzBbU0/MnDmpKHRTk9HBrp7TLIrc3m1LGYLA00qdUlrrNi3fN4Z+HBAp
         jaZw==
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
Subject: [PATCH 4.9 14/77] video: fbdev: atmel_lcdfb: fix display-timings lookup
Date: Wed, 21 Feb 2018 13:48:23 +0100
Message-Id: <20180221124432.767583629@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014629325392076?=
X-GMAIL-MSGID: =?utf-8?q?1593015298084145648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1119,7 +1119,7 @@ static int atmel_lcdfb_of_init(struct at
 		goto put_display_node;
 	}
 
-	timings_np = of_find_node_by_name(display_np, "display-timings");
+	timings_np = of_get_child_by_name(display_np, "display-timings");
 	if (!timings_np) {
 		dev_err(dev, "failed to find display-timings node\n");
 		ret = -ENODEV;
@@ -1140,6 +1140,12 @@ static int atmel_lcdfb_of_init(struct at
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
