Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C942CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84890208FA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwN5kjXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84890208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeGCGwN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:52:13 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42633 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeGCGvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:51:44 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so502317pgu.9;
        Mon, 02 Jul 2018 23:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0qcgsC/nOB72p/BlSDBRNrZW7QvDpARz7p33AuGiHQ=;
        b=gwN5kjXEb7A1aCEEgS/9KWn/ZpZNC/JdunGRP1vnX0chizwjYLi6/Bx7RJ4PA4sLzV
         32gNLbeOofU/h54TDqpImxQVTrwQGq80nUdyOL+AOFw7uQgA79ofrQZBlTsZ4AnqX5MC
         E2T8Bv1PzejxT/JfBiFfL2rLYG6TIp71D2TIxql9prUfFJdkjBt1TlhfhuKMkEt5f/pu
         cDbKvh48xI9ParIixijmTCRkjZ4UzjvS/CwTj2R0x9o7xwzSGHHcIGagj31gi0Eq8btf
         WxoRDKVAKox74/zZlwxkiMAjFSgzKXUTPCIcijPnrlOg2Bed3Xw07eAD2hDrKk1l3Cg1
         fVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0qcgsC/nOB72p/BlSDBRNrZW7QvDpARz7p33AuGiHQ=;
        b=L8j9dLGweU6Hp7HQlIZhcefeSPcSJB7xw/V6MKmO9BykjMVxo2BC4mEh2bbZ9MUlkR
         pLE5PJxfdeOcdzJwKUUKq6Qp+SZLXmn/yMLB4opy4GeHhGrjSY+f+Gnk3ZRQEkWe2HFH
         e0ElFfw6sX52IUrgV1++KZQ/EDxCfA6Jd57fdWmdOxmHBaEc0xac6RpAJTfo+SKJHAPI
         uxhQXJEbE75Zq5WaDyt6OY9HXm9rAcJg/0hbhuoVtgxWuLAICFFeYAqKB2F588CTjKCy
         4GKD4vJGutaZ8/pbvzGDPBK1ANFkmskcSFKycIP19UPNKxQxADDEKGHKT8X9WCFZkKIT
         /LQw==
X-Gm-Message-State: APt69E2Oap2QukmBynS4mzN6ECmAKPiPKwZsoU2w/0vpFTk7gsLzMWMj
        0LNqFm/qHJcu1608CPm+op5R
X-Google-Smtp-Source: AAOMgpc8we1A7tpNoH7LXfsSvOG5VjIN+I6r6hsXSi64Ui8JTgJYGfi58fw6A8n+svczuGgzGsKB7Q==
X-Received: by 2002:a63:2581:: with SMTP id l123-v6mr24239534pgl.226.1530600703667;
        Mon, 02 Jul 2018 23:51:43 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e189-v6sm981122pfe.52.2018.07.02.23.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 23:51:43 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 3/4] drivers/base: clean up the usage of devices_kset_move_last()
Date:   Tue,  3 Jul 2018 14:50:41 +0800
Message-Id: <1530600642-25090-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
correct device's shutdown order"). So later we can revert it safely.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 684b994..db3deb8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
 
-	/*
-	 * Devices that have not been registered yet will be put to the ends
-	 * of the lists during the registration, so skip them here.
-	 */
-	if (device_is_registered(dev))
-		devices_kset_move_last(dev);
-
 	if (device_pm_initialized(dev))
 		device_pm_move_last(dev);
 
-- 
2.7.4

