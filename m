Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELttkdmyhDNIUtyT6TLUbTYelcFs8FoKUV6l4UNNb+P4yVSvXcuZrd5LiVg9f9GVfoSDsHkD
ARC-Seal: i=1; a=rsa-sha256; t=1520824062; cv=none;
        d=google.com; s=arc-20160816;
        b=FBSHJHfxEMmGW6+ovaQkcilExaUZfOC16e4uORq9K7zOzVXV2WzGeMKP0np0d7JNYt
         Ou2umtJHpWcAqOmyGIkWTJ7fFLu0wqs28sn0aUsVEghjXr4p36j5PfqmhkeGUXsmR+wl
         ZaTFCCAcmNON//IZtkJiUSp8yn6fuykp8Ynu+eNagQzH6HEBYMA0wg2+ajs+Q4ZIKxg/
         51AzMLdLhXKluskiVfpGhRP51lcSxotlG5hCUXjwZi+vEVRvbSCYVg3ZaBqMK+3QrJuY
         siq5EotcwNWYDJX6T4yBixMUF6RDSXhWQyeGjq96nCk31w1IK86auQUB4FuM1peEU53T
         Efsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=OiYurEBv3xZl1NqaC2LYN2DIT6Bxx3gEPXSPm4oOOb0=;
        b=V5EAOacAuNZD4eO+pIiqRvTADh81YwalJ0w+FIcyzutsY0uLtBTnYSYO17M6tWjOU4
         J7i3QVpUzV0PDeIKHpEwxYAy57ArrnG80xQdWcujvEAS5zD8YcPNQSb/QVUPE5TBvvpp
         6+CgCSh2/B1CZL5yBb8yfzpvmZ4lLqO4qnnwakQ71j4xsIGtltkn4/ETrdZWiVklJtq9
         boFMmqXmTNcODrQHjfq6oblTNnQiUiW67fxyzjAdi7wQHHgWMsuc+Y6JfhQi+2wqALB6
         lkvNQQPpHMc4Rk756aplris8oes7vAaAzZlVWXv25+lD4KxJ7k3LVQV00cwX5OiqaErk
         vsrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Peter Huewe" <peterhuewe@gmx.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.906503914@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 026/104] staging/wlan-ng: Fix 'Branch condition
 evaluates to a garbage value' in p80211netdev.c
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699612252295866?=
X-GMAIL-MSGID: =?utf-8?q?1594699612252295866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Huewe <peterhuewe@gmx.de>

commit fae7e4d39373305cf505d1f0871a4491897d56f9 upstream.

clang/scan-build complains that:
p80211netdev.c:451:6: warning: Branch condition evaluates to a garbage
value
        if ((p80211_wep.data) && (p80211_wep.data != skb->data))
	            ^~~~~~~~~~~~~~~~~

This can happen in p80211knetdev_hard_start_xmit if
- if (wlandev->state != WLAN_DEVICE_OPEN) evaluates to true.
the execution flow then continues at the 'failed' label where
p80211_wep.data is used without being initialized first.

-> Initialize the data field to NULL to fix this issue.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/wlan-ng/p80211netdev.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -354,6 +354,8 @@ static int p80211knetdev_hard_start_xmit
 	union p80211_hdr p80211_hdr;
 	struct p80211_metawep p80211_wep;
 
+	p80211_wep.data = NULL;
+
 	if (skb == NULL)
 		return NETDEV_TX_OK;
 
