Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvfWMZVA29MU6UrRGI8qcyqy3TEqdtm0IfDJo+W6NWp1unk7w6lw7mcMBomt31bwN0NPHdh
ARC-Seal: i=1; a=rsa-sha256; t=1521214586; cv=none;
        d=google.com; s=arc-20160816;
        b=JOEMKBNJkx1Oa79eax8/d/TnX5nAEujZrGv5ZNY7tknC6uNR+ljA215b0KAzF77bXt
         tAEM8BrsujTeBhyH3V2A24de6VDw5XX6ZROJWktH/VPw265Zwh5ewzXiIiNfYzDl+Dcd
         gFUI1N6B1e4xok4mokmISNZ++3wlhOgbLAPeD9SE0VSA3we2MqkKJ93+vtKKJYZfJjFU
         OB40hFck96r+wkW2t29ZiXZQK1YbHH2tfluKvt7asx84GnNNjNMijluKmBvgE+Z60Pmz
         b0pIK0MmB7owh30rmvJRoRRKksPEkqkQBVOVSxGtqrxhkT3mvG+UXiLnj8qLI6O26rPL
         xFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W5Q27BB1rthFN54HQo35xyhxUgmXmAGpKEbi59wj6MU=;
        b=iZaqVU2uRUrOO612kgopvEJEf2+duj6m8icAR31RBGyb9zlvchL7GBPMrJ3VRqmKh/
         rFXDFi8G0eEGrX/BWxkilH9olrjxn4yHaDRm+ukc/LfY4RpwYK2YCTe4yk8r7/kaK9Xn
         lUChm0FcWLu++YurdWub6y2LGxe3+oBRpCsC+FAdhakmzqh12RCzAVhSkN3Rt5yZC0ry
         Xjx61urnro++aggzFCqUjEbLrTwwIA4XKkTS8nwBBEEMbp5wz5I5l8nP388RETyONmKd
         xiUgsgFDiBXuJfIGnsxu8OnZ4vthgjz6PxhZFR3kCAsZbfeoNGSry2kiGNsyplzYhGbt
         qpZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/109] power: supply: ab8500_charger: Fix an error handling path
Date: Fri, 16 Mar 2018 16:23:26 +0100
Message-Id: <20180316152333.054464946@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109105745620976?=
X-GMAIL-MSGID: =?utf-8?q?1595109105745620976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit bf59fddde1c3eab89eb8dca8f3d3dc097887d2bb ]

'ret' is know to be 0 at this point, because it has not been updated by the
the previous call to 'abx500_mask_and_set_register_interruptible()'.

Fix it by updating 'ret' before checking if an error occurred.

Fixes: 84edbeeab67c ("ab8500-charger: AB8500 charger driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/ab8500_charger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3218,7 +3218,7 @@ static int ab8500_charger_init_hw_regist
 	}
 
 	/* Enable backup battery charging */
-	abx500_mask_and_set_register_interruptible(di->dev,
+	ret = abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_RTC, AB8500_RTC_CTRL_REG,
 		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
 	if (ret < 0)
