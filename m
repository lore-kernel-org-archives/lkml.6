Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227duy2i6SkIAn7D/BCbYBxsn6ZWj0B+/ZwXLljnF0l5w2Igo0vD7BUo+K1RXZR9jGJSiTwD
ARC-Seal: i=1; a=rsa-sha256; t=1519218179; cv=none;
        d=google.com; s=arc-20160816;
        b=DfF6/ZpXhhvexxgbFGz39dfPOJ1vHn7B3FCaPTPVYqFAbzjJ3I10OrLtdOp2KoPYbd
         9uNLBDykV/NX1IA/gS/kC+ZFAN/1gdIGSpLTesHQo5VXKM/TXJEMmhLFclbSl10X/eWy
         TImWa6XlZXqKNaL9si8gIu+8ewdjSrR3pt6ijJXySHVovPKlltN73fz9wBwLzew73DlU
         ZykwuYzvbqlkOvCY273Aaoe4VM3y29C/BUEAYU5FcNG7abnYYE0UDIeYeqTceGeJK0SF
         ImFVS8G/rjW8wvKM3+J4BCzsqRiTZwshRQz6Xv1o0wFbDttLFXs/jP+D0RL3rNWtCrrP
         CvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J2rAazOcLGEL83i+h9uopf/HPMzewKOMjr44bgRXjp0=;
        b=EOc/bbgGoSKNG0apU4npYXJnFdYYd2uCsIuSTA+EIYLQULLh8fG5NvrLZvEGHPUA9i
         KaAoIt7pHNlvi8wyyEP8IHElvq78ogfquTcCxqL2yNub0KeRMcSq1ElSMknjwdYIGQcT
         7F207vH2w94Yhk5Kc6tF8Ey9hJO/wMi0SZpwm2dGo68HLikeBjjn+iFOATXyDrJmiU0g
         y1jbL4t+fN2pEZ0VREzTXiwk8BJ02LFnh3QZhMB3Zl6fKqyF96ngpgtlGB0fT8SXRuTd
         wCpifHJiTD11bREKZ7ODlafYzrSXrw8au2zI0QJnfVOXzQIn3O2EQkBMOYMi78QNFoMJ
         kJcQ==
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
Subject: [PATCH 4.14 116/167] video: fbdev: atmel_lcdfb: fix display-timings lookup
Date: Wed, 21 Feb 2018 13:48:47 +0100
Message-Id: <20180221124530.764473157@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014629325392076?=
X-GMAIL-MSGID: =?utf-8?q?1593015721933977448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
