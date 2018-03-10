Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtNmw+ZBHP5nK5P6DmUNLoIjsmhlZLsbaFtNQPII+jofdiN9izZyMDwLCOg2GJiQ5jg8nxU
ARC-Seal: i=1; a=rsa-sha256; t=1520641191; cv=none;
        d=google.com; s=arc-20160816;
        b=unwY2TneW5478Rbl8DRaxxTyeHuW1eejYAw1yZjaL+SsFXLN+/uwnxPX9lV+uviYUQ
         djdR3x9vJXtp20xDLzCuT5Am85wdELIweE8YyE2iG4CFNGaj0t0bgur/eCuC7pw/VJpw
         dx6/2qLMFhe7ORWFvSD+I/exYTryM5BWE9kRIEXR7JtOnwRY0eFmnXLz+9k28Ybfu/t6
         4Msc4mKpK70bFXLz6zqfSt9JYfKfaLB+JadUBMShFkoq6c6o8DELeHh1J/k694H+zeUB
         4nUNqBtRDHFZVzINzergKoHfKM2dW7RL9t0G3ZNsLZxYATxJ/eADwEb0aCJ3SjhL7pxD
         Umcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bN56o2FSyr6HCk1ViJiZ0KckLdRJ6yHwHcAkMVqsOk8=;
        b=Fbec6XcqcX9QEQh4OUvmvGe/4+S/j5v+RZ0bVH5eg7bCufT4VJAhU8IsazvXWt6Ycv
         NECdqvsOQ4D13xT8LTXDNd8VVYEt/EoiIVP86ZOKO7oz1ttZqzA7p6xU54ER1Sr1573Q
         D3Ms0c8xe1vRvvExpo0xkDQVGhEWlF/FL5S1vW6K8SFTkb0cQk0+0jncPyfv7Yxj92wQ
         XA/cW60XUzlf/xcGvYujXjULqgHgkYPTOoEi6VWumpz15oL6Ltu8vwh8ePAn6nfldvJF
         VJRxbKJH0FTRun/OoRYitXoof2Ki5tL8WArYfdEPKBwGHSr1jJn5Id90hKTPTxe/PlJ6
         yspg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nathan Sullivan <nathan.sullivan@ni.com>,
	Zach Brown <zach.brown@ni.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Willy Tarreau <w@1wt.eu>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 4.4 15/36] leds: do not overflow sysfs buffer in led_trigger_show
Date: Fri,  9 Mar 2018 16:18:31 -0800
Message-Id: <20180310001808.135271502@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507812947407686?=
X-GMAIL-MSGID: =?utf-8?q?1594507857765242638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Sullivan <nathan.sullivan@ni.com>

commit 3b9b95363c45365d606ad4bbba16acca75fdf6d3 upstream.

Per the documentation, use scnprintf instead of sprintf to ensure there
is never more than PAGE_SIZE bytes of trigger names put into the
buffer.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
Signed-off-by: Zach Brown <zach.brown@ni.com>
Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/led-triggers.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -88,21 +88,23 @@ ssize_t led_trigger_show(struct device *
 	down_read(&led_cdev->trigger_lock);
 
 	if (!led_cdev->trigger)
-		len += sprintf(buf+len, "[none] ");
+		len += scnprintf(buf+len, PAGE_SIZE - len, "[none] ");
 	else
-		len += sprintf(buf+len, "none ");
+		len += scnprintf(buf+len, PAGE_SIZE - len, "none ");
 
 	list_for_each_entry(trig, &trigger_list, next_trig) {
 		if (led_cdev->trigger && !strcmp(led_cdev->trigger->name,
 							trig->name))
-			len += sprintf(buf+len, "[%s] ", trig->name);
+			len += scnprintf(buf+len, PAGE_SIZE - len, "[%s] ",
+					 trig->name);
 		else
-			len += sprintf(buf+len, "%s ", trig->name);
+			len += scnprintf(buf+len, PAGE_SIZE - len, "%s ",
+					 trig->name);
 	}
 	up_read(&led_cdev->trigger_lock);
 	up_read(&triggers_list_lock);
 
-	len += sprintf(len+buf, "\n");
+	len += scnprintf(len+buf, PAGE_SIZE - len, "\n");
 	return len;
 }
 EXPORT_SYMBOL_GPL(led_trigger_show);
