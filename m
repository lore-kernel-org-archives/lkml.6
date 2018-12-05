Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772AFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5ED2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYe9eSxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5ED2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeLEVN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:13:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34360 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeLEVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:13:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so18285264ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=IMLARoIa3Yz+W3sDU4jz4bfmx64s4C98F6yoB/esx1g=;
        b=JYe9eSxCbW1H8LYRDJvcG5LXg+Xamr0KV/5cUaOTNe/nWiWnJUYaw7A9NM/j/FRsFX
         YRznBTlnKD0hq24syuDouULehUZjZ2IXuB8g6aom0B0nhyD2ong05INBF4+ENYYiNPyJ
         ahpnH4AG/n12a5h3kmIOk/xTuBkEGJ+zs4CRhpuwH7yfkgRGSkUYPwNqwDr8aSbnbsUM
         BDmGuUiPQQ1Jxm6QyBd+m9aWn9KSegj1SpYrYMxdOFjH7YZzLGeS7UACMD0uQMvRpa/X
         lNm3BcyGGG+sWfLWffLbxLSVHsJp8zghZWTUTqKof4Jo5bPDGAMt7PVZUVxEk6UPN39Y
         vODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=IMLARoIa3Yz+W3sDU4jz4bfmx64s4C98F6yoB/esx1g=;
        b=l5P3Nh/XcfY/HRjBIbN9a5t/V8yd1SUgOJski9nesj6dDKvmwtR/ndM4iM1gYbgYZU
         reiSUF8LsI1+aARht6UbWfOboNqb/t8mhMXEUfAto/jvFomJr+9cTQ4rfSXJHBH4l3iO
         tU8rAZr471QxJ4uZKAj5BR2dRDLIHjUhwLnMVuYwQ1Mk6M40OQFoZew4ORvejCK6K8oz
         h1cBbDhCwmvF77suwuA1UWOfC1mLqKib42IvHUi9eSLdc0v4RX2FGCLn+PPatK5F52go
         AZ13282a5JbYB7juo58oNf+KGomOfAZ6rGEtXPcfw/bgivO075iw1iEWWRoSIunBu9tA
         zMvg==
X-Gm-Message-State: AA+aEWZfRGg5h5cRCtO1k6on8RZX0DNY0wau2dfzYJKQep2tn+65Lmiu
        dCPEhCAo1WTQ6AlijHJzihA=
X-Google-Smtp-Source: AFSGD/V+OxBJWmJMSLb6gomApSCTaucp/wIi1mV5V/5KQnkHXPmm01MWuW0jhhqCpXrr7UtNPOz4rQ==
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9-v6mr20098676ejh.236.1544044435971;
        Wed, 05 Dec 2018 13:13:55 -0800 (PST)
Received: from dell.be.48ers.dk (d51a5bc31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3252924ejz.70.2018.12.05.13.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:13:54 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peko@dell.be.48ers.dk>)
        id 1gUeUU-0001Ot-44; Wed, 05 Dec 2018 22:13:54 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Cc:     Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for UUID"
Date:   Wed,  5 Dec 2018 22:13:51 +0100
Message-Id: <20181205211351.5309-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 712ff25450bd01366301eef81c33e865d901e7b7.

The output of dmi_save_uuid() is exposed to user space as
/sys/devices/virtual/dmi/id/*_uuid, so this breaks backwards compatibility,
E.G.  I have systems that include the content of dmi/id/product_uuid as part
of the keyphrase for cryptsetup luksOpen.

As the change was purely cosmetical, revert it to fix such breakage.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 drivers/firmware/dmi_scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 099d83e4e910..2ed51651565f 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -211,9 +211,9 @@ static void __init dmi_save_uuid(const struct dmi_header *dm, int slot,
 	 * says that this is the defacto standard.
 	 */
 	if (dmi_ver >= 0x020600)
-		sprintf(s, "%pUl", d);
+		sprintf(s, "%pUL", d);
 	else
-		sprintf(s, "%pUb", d);
+		sprintf(s, "%pUB", d);
 
 	dmi_ident[slot] = s;
 }
-- 
2.11.0

