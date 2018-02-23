Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuEuesO4SeCXpxMBGVvoRf2TvzPX3TCExOPKu62B9eEfmrWqbd8dyDLp0URxyIIhRzdpcHl
ARC-Seal: i=1; a=rsa-sha256; t=1519411162; cv=none;
        d=google.com; s=arc-20160816;
        b=z0wQihoAy0XU5Xquk49HNdxFD9Rc1L5yb+Si1jvE73qKu9xEiToKW7kg5QMourdfmY
         O+JVafpPA1QN10BctnHrvACg1irHiErVSEwXhBAgLLFitYBZoKzgAHW7VCRzT4Z3cJBJ
         GsAHybIvSkby6WZs15CbegzTLs4jpgY3TBm10LCKES0rpgKAcE66nslw17Orpdk3x1Nj
         WvJXHh95XT0heVP8rOUwKQ3jehrNvGq8emU3eVM9Se5HVJmvNOuEQKOh4iQdty8IohZx
         +ivaSDyj5apZj+c5p6fqQrkx2KEyMBPjjqNb/J5saRiDTeZyJqPcRJCBdfD0Ka9N67RA
         PFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jxaYFn8514Cs30wPGG3r/Eau1dUgtRqynvneRuGthpI=;
        b=GrzxmeE25uNaDEvco2hseMGpSeDzsYqw4ivfjsG2pTFtPqJs6mo0UdGb/x36mwCKse
         R8IcsVkQXLzm31gVmGkZWVrCh+nzJDRiobmDI1hp1dQNBL0MgUTUfpCU26tzNdpjP2Qq
         xXgVhwcn7VgI/2vMmQ2pge+1ePHnJPvvogRNZ3fXjB0rxe0Jf2Lg6UQQkdn+hJQtQihm
         HixH4xjn3iRpWeT0Wkq2SEMX0BEGHaiOypCcwc3rShT69w/oROuvFQgcuFDkWLXfkggD
         Z/YbGz28tOkAy7/FCqhz30wq10oNNt3IoRPsPuhMcOpw8JqM8D0yoQVvzy2vTb3RXvj1
         VdCQ==
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
Subject: [PATCH 4.4 142/193] cw1200: fix bogus maybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:26:15 +0100
Message-Id: <20180223170348.116364781@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218079056239133?=
X-GMAIL-MSGID: =?utf-8?q?1593218079056239133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/wireless/cw1200/wsm.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/cw1200/wsm.c
+++ b/drivers/net/wireless/cw1200/wsm.c
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
