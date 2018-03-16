Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2161282-1521181896-5-18302626582722497116
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521181895; b=aOB8mR0e4rIMDcxbo1g+D5xB7aTQCtgJRw8hex+WeaMsjZU
    jQh9Oyu0YqrkRZe3hTYmDE5kzvuJve14YYcyYmNLsg51ujcdGNvefDTy2FljSOmc
    cD5oUJXFPZI2nxjTWkQ52TtYes+uDnjiwd8JsfsACKImLhFwUexXoezCbn8SjE1f
    99T5tTnIu8y3/dMcyfsWMylSbutecXE2OvEUnhiTUTCHk/LLEoYgemjLr/PIadM3
    HN0C5wWJ3K/WXHnsohK8Y6g7+j1OwzLGpK8F3hfRkO3m7guZCSYO/PQkyq1Juw2N
    J1q/l1vEocFbYYosxaOMEXlmzaC/CPBieCxmJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521181895; bh=b
    YjAsodE4ALk4o6/1OVWx2MFx2QWqQe8nURzncI2ZcI=; b=gRpIho4jKyhrCgtQk
    Ey/ML1t2Wkf3KAYMkBMkLYcUIuKylLok42JC8pRNoHgVxOQqaO/rCW6WWsIWBRMi
    3EOE2nEbnFvaiWsmaCCtzlvIsTe0bX7yDu0kKgPlzOpX+aIsvU5IaPcmIxerAZX1
    CyPOnYmy6ztB7DkCfcn/llArPOD2EXchOsJt4fkffwPcythzGMAuh883EzbAdPRd
    UJZSaCRI734nw8GkNiUsI0X7mUFUKLFhH48MbtOQ8/iEgTLVMzncFGn25A6Xuw+n
    SbGhtL3STdn4RH3ATEXnnGYlFnithQK9XDTh5ODybB+HF4VwyDBzybE+M2VY6ODL
    kCk3Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 6/6] staging: ks7010: Factor out repeated request
 initialization code.
Date: Thu, 15 Mar 2018 23:30:35 -0700
Message-Id: <20180316063035.3037-5-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316063035.3037-1-quytelda@tamalin.org>
References: <20180316063035.3037-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:RVXSQ1W9Yba0fe2S6VzwZHMSY2i+fPh0JXAejFHHGiJSTOG/7Ke
 VpEqAT7hFTZww87eikc8QyTe1XSe3MUARVCO9vrJYfex5CgVP8KKb6+xb85xgZTL2ozUHm/
 2VBvPFxjCxs5q3YqNsUXvPPB/CcSm+wzqQ/tnBg+PBSalTGx2rPwQD9xIC0vPjq0uxk2Xdv
 ozjGWuvgEN9idiH2s7u5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DWruvkktClc=:ZV+JzEFu4Rkb0bpZ6Ze9pA
 0xEQ2QzhdfKA7GyfFF2NJzmtzs84vGpGGyvaCb8BLscUbn62yNGJosVsAHDyVA+C/JrR1SWCV
 lFE4VVJb/1dRDgyTt5kcCUUwBsK+yh0b7FdSZzM9qP0QXdGzjVuxtI9hUUZG54RJtGkwVSU6u
 OaiIOZwoEzo4Ua56SVq/IO9PFSM/OKXbSEHmHaSVOV4nOA2kHaoq8v4l6zQsIHRQLa7+nicta
 4e56P54vm6bou4rRfbsV9HieDj20q1u3Jzern2OFLBKm7XOwjLshtk32WaCZOFa792w+ul70L
 3F1gh53Eddddz0dYzLQJSNJUK0M/8503UR4Lgv7wgPhRwzglL2YyJLexOWN2yMajOwXCWg65B
 xdGqPpb17UF9MBt/UMmdd7BmiIoz6jp+FavRHD0zdVHx8lYLj7usUDbbO+/FouPX+JUShAMto
 xWoEaDr9gE3rFGwNmK7Tf9Sjk1PZBiGQJunvATOqcjEIhmhL6H0TFwU5CeYU1tBBkySoCL7sM
 84sWUGUDeBSyeym/S02tFQ5V6aObxIP8iUzC5yJhYTEEsPBrurrF25yS55LjVNUudvFXWzlUU
 EF+REsTJ5Hg+MiLnR4ao1W4rqphW9ocl6sWT8bDYUCOI1XpJFianfMV4Lrid4IZbZVpilL0Hq
 HAkk9zVULkQpTQzSbSTriwvueqQ8ecuW7GMGLnGsdN/mPRx1jDilPwqFz6pNX3PyG7TjyBXdC
 FuuitybtzaE6JPb6LZ5NUzp0wzMeS97G2LdOVg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The code to initialize various different types of request structs
is repeated multiple times.  Factor this code out into a macro
called INIT_REQUEST.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 55 +++++++++++---------------------------
 1 file changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 6fc2c3647908..3e5016aad029 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -40,6 +40,17 @@ static inline unsigned int cnt_smeqbody(struct ks_wlan_private *priv)
 
 #define KS_WLAN_MEM_FLAG (GFP_ATOMIC)
 
+#define INIT_REQUEST(pp, priv)
+{(
+	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
+	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
+	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
+	pp->rate_set.size = priv->reg.rate_set.size;
+	pp->capability = ks_wlan_cap(priv);
+	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
+	       priv->reg.rate_set.size);
+)}
+
 static
 inline u8 get_BYTE(struct ks_wlan_private *priv)
 {
@@ -1412,14 +1423,7 @@ void hostif_ps_adhoc_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-	pp->channel = cpu_to_le16((uint16_t)(priv->reg.channel));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	pp->capability = ks_wlan_cap(priv);
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
@@ -1437,16 +1441,9 @@ void hostif_infrastructure_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1486,16 +1483,9 @@ static void hostif_infrastructure_set2_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 	pp->beacon_lost_count =
 	    cpu_to_le16((uint16_t)(priv->reg.beacon_lost_count));
 	pp->auth_type = cpu_to_le16((uint16_t)(priv->reg.authenticate_type));
@@ -1538,16 +1528,9 @@ void hostif_adhoc_set_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-	pp->channel = cpu_to_le16((uint16_t)(priv->reg.channel));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 
 	/* send to device request */
 	ps_confirm_wait_inc(priv);
@@ -1565,15 +1548,9 @@ void hostif_adhoc_set2_request(struct ks_wlan_private *priv)
 	if (!pp)
 		return;
 
-	pp->phy_type = cpu_to_le16((uint16_t)(priv->reg.phy_type));
-	pp->cts_mode = cpu_to_le16((uint16_t)(priv->reg.cts_mode));
-	pp->scan_type = cpu_to_le16((uint16_t)(priv->reg.scan_type));
-	pp->rate_set.size = priv->reg.rate_set.size;
-	memcpy(&pp->rate_set.body[0], &priv->reg.rate_set.body[0],
-	       priv->reg.rate_set.size);
+	INIT_REQUEST(pp, priv);
 	pp->ssid.size = priv->reg.ssid.size;
 	memcpy(&pp->ssid.body[0], &priv->reg.ssid.body[0], priv->reg.ssid.size);
-	pp->capability = ks_wlan_cap(priv);
 
 	pp->channel_list.body[0] = priv->reg.channel;
 	pp->channel_list.size = 1;
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
