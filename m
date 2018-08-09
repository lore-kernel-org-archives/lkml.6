Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4069FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84F821E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLvyrI2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84F821E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeHJBjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:39:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43804 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeHJBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:39:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id f135-v6so5272667lfg.10;
        Thu, 09 Aug 2018 16:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PRu/WH3UfsbVfxNrOd5qm0di6r14wGa6ruxSLvmGvrA=;
        b=BLvyrI2w71Bbt8HCYBPwIZE+IHVn8FTbE7EPg687uqxrXfU1PxjkwHDnEeespaf0x5
         9z56DbKQExi5ouSMAcpK52otXKNoIr3nrAT40g08f+NQKQKH4c7+x+Jdzd05BsosXmuY
         epEFMdA2iDcys91RWeg9BPaJ6PtKuHWGAe3LzUos0tA91Qkh4pu0mD7x1I60r5KnsbkT
         r8B6kwObiGA3I4wtwLuRJl5Su2a4T8KMhEEGF1Kc2mRKMxtrQJv1xaq4d4C3kQBWeN8Z
         PEQbLzxf7lo/2pkd3tGuILq9+LsVTGKpYa93pu7fmiC7kQsaQybI7vyurzs3B8umMzv+
         P5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PRu/WH3UfsbVfxNrOd5qm0di6r14wGa6ruxSLvmGvrA=;
        b=dQ9QuKNcc/bsq2s7/J3yIRZPR7AGgASbAFzIXPGHDq1+N3CubkL659yh0G+nmiJlYm
         lovO0p91BGWjY20NxataBsm6UZi1vtVw8o1LGSAug0ayCD/1oLFjBXGwswPiOcQ+x0W+
         JKaEoY/7Rz1Gd+nSoulyxhVmBkw2Rh35IXCmVUW02/9Glxw46NZIOh0H1IjVBfTN2ewz
         wnuQ1pUDXse7Un1hXut+E38Ih3QuN6nLjMvMYhQvcuQCqUEFmJJdU3oTzyRNvNiaxP7a
         U9uqUKw4jos3yPb/kNxJMPOKn2/YdFHA0npocworZMUXhDLGHOyzeSYzincltV+WWpM5
         tPyg==
X-Gm-Message-State: AOUpUlEjcBho324AhL4AS5eihXhv4RgtfBNwbJghFSIvuh8dUWlkkXfn
        oF/o+8jUbaGvzawhlZQIumY=
X-Google-Smtp-Source: AA+uWPww8D9HzZlQqeLui4IpnjGTu2HxJdRXdUvEzUv6LN7qkNXTWKz5BTNUJUsXSklN8YcmFxHDIw==
X-Received: by 2002:a19:93d2:: with SMTP id w79-v6mr2968971lfk.20.1533856352982;
        Thu, 09 Aug 2018 16:12:32 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v9-v6sm1352177lje.20.2018.08.09.16.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 16:12:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: Ignore clients initialization failure
Date:   Fri, 10 Aug 2018 02:12:11 +0300
Message-Id: <20180809231211.26182-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From time to time new bugs are popping up, causing some host1x client to
fail its initialization. Currently a single clients initialization failure
causes whole host1x device registration to fail, as a result a single DRM
sub-device initialization failure makes whole DRM initialization to fail.
Let's ignore clients initialization failure, as a result display panel
lights up even if some DRM clients (say GR2D or VIC) fail to initialize.
Actually VIC fails if initramfs misses the firmware file, so with this
change a serial console isn't needed anymore to figure out why display
isn't working.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: Added WARN_ON() that should get more attention than just a error message.
    Made clients_lock to lock around the lists modification, that is in line
    with the rest of the code.

 drivers/gpu/host1x/bus.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 815bdb42e3f0..07bb6b6c1260 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -199,19 +199,23 @@ static void host1x_subdev_unregister(struct host1x_device *device,
  */
 int host1x_device_init(struct host1x_device *device)
 {
-	struct host1x_client *client;
+	struct host1x_client *client, *cl;
 	int err;
 
 	mutex_lock(&device->clients_lock);
 
-	list_for_each_entry(client, &device->clients, list) {
+	list_for_each_entry_safe(client, cl, &device->clients, list) {
 		if (client->ops && client->ops->init) {
 			err = client->ops->init(client);
-			if (err < 0) {
+			if (WARN_ON(err < 0)) {
 				dev_err(&device->dev,
 					"failed to initialize %s: %d\n",
 					dev_name(client->dev), err);
-				goto teardown;
+
+				/* add the client to the list of idle clients */
+				mutex_lock(&clients_lock);
+				list_add_tail(&client->list, &clients);
+				mutex_unlock(&clients_lock);
 			}
 		}
 	}
@@ -219,14 +223,6 @@ int host1x_device_init(struct host1x_device *device)
 	mutex_unlock(&device->clients_lock);
 
 	return 0;
-
-teardown:
-	list_for_each_entry_continue_reverse(client, &device->clients, list)
-		if (client->ops->exit)
-			client->ops->exit(client);
-
-	mutex_unlock(&device->clients_lock);
-	return err;
 }
 EXPORT_SYMBOL(host1x_device_init);
 
-- 
2.18.0

