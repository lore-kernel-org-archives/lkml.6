Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtMQp9fcPAvr/MhUh48XFw02Jy4tZv34dvg5o23ziq/3ncJks0JNZBd1GS5K6sUHdCRvz4U
ARC-Seal: i=1; a=rsa-sha256; t=1520451657; cv=none;
        d=google.com; s=arc-20160816;
        b=AROnZoNqCVTMtz+z1+HRQ3EDI0qcVdniFDwt/TMdwyWFFFFIKknglduzGNXax4GT2l
         OPsPzghzYWIjjNwdTlmdsDIQoNZwgDlif2LJCTBN8+z8fWfBrgLthvJJTnOQX2vqGDUW
         lQFml1r51KUbPhCk+ekAgUJhWIhrAADl3B548toPFqK1WOq2U9q6RBp/2HwyLrL45sK9
         sPNRkYp4lMw8p+dBQ7CSN1Si/Xs2382WqLGki1iWAdg96+He16UP85MF6WgnNo/Fzi+m
         Js1aYegKQm2OHE/c+pQuZtpyEk1onyv889COvptCJnkHR+PL8QD7zuCAfA0LiNO37kX/
         5xug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UJ5ikArwJVOLExTQxUehTTc34gCe2y4hh4YPZnH4zyA=;
        b=PBb7mS7MRoSmRRHhLoSzeLOj+MYofaWlmd+uJZZA0KWlzToYPAYekTwLKPLdtgnq9D
         PtPUZ4LVk1oo5J9mCh0XcCKuCSrTpuFOOoqXO397xuq2d8VeZ6uHyZ57+RmlLIJ25XQQ
         LjdmhtPlCFIieH3xi8N0lXrG+eprZW1WwkNzSKilzFRw//AkiJ86+XVJVo42tZ1jWof9
         z703rc5eWUuvpYZxFjqTsHwAMAEAK+vmlhUbj4rv601u65aYgVTKJMs+xWnESk5YHuOz
         qygc5b2glHMxgiMWsFjDe2YD1P3rslL6CdoTaGJPhZNAfVWfjwRJoZC7aKMu4y+xl1w8
         72MQ==
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
Subject: [PATCH 4.15 041/122] hdlc_ppp: carrier detect ok, dont turn off negotiation
Date: Wed,  7 Mar 2018 11:37:33 -0800
Message-Id: <20180307191734.965892097@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309117628615611?=
X-GMAIL-MSGID: =?utf-8?q?1594309117628615611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -574,7 +574,10 @@ static void ppp_timer(struct timer_list
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
