Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227VNIrV/cKMWbugq6KK7UGCML0e+Iw8U1FPpQQNpe/oJKfjUkCFOJeMut9s8bUf9XKBpxvV
ARC-Seal: i=1; a=rsa-sha256; t=1519411664; cv=none;
        d=google.com; s=arc-20160816;
        b=j9A05qPP3TrSJEyx6l21IBqeyA4ECpXQ/zAX16fD/fquhDnwQCGMFqEbxCkokT3dcV
         W7BGtLnrLdJrUA3bMFFAXG09dqvg2sqS+rt7ItQm2SYHE1adlsI2V/lcM/H1ptD8UzjE
         /TCsd1jIY7OdDIlZbibCizbucwR4UM2Uc4xAbxAL8Xosrv6TV8nCegHCR+RcDV/vDbHf
         FggwUxo63ocK6i72bAiGpAXJqVsMMWacXLy0rxvomg/28xk1orzY2u1+YFnVg7pJoIB4
         GP5YlCCFNy8BQ0SSM1+c5MTgSNj4T0tWcvjUHsZ9/iJGdnGGrrG4zfclFPYohB4ciWiS
         plbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+JewBWHCHKG8zFUH1Dr7c8O72gjkmfLWxqlAqdbODIU=;
        b=MPsMgo7jdYCxmMMfS+EFWph0oLFuPXsLzOvAuta6limf7VBP8nlmZIYnApWMXSOemG
         /mVLJnAUrW1jx8U4ATo5a1qrqnU4EFRo4LYER2ZZj6hh8WXb0/CktHhNWBgb+1ldtw3U
         Epn+CdQCd6naydvKiBttQqQzFOqC0C05f2ksKzAhtdSly+21hZE7XbJCn1LIPsMAzwwr
         Hy40AHgFW53cEV6xxzwRXix0R15GgzrI7UZgofe7Mw9Sfciw79sYnskZYmTonRJg5+Ly
         TqDwYn14a9LM3q3591g2+v/GrUShNnDHIYY5zIF/JKF3cb+OzvYutQx8uHrnULwJTZ7u
         +DvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Laight <David.Laight@ACULAB.COM>,
	Arnd Bergmann <arnd@arndb.de>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 119/145] cw1200: fix bogus maybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:27:05 +0100
Message-Id: <20180223170740.204095595@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218079056239133?=
X-GMAIL-MSGID: =?utf-8?q?1593218604954003757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 7fc1503c906f0fac62d3506a6e993e49fb996248 upstream.

On x86, the cw1200 driver produces a rather silly warning about the
possible use of the 'ret' variable without an initialization
presumably after being confused by the architecture specific definition
of WARN_ON:

drivers/net/wireless/st/cw1200/wsm.c: In function ‘wsm_handle_rx’:
drivers/net/wireless/st/cw1200/wsm.c:1457:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

We have already checked that 'count' is larger than 0 here, so
we know that 'ret' is initialized. Changing the 'for' loop
into do/while also makes this clear to the compiler.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/st/cw1200/wsm.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/st/cw1200/wsm.c
+++ b/drivers/net/wireless/st/cw1200/wsm.c
@@ -379,7 +379,6 @@ static int wsm_multi_tx_confirm(struct c
 {
 	int ret;
 	int count;
-	int i;
 
 	count = WSM_GET32(buf);
 	if (WARN_ON(count <= 0))
@@ -395,11 +394,10 @@ static int wsm_multi_tx_confirm(struct c
 	}
 
 	cw1200_debug_txed_multi(priv, count);
-	for (i = 0; i < count; ++i) {
+	do {
 		ret = wsm_tx_confirm(priv, buf, link_id);
-		if (ret)
-			return ret;
-	}
+	} while (!ret && --count);
+
 	return ret;
 
 underflow:
