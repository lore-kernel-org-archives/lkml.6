Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE9BC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKn2b99R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9693E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeH3AfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:35:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51170 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbeH3AfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:35:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so6529598wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EXoCUCieFeLBolGpHqFnnrhfapWEibSj9fnmSNclOfY=;
        b=eKn2b99R2dBObCh5J/VA9Awdnh5vdeopx/4vOapR47OeUDNovKmQjizXpqF5KgvQGz
         nWM76yV2b3ktLML80ZBHBl/UsquRnUainT9UA4hlKUj41yMJEEKReLYlWy6Fs387k7lm
         X9ZsLF5G6As1vqwfnfnD6sZQTQrg8+9lWOGFbDJklEaR+ASEmlyARWzIiU5s1Xr6clD1
         yoP52u3yaVopPMR758mPVdCeQAhl+DlAVI16yqT5YTQxs58cjlR+L+hweUzV+PC5Z+Yi
         2yM1VZHQ8N1HwxEuWOp7+M1YUziKlK6qpoWJjWqelaHPB/juceNFpQ+qJeKvZ5kT6RNC
         bAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EXoCUCieFeLBolGpHqFnnrhfapWEibSj9fnmSNclOfY=;
        b=iJmnoTvOdbHZ2N4ln9U/4EW5o+hO+62DY0oQ3W0/XkFU4hKjpG8jBdPX3R1EmnxXjz
         LNwUg5vvUEL4sahpryscyA8dV3WkqhLhT75MFZYbBBoLWBHAv2bq0y6v+8zmD8vinKLj
         R+YemNcOLx9zFvPwL5YjINdmZ1E7Q5/U8VWiKLUmgBi3iMXLVen7tSkKJwOYoHhjYTqa
         2kvZTx+OGfCH7o/yqgQsJpEkvE6Jl786ZOug+qAH/UghbiCe4uk/sfJRPmFbuMx86aGz
         A4Nb88SOk1WRaa4d1wDu44O0nF8ZoJjDX7dcd1bmnDrvXur+nmZXeZ4Tl01xrPXIodT/
         k7rw==
X-Gm-Message-State: APzg51B0ND2EPwHWSrCcXaD5tOaz4izO6Qh8nLuD73IQ+6BhbPbYdJ0e
        omfEGIiSXfMMFVfI64ofurY8kPwPHgc=
X-Google-Smtp-Source: ANB0Vdb6icqCcju1ippLLF1N5xUJHG9s+U1JmwQs3SpFB8HYZHINnmyvSHPJzUMPmIOnQVu9yPMy0A==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr5333325wmd.69.1535574992935;
        Wed, 29 Aug 2018 13:36:32 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:36:32 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 21/21] staging:rtl8192u: Rename ASCap - Style
Date:   Wed, 29 Aug 2018 21:35:47 +0100
Message-Id: <20180829203547.15650-22-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829203547.15650-1-johnfwhitmore@gmail.com>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable ASCap, as it causes a checkpatch issue
with CamelCase naming. The member has been renamed to
'not_used_as_cap', since it is not actually used in code, apart from
initialisation, which has been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index fa4c0ab43703..f46d7f3ed7e4 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -69,7 +69,7 @@ struct ht_capability_ele {
 	u8	not_used_tx_bf_cap[4];
 
 	//Antenna Selection Capabilities
-	u8	ASCap;
+	u8	not_used_as_cap;
 
 } __packed;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 3e2172b6008b..a1fb971f737c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -599,8 +599,6 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 			pCapELE->cap_mcs[i] = 0;
 	}
 
-	//Antenna Selection Capabilities
-	pCapELE->ASCap = 0;
 //add 2 to give space for element ID and len when construct frames
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)
 		*len = 30 + 2;
-- 
2.18.0

