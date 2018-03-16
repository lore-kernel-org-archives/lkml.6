Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu2v1Jv59S52joET6SFljbYR0dxTTgUJlfRf9mNqfWfK172a4O6GIUMnTo+eNgcouaYhkeZ
ARC-Seal: i=1; a=rsa-sha256; t=1521214937; cv=none;
        d=google.com; s=arc-20160816;
        b=wT0LE+YB94PC46oof2kxDzEd1U9dhqZulcxuoLXWycR5lbk12z/oNNTwrjUtz3ePTg
         13BzCZ5Y8B9O1C7TTkOWqKBvCr1gL1agtoz54Fux2bJ1nt989PZxcMP4hTcSl4jnq84u
         03t74kpXPmlFLou0yLLCEmUSD0tVmCBQiNhcArhxQhU9TzN80K7ehqW6mRSPRXqOok1Q
         zapfhymGFaQPQyfXiQVpfQEaGr+9jBITlEIXQGfp2U6UjSMR4bmLxIzaJNpU02AX/Zuh
         LuoHRghfptVCSZW5CNN+ThapQfUJRbll+kMzPx/f5+71KWjlaelWBO+KTqnAg/MkRGyX
         Rn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YAn7KIByulNyXqus6i5hCiHueJ2COzwjrUKx9FEDUow=;
        b=DMAX9eTbHDJxn3Hvu6B0zeSIdZHM56suiBo6CVg5sNVWS+dr7Y4oNilllSDC/TnozM
         Vu728Pr00FDMXc4Evus6kaxhlK6qPXHsdvD7QvKVtj/piVxyRvYo3QTuT3bOA8vlj4ET
         c256XVECuRraeg9SVzBwP3auHiPIO30fDsuzAzStQmplhheRFFJVw2KXDulVs8zr/FV0
         I/6t2QiVZ8oXw4Kad3DAFnFEDJYAZQiFY0cYJ2pAcPckKKfHPWG7wlCAsUusM4katlJ3
         zbFhzcZUiBrYhGCFXaDPJCOQYHwrFPyWrr2qIo7SyhsYXDhUlKrJfIDoN4LFeHXRSkCO
         BqEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 069/128] power: supply: sbs-message: double left shift bug in sbsm_select()
Date: Fri, 16 Mar 2018 16:23:30 +0100
Message-Id: <20180316152340.168974451@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109474102643302?=
X-GMAIL-MSGID: =?utf-8?q?1595109474102643302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 7d54d0d38ec42559c891526f079f1e035cd4b3ae ]

The original code does this: "1 << (1 << 11)" which is undefined in C.

Fixes: dbc4deda03fe ("power: Adds support for Smart Battery System Manager")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/sbs-manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -183,7 +183,7 @@ static int sbsm_select(struct i2c_mux_co
 		return ret;
 
 	/* chan goes from 1 ... 4 */
-	reg = 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
+	reg = BIT(SBSM_SMB_BAT_OFFSET + chan);
 	ret = sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
 	if (ret)
 		dev_err(dev, "Failed to select channel %i\n", chan);
