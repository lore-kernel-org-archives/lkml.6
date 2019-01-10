Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82C8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E50D206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVIziZOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfAJFma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:42:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51287 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfAJFm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:42:28 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so9976721wmj.1;
        Wed, 09 Jan 2019 21:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+/Zbi6zEL0OBRO5mltxI7+vObSFQp+JULbs9Uzhlcc=;
        b=MVIziZOYY1qsduDoCJlRGrZ3arIjV1Wq/8oFVzZO9YJ9FRJBharqwFnzuNCcf4PYJY
         HkLHq3dsMTqMWFJfFru1g/7/+wfTIBJtqG5RjilRooa1kKIPYw1vTBuNkGdXDx96Yg3I
         Mlh9EoGv3U4FAsIkuSpa/OytuqtSL9qXy3uQFQBknBx4REhO63scxXW30aDAzLagJ5IT
         3QHpk/2ZMzNkL+lhZFijQDtBHMeZZPdvZbWDCALhDPuZ4P4v57FDiI+IhYtZRy6xMq1V
         qXC7wE5bfIArYthvR5NQq8lwr/lTbkls/emFQxS+zAHx9Sy7aIhLfBPIVNmSq17ukWP7
         gDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+/Zbi6zEL0OBRO5mltxI7+vObSFQp+JULbs9Uzhlcc=;
        b=KhFx9jtVxKDlNQx7hGOgq8mbBzFWyjEwwVRyXJhKtYoijbt9lN4R8gK9puWzsGft1U
         MUYUFcc7N5QBScwIV3ruzNV+V2rQbKh3E8ZHo7zKQ2JHygdv/6RMX/mVlRTfAvremlki
         aztmAOECRcJJr+JcHz19x5x7gCYPaycIhq5404psW3WY5VbrnWhJCOw5fdiajmMSNpUn
         YBJUW1wpgJzFxuXHqahiWAVcOrmjzSL6SUa58RDdO0uhen8vOcQ4m5j/WJeiq5Z8CXTz
         ysvAPHaupgxy1GGd1uRkOAG4JcZ2fKMHO8myyIQXGvyWli2wJNqdDHz64ML6/gU7SN86
         l2ew==
X-Gm-Message-State: AJcUukfYmD73GgsGIdPEYFHU3Bp7RCQ4DC3HNTCUoNGsv9ZHsW4e+qam
        mxBqfkJsEq8VpzyDCpixhp4=
X-Google-Smtp-Source: ALg8bN5kTffYYX0op16vk5C2d6fXx1rbgvx7okSKHiEUsfUXRrL2PpHcir+DRps3ohWhJ2Pb9viVmw==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr7969090wmm.52.1547098944941;
        Wed, 09 Jan 2019 21:42:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w125sm20434809wmb.45.2019.01.09.21.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 21:42:24 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] isdn: avm: Fix string plus integer warning from Clang
Date:   Wed,  9 Jan 2019 22:41:08 -0700
Message-Id: <20190110054107.6069-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108050649.9962-1-natechancellor@gmail.com>
References: <20190108050649.9962-1-natechancellor@gmail.com>
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

This is equivalent to just "\0". Nick pointed out that it is smarter to
use "" instead of "\0" because "" is used elsewhere in the kernel and
can be deduplicated at the linking stage.

Link: https://github.com/ClangBuiltLinux/linux/issues/309
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Use "" instead of "\0", as they are equivalent, but "" can be
  deduplicated by the linker, as pointed out by Nick.

 drivers/isdn/hardware/avm/b1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
index 4ac378e48902..40ca1e8fa09f 100644
--- a/drivers/isdn/hardware/avm/b1.c
+++ b/drivers/isdn/hardware/avm/b1.c
@@ -423,7 +423,7 @@ void b1_parse_version(avmctrl_info *cinfo)
 	int i, j;
 
 	for (j = 0; j < AVM_MAXVERSION; j++)
-		cinfo->version[j] = "\0\0" + 1;
+		cinfo->version[j] = "";
 	for (i = 0, j = 0;
 	     j < AVM_MAXVERSION && i < cinfo->versionlen;
 	     j++, i += cinfo->versionbuf[i] + 1)
-- 
2.20.1

