Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/EksUGPDnNqdfOinr+MI64r1NDKmJLNNGIFsp3XAYzPvQwmFGnNenGDEgQLjJp4s2F4wsM
ARC-Seal: i=1; a=rsa-sha256; t=1523399936; cv=none;
        d=google.com; s=arc-20160816;
        b=I0ij8Pfmgl6FCSyx2dVZwW0pbEB8T3LrvafFvCJbJyCn0RGMZB2cNsOQCFo/jQ46ZC
         jVxMjlBWrvhpVy6BSK0D1at/6PQPYCE2zvYSfrPfL/6xH+S+/RsKMSULXXkT2JaAfz4C
         E6B8f604+EdhPAsdrmuY8nltXHKQsf2EXAqvEFYduSexxng1tAPigsfP7LSm33yEsai3
         q5MYx9TPtf/PePHg7BELYHScweE1Qge6vTLNOAQyMbc+sqp3hRuGGf4tlQiL2EgOzHHY
         eiWps06a91j4HmnoxcQdswtqnQY1ysuCY/2hn9z/9NyU8Yj5iJJH9yJiLO9xP5oRxqw8
         zW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jMu0LBP26Ga7Rrm7DaiVO1Byz6+M+Zo6e+D4f/HtIRk=;
        b=Bj/PFzlMSpXXqc6ZXNKfJzQcQjCJ2QSu5RbDx76vnPJ4blBHnkpDh262JI9Z+tfYGn
         yUSTj+F9PsRj7GbRtscukSNtjThjau1aTZaqe9xlJZBj5LpPx6al0siO2S/a540lmIDO
         UZ/gtffkUnytg33r/r3YVakEkIi3qg3BoG75OniAHMvYn607i8HXOMYP9q6T8li6Y8gP
         D5Dz75ueRBaoJdDyqYcFkU2PGctRP76qWcp2zSTl7FijZCFGYr3yKltz/FTYWCBJAIcJ
         38r3VEtQOU4uLoisvFXQL975xT+AkVgfQuuQ3ICPf9sum7VwqACFqM0V2jM9vL0hxvYu
         z9fg==
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
Subject: [PATCH 4.14 117/138] net: fool proof dev_valid_name()
Date: Wed, 11 Apr 2018 00:25:07 +0200
Message-Id: <20180410212915.786217964@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399718871471315?=
X-GMAIL-MSGID: =?utf-8?q?1597400612116851880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1025,7 +1025,7 @@ bool dev_valid_name(const char *name)
 {
 	if (*name == '\0')
 		return false;
-	if (strlen(name) >= IFNAMSIZ)
+	if (strnlen(name, IFNAMSIZ) == IFNAMSIZ)
 		return false;
 	if (!strcmp(name, ".") || !strcmp(name, ".."))
 		return false;
