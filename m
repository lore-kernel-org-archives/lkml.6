Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-422771-1518026278-2-3673187585369293038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518026277; b=LTLuxyx4JDR88W2FzhmCkL3Ew4O0SomAm4IcpkH5CblGsa9
    fD91jmY3GD3ebz9ReUYlCgJiBqt3Nz8KSbCWype8EMdBCVEYLKAa9WpmMpe3QTi4
    ZNslmmc0CC/4Onu0RJKRhshJKDZUlhyl2SKKl37SU7qBX3XRgzdhG1pRZVSZnUcJ
    9GzR2ogYlI9SHrzAPFOqSKFsPiI3v/ret8gS58fDmK2gmpPV5lFoXe6UzJMbd/BT
    Ag3MlHy3WVSiG2lB5jLUiXMoI1vSS5gdBSkgI1XxIebtxFyA90Yzc+SwDjlfxvoy
    rRr6+tDkR2en+4AnBTMs5mo6K1bS856MsE7j6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518026277; bh=v
    IsRHWwxGxC10imzdkUxvfSHdKkkJBvfxUMJG6Ioa5k=; b=s4hSdQYijYvMOoWKy
    uIMJjj1O7loHSM2u7jtlJ4+cwZ56kgOZuH1Xf+V03e8F99EzcM+lSzDaI48GuLp7
    IjbWAUB0coZxx7FiXYWXtrjr6qVyJb1ktbuF2Fkly377tVk7VABO81IIPP/r5xHZ
    2p4JWmcxuGrO/+QfL5UhhzyM4w9XhuFm0wB4rupYkKwfysNRoTELz8Eue4jI/PpS
    0a2Z/hkUM/viA4Og3rMgkAChoaTbhAO1lY5NVA+8NFWMGzGX/J1qIlt9uUGRCoRh
    Rp5xkVp+qYHInc/DjwifRbzVfuL15DVJ4vyjH11wlh1dM1QwNZESuUa1nZ3SLWg3
    /hlwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: devel@linuxdriverproject.org
Subject: [PATCH RESEND 3/4] hv_balloon: fix bugs in num_pages_onlined
 accounting
Date: Wed,  7 Feb 2018 18:50:02 +0100
Message-Id: <20180207175003.28859-4-vkuznets@redhat.com>
In-Reply-To: <20180207175003.28859-1-vkuznets@redhat.com>
References: <20180207175003.28859-1-vkuznets@redhat.com>
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
Cc: Eduardo Otubo <otubo@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Alex Ng <alexng@microsoft.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Our num_pages_onlined accounting is buggy:
1) In case we're offlining a memory block which was present at boot (e.g.
   when there was no hotplug at all) we subtract 32k from 0 and as
   num_pages_onlined is unsigned get a very big positive number.

2) Commit 6df8d9aaf3af ("Drivers: hv: balloon: Correctly update onlined
   page count") made num_pages_onlined counter accurate on onlining but
   totally incorrect on offlining for partly populated regions: no matter
   how many pages were onlined and what was actually added to
   num_pages_onlined counter we always subtract the full region (32k) so
   again, num_pages_onlined can wrap around zero. By onlining/offlining
   the same partly populated region multiple times we can make the
   situation worse.

Solve these issues by doing accurate accounting on offlining: walk HAS
list, check for covered range and gaps.

Fixes: 6df8d9aaf3af ("Drivers: hv: balloon: Correctly update onlined page count")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/hv_balloon.c | 82 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 5b8e1ad1bcfe..7514a32d0de4 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -576,11 +576,65 @@ static struct hv_dynmem_device dm_device;
 static void post_status(struct hv_dynmem_device *dm);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
+				     unsigned long pfn)
+{
+	struct hv_hotadd_gap *gap;
+
+	/* The page is not backed. */
+	if ((pfn < has->covered_start_pfn) || (pfn >= has->covered_end_pfn))
+		return false;
+
+	/* Check for gaps. */
+	list_for_each_entry(gap, &has->gap_list, list) {
+		if ((pfn >= gap->start_pfn) && (pfn < gap->end_pfn))
+			return false;
+	}
+
+	return true;
+}
+
+static unsigned long hv_page_offline_check(unsigned long start_pfn,
+					   unsigned long nr_pages)
+{
+	unsigned long pfn = start_pfn, count = 0;
+	struct hv_hotadd_state *has;
+	bool found;
+
+	while (pfn < start_pfn + nr_pages) {
+		/*
+		 * Search for HAS which covers the pfn and when we find one
+		 * count how many consequitive PFNs are covered.
+		 */
+		found = false;
+		list_for_each_entry(has, &dm_device.ha_region_list, list) {
+			while ((pfn >= has->start_pfn) &&
+			       (pfn < has->end_pfn) &&
+			       (pfn < start_pfn + nr_pages)) {
+				found = true;
+				if (has_pfn_is_backed(has, pfn))
+					count++;
+				pfn++;
+			}
+		}
+
+		/*
+		 * This PFN is not in any HAS (e.g. we're offlining a region
+		 * which was present at boot), no need to account for it. Go
+		 * to the next one.
+		 */
+		if (!found)
+			pfn++;
+	}
+
+	return count;
+}
+
 static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 			      void *v)
 {
 	struct memory_notify *mem = (struct memory_notify *)v;
-	unsigned long flags;
+	unsigned long flags, pfn_count;
 
 	switch (val) {
 	case MEM_ONLINE:
@@ -593,7 +647,19 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
 
 	case MEM_OFFLINE:
 		spin_lock_irqsave(&dm_device.ha_lock, flags);
-		dm_device.num_pages_onlined -= mem->nr_pages;
+		pfn_count = hv_page_offline_check(mem->start_pfn,
+						  mem->nr_pages);
+		if (pfn_count <= dm_device.num_pages_onlined) {
+			dm_device.num_pages_onlined -= pfn_count;
+		} else {
+			/*
+			 * We're offlining more pages than we managed to online.
+			 * This is unexpected. In any case don't let
+			 * num_pages_onlined wrap around zero.
+			 */
+			WARN_ON_ONCE(1);
+			dm_device.num_pages_onlined = 0;
+		}
 		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
 		break;
 	case MEM_GOING_ONLINE:
@@ -612,19 +678,9 @@ static struct notifier_block hv_memory_nb = {
 /* Check if the particular page is backed and can be onlined and online it. */
 static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
 {
-	struct hv_hotadd_gap *gap;
-	unsigned long pfn = page_to_pfn(pg);
-
-	/* The page is not backed. */
-	if ((pfn < has->covered_start_pfn) || (pfn >= has->covered_end_pfn))
+	if (!has_pfn_is_backed(has, page_to_pfn(pg)))
 		return;
 
-	/* Check for gaps. */
-	list_for_each_entry(gap, &has->gap_list, list) {
-		if ((pfn >= gap->start_pfn) && (pfn < gap->end_pfn))
-			return;
-	}
-
 	/* This frame is currently backed; online the page. */
 	__online_page_set_limits(pg);
 	__online_page_increment_counters(pg);
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
