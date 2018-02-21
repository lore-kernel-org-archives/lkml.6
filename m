Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2279syoEYbyahgKb5dbpe+nc/QPh70PmWKO2scjseWfxXnc8RMp7OFaRumHU6ClNY1KP7zUf
ARC-Seal: i=1; a=rsa-sha256; t=1519218674; cv=none;
        d=google.com; s=arc-20160816;
        b=vZhmSjjCwdsdzwFeHGTZMRFexy4RZokQwf9wUymhxcgzLbbxj79CXmgotMzRChgQKZ
         HWAZiviZIjS1Bo7B4Wm2EYPFZJoGHdCs4i8odaOcCmn4tm9F0VXo9Zwm3kcMqX/hBHP0
         5MiHQFw/8YrX3+ostJeYlM9+Kb7VJNDnLUuZhfz121cNXB++peP4lGEWj5JxZno7pViO
         inUtcr5rmE2rkoJZB6rCPazwED1wfTQH16hyA3z3LyJI5y3NiUIDwr0cHSz8mPU0zLeM
         OnqOmazyGGt3XCdfVU8WuDZJs6OQ9Dm/tYkaEps2CJ494u+A8gJaXb/WvhzZecrRCN88
         CKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VGbO1bFe4tvUedgFy8Oc6sTtZUtxeRoXCXc3CqoVt6s=;
        b=l8YiLmg3B8JrqZ3t/nuTGfhcby1iOeLQq6uhwlAJ9UVvQndDL14h4T7TKYyf5+TV9Z
         KMtAJHN4jDG2D/ghpizvaDklEuzn4FaPtx5d0VCftNCGiwfc74hHo+LUt2MESVmWbHHk
         OMV8h9jlkPRn47i7jRfB7rgCG0mLG6xyIFqe79N8sbH98k8aav4VBs+90+f9iwYO8+eO
         toLG0EJuBWp1s89zlrsnUI9BJ9oBUARC9LDdbCVN5nAHvT56BUzDRRPEIpPULDGYMjg0
         QEfSol9f6eigVBXxwI3p6ZrTzcyNxvpd2LEIEMIKKLy+HTt/LsVQHQZDKc3AYLyYFUyp
         Vz8w==
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
Subject: [PATCH 4.15 119/163] video: fbdev: atmel_lcdfb: fix display-timings lookup
Date: Wed, 21 Feb 2018 13:49:08 +0100
Message-Id: <20180221124536.698588163@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014629325392076?=
X-GMAIL-MSGID: =?utf-8?q?1593016240878328145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
