Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvHfdeKqLi/xkQeSepDs/PDg1pcBGwfUmc+qmUbSQ19fhq94mXfHeuxC8LZ87Xj+TN3kfyV
ARC-Seal: i=1; a=rsa-sha256; t=1519980899; cv=none;
        d=google.com; s=arc-20160816;
        b=d3GLP7CBAt3Jhuaq90PVDi3HBE3Q+4HtMyZ3QUxxy7VItN5+bWcdjOjK9iAwTJcGjj
         x2MXAUQO35iKOFPN4eBgJ1Efa2hRr3rJFJdJoqyTmCZ6EuKwpRzZMk2JUt9ue0XKRVay
         T2PT0AMZxqPXRCkGUL6O/B0CQDOWEgppKW90a/3A6gtAGnaJD/xz2kRrcibyQ+oErA4N
         UPubn0bArLgZuWx75OQtT4gDhirLmIo0C2E0h0E+XsPUB/x6aUtNIN+3bR4TqduVrVKK
         59WfLWzL6yteAPPbFNpFAh85fw/dZQPi0iKEfufy2KCEO1coL9VqzVghbyGJUT9wOpUE
         LCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lfsrjHS/Gc4eJxThhMkmH9SrVTT6/eQtnxJ85UkdCOw=;
        b=UV4LcSnnLZfaliHkBpv5ASjbdxZlcO0PeThooqkw9w2pmLuZNBhxHF90X8s2jwNYmm
         I4+PsetnmISHch/nYhJMSTKBuwXlhdSoTqTCD8jRPa2SEBR3bXXEC+Itm+VYgFG9iaJo
         RDZ+0uBIrQdSiKXXDDjemssR3pYl6ONSYdYX3bZ20c6US97uvYPBjytEnJUUSvCdBtZ2
         ghqNo7yKiDbADk33FmzJ+UONNpN5GUrC7U6QZKX0VEeX2pcpq+Qi5JF+57tuI4v9gtUG
         +lp63N3/BHaxc9GOSAsTiO1ZVOawmkW6rLM9MP2fmo04hvRXr6oEfDBHMEJsXiEtc2f1
         4jZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Luu An Phu <phu.luuan@nxp.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 25/34] can: flex_can: Correct the checking for frame length in flexcan_start_xmit()
Date: Fri,  2 Mar 2018 09:51:21 +0100
Message-Id: <20180302084437.652137759@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815491970045896?=
X-GMAIL-MSGID: =?utf-8?q?1593815491970045896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luu An Phu <phu.luuan@nxp.com>


[ Upstream commit 13454c14550065fcc1705d6bd4ee6d40e057099f ]

The flexcan_start_xmit() function compares the frame length with data
register length to write frame content into data[0] and data[1]
register. Data register length is 4 bytes and frame maximum length is 8
bytes.

Fix the check that compares frame length with 3. Because the register
length is 4.

Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/flexcan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -493,7 +493,7 @@ static int flexcan_start_xmit(struct sk_
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[0]);
 	}
-	if (cf->can_dlc > 3) {
+	if (cf->can_dlc > 4) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[1]);
 	}
