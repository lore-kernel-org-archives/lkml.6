Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826C5ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9932064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="qvLErrpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9932064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJ2HF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:05:59 -0400
Received: from nag.0l.de ([207.154.252.120]:33460 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbeJ2HF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:05:58 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNpEQvOZqIKB+uF8P0m8ZbJqX+PtvoPif/KGnamFfUk=;
        b=qvLErrpoR46oevlinV4BnIoNz65BXTDNvp/GzKym+K12NLS+8ZdggMiDwBzR7GVWS1pxoO
        Lm/aXBMuKCjaPed8hEmlyoj/jrbw/yPP7C/vK8XFGlLzN1DY5NauCD20NYmT0GH22+2hyB
        1/08dwgxxR20SaIoJ7T14zdwqeFIuh93FJBIH6RitiE480TghkXLOWPQy4TBoBktape86F
        w31ZP2KEMAbne3o0bDLH+UEm2lzmhz9aadxWUHI0WMSlzgUuYONO0r7BATNzJ2fMgmNkwn
        eaFEGyMwgjoEjLO+X81yoslUMTuX+FhGiYPe7PX4mDSyMBnSvhfGUY5PimBi3w==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH 6/9] w1: do not log errors about failed memory allocations
Date:   Sun, 28 Oct 2018 23:09:25 +0100
Message-Id: <20181028220927.56227-7-post@steffenvogel.de>
In-Reply-To: <20181028220927.56227-1-post@steffenvogel.de>
References: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764601; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNpEQvOZqIKB+uF8P0m8ZbJqX+PtvoPif/KGnamFfUk=;
        b=ErcAWlsXyjm+aGWbnNK5lJnasOchEibpAJlXK6VDLvcEOuC29Vwe/3/0oAR/eHyVXJCOgR
        3lbODm2hlOBZhiJVj/b2l/6EU4AKSYXI9rk2jK8HX/8qA6m+HA60xvZvYOocDC8x4YUNry
        dyqUGcgDeu6UQuIbbQQ/7SDjlzm0AHI1lEr40YINoqyvNZPfIr6kSjBOV+mJrnKTSepayE
        IFY+mhBDD5c2qQbDbCeAsBE+R9ovn6NxMVcDrzuMHchvfRcyumO1WldxoMRRwH1NsTef9z
        K0nSjJkBmimwxhgVpxWBp3YthrQ6hlgiCD8eOFDTNQvYFe/Y0L6I4u+EMHjBlg==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764601; a=rsa-sha256;
        cv=none;
        b=f1kzF196ISyoWIsEpJHb/wxYhhZytxxlIs/0EpkTErcErZP/jY59niet3NBLd4TREZ5oxipknWMH7yu3vQUxvkmjS+9bnoCc18U/v9kes4uPcLClP6KTQG6C/WBZHwvmiYrv6qycSU6yoDQ6HsZjq/DGk5wnDDocr9a9zCtbAoM9Yd+70m27hGCa72sszRUqsVF25wouOk7PFZiA2KAMYfGWNvQ8imbkfH1uVZViv1WhnV8aOx+3jRyLydUnZBAIQUNVsqaQ9uUM+igYdvEG82xnpyySQLXPGXXi3NuMuTC23jrJ2tEgA5OzmjyLqWvjdfx1SJy03k17CLcdSo4aSg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a warning raised by the checkpatch tool.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/w1.c     | 7 +------
 drivers/w1/w1_int.c | 6 +-----
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index bad2ee26cd4e..e8ce97e066ec 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -747,13 +747,8 @@ int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
 	struct w1_netlink_msg msg;
 
 	sl = kzalloc(sizeof(struct w1_slave), GFP_KERNEL);
-	if (!sl) {
-		dev_err(&dev->dev,
-			 "%s: failed to allocate new slave device.\n",
-			 __func__);
+	if (!sl)
 		return -ENOMEM;
-	}
-
 
 	sl->owner = THIS_MODULE;
 	sl->master = dev;
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 72b9392d9551..dd34d6a33f50 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -33,12 +33,8 @@ static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	 */
 	dev = kzalloc(sizeof(struct w1_master) +
 		sizeof(struct w1_bus_master), GFP_KERNEL);
-	if (!dev) {
-		pr_err("Failed to allocate %zd bytes for new w1 device.\n",
-			sizeof(struct w1_master));
+	if (!dev)
 		return NULL;
-	}
-
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-- 
2.11.0

