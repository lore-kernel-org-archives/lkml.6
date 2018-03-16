Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLzW9KdnvmJi/HRqggfI91+SCzF+Yvz+v4kT8yDmYt21ZvZVIr4YBZsN0r/7aaQbaow+19
ARC-Seal: i=1; a=rsa-sha256; t=1521214940; cv=none;
        d=google.com; s=arc-20160816;
        b=gcfc0eGyzdgZ8kBXU2hltB5hJg/H4LLFByquJUO/P0meQh+f/1aPWY39Ksn6dIK5m7
         fstdlAHqCZzWLl3V8i0SbMiNykLo0dsOVPUuW/kQOszTu2SPNXTuL/xbIB0wIiA8AH/t
         q/yWirRKtaWuWcFQlIYrcQkGMmuJuTf+1dD9YZ5KWExYgEBOnjbhX9rRlyrsCr4GDaEB
         XX/M0GzA85ejKTNLcvlYxyki51hwfcsUre4xYhVh9eVg2xTigVuix72qBmBtMRWa0viA
         NXNomFvSAE6uB8w+tezvi+c2bGUg/CjAvVv7OJbli1a/WhcJe2XsM6BnY1fT5o+RFppr
         XOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VhZIoIYBJpPs1LRm/9aePPmnyM9UTjykygGthXyItXY=;
        b=wthzmJxvqQca7A8LFJS/h9OO+wBu6BUZxHPdW9c5v9oM9z4H5C/83FgehQdm88I660
         WfsSCvEpMxX4NBDhx8uGa/JKQ77M7K1vZvSgzWbRD+07UG+XFI7LY/9DB6WHygurFgBs
         whbqKcjAyWmCrutioh5VQO0hborye5H8JUQkB+1EFk6vHwEB18ATx7QtdR2Q4ygxkoXJ
         E7tGl0+0OMSqzdlCUkMzfGwqeOPd+CT2kTCqHg4lTFrR9Pm08wmewxHH1nxiuclCxLz+
         boHOJ0/wSv9AvqhG5a5+9taZOAqmbbwoEeqUHAWwtUmKqibRighfboTHbdxIgpNt7yF1
         Nrsw==
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
Subject: [PATCH 4.15 070/128] power: supply: ab8500_charger: Fix an error handling path
Date: Fri, 16 Mar 2018 16:23:31 +0100
Message-Id: <20180316152340.210499398@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109105745620976?=
X-GMAIL-MSGID: =?utf-8?q?1595109477263285112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
