Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134DAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D432E20700
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoayY1Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfAHFIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:08:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54099 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfAHFIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:08:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so2829190wmb.3;
        Mon, 07 Jan 2019 21:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18QAWLA00yLBRYhbDWeCqa1PJ4zB9ywupFQ5k9+uPCc=;
        b=IoayY1Fb4jWRCNopeeCX8WoTdrFewjRtzTqFf4cryLaeOz86mFFcZUq3O8SHXWMXqr
         L6/TYvu9JpQnYxQOhIjYeEv+7GvialQmUQ+imBXePXNrPoh40/0M1FRs4aas2pTiLC22
         Hv9xE8ub8KQzsdQkF9FugTBppE/Qywp3Nv3ts66Y85mR7AbWH28eEKI26zSckOZnozbA
         MUCo3VMCI8CgC2aJ9edIrcMqp0dRZWX/V7HZf0sT49D5zTnSmxMa8C/o0Jqljf4qutQS
         WgzXbopFgeItPcSK3GUBD02/I21fAV+1ZXGNP3bO1UoeCEqKNMQxUnIMGNk0w/oCvyiA
         PCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18QAWLA00yLBRYhbDWeCqa1PJ4zB9ywupFQ5k9+uPCc=;
        b=Amy9n58sWjdZ0YKegQttAqCSidnyxzKHM2q0yKfJ3irM/iIYr6ZWKX6IO2E32OnFq4
         pbJkaCthS+D3NSgAU86QS9BO0zkoKZYi4QBC2+lchFGDrdLk/sv/UEMD8bCsMDRmT9Jn
         iwMpo6QIQPUxAvJyzlwScu7xGmQMvlk3+s09HdBy2WxcGCz7e0Y2EHiZXV2xoL3L7ZAN
         iO2+exITVE8MFrSYFRvo4Mj61spvw/SdctLopINSqpYYhovIb0FF5YcL0DxNZm76NV4N
         LJNiUY9lt3eGSIN7RRLvMpgsvA3KbzBrQ9o4SGqgmd50hgPLsOUUfF34+bGdTi2noZ7a
         cZRQ==
X-Gm-Message-State: AJcUukf9IxtuCrp+Dy3vQc1jahtngJKHIcItg6lQDuJl9YkRr/SI/Aux
        qvE7t9jLbh6QbZuJ2o0xjUY=
X-Google-Smtp-Source: ALg8bN6cHP8GGbSRbTutukUCi70uCw2HJRlGsVBflX1cI8oQiOIuGnI8UmVkW9PjbjPOv4JsISHstA==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr446182wmj.127.1546924077811;
        Mon, 07 Jan 2019 21:07:57 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y34sm151735604wrd.68.2019.01.07.21.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:07:57 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] isdn: avm: Fix string plus integer warning from Clang
Date:   Mon,  7 Jan 2019 22:06:49 -0700
Message-Id: <20190108050649.9962-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit in Clang expanded the -Wstring-plus-int warning, showing
some odd behavior in this file.

drivers/isdn/hardware/avm/b1.c:426:30: warning: adding 'int' to a string does not append to the string [-Wstring-plus-int]
                cinfo->version[j] = "\0\0" + 1;
                                    ~~~~~~~^~~
drivers/isdn/hardware/avm/b1.c:426:30: note: use array indexing to silence this warning
                cinfo->version[j] = "\0\0" + 1;
                                           ^
                                    &      [  ]
1 warning generated.

This is equivalent to just "\0" so fix it to clean up the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/309
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/isdn/hardware/avm/b1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
index 4ac378e48902..7fa8141e2019 100644
--- a/drivers/isdn/hardware/avm/b1.c
+++ b/drivers/isdn/hardware/avm/b1.c
@@ -423,7 +423,7 @@ void b1_parse_version(avmctrl_info *cinfo)
 	int i, j;
 
 	for (j = 0; j < AVM_MAXVERSION; j++)
-		cinfo->version[j] = "\0\0" + 1;
+		cinfo->version[j] = "\0";
 	for (i = 0, j = 0;
 	     j < AVM_MAXVERSION && i < cinfo->versionlen;
 	     j++, i += cinfo->versionbuf[i] + 1)
-- 
2.20.1

