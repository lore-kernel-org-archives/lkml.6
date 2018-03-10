Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELteRIMF6zCQB1C1oYme2gf4wj5pvjRjVKdSANyX5PAdHGAvPAXDXziyGsjYRptwD9b4CTIy
ARC-Seal: i=1; a=rsa-sha256; t=1520641313; cv=none;
        d=google.com; s=arc-20160816;
        b=DhC4kEFIutaQxSLgdb8iGinW1hWO3agtW5y9hrWPMMlIZJCP3ywjit51U+8rz06esO
         ZBh5lbJOyskoe8YFt8bmawscl+s3RQ2DmpAjXhi045xKy1Q332m8/4Fm1MiZ8UIWQy1v
         pjSHN138THaa1W2aG07uYmUjSx+QVl/uBtBIedtpeejZ+qSDPY1gOp2BG07CsZkaw7mB
         90ugonyFKpTxcRWy0VZRbpwiInZATb58041Y6JT/02D5PVpEeGECn4IKFXkC4W81eeUs
         A6ksugjfH9nMk1qguLZzxczk+HedvBhjgtM6QFISJhXUqnQhfqJ3S/22V/nkP0QEahz0
         g3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Oz3dTtkcUDneisTJGexOgmPyTWSWFpeifGtNqqDW+VE=;
        b=mnI4UgF8nDwjzCBwpTeQ7Mjif/Ubfg7sEWGzJo//lr8Zi3wbwzrlTZfUBm6qASmSGJ
         SuysefABcugXgwzhFL4yM9Lg5ivOXhi3Q9gFpEqPa05I+Vx1HhOksWaqf5Qazc2tXKC5
         16eG+zCuN2H/ZH3gW+sy/o8ReQ7gGX9GThKijdrHPFhACzz+pi6xYMKBoGIq/4CessG0
         cN6wDi5qjAbItOvJDW58EG7Vdg2TsGn9mHJa41NEJGR6v7Qhk8Xg7+LbIPdG1sRCodwH
         nDy6LV+4VWBjHD10B6cgH748XlUYslGEaxwr2ANjT03yGhp1GXeiK8GMzdT77b9gYxUE
         EPNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Denis Du <dudenis2000@yahoo.ca>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 35/65] hdlc_ppp: carrier detect ok, dont turn off negotiation
Date: Fri,  9 Mar 2018 16:18:35 -0800
Message-Id: <20180310001827.810045143@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507817246578750?=
X-GMAIL-MSGID: =?utf-8?q?1594507986093594335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Du <dudenis2000@yahoo.ca>


[ Upstream commit b6c3bad1ba83af1062a7ff6986d9edc4f3d7fc8e ]

Sometimes when physical lines have a just good noise to make the protocol
handshaking fail, but the carrier detect still good. Then after remove of
the noise, nobody will trigger this protocol to be start again to cause
the link to never come back. The fix is when the carrier is still on, not
terminate the protocol handshaking.

Signed-off-by: Denis Du <dudenis2000@yahoo.ca>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/hdlc_ppp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -574,7 +574,10 @@ static void ppp_timer(unsigned long arg)
 			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
 				     0, NULL);
 			proto->restart_counter--;
-		} else
+		} else if (netif_carrier_ok(proto->dev))
+			ppp_cp_event(proto->dev, proto->pid, TO_GOOD, 0, 0,
+				     0, NULL);
+		else
 			ppp_cp_event(proto->dev, proto->pid, TO_BAD, 0, 0,
 				     0, NULL);
 		break;
