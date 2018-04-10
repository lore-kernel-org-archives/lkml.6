Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/TvYXddesK0jDWBY+bVzYpzIpWNp9nC4WmOf4yeet+9u6ER0Ji0rwfZEFtOwpcSYGEhZJt
ARC-Seal: i=1; a=rsa-sha256; t=1523399534; cv=none;
        d=google.com; s=arc-20160816;
        b=HwOtEJc0sqfw05dzzgjfhxqlqrdStZcUjnMGNJzmb6UYHC6K4MlGKlo78gZSByUDIU
         2b98PGfgB+9xx1KulL9NnergxToH5CcAqBBr22rSnyyM1BLq6hOOPsYax72GsVIDs7ww
         1dZQa490qS+pPAFSM8/CTAhKSREGpVFrcdF7qtV+Ki1gg6Z/zkmgviZ6+2NqUZg2q5sc
         U17+woHm7faMeQULumo060PhCQjf/mN1qrsyFt0KSN8pciuwFnmG1VYk7B1Em4avtKVO
         J7+NwqTCXYHq1QtJPM5rc1l35Rd19X3TqBKB3MaL8Mgo/E+0+0nOhiyK/yrsHiawjLFF
         ksJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yGjCethwPTHq5Rmv8v4renPguUkZTnu5+b6rK3EfYy8=;
        b=H/1lEELvpuHeLLr2U5Ag0ttVwIa6sNFMo3BoaQiYKWSqDgmUtFz5n71IUB7PjzA/SV
         yo/+nTp4vu0iOphTeDiXkg7BQKo39eeQsTiKc1/X1JA36tjZoS6mGHrIAmuixT7QCfkC
         wAzqmHNKobT3w0pyFaDG0LRHaTx8aTw/d7Gyqt/hscFwsgqUYI0ag42IXHOPChA06o+1
         6ljzen8mbzEUjeK58K2XvPV9m4EvBUFsQwqUU20+8uROpiFm/0IVqNyO1CfuJZ3rgUtH
         KgYx/r5HmfnNe4jaNODARMbRQaayrC6vHtxEYqNsKJQHgHBsgaNXgxjbAbmgx4IRyYCs
         sbTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 143/168] net: fool proof dev_valid_name()
Date: Wed, 11 Apr 2018 00:24:45 +0200
Message-Id: <20180410212807.172759547@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399718871471315?=
X-GMAIL-MSGID: =?utf-8?q?1597400190313494765?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit a9d48205d0aedda021fc3728972a9e9934c2b9de ]

We want to use dev_valid_name() to validate tunnel names,
so better use strnlen(name, IFNAMSIZ) than strlen(name) to make
sure to not upset KASAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1027,7 +1027,7 @@ bool dev_valid_name(const char *name)
 {
 	if (*name == '\0')
 		return false;
-	if (strlen(name) >= IFNAMSIZ)
+	if (strnlen(name, IFNAMSIZ) == IFNAMSIZ)
 		return false;
 	if (!strcmp(name, ".") || !strcmp(name, ".."))
 		return false;
