Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-212613-1521781736-2-6981532933397635558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521781735; b=FIIkAvqn2ig0E7sVg32/VqzgInoENRce82nKA8Fxl80ETiL
    205ikrLoCb6lrY4crwPyIeQulQVICW3QxDvCeT6VWmlXVVkLsXx14G0C5ydfMPci
    XN45PWznHE5Bo2AUxo5AcAdD9pMDo0RDPwMUifI8sWRPprCC8TKmzkgb0VFSxYVl
    a0LUhoLgUAo4ZkfIr260RwYsNFPWK6qVc+cCP2NTUIRpBXGAYccv9ZxFgCRtIx+p
    Zx+NzK58kDxhOP+1+Tc0VdCuATtysJGsI01uNxKQscWnzjRknLXTkgDFUk0wAPhQ
    I83Ep2jRQ0/lgTFmcAYZ1uGDUCuAXg90YhiDnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521781735; bh=P
    /6hfb3q1tqIWuH3HQHSbF6cbDNmN0tPwS4VUiCMsBA=; b=hItWEzSEvM15/lony
    O59nGP/FmNb27Wo0D/Cq7nMMDb6PxDOq0299iPcOedXWUPYxLQkVJjZi09ykXWWG
    g3v0uqagfRb1WbYjDGLdQfwqBWv4PLSzZmWS1g6M7LKdCSvqnwpaNiGXboot3ymC
    KHns114I9A6/eztfIb8hkQD34II/voz52oi+RvpcF1+GLY3yTyzj8NE+k/tv/Tfc
    6YIdqQ0fA1nNrbzDBkFd7g1QKNcqYvHRCTg7NgfI2j0XErnr1ywwjTu11iXfLLlK
    2sNIYlqDFmT8e2vUKLNNOU4K5di2kViM93X4biR9NtogX6D4bs1Ju0txzyFkTQ4L
    G2MrQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 6/7] staging: ks7010: Factor out repeated code for reading IEs.
Date: Thu, 22 Mar 2018 22:07:44 -0700
Message-Id: <20180323050745.28903-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323050745.28903-1-quytelda@tamalin.org>
References: <20180322172014.GA6801@kroah.com>
 <20180323050745.28903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:esbK2Z2LbhWzT1mQKR4HtxjCj80/1E6PD9dlRH4n7kzIVoRs8VW
 X+TM2DNoEEXDJLUFyEBXJ84OJAQkYGMZV+KV3ITkig+eeCuv4EAUOfuINoQ0PORAYcfsUhF
 eOS6HabsZ+k05Di+JFU1mnoLBHlmcgWREUFmBvvpw3AZWYPPF5+n7CLnhV97/17i2SgLBtt
 w6a78IulBf0ZUSPGF3b+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3ORZJArsb2Q=:onHhF5AvldQFF1TLp6tCuK
 ytoXcqu/MQUrVQBdFD+K8qAz3SZLfusQeR23iXQc85v5BRKYAARif8REgMrJKM6G1n/zsFFRz
 zTEFNyVi3Img1AoiWfv7FNkCcCxZKf/LxUgWyCh4ybem5ZlqzQh14Ik0qNCyQPtJL3SfZ00U+
 l9tG3Opit+OgD4Dl7A9U1PHXa8aAADTWKA8iOCF4jJHOd+NanlHmOk7xiHFhv1HdEky+URj3z
 4WYoRdnidUHoSdbT/LrXnBW6+gRgtz/AgT1YMZYFl6BeDYwele6nhU2B519qc3SbArlwN1EUp
 I/XFfbwUgQTUeo73SfOfi+2vRg9ZQ176mCZ6tlbiycIfZCwPoYiBq5y5rRg266OD3/5T5JwW1
 AFZ9hTLne8wqixmkK5Q6sffjuDlLlLoIfmJwNDKpOSi9GFTrvghmrUAusRKenMNA9tcIoevdX
 644HWsDTvvf8rSJeiFc7hL96x+0gmwaaLGv+tw9TJYEKI98vothBhOsL/0ldGBV9Z1ejeFqQK
 CXD7ob9sroV9cxNS13rOYtaY1PMypwBAhAA6QxXINbaTlfQuMlgdDOg6h6QIDoxbb41zCS+Xg
 82/q+im7ZWuhsVOW5aeREuofYZgozN2AJ2ODfmMoVMAy4RtYNrp+FQJjUu4Sh9u0/UU3vBcwY
 iMpB3aemziH+D1pFblsm1ubi/ONxDSSO4PFJjR1pNQPqXvfTEf5Rhz6SseGoeCPz8yNOoDkxg
 gSRBQvlQLEOPvMtL/RnAutklaRlHX1I8gXRY3w==
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

Some of the code for reading IEs is replicated multiple times in the
switch statement for get_ap_information().  Factor that code out into
read_ie().

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 1a0fe15e842e..21219d0bbb6a 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -216,6 +216,15 @@ int get_current_ap(struct ks_wlan_private *priv, struct link_ap_info_t *ap_info)
 	return 0;
 }
 
+static u8 read_ie(unsigned char *bp, u8 max, u8 *body)
+{
+	u8 size = (*(bp + 1) <= max) ? *(bp + 1) : max;
+
+	memcpy(body, bp + 2, size);
+	return size;
+}
+
+
 static
 int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 		       struct local_ap_t *ap)
@@ -245,11 +254,8 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 	while (bsize > offset) {
 		switch (*bp) { /* Information Element ID */
 		case WLAN_EID_SSID:
-			if (*(bp + 1) <= IEEE80211_MAX_SSID_LEN)
-				ap->ssid.size = *(bp + 1);
-			else
-				ap->ssid.size = IEEE80211_MAX_SSID_LEN;
-			memcpy(ap->ssid.body, bp + 2, ap->ssid.size);
+			ap->ssid.size = read_ie(bp, IEEE80211_MAX_SSID_LEN,
+						ap->ssid.body);
 			break;
 		case WLAN_EID_SUPP_RATES:
 		case WLAN_EID_EXT_SUPP_RATES:
@@ -270,22 +276,15 @@ int get_ap_information(struct ks_wlan_private *priv, struct ap_info_t *ap_info,
 			break;
 		case WLAN_EID_RSN:
 			ap->rsn_ie.id = *bp;
-			if (*(bp + 1) <= RSN_IE_BODY_MAX)
-				ap->rsn_ie.size = *(bp + 1);
-			else
-				ap->rsn_ie.size = RSN_IE_BODY_MAX;
-			memcpy(ap->rsn_ie.body, bp + 2, ap->rsn_ie.size);
+			ap->rsn_ie.size = read_ie(bp, RSN_IE_BODY_MAX,
+						  ap->rsn_ie.body);
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC: /* WPA */
 			/* WPA OUI check */
 			if (memcmp(bp + 2, CIPHER_ID_WPA_WEP40, 4) == 0) {
 				ap->wpa_ie.id = *bp;
-				if (*(bp + 1) <= RSN_IE_BODY_MAX)
-					ap->wpa_ie.size = *(bp + 1);
-				else
-					ap->wpa_ie.size = RSN_IE_BODY_MAX;
-				memcpy(ap->wpa_ie.body, bp + 2,
-				       ap->wpa_ie.size);
+				ap->wpa_ie.size = read_ie(bp, RSN_IE_BODY_MAX,
+							  ap->wpa_ie.body);
 			}
 			break;
 
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
