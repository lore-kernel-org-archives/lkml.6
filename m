Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsxicbIADVKxTLGDt6Vg8mgcZvemo5GI9NNMKOn4zQSw7Dveb4KjT+et+F9Av+ozHZYRQDU
ARC-Seal: i=1; a=rsa-sha256; t=1521799288; cv=none;
        d=google.com; s=arc-20160816;
        b=mC52cadwo4UmT3uQDR2cEmlyjfd6hsgAQkrAbj1eDsXn6iXhCQPz88ryFTJ+Ti6cLC
         KiGjo3Qn6RZ+9x8x5Iro/Pnn9wHelGeUthdK1hS8l5qoBVEs6ohH9IOtuwucFcQF4op3
         fOsEgeptvqDpuYhreAntWNsWw9U/yVEY0I6S81o0qwR03PA/hJ5qk/tam1AAtVyhQs8m
         Nj+EuBvLuhwPP9tCcRPOZNWUTEW9nmTm2WnaBrDoa0LMWIq2d6bESoQomoh6BUTd0vZZ
         zRn2RRsu0r89RbrmR7TmWyzhXzC0Kf/CIfV/dqhTg4z+JJVzrtc/H7tuIt6GKKPzZnRT
         w/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vj0l0G7/SwLCZaaO3Zq1Gqm3YxQE9EVOl8j1BflGxuo=;
        b=CoLL93/mJrZC7+0EPx9Bs2kZ26hJH4wR8K5StDrqWndHoePINMw3/9uPHE0JtzaVR8
         aiMOmPrSsjAtfgrOBu78nnVDk3euv71q7T0naexQOX9r0iNB1MFCq8Jlotfw4l0XIlIn
         J5+A6oRWMckiHnj40g/OyhvTNUEdwzARkqIRRC9I+7OkgceYE/ybIuCgCY12p5iAixtY
         REHv7LMFRCztZAguA98Oi2BE51W3miH6B1mltUXmr5d/JME/rJwkrrvfgcnEVFQaoe0j
         xjXVHr+JxcbCTQNQDMsIMyMMSCbhkO7mBMsSw4UZkVpPsr6z9TLkqyZEhcOlzU9Dya5y
         xMmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 18/77] qmi_wwan: set FLAG_SEND_ZLP to avoid network initiated disconnect
Date: Fri, 23 Mar 2018 10:53:52 +0100
Message-Id: <20180323094143.436287448@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721946694563316?=
X-GMAIL-MSGID: =?utf-8?q?1595722210652218111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Bjørn Mork" <bjorn@mork.no>


[ Upstream commit 245d21190aec547c0de64f70c0e6de871c185a24 ]

It has been reported that the dummy byte we add to avoid
ZLPs can be forwarded by the modem to the PGW/GGSN, and that
some operators will drop the connection if this happens.

In theory, QMI devices are based on CDC ECM and should as such
both support ZLPs and silently ignore the dummy byte.  The latter
assumption failed.  Let's test out the first.

Signed-off-by: BjÃ¸rn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -826,7 +826,7 @@ err:
 
 static const struct driver_info	qmi_wwan_info = {
 	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN,
+	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
 	.bind		= qmi_wwan_bind,
 	.unbind		= qmi_wwan_unbind,
 	.manage_power	= qmi_wwan_manage_power,
@@ -835,7 +835,7 @@ static const struct driver_info	qmi_wwan
 
 static const struct driver_info	qmi_wwan_info_quirk_dtr = {
 	.description	= "WWAN/QMI device",
-	.flags		= FLAG_WWAN,
+	.flags		= FLAG_WWAN | FLAG_SEND_ZLP,
 	.bind		= qmi_wwan_bind,
 	.unbind		= qmi_wwan_unbind,
 	.manage_power	= qmi_wwan_manage_power,
