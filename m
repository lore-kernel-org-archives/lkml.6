Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpipWFFwsleOwwhB2Z6x/95YxAT39G2khhan7KSh26JRTfasuTOo+7Y831AaCpsnpAO2tCg
ARC-Seal: i=1; a=rsa-sha256; t=1525116404; cv=none;
        d=google.com; s=arc-20160816;
        b=Qb4LAfQYjRyzzZrCx9TDsxjY2kljebeixtVvkUMPIb2761Y4gsUmRQGn/60yEUMJtO
         QTEVxFt4ag3MbfTcyfiZQHnj0pgTJn2j87Mb6wgxl4BCWMRmekyrj8W7zxn/RF7etHdp
         oZzeZJei1pxy9fVnu4DNIsXne6fqUmJxfCA6wwMdBUf/Vr9EQbFVe52AaEb45K6M/7LT
         iHvK0L3aJkylSb9ySI536NBHUhUnoZgYuVuq4dWYweFSdhvC9RYZBDZq/aS8tik7Qrf1
         4uIijif1pEEKnj8VFbbKddWaU7D0T8qTb2bnOmwbp36D1T6IYwubaD3UO/KVGJ9nIrLF
         P3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xU07u9rcJF9kv9Y9+olcsCZCoiLRtsRWpMhGsDLzb5M=;
        b=rZpMmYNFgR6M/0Kel7N/E4drsxOebLCOyTibLSc6xOMFziJmZjmD/TcnEiCclcCVPt
         qs8PSuTX6aoMyuB+FmpoW4+KBYO3yhe9rkJcbZqn1T7KtcdonwuuNK0AnuIVnEzJcBYF
         UpewJ7x8bKlQtcmlhGceS/cGkZZcV6hMZGlrkMreW6ngk1B5T0MAuE12ti6dMmAv4Rk5
         Ik68mV7Akknj/XJ5aBUS2a6f5K5iyAnVFhUm01XekuFZBNHRkDw3jghyRbiiJg4lmW5C
         nUj45R2qzG/l07nqGkqywXYloZdw3z9vWtmgjnzgO23ki55HlPGKloWgxIiQKvG2ikE0
         vVfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC6A22E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 54/61] rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops
Date: Mon, 30 Apr 2018 12:24:57 -0700
Message-Id: <20180430183955.893665304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200458168211675?=
X-GMAIL-MSGID: =?utf-8?q?1599200458168211675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 682e6b4da5cbe8e9a53f979a58c2a9d7dc997175 upstream.

The OPAL RTC driver does not sleep in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware, which causes large scheduling
latencies, up to 50 seconds have been observed here when RTC stops
responding (BMC reboot can do it).

Fix this by converting it to the standard form OPAL_BUSY loop that
sleeps.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-rtc.c |    8 ++++--
 drivers/rtc/rtc-opal.c                    |   37 ++++++++++++++++++------------
 2 files changed, 28 insertions(+), 17 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -48,10 +48,12 @@ unsigned long __init opal_get_boot_time(
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			mdelay(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (rc == OPAL_BUSY)
-			mdelay(10);
+		} else if (rc == OPAL_BUSY) {
+			mdelay(OPAL_BUSY_DELAY_MS);
+		}
 	}
 	if (rc != OPAL_SUCCESS)
 		return 0;
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -57,7 +57,7 @@ static void tm_to_opal(struct rtc_time *
 
 static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d;
 	u64 h_m_s_ms;
@@ -66,13 +66,17 @@ static int opal_get_rtc_time(struct devi
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
-			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	if (rc != OPAL_SUCCESS)
@@ -87,21 +91,26 @@ static int opal_get_rtc_time(struct devi
 
 static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d = 0;
 	u64 h_m_s_ms = 0;
 
 	tm_to_opal(tm, &y_m_d, &h_m_s_ms);
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
-			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	return rc == OPAL_SUCCESS ? 0 : -EIO;
