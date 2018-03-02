Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsj7h2jbbmhvw2u+O2tKWVl/mQ7rPVKT5QXRtcqppQYlQZ4qhqHayCGJkiZBP+UIiGj7jWe
ARC-Seal: i=1; a=rsa-sha256; t=1519981024; cv=none;
        d=google.com; s=arc-20160816;
        b=JNOsX8y9OMX4NS2hBqw2PpQI4gzoNz5+h0vFKcCkM5v1NOXJs2gmdnQ645kUcgB/wT
         tCpD1EStOS4sFju9idAkm8dNxDw7Pj7ORxBaFBrH2S1H28djpqa2xhkxB8LCSFOCS57b
         Ylirywwkd3J6reW39NYO0M6b0BZOSoYhEXzbz2kLjVysR9OJoPyH3sXHoj6N/BnhLyYG
         5Z0mNTsixo9maCYzJKwZPffmocr451P7TvK7gW1YwnngTGxplrfafURBddrmKHn91RKP
         uw/W6Xg7ZBONvwWtwXrNYoyVz0uiuO08H9UECWlIXgYxzZLUUuK9MLcN6FevevKz3Sj3
         M1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OPxzcP3U2YOkBzrwiwr5WXHKoiIMSFmdscELIoyYCI4=;
        b=hKvr5kwvko4z9wytJIZIWuhpoPpWo2MJJKzBtMBary4Do88x8EpicuwSr4l81rAJJL
         k03gdJA5mz3iZILwdzufeKWsrZ8G9D4CbYnI+VI09TzZzl0mtKmd/007t7Hz1X0SJYu9
         BZxvH3vK+0RFAUREOsp8Bwh/7xWW3gHxHnKMarqdFvOQHedpBdksWqfrMwARJ6RlPrI+
         Tg2WNDCEa6mdTvKAZVsW+OtVuXtmlx+chCogF6N1WqNTfSX49Fv5NwO/pUqaP7D6peTu
         16UP91RWkMDmXsHbbXRhzpg7V6VoLyQajMyR3cc+a4B2rWVgxRcwM2TxrDkqo7oAkYAU
         WvRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 28/56] tg3: Enable PHY reset in MTU change path for 5720
Date: Fri,  2 Mar 2018 09:51:14 +0100
Message-Id: <20180302084451.002918062@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815277327871524?=
X-GMAIL-MSGID: =?utf-8?q?1593815623498766618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siva Reddy Kallam <siva.kallam@broadcom.com>


[ Upstream commit e60ee41aaf898584205a6af5c996860d0fe6a836 ]

A customer noticed RX path hang when MTU is changed on the fly while
running heavy traffic with NCSI enabled for 5717 and 5719. Since 5720
belongs to same ASIC family, we observed same issue and same fix
could solve this problem for 5720.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14238,7 +14238,8 @@ static int tg3_change_mtu(struct net_dev
 	 */
 	if (tg3_asic_rev(tp) == ASIC_REV_57766 ||
 	    tg3_asic_rev(tp) == ASIC_REV_5717 ||
-	    tg3_asic_rev(tp) == ASIC_REV_5719)
+	    tg3_asic_rev(tp) == ASIC_REV_5719 ||
+	    tg3_asic_rev(tp) == ASIC_REV_5720)
 		reset_phy = true;
 
 	err = tg3_restart_hw(tp, reset_phy);
