Return-Path: <prvs=16521a1f51=stefan.potyra@elektrobit.com>
X-Google-Smtp-Source: AB8JxZpsvuHe3Gl++/heXUypdPRrfOPjiSZua0ZQlBMWOEjBl11LbIQah7RI9J73fq7vxT2i8GSg
ARC-Seal: i=1; a=rsa-sha256; t=1524585828; cv=none;
        d=google.com; s=arc-20160816;
        b=d8yT+P/B3zxgYJrh8vLh+MQ/YWRWY6LtMu3ntaLH7uK5g5zxlu/A9TYHP7nPnomK56
         QU5PVBRyi07d8xZrNFL3aCn2QhyCylxxJs5meLp4am/XyNKIo9y0B/qiFVk6MqybgfhQ
         sduKrC7lmV3A27Nlbywq/4SSIdovad++pdh9sws+wWLdy7EX1e1OXIsdzBb8G9xDdD4S
         6SA8YcQa/7sbgYjBJmK0E4LodLa1/r8JBcw7ubxuhaUt1TNwqSkoMMrS97ikaMA3AOEd
         cezJVa6LUbsmMdIbWIYtlk3q/WBnz3MW1uA4dHFspmXnyIVP9z5WwmOC0vbTYrBVbNy6
         t8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=hV4AEbqQBLmBCqgLdp+4jOTzIbIpLF3+PttCQsII8oo=;
        b=MqX5fj11LqGqr4pkkT4I2D7ygdJZB+FDOv5Qg8MQ2/RjvvWz/DpYCOqaSl2r7eiOaU
         wU0KCBS3OD1hgYVPHx1pUL2d7PgnHTx6Dp0ZY0jsmOpV5pG4JAqbMoWeWj9iQrI3a8IJ
         NqkZ72q7SNlRLqrVkidU9OTYv7mEiWWmcQgghzb7F9buZWLeL0kypTRRIV22ZJdVkDN2
         VHq40A977DgucUOLD4bQXxeuSRLSNabBxUaTA3mQmXObM1Jd+RycatrnHxERiwQ4AAx7
         wYXCxKiUFRVJZ3Nto2cONwfRaqveFIYlmp7KwkBO7n9xFdwDoWy9flfqGtJSQXBqNJXF
         IE7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of prvs=16521a1f51=stefan.potyra@elektrobit.com designates 213.95.163.141 as permitted sender) smtp.mailfrom=prvs=16521a1f51=stefan.potyra@elektrobit.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of prvs=16521a1f51=stefan.potyra@elektrobit.com designates 213.95.163.141 as permitted sender) smtp.mailfrom=prvs=16521a1f51=stefan.potyra@elektrobit.com
Date: Tue, 24 Apr 2018 18:03:47 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ldv-project@linuxtesting.org>,
        <sil2review@lists.osadl.org>
Subject: [PATCH v2] sc16is7xx: Check for an error when the clock is enabled.
Message-ID: <20180424160346.GB16979@er01809n.ebgroup.elektrobit.com>
References: <20180419130228.rdee6hwsjcui5py7@agrajag.zerfleddert.de>
 <20180423075519.GA13262@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180423075519.GA13262@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [10.0.24.181]
X-ClientProxiedBy: denue6es008.ebgroup.elektrobit.com (10.5.139.25) To
 denue6es008.ebgroup.elektrobit.com (10.5.139.25)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598644109812431305?=
X-GMAIL-MSGID: =?utf-8?q?1598644109812431305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the clock is enabled, check if there is an error. Otherwise
clk_get_rate() can be called without enabled clock.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 0814e8d5da2b ("sc16is7xx: enable the clock")
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/tty/serial/sc16is7xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 65792a3539d0..243c96025053 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1168,7 +1168,10 @@ static int sc16is7xx_probe(struct device *dev,
 		else
 			return PTR_ERR(s->clk);
 	} else {
-		clk_prepare_enable(s->clk);
+		ret = clk_prepare_enable(s->clk);
+		if (ret)
+			return ret;
+
 		freq = clk_get_rate(s->clk);
 	}
 
-- 
2.17.0
