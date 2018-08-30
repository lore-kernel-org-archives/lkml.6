Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFA2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403E6204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq3sFlwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403E6204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeH3FrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:47:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43102 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3FrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:47:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so3102651pfi.10;
        Wed, 29 Aug 2018 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dyn7GN8lH5UuIRP6OFnVsQ6loTA5lg0n6k2ZgI8W43s=;
        b=aq3sFlwQjigxUDonF4Ym+BX73IC3o5IwsKymldWVJvLhafHKQu+7JRMDHG5R/fkAGw
         ZnGMLUBeC8MV6yp9T20f1RzjnLGLE6RoldGOBzLF7ZcvgB/skRfGuE6o5j+1PnM3PhwR
         b5uk4+/P3198/f4F/oKBCE/P90LfOw99aB24z291nJeqmTZmd1G3RzwdzCmz8nzB2pS8
         nh9ldxKUH6vFnd3/svcaGIhJhfAo65mX403CIbT36teRe6ibBXDqSYKb9cEXxmLO0boS
         TuW7+xktN+1n56l/8tmZ6BeeAbBFlSIESZ9uagYKkwdjxQYHydE9/GH4GT1HqUIDg2JL
         QbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dyn7GN8lH5UuIRP6OFnVsQ6loTA5lg0n6k2ZgI8W43s=;
        b=KUw3+AweH1gdxfQnRRSFbSVn9dOdAv8MtKoEdw/KNflLdM+JDJNhha40BLLFA++9Pw
         CISYtO0Rh+ok1bvB5/WhZOXo136EqQo28nNqHKeTC9znA8xV5+G1lByQQ5O1VpBSIX5j
         ybTfBnGSWEjDcQXVsfDTTMMqCr2ktat4xI8QG5lXl9LZ1PnRwpSr0LWgatcW341z6YFs
         QI3QnZi2OPcT8tTFlOHHpsj8pfwfZctqRzbnWty9xayLkQv+dJFZWp4vchqE8MC3QLHc
         84waO9JY3HkGK+/m9uAvvRSucDxctpecO7jqF/As4/RXnHNNdRjxhx1jTzYDFxe1mlOV
         sYAw==
X-Gm-Message-State: APzg51DOJ1PQBqkKLUp96uDQN2z9ogeowAW+VO0k8iOtqGTa9YlfwN8a
        MeAuKeeff3wCOyxanx7+ZLI=
X-Google-Smtp-Source: ANB0VdbYizxyiupdHl6Ze83b6InCh8t1o7o2LuHONANX9YSqio2cQIjp5UG3xvkI1xH92vXveA1ScQ==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr8416989pfi.2.1535593650815;
        Wed, 29 Aug 2018 18:47:30 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id f75-v6sm9916450pfk.85.2018.08.29.18.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:47:30 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com
Subject: [PATCH V2 4/4] USB: serial: f81232: fix bulk_in/out size
Date:   Thu, 30 Aug 2018 09:47:14 +0800
Message-Id: <1535593634-22004-6-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Fintek F81232 bulk_in/out size to 64/16 according to the spec.
http://html.alldatasheet.com/html-pdf/406315/FINTEK/F81232/1762/8/F81232.html

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 863430d7535f..e3ab1646a693 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -785,8 +785,7 @@ static struct usb_serial_driver f81232_device = {
 	},
 	.id_table =		id_table,
 	.num_ports =		1,
-	.bulk_in_size =		256,
-	.bulk_out_size =	256,
+	.bulk_out_size =	16,
 	.open =			f81232_open,
 	.close =		f81232_close,
 	.dtr_rts =		f81232_dtr_rts,
-- 
2.7.4

