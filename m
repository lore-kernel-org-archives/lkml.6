Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsZr/qDp/jh/eONbN6Go8SVTyD9PsVl5k3r8ReSrO2L0yh7KJ9HucWK2agHO2za9ICDilMO
ARC-Seal: i=1; a=rsa-sha256; t=1521484061; cv=none;
        d=google.com; s=arc-20160816;
        b=D/ZQJiawSrN/xkBz9CdKLtHqj9tSUO8Ejvd3Ke9KXqCIzUO8CYdQ7dL2OTa7ZkwlaP
         BxeYxBIDTyEOlTh2Uz7oj3RCTFU/ePqqlHGxaVONm5L25wgayCMdEgx0E7zvS++8VneH
         A2Ej8GXcYk5GWcvEwXHpZyawsrzjmXmczmDah3qzuUCqIQZ/Hvhje8aiqySMg3U0k1rK
         gEdr9VIUu4eLJ9cVZon6JOuVnmb1Y/kWhSs884ywVivaUwzP3IYhnL8OMdwFwwnoUQ02
         covwEcCjWiUsQz/VRov3wnVp20jyahnbUYcMygP157fcVzrdNUbJK2lYzeqZ7LaOXbYf
         Be8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QUYtdfBZDl4uHE9YtxdPihvbJCXXvU8q8UBzlSdTQ2w=;
        b=XRxdnY0lUiEwJ4+irDigf2dnqy71kjTuYWFMCDcBAaj2nhMNdHq1ODrzJqhQh9lUAC
         kgQjpug+u/Xlsj0BtIG2kTTvwHuThSZ1jN9sG5yuXJdmek/nL8M/na29mmTa6ZuS6k+v
         cryq1DY6P3SeQWzJd6/cooZE+w1HSmiafBJQCg9Xv7DIhGaxpxZO3GVYjoS8afLC91fz
         a3163EywVOg+lQy1X8Vt03Znz6Uq57hAMrym0Py+q3MblixV3XtnJx4j02vb9TGj92Gb
         tQLhIiNcg8UILtdatS1pgzSnErqtDeZ58kKS90BpZ+qdsVtmpP+PNpc1PZaVPjaZ210w
         6LiA==
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
Subject: [PATCH 4.9 182/241] power: supply: ab8500_charger: Fix an error handling path
Date: Mon, 19 Mar 2018 19:07:27 +0100
Message-Id: <20180319180758.677378811@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391671060606802?=
X-GMAIL-MSGID: =?utf-8?q?1595391671060606802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
