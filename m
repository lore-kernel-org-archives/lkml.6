Return-Path: <kys@linuxonhyperv2.linuxonhyperv.com>
X-Google-Smtp-Source: AH8x2263+RK4Qq71mTiAWQP2D5/M/ExN11IevMdpxzii5VT0VWzLx+NWNC/E/YnIgPFEyHhdQ+U0
ARC-Seal: i=1; a=rsa-sha256; t=1518395678; cv=none;
        d=google.com; s=arc-20160816;
        b=0mgjZoA+k7zxD/P48WdCIUhqqJfn4q63T45VGT5wJP4oELHWTpQzw7wkFpYm8goXKX
         ekyRr9GQ71R5h+Gp5mQK04g1Wn+yR0A6UUGFHp+Z4isKzYHlogSxsPYK+f52ccABBNDQ
         m4/S6FO6HybCrxwsBT28lykrlR9B1CAuQjTGHoqdBecMT6BleqfJC9tV+nsbOtFHPh9E
         8/POvjjjBkdVi4q67vBX0qZw1KKe11CH7izl1jk+iBeNsKaQjlMmNctDz9DrFs0+sSUj
         RkhDHq22sCxcwOrzTbrJd1AL++ImqkhJBWd20dINx5j+aOlR4dkk+UZp9S+mIRQt1haG
         tVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GTQLATV3W2/YOtOXtY3EPQRnA/gDuscedbnj1zSfJTg=;
        b=V51shI8UXDIKSjAfY/XZON0xTDuyISKxgAZ2xz7PIBrwVt+PxOCIJIfvwoj16jLTqA
         rjPj7echSr3MPdSX5ochQJs7wfJfOSjeSFWwNeMDRwM74pCar23I2CigSH4YOlM4oCEl
         dSxSkEKCa52DfAZKiTJZULwK0NLb4A259hAISJd/I1dkd55KqTCAhJHmzoHx96u5pgii
         p7cUAfGrZ+LU0O6tEzA7mp4AP6vC+IkjkKO8TQSGbpSklPSiTXTvb61QhQvQjWPQaKdR
         hee8D9Ayidu4kkfYcMMkzC4l/viY/1RlUNuBlgs6IotQ4EG3V5Wmwm3WJMq8U0z3XhMx
         /gtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 198.71.225.37 is neither permitted nor denied by best guess record for domain of kys@linuxonhyperv2.linuxonhyperv.com) smtp.mailfrom=kys@linuxonhyperv2.linuxonhyperv.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=exchange.microsoft.com
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Cc: "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 10/12] hv_balloon: simplify hv_online_page()/hv_page_online_one()
Date: Sun, 11 Feb 2018 17:33:18 -0700
Message-Id: <20180212003320.6748-10-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212003320.6748-1-kys@exchange.microsoft.com>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfNlz0XpK94vnLd9YGAHOnLUSrKdaW3REP0kibOY4AR7nFiacVIwMXPvluS9XHiBhMf7a10C0r6OxQmyAfJxKlLVOtX01Vf0ofj6QfQ2Ctaqt0qi0he6X
 Z0Tv+iP6XpJVmq+22xf6u6Dr0586bCssXe3nRtof/1SI1/ktM0lWWxFzgY4DxooTQgEpUVfHrOp8j/cYzEQkrB0OpYqAEgkGesoWvde5gcIE7xCvX+tBE2vv
 zBbM0qYJgG2KXUJf90omtaBecUT/QyXwhkJCG7J9vdtKwy5tLobqWmMeAplwetFH2GKU/GXAsyD7G83N8IcQo/ZQuq6c89NLGW2MqAZxbaLy/Xzy4Lr8kVX/
 5I3ocXcuxVTy+sB+0Bsd2mCUscajn1tK4Lhp6vSGsx2BH5uIgP2wBGJa5R6h8QlYXV3jnonluvgA/LXhL6JDZMyy2ZNdb/sVYmvJYdP2AmdGtQa6+YoLSOm+
 zREhgWcufhKkNbK5XoYSrAocOb9jJOYGlwt3Q1OOW/lZiPr6y5trf5JAWBE7cKxQ01Ik8vj/vUnUAlf/lLpJIHfaSRQBiNf5WkOxDg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153266661496806?=
X-GMAIL-MSGID: =?utf-8?q?1592153266661496806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Instead of doing pfn_to_page() and continuosly casting page to unsigned
long just cache the pfn of the page with page_to_pfn().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_balloon.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 1aece72da9ba..5b8e1ad1bcfe 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -612,28 +612,17 @@ static struct notifier_block hv_memory_nb = {
 /* Check if the particular page is backed and can be onlined and online it. */
 static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
 {
-	unsigned long cur_start_pgp;
-	unsigned long cur_end_pgp;
 	struct hv_hotadd_gap *gap;
-
-	cur_start_pgp = (unsigned long)pfn_to_page(has->covered_start_pfn);
-	cur_end_pgp = (unsigned long)pfn_to_page(has->covered_end_pfn);
+	unsigned long pfn = page_to_pfn(pg);
 
 	/* The page is not backed. */
-	if (((unsigned long)pg < cur_start_pgp) ||
-	    ((unsigned long)pg >= cur_end_pgp))
+	if ((pfn < has->covered_start_pfn) || (pfn >= has->covered_end_pfn))
 		return;
 
 	/* Check for gaps. */
 	list_for_each_entry(gap, &has->gap_list, list) {
-		cur_start_pgp = (unsigned long)
-			pfn_to_page(gap->start_pfn);
-		cur_end_pgp = (unsigned long)
-			pfn_to_page(gap->end_pfn);
-		if (((unsigned long)pg >= cur_start_pgp) &&
-		    ((unsigned long)pg < cur_end_pgp)) {
+		if ((pfn >= gap->start_pfn) && (pfn < gap->end_pfn))
 			return;
-		}
 	}
 
 	/* This frame is currently backed; online the page. */
@@ -726,19 +715,13 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 static void hv_online_page(struct page *pg)
 {
 	struct hv_hotadd_state *has;
-	unsigned long cur_start_pgp;
-	unsigned long cur_end_pgp;
 	unsigned long flags;
+	unsigned long pfn = page_to_pfn(pg);
 
 	spin_lock_irqsave(&dm_device.ha_lock, flags);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
-		cur_start_pgp = (unsigned long)
-			pfn_to_page(has->start_pfn);
-		cur_end_pgp = (unsigned long)pfn_to_page(has->end_pfn);
-
 		/* The page belongs to a different HAS. */
-		if (((unsigned long)pg < cur_start_pgp) ||
-		    ((unsigned long)pg >= cur_end_pgp))
+		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
 			continue;
 
 		hv_page_online_one(has, pg);
-- 
2.15.1
