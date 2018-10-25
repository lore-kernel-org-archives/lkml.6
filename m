Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15060C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22E22082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtU9xhS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22E22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeJZEK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:10:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZEK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:10:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so10537659wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcp9mvv9nBmNO4dsscPgnoiWKk0gQuM1wRbUL7m4l0s=;
        b=gtU9xhS+4hl2nrab/TyUaWqQ+ho/beIg1IJENN+DqUai237Bg+w97IkKlr207xc227
         C/v3BuZs9gXPtd98cFUtkru8MlfZqbCPC5mfyV96lxD9mCFRlFEJyth7CBlvj3+Lw2V0
         IaNUzPbRhgT1QkRmkIZT+Z9Hy92Fw3DkcjDj5BHR39B3mrguPenGMAoNG3nrZs4KMQtO
         vLUTAm8eAt0tLfSVCNNsdSCtoolGx5cgjSR1K5ohzgnDloD7dLgnlUKNwQBHuwnwcMqt
         S2U8XkWAIszyANc5TGlyxBwOYzdpG9who0W5ROr7pQOJr86w376kPtXU/VlbMtcaGk6Y
         GY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jcp9mvv9nBmNO4dsscPgnoiWKk0gQuM1wRbUL7m4l0s=;
        b=rrY7YwojyNim2r9f5IVp2iAwJHP3hVebBrxyoGIcLBx3qkLhrS1wLrBQsAhtTBVHvs
         HWcgRNN7stRkGtyIN/OkCngZkITLcfATJbP11Wo2aY5bA/U0zFPe1HnaAh6OGMNPzY8n
         CJ9sCsvQKv0bceN5Lr8E7clvmZo/ptGv5sv1qHl2pEQ0mDX61Wu6AIcwwi8kEHaSE346
         eooBtautNrGOqS2dfrAD35MZAV+q5BI+/6jybs7YnoRl2aU3Jg9BLi1lVXBKRTUvrvao
         pFa78QYbiFgYQ736D0TK8+L96TzAc7LMKW2WYdVfFTM7gjy5L5P40ik7fi0klLn5hzB/
         ATlA==
X-Gm-Message-State: AGRZ1gLAiTeBIZHNxzQQAjBVdtZSOnI9dwTBVmd4/NxOrRKYHa4Q+B37
        w1QTxAhxYaqcwe/rMxZxOBM=
X-Google-Smtp-Source: AJdET5dCuMgckC5FcD9H/n0lxo9mI+LJbCR1JCk/0UMP5mx/jP8IuvPoWEkw2fPUZNhVPDsolnOemQ==
X-Received: by 2002:a5d:4182:: with SMTP id m2-v6mr3422827wrp.8.1540496179603;
        Thu, 25 Oct 2018 12:36:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p125-v6sm2455871wmp.2.2018.10.25.12.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:36:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915: Disable -Wuninitialized for intel_breadcrumbs.o
Date:   Thu, 25 Oct 2018 12:36:01 -0700
Message-Id: <20181025193601.11746-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning is disabled by default in scripts/Makefile.extrawarn when
W= is not provided but this Makefile adds -Wall after this warning is
disabled so it shows up in the build when it shouldn't:

In file included from drivers/gpu/drm/i915/intel_breadcrumbs.c:895:
drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c:350:34: error:
variable 'wq' is uninitialized when used within its own initialization
[-Werror,-Wuninitialized]
        DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
                                        ^~
./include/linux/wait.h:74:63: note: expanded from macro
'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
        struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
                               ~~~~                                  ^~~~
./include/linux/wait.h:72:33: note: expanded from macro
'__WAIT_QUEUE_HEAD_INIT_ONSTACK'
        ({ init_waitqueue_head(&name); name; })
                                       ^~~~
1 error generated.

This warning looks to be a false positive given that init_waitqueue_head
initializes name before it is used. Rather than disable the warning for
the full folder like commit 46e2068081e9 ("drm/i915: Disable some extra
clang warnings"), just disable it for the one problematic file because
it could be a useful warning for other cases.

Link: https://github.com/ClangBuiltLinux/linux/issues/220
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/i915/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 1c2857f13ad4..f36c420afb99 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -26,6 +26,7 @@ subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
 CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
+CFLAGS_intel_breadcrumbs.o = $(call cc-disable-warning, uninitialized)
 CFLAGS_intel_fbdev.o = $(call cc-disable-warning, override-init)
 
 subdir-ccflags-y += \
-- 
2.19.1

