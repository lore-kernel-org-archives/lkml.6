Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr2clINI+wJGaVyoTQlZZeziwBjOROMOtW4lavOOPR9j16tbp3q/oN9YQIcXKEGooUPD+qi
ARC-Seal: i=1; a=rsa-sha256; t=1524838017; cv=none;
        d=google.com; s=arc-20160816;
        b=uQ+TtJXcxairqXywXZbUBDfs3nIf2N5/f57/O1p+VgNT77pnzFME+QSHqeCyX7mBS1
         hrqV6WXCqbrBSILyEFPk2s6qKv7yv+hlCufU9XdGs42A1p1N6c2+Vah2e9ErCS4TM3+z
         8lfpVxCPDiZU62wEFhXG5fw72cs3DGYBJdrSmHiU1bBvHfcvKTzAQccC/7RGldKapdX6
         Uz9yJShV+s1o46KAqnbthj9Egs+0vsqozCyf//KwEty+LsLwaTORLTweEBvxx6uuk8co
         VrNGiaFJFNl5IpdaA8jxruZsotY/gyOE/ul7r2ct7MR2wA0AuFBpwgQxDIOv0liRfXGS
         VIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=KbDKNOcIJFTw1bGGf1e0U26OK9ghhTVoNPE2E2qBXiA=;
        b=AibqiBY6E1BkOLQrtsiMrEdiQlWT+f/SdHXZ6Ue7DCg6V7IRZoC+7kN1VFSgw/4pLb
         yQ98JTnU8g56d51UtkMYRIbJZkS6isMAH/Wce72pbriGTY9BNjKV4sM9TqVfamVh8UNS
         GPW1NVWhVLkGwxNFhHjMUer1mrnrbsvQdrE91RD5r81CJ5y7rXoAhLxRGizlNLesuqKq
         9wjP+31X1jsWzra53w5v4igmCkfxlGeu4Mo8SBplbdQWfNPpX4sj1EjUBC6cAKay6tfX
         FQnUUlq/PjIxrR9wVCrgAWGqbjq2Zjynm21zhtS74+qIu/3whp9PKVpr4t4VfXemdxf+
         nkTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD1C218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Doron Roberts-Kedes <doronrk@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 29/80] strparser: Do not call mod_delayed_work with a timeout of LONG_MAX
Date: Fri, 27 Apr 2018 15:58:22 +0200
Message-Id: <20180427135734.449660017@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908548917467784?=
X-GMAIL-MSGID: =?utf-8?q?1598908548917467784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doron Roberts-Kedes <doronrk@fb.com>


[ Upstream commit 7c5aba211dd61f41d737a2c51729eb9fdcd3edf4 ]

struct sock's sk_rcvtimeo is initialized to
LONG_MAX/MAX_SCHEDULE_TIMEOUT in sock_init_data. Calling
mod_delayed_work with a timeout of LONG_MAX causes spurious execution of
the work function. timer->expires is set equal to jiffies + LONG_MAX.
When timer_base->clk falls behind the current value of jiffies,
the delta between timer_base->clk and jiffies + LONG_MAX causes the
expiration to be in the past. Returning early from strp_start_timer if
timeo == LONG_MAX solves this problem.

Found while testing net/tls_sw recv path.

Fixes: 43a0c6751a322847 ("strparser: Stream parser for messages")
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -67,7 +67,7 @@ static void strp_abort_strp(struct strpa
 
 static void strp_start_timer(struct strparser *strp, long timeo)
 {
-	if (timeo)
+	if (timeo && timeo != LONG_MAX)
 		mod_delayed_work(strp_wq, &strp->msg_timer_work, timeo);
 }
 
