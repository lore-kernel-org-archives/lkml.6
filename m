Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89425C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC632170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC632170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeHZK3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:29:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeHZK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:29:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0808325A;
        Sun, 26 Aug 2018 06:48:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH 3.18 55/56] PCI: hotplug: Dont leak pci_slot on registration failure
Date:   Sun, 26 Aug 2018 08:45:16 +0200
Message-Id: <20180826064234.924352726@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org # v2.4.15+
Cc: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pci_hotplug_core.c |    9 +++++++++
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


