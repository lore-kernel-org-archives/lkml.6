Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscVLYYw/nURaoKRDTBpQjuKTw/9g3YXL1wYiJjtNkdOpM1nUxgTlAqEmPKK6Kxl6X3lNRN
ARC-Seal: i=1; a=rsa-sha256; t=1521800307; cv=none;
        d=google.com; s=arc-20160816;
        b=t9+CKvDR5ulSxWXjVJyV0ryd2yAg1dyFUIUJlM755BG+HUNG3P95n9E+fWpauKWqa0
         Z3cYrsen8hCCXyfPjbClfokPTex7TvSVDHp2fVdQE5rFrViCx7G9Luulp/BQKqeDmnSQ
         Q5qSypdHOhTOsKijCm7sNi5YpmBjpqU8+ifps3OyP5ab8iNZL231tKSTiapAwOhfQK64
         l5B+79dC63/hi13mPliXi/EvsmBo3xhsDVtBCErrosWfvOFo/sp7wEqxQys3Lz/R7l7P
         m62HQaKT9yE+aD7f90oBkr8ike1S2gHwJ3+ytYmDmbcNhZ5XcR+CNNkbeDNYZWQPjO2c
         HMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rJTpKId8shgCf2uaJTJXy4rhe9OYnl48U0E7DY9An40=;
        b=w1tbbyS//5vXPuFMTc2AEd88emQBGj/DsSXzkv91rJYhJ8z3lcs7I42IaArOH9qH7S
         jIkCVeI7CZcE5ZjVzYODvMn9gkkjgwnxrbZDC6JFHBEd2v5eiF6TCk7ZJThlhmQLK5TR
         wO2QWcDNrWIiZL+OTSNbcOjFTeK3Dee+gEq/528OTEI0dPHY7uS/pcTOuNdKxjGv9kY8
         OaY9hpQTAHNyd8nPi1aDpgeboVJ8ZV/Lk88ch7w+st6yLthAsWM2at5m7W3MEnYU8fWG
         cWQWXjr5lIXYgM6DD5ZYS7uL7Fs/Uy2W1fOC9rgOO01ozp6ywJCuyXv4fBnG+FlqPpPe
         0Uqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Ahern <dsa@cumulusnetworks.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 08/47] net: ipv6: send unsolicited NA on admin up
Date: Fri, 23 Mar 2018 10:54:59 +0100
Message-Id: <20180323094248.489986312@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722415025079471?=
X-GMAIL-MSGID: =?utf-8?q?1595723279440041460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsa@cumulusnetworks.com>


[ Upstream commit 4a6e3c5def13c91adf2acc613837001f09af3baa ]

ndisc_notify is the ipv6 equivalent to arp_notify. When arp_notify is
set to 1, gratuitous arp requests are sent when the device is brought up.
The same is expected when ndisc_notify is set to 1 (per ndisc_notify in
Documentation/networking/ip-sysctl.txt). The NA is not sent on NETDEV_UP
event; add it.

Fixes: 5cb04436eef6 ("ipv6: add knob to send unsolicited ND on link-layer address change")
Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ndisc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1646,6 +1646,8 @@ static int ndisc_netdev_event(struct not
 	case NETDEV_CHANGEADDR:
 		neigh_changeaddr(&nd_tbl, dev);
 		fib6_run_gc(0, net, false);
+		/* fallthrough */
+	case NETDEV_UP:
 		idev = in6_dev_get(dev);
 		if (!idev)
 			break;
