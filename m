Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227p9xV/JSMqJdDP4xSeqAfhKxFygjSojvyDQxk5RNfWv8bPrv2n774ncgo/owJmw4FvlcfP
ARC-Seal: i=1; a=rsa-sha256; t=1519410606; cv=none;
        d=google.com; s=arc-20160816;
        b=W+/2sbh5GnVUx/7Vwnh4ubuUmSrl1dVzsQtpcUUHxDuvyspkUDGJOh7Vq8W+rSgd8M
         zVSRVhXTuveQrCgK+Hja6psstlIBnt0OBg1wXNKW2zXkOy5+uV63PVK/jJqakXXw1AHN
         PiGlX6rQWq8XZsJosWTJZ8RQ0sBZ48VUnEd7c5NFUc0O03ZMxi5RjjG5A08M5uWbQuCB
         sg3HmnODE7wXJWUVoCBFSV9sWhXMgpPs/5E9MHqYozhsty4SHJ87xTumTr9UtbYjIi0X
         edCw1BhKKbTAdIw0Ufv/LiKWMYSxosq0rz59LNG+O7zsqfBej76vZZCaZ4saDyFfG6Hf
         +6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BaGFdERIi5xJjnd9i/ME2Mm8ubaoy+Ov/1nqvg6qZ10=;
        b=T+Ow4vLMAtT2PZDhIRy1ING/8s9XQNFFXjOeD+xsQZuY/1sU/4yxhSS5ZqPUTbLyIU
         Op7vTjbNPRVyTcBPfU+9KxO4T6y44bWD+LYKzypiTW65VsevY999SDed5nVvqnWo6nrA
         Nq/7VkpoRJnQqarhrPopgAxlbV/pht/qU70aKoI2yH2Z26IyhlscQjDC5bXs6K0TqkLV
         Z/jhcXGKnHm35pZSOd4W4WwDLGOtvxq/nPlSv/cI2Sz9rn6xYPYx/i+lWRbRoYfAK3E0
         sf2NxsiTl8gyjsF18Ed8ylwRI7ExrghBTZy+Uw9myvp/wcyzDhbr8OEu+sU/WBDJkiJC
         NVog==
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
Subject: [PATCH 3.18 11/58] video: fbdev: atmel_lcdfb: fix display-timings lookup
Date: Fri, 23 Feb 2018 19:26:10 +0100
Message-Id: <20180223170208.466195106@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217495892868716?=
X-GMAIL-MSGID: =?utf-8?q?1593217495892868716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1121,7 +1121,7 @@ static int atmel_lcdfb_of_init(struct at
 		goto put_display_node;
 	}
 
-	timings_np = of_find_node_by_name(display_np, "display-timings");
+	timings_np = of_get_child_by_name(display_np, "display-timings");
 	if (!timings_np) {
 		dev_err(dev, "failed to find display-timings node\n");
 		ret = -ENODEV;
@@ -1142,6 +1142,12 @@ static int atmel_lcdfb_of_init(struct at
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
