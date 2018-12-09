Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5F1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7E720661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7E720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeLIWRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:17:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37204 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbeLIWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:19 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73O-0002iZ-Jp; Sun, 09 Dec 2018 21:55:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003G7-RF; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Greg Kroah-Hartman" <greg@kroah.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Lukas Wunner" <lukas@wunner.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.569368809@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 050/328] PCI: hotplug: Don't leak pci_slot on
 registration failure
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 4ce6435820d1f1cc2c2788e232735eb244bcc8a3 upstream.

If addition of sysfs files fails on registration of a hotplug slot, the
struct pci_slot as well as the entry in the slot_list is leaked.  The
issue has been present since the hotplug core was introduced in 2002:
https://git.kernel.org/tglx/history/c/a8a2069f432c

Perhaps the idea was that even though sysfs addition fails, the slot
should still be usable.  But that's not how drivers use the interface,
they abort probe if a non-zero value is returned.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -457,8 +457,17 @@ int __pci_hp_register(struct hotplug_slo
 	list_add(&slot->slot_list, &pci_hotplug_slot_list);
 
 	result = fs_add_slot(pci_slot);
+	if (result)
+		goto err_list_del;
+
 	kobject_uevent(&pci_slot->kobj, KOBJ_ADD);
 	dbg("Added slot %s to the list\n", name);
+	goto out;
+
+err_list_del:
+	list_del(&slot->slot_list);
+	pci_slot->hotplug = NULL;
+	pci_destroy_slot(pci_slot);
 out:
 	mutex_unlock(&pci_hp_mutex);
 	return result;

