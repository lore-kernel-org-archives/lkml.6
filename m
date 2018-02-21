Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225TYwuVoeYpbsVxdNoKN/jXVwML6oELBxEV6R9kKgX0pPS0uUykZrcmZ06ExjoYK6mCWtCS
ARC-Seal: i=1; a=rsa-sha256; t=1519217667; cv=none;
        d=google.com; s=arc-20160816;
        b=Bs//Gew6xuEMLS5anY14JIv1GOiYvsvEsCkxmNHv1ziOSiFZEVgmrXvSykebyitCf9
         Qc8M2OIzJ9wSdm4ioiceMwHkjzWsa1VrHVwWsMGebYU1RFDtfGNQSfrP0fA7PMRV9HIu
         26g+JkBqAhCUKQPvUnBLTXg8cZMQEitUsAuRSXLgacf97zEmyIIGtuCys+1n0pT3cUZA
         OZtQMq9WfZW32mSXojEe7TI9wKZN1NXT7wkl9zzmaQARH1nfu2GWWKIMyhpH8FqbeBue
         d3Y8IhQJPPfiyeLisNFeLTW4kON8GXQ84NS3K8ntwSnwUhJ5nobzIhipIKJrBlkDItbs
         nUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DX+Tw0N4flZShYDmAePoSsHrM5GNZu/IjEjVtzRib3Q=;
        b=xv5jYS8QgDzjfOc71rOs0JYcOCq5SuvdZeirpw80ilB3jRgR0gmKDwaz7iuipOd8fZ
         k2KGao6oPGa3lV9YqsGsZRhEjNXgN1THnX4FpG7KTabKtBtd5aTkOgEwUaENjcXrSI27
         A/zVU9RN41sgm6/yK7JpmuW1zu4pBF8KE8ycgZd21hVCcBx27T0RGDE6tpXPTlSR/fhI
         ONKrWA0ccD+LbzfBURXAK9Ul53dRYV1aUcJ7YwfXmS93opbpOfPHv/m3qF8968668Wws
         Ofmpp6hmhFENXfCKe2gxk+4tVW4cYL0vl0xf1kKen6EiJxGClUh3n56Ulw96PGTNkpWi
         c13A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stewart Smith <stewart@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 04/77] rtc-opal: Fix handling of firmware error codes, prevent busy loops
Date: Wed, 21 Feb 2018 13:48:13 +0100
Message-Id: <20180221124432.350707446@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014681201227169?=
X-GMAIL-MSGID: =?utf-8?q?1593015184863074705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stewart Smith <stewart@linux.vnet.ibm.com>

commit 5b8b58063029f02da573120ef4dc9079822e3cda upstream.

According to the OPAL docs:
  skiboot-5.2.5/doc/opal-api/opal-rtc-read-3.txt
  skiboot-5.2.5/doc/opal-api/opal-rtc-write-4.txt

OPAL_HARDWARE may be returned from OPAL_RTC_READ or OPAL_RTC_WRITE and
this indicates either a transient or permanent error.

Prior to this patch, Linux was not dealing with OPAL_HARDWARE being a
permanent error particularly well, in that you could end up in a busy
loop.

This was not too hard to trigger on an AMI BMC based OpenPOWER machine
doing a continuous "ipmitool mc reset cold" to the BMC, the result of
that being that we'd get stuck in an infinite loop in
opal_get_rtc_time().

We now retry a few times before returning the error higher up the
stack.

Fixes: 16b1d26e77b1 ("rtc/tpo: Driver to support rtc and wakeup on PowerNV platform")
Cc: stable@vger.kernel.org # v3.19+
Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-opal.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -58,6 +58,7 @@ static void tm_to_opal(struct rtc_time *
 static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 {
 	long rc = OPAL_BUSY;
+	int retries = 10;
 	u32 y_m_d;
 	u64 h_m_s_ms;
 	__be32 __y_m_d;
@@ -67,8 +68,11 @@ static int opal_get_rtc_time(struct devi
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		else
+		else if (retries-- && (rc == OPAL_HARDWARE
+				       || rc == OPAL_INTERNAL_ERROR))
 			msleep(10);
+		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
+			break;
 	}
 
 	if (rc != OPAL_SUCCESS)
@@ -84,6 +88,7 @@ static int opal_get_rtc_time(struct devi
 static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 {
 	long rc = OPAL_BUSY;
+	int retries = 10;
 	u32 y_m_d = 0;
 	u64 h_m_s_ms = 0;
 
@@ -92,8 +97,11 @@ static int opal_set_rtc_time(struct devi
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		else
+		else if (retries-- && (rc == OPAL_HARDWARE
+				       || rc == OPAL_INTERNAL_ERROR))
 			msleep(10);
+		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
+			break;
 	}
 
 	return rc == OPAL_SUCCESS ? 0 : -EIO;
