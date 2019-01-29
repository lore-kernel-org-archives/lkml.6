Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83809C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DF020844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MlUozkQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfA2Sya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:54:30 -0500
Received: from mail-yb1-f197.google.com ([209.85.219.197]:35923 "EHLO
        mail-yb1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfA2Sy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:54:29 -0500
Received: by mail-yb1-f197.google.com with SMTP id 63so5413932ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G0epUqFu3AmCTsfTCZBWyuwLgZxvATnBae8HP0ixIfc=;
        b=MlUozkQMHxb5n/jPhkS4DTcTd4VsaPbttFo5x9eWIG8pksOUrzuTaW5m3iXV/mtKf/
         Y+9hTZdImQ2UdWUsejIhnp0zgbQ/Kp6z55CLpGu4Qc9zI+8hQXt7d9EgBJBfGmLDdRrV
         5jqbFq7ZYI3mp9uzYqL/v3dhYRegKkXLCNxvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G0epUqFu3AmCTsfTCZBWyuwLgZxvATnBae8HP0ixIfc=;
        b=moMS5jUpE57e9zvguG+gGq4Z2AeNQ6HihNXzy/vpUklaQbeDAR3Bkc5bXqApUQ7GYU
         7PjZMlJtYwSf93x5AUWd9EcDCUGrkRdsH1TGUYsU71Fh9SLv4U2UUm52L5pTX1oMg72G
         VtM8aV4ZYoT/yEQGS1t6mMFQlcXxOhBmtfpLGhkI593ccK6r5ToWRssYx0fS8RGtwamP
         yGktq4WMDXUMK67iJJoeqSHErN5d60yWWrlepg7k5DG3LSvZyfyFR+h5G/yMy1mrprTj
         ZIduUnFLAsnwrBcG8hj9Hc8WrwM/3sRzhJaGuIjc27n4XIvA5qCrkce+AUj/VvfBtgcN
         33nQ==
X-Gm-Message-State: AHQUAuZL4jttqR3A60vwoAkYwPT9vQ8sH/1dCqQ3msyU+vvrs4T1Hmg1
        0QmNZyTDiYp2R9kJscGOBf2fSEMHF6fThKj9
X-Google-Smtp-Source: AHgI3IYuvkCaYCMYauiy4MF48g2nOFC0MFUTa63C0CTHb56BRwsat5DJrrNduvdch+8ZPCiFAxixBi2AOH0e66LH
X-Received: by 2002:a25:ca11:: with SMTP id a17mr2633199ybg.43.1548788068983;
 Tue, 29 Jan 2019 10:54:28 -0800 (PST)
Date:   Tue, 29 Jan 2019 10:54:24 -0800
In-Reply-To: <CAJ-EccMgDvx81g-XgWymdYn_G5Ou8mgbef3GUbx-C_Ai5qF-pQ@mail.gmail.com>
Message-Id: <20190129185424.251139-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <CAJ-EccMgDvx81g-XgWymdYn_G5Ou8mgbef3GUbx-C_Ai5qF-pQ@mail.gmail.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] LSM: SafeSetID: 'depend' on CONFIG_SECURITY
From:   mortonm@chromium.org
To:     rdunlap@infradead.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Micah Morton <mortonm@chromium.org>

This patch changes the Kconfig file for the SafeSetID LSM to depend on
CONFIG_SECURITY as well as select CONFIG_SECURITYFS, since the policies
for the LSM are configured through writing to securityfs.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/safesetid/Kconfig b/security/safesetid/Kconfig
index bf89a47ffcc8..4f415c4e3f93 100644
--- a/security/safesetid/Kconfig
+++ b/security/safesetid/Kconfig
@@ -1,5 +1,7 @@
 config SECURITY_SAFESETID
         bool "Gate setid transitions to limit CAP_SET{U/G}ID capabilities"
+        depends on SECURITY
+        select SECURITYFS
         default n
         help
           SafeSetID is an LSM module that gates the setid family of syscalls to
-- 
2.20.1.495.gaa96b0ce6b-goog

