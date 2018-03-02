Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvwmYNd56Vlp7H1YCH5UkKgpQAZPGms/NjUqPbYqO6ckJhqKHJsaLoWypLIR7GHk5gXMzvR
ARC-Seal: i=1; a=rsa-sha256; t=1519981421; cv=none;
        d=google.com; s=arc-20160816;
        b=QL6XvobOAY0Pe9B8MMi969EPiAf7OB7qXk3HleA/ztyF2xIz1yEbeXfCu7RcAI3zOS
         LUfd2T4e6gsFChZpZ3ISRjqj+RWrvw+Ny6xug9KOYrm4NwO2JoQEu4s0xQpFwJkIn2uc
         gQBUA+tOREq3t8eBrBhfrd1gIoSJe4dfa0a+VbOrbzFoJZxWTnvjes2r7WwkQl1PTL1B
         ytD3YQC+hjnqImovFpQJ6nxjBmCffmPTfYoxatoIncyXbX7FykPpXiWBkbPGVLSINeKE
         dxKdDoqRDUKx3m1C3pQtEptoRciM3fBi9MlV8H8ctAsmm41m7arXQXYwsZwto/ZKqFBP
         2yKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nBOI6bA4Bz3UQi992pEGxnpbb6bFBNRhZTCYu7Nn3IY=;
        b=Kia7qynIauCCwqeuF8/Ihc0OyMF53gMktwAixwbP3UKoaRTzMjHIpe2MsSqO++dpNg
         XjTVUh6Pah87yy2cW+vKCaUKlRbX8d4NKPfODNZ+x/eq6GWBdmabB3vmfOnKbTvCQw3y
         0tXv4B6jWIHOKba30e+gpDgSzwQ1CHK0huD0bHIQGHN5MTSX9m4pieV33Dzxz1jIKp11
         EimWzLx4pWnFCZ95EjwsmjrVR2stv4BhjczIjLzj/gGnVtkfZBOuRbwcdqPvzKJLdl7I
         CyO9got7zjl3f/eQZEiXFnO6kani0FROxo0T0WE1lSe9mwM6tqa3+QRWlTgP69bNEMv7
         mhbQ==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 086/115] can: flex_can: Correct the checking for frame length in flexcan_start_xmit()
Date: Fri,  2 Mar 2018 09:51:29 +0100
Message-Id: <20180302084507.328590650@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815491970045896?=
X-GMAIL-MSGID: =?utf-8?q?1593816039535950473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/flexcan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -526,7 +526,7 @@ static int flexcan_start_xmit(struct sk_
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &priv->tx_mb->data[0]);
 	}
-	if (cf->can_dlc > 3) {
+	if (cf->can_dlc > 4) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &priv->tx_mb->data[1]);
 	}
