Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C99E24788
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umf6TeNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99E24788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeFYFXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:23:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35170 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeFYFXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:23:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so6261644plt.2;
        Sun, 24 Jun 2018 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2PgFlR5DMr1n4DFmL2/H8moGaIFk/PpLJOyse2SJBv4=;
        b=umf6TeNz8pdVNSjULAQ780+NK6Itk49rDOHKSz7YIR+WjivI3EPRuYcAVznP5lLHAC
         MBCFdxAXREokKGKd7xDVdKzhAm0k9pfOtFa+U0HssAz6Yn6lignHjW2eTxl08xGKruj7
         RoDuxe6nsYvEMhf3YrWIe6DdkJ72Toai1/EryITFGUkQAm1m8tOih597lD/A/cVCww6c
         pglvHxN54IC6sh/+pRLCRvqjc9glNGrTOTZW8fXwBT37peq9R1RbxjAlNXUARMy1O+XW
         23quwSBtxrUOAEZ3HNwM0cvKJIyglRGHBPXIZM4tM6HFrg4rUXaUOR+FYqHZi/PNhqzP
         KkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2PgFlR5DMr1n4DFmL2/H8moGaIFk/PpLJOyse2SJBv4=;
        b=iwOGUoxr17UUXn4McJD6XohXjZOFKeGQz3fRNeerN/1ASpasI4+SS6UsmthJbZ9q3N
         y8w8Q2/jJyz/+ivjnvHzHQYoCVYeTRpR6A9kVtezsIs2yrxbcqG0UKfAiD1YHkHovGdo
         QP4KX9pWR3HJrcIIFavKJKjVJeeQpevHj482NsGrQ4UPOH2T+FPjXJiiC1mxbz0rmHXo
         rf5gTaiORNRoi0M6hiPSc2qw16gAqF1Z+JAfSbTXVxjf3aPQPKCkVKoX29LGZ/Hz/zNj
         tSNx93iadDxcHT7JA0/YiuqTKpaRU8a6koj376KKLHmZANhMsLj5zvH8DC+IxT4QnW27
         eE9Q==
X-Gm-Message-State: APt69E193wyNHKSBrJPz/PYk0cSZbhKfBMQZ6eG1nzoMJR/AY8pzYcUM
        H777Z5/fq2yNEUUgrysvDQZg
X-Google-Smtp-Source: ADUXVKJLsNj4bsfceFwgHnlLYF8MT9TTZMfziMsFLzWdmB/McK2tf1LaLSFJs1QVQj6zGXZOLhMCmA==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr10957060pld.118.1529904221664;
        Sun, 24 Jun 2018 22:23:41 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k71-v6sm1835936pga.62.2018.06.24.22.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 22:23:41 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] drivers/base: introduce some help routines for reordering a group of dev
Date:   Mon, 25 Jun 2018 13:23:05 +0800
Message-Id: <1529904187-18673-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
References: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce some help routines used by next patch. It aims to
ease reviewing, while the next patch will concentrate on algorithm.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 36622b5..8113d2c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -123,6 +123,44 @@ static int device_is_dependent(struct device *dev, void *target)
 	return ret;
 }
 
+struct pos_info {
+	struct device *pos;
+	struct device *tail;
+};
+
+/* caller takes the devices_kset->list_lock */
+static int descendants_reorder_after_pos(struct device *dev,
+	void *data)
+{
+	struct device *pos;
+	struct pos_info *p = data;
+
+	pos = p->pos;
+	pr_debug("devices_kset: Moving %s after %s\n",
+		 dev_name(dev), dev_name(pos));
+	device_for_each_child(dev, p, descendants_reorder_after_pos);
+	/* children at the tail */
+	list_move(&dev->kobj.entry, &pos->kobj.entry);
+	/* record the right boundary of the section */
+	if (p->tail == NULL)
+		p->tail = dev;
+	return 0;
+}
+
+/* iterate over an open section */
+#define list_opensect_for_each_reverse(cur, left, right)	\
+	for (cur = right->prev; cur == left; cur = cur->prev)
+
+static bool is_consumer(struct device *query, struct device *supplier)
+{
+	struct device_link *link;
+	/* todo, lock protection */
+	list_for_each_entry(link, &supplier->links.consumers, s_node)
+		if (link->consumer == query)
+			return true;
+	return false;
+}
+
 static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
-- 
2.7.4

