Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58995C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DED24788
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCkrnaVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DED24788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeFYFXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:23:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41240 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeFYFXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:23:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so5909218pff.8;
        Sun, 24 Jun 2018 22:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J6D5eN1+0fIt5/9Ceft+1VHrVFUjZfVeHhccJ811fjY=;
        b=bCkrnaVDE9PBFn/cu5FhPi5cZ4QZN5d0TkBLYz+ads1UPq/bnDmG4MQlhn/hqsSqVe
         jjn0/XbiLRwIgkN60BXPgwL+JbdCWeR6KSK3jpIStZKF8Y0AQjpTGMv2QAPwuTA1aB6P
         e8g6JNw0e0h4Z/HSdd0STsmks8NUInUNpkzB63JGKsGUXNn5Vakb6E36KyHbm5Qkfk1n
         HEMGgekzepxh1dfhQ0pkBTGt3M1LoCuync1fZy8NfJZuSYhEaaEeJRTny1SNoPFn4dii
         faXVT0RC6vkuZe4TU08hCbgqJsB4OTRyYYILEkpkPsfjpO92BYY8hWW3x+41aAt5EWc+
         MS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J6D5eN1+0fIt5/9Ceft+1VHrVFUjZfVeHhccJ811fjY=;
        b=F7Dl/xaS5A/wCvs6DA52iktAi5df1bOTkvXrrC4a5PauFXHOP3ErPZcT/VyL7JmPUE
         TcHTaWc0Foi6d66h0fhbrpBOWSrF99izWcq2c9SZGs4twpBZxywqLqXk0OYie6Ei4j96
         urgnRpRaqe7IH75dcSEvngqlN/HYH/cKiePVc+0vldysmaqXJgPSJS3FNaubWB9paBc0
         J4QVhRc5P3G1ni+OfF7yYcftetDLM2jxzxcb/67pctvn9JkJCYHr6/p5WXoU09vvKh0/
         xm9z9NYDlQOQKhIx2Gg7TBf+QA/vzS90I0ir5OmHQqnUjc4KGrT12gDR23Z1hwoXwZTV
         t1yQ==
X-Gm-Message-State: APt69E2wM3NSc6FZgXnr4rOeZzWbG39YRFEk4TivHZkxSjPVOFGMvVhX
        JfuFweT7dEd1gobv4N2xW/M3
X-Google-Smtp-Source: ADUXVKIfAYSNfiRhPrpVaNdbouR+VPG7nVV8Xi2FwNQvt+Nev+3NxsPiJgJlvSUPfMxzcN7QXr7r1A==
X-Received: by 2002:a62:da59:: with SMTP id w25-v6mr11489609pfl.161.1529904225149;
        Sun, 24 Jun 2018 22:23:45 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k71-v6sm1835936pga.62.2018.06.24.22.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 22:23:44 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] drivers/base: reorder consumer and its children behind suppliers
Date:   Mon, 25 Jun 2018 13:23:06 +0800
Message-Id: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
References: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
introduces supplier<-consumer order in devices_kset. The commit tries
to cleverly maintain both parent<-child and supplier<-consumer order by
reordering a device when probing. This method makes things simple and
clean, but unfortunately, breaks parent<-child order in some case,
which is described in next patch in this series.
Here this patch tries to resolve supplier<-consumer by only reordering a
device when it has suppliers, and takes care of the following scenario:
    [consumer, children] [ ... potential ... ] supplier
                         ^                   ^
After moving the consumer and its children after the supplier, the
potentail section may contain consumers whose supplier is inside
children, and this poses the requirement to dry out all consumpers in
the section recursively.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/base.h |  1 +
 drivers/base/core.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a75c302..37f86ca 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -135,6 +135,7 @@ extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
+extern int device_reorder_consumer(struct device *dev);
 extern void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8113d2c..db30e86 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -161,6 +161,103 @@ static bool is_consumer(struct device *query, struct device *supplier)
 	return false;
 }
 
+/* recursively move the potential consumers in open section (left, right)
+ * after the barrier
+ */
+static int __device_reorder_consumer(struct device *consumer,
+	struct list_head *left, struct list_head *right,
+	struct pos_info *p)
+{
+	struct list_head *iter;
+	struct device *c_dev, *s_dev, *tail_dev;
+
+	descendants_reorder_after_pos(consumer, p);
+	tail_dev = p->tail;
+	/* (left, right) may contain consumers, hence checking if any moved
+	 * child serving as supplier. The reversing order help us to meet
+	 * the last supplier of a consumer.
+	 */
+	list_opensect_for_each_reverse(iter, left, right) {
+		struct list_head *l_iter, *moved_left, *moved_right;
+
+		moved_left = (&consumer->kobj.entry)->prev;
+		moved_right = tail_dev->kobj.entry.next;
+		/* the moved section may contain potential suppliers */
+		list_opensect_for_each_reverse(l_iter, moved_left,
+			moved_right) {
+			s_dev = list_entry(l_iter, struct device, kobj.entry);
+			c_dev = list_entry(iter, struct device, kobj.entry);
+			/* to fix: this poses extra effort for locking */
+			if (is_consumer(c_dev, s_dev)) {
+				p->tail = NULL;
+				/* to fix: lock issue */
+				p->pos =  s_dev;
+				/* reorder after the last supplier */
+				__device_reorder_consumer(c_dev,
+					l_iter, right, p);
+			}
+		}
+	}
+	return 0;
+}
+
+static int find_last_supplier(struct device *dev, struct device *supplier)
+{
+	struct device_link *link;
+
+	list_for_each_entry_reverse(link, &dev->links.suppliers, c_node) {
+		if (link->supplier == supplier)
+			return 1;
+	}
+	if (dev == supplier)
+		return -1;
+	return 0;
+}
+
+/* When reodering, take care of the range of (old_pos(dev), new_pos(dev)),
+ * there may be requirement to recursively move item.
+ */
+int device_reorder_consumer(struct device *dev)
+{
+	struct list_head *iter, *left, *right;
+	struct device *cur_dev;
+	struct pos_info info;
+	int ret, idx;
+
+	idx = device_links_read_lock();
+	if (list_empty(&dev->links.suppliers)) {
+		device_links_read_unlock(idx);
+		return 0;
+	}
+	spin_lock(&devices_kset->list_lock);
+	list_for_each_prev(iter, &devices_kset->list) {
+		cur_dev = list_entry(iter, struct device, kobj.entry);
+		ret = find_last_supplier(dev, cur_dev);
+		switch (ret) {
+		case -1:
+			goto unlock;
+		case 1:
+			break;
+		case 0:
+			continue;
+		}
+	}
+	BUG_ON(!ret);
+
+	/* record the affected open section */
+	left = dev->kobj.entry.prev;
+	right = iter;
+	info.pos = list_entry(iter, struct device, kobj.entry);
+	info.tail = NULL;
+	/* dry out the consumers in (left,right) */
+	__device_reorder_consumer(dev, left, right, &info);
+
+unlock:
+	spin_unlock(&devices_kset->list_lock);
+	device_links_read_unlock(idx);
+	return 0;
+}
+
 static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
-- 
2.7.4

