Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C17C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ABA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HXuUj1zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbeLQQRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:17:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40208 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbeLQQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:17:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so14661294qtf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FdHHPYu6Z4XIuervt8zemJE+EzH7eEXPplMx1qOEugw=;
        b=HXuUj1zhPaVV2QXZdkWaYbIytPal51D7HIX7+6pxZqmoWWfrEVsjEh+KEEqv+ufbxM
         1oP99wZ1zP2H0M5JxVSxMJVkm5uNA16irF05FGgRWGepbH/D8SoIRwYC1az+gpqogHWi
         uOmSCPk3YOJpDoehwnW+xVrBicQ+ee7o2HWKR/LRuVYCkxEQZZX9t/gQGQWXBM9b33pr
         YwnJ2+CyzUXVHUgC7a8x87dVbi1cgA2GsD9+d0IhQMvv7+FCKqVkjQkIrxYMB42wdzZg
         fexqkqH+p4B9xZTYCiCirawEPObWQE9rqEJekyA13AdC2qGQlhPDukgWicQhzNoe286f
         tMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FdHHPYu6Z4XIuervt8zemJE+EzH7eEXPplMx1qOEugw=;
        b=rDNI/c6JMGfg5KOIx01FhwN949hKqxOy5kdd6VeN3E85ZVP6l2jjE3MYRnEpNSliHb
         5nbVZuMtPLBeFAf32VOcHCyeBZ2izYwJSgYoxZyHuzd81Dc0obJKiIjzBf7cNmnjVbVM
         pFKe9VhuMgi6VRPBuYR3FQo0MdrwqpqnZIeJtza+EzTI61Nqesh/CPWwtUv7QqI/t4kR
         ALiubF0R4F1LolQLRoI1P7ezXQHWzBWIZhRa/vf78BP6BSU/uiJNi2PNlbVWHvvlqeBs
         st3JpbFXysNYWZATBUivcp2zGssH6EZytVk+4B+B3CMGHfAIuUcbNaCBXSg0aC6uFuNY
         7dnQ==
X-Gm-Message-State: AA+aEWYIdfVQSjzG8NdU5Zbc0tPQNLO+LPCfui4GAPasMLcxoSM4jjLH
        G3kPq/oxiig0bFrJs5dNiDvqqQ==
X-Google-Smtp-Source: AFSGD/UEl7nur5Lf8+x1IfUfB+dLXraLr3vsmNzVnx+fOl1hrR0JWjMnMRmCjVJs9X6ikJhAjhOfzA==
X-Received: by 2002:ac8:1102:: with SMTP id c2mr14159106qtj.195.1545063467080;
        Mon, 17 Dec 2018 08:17:47 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y32sm8885831qth.3.2018.12.17.08.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 08:17:46 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     jpoimboe@redhat.com, mingo@kernel.org, bp@alien8.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] kbuild: error for CONFIG_ORC_UNWINDER is too much
Date:   Mon, 17 Dec 2018 11:17:28 -0500
Message-Id: <20181217161728.6875-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <869bc700-1d6d-b950-76c7-5d0fc589152c@lca.pw>
References: <869bc700-1d6d-b950-76c7-5d0fc589152c@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ifdef will be evaluated immediately in the first phrase of the
Makefile read-in, there is no guarantee that the value for
CONFIG_ORC_UNWINDER will be up-to-date until in the second phrase that
this recipe is ran.

include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig

Hence, change error to warning as this is essentially a best guess. The
original bug can be reproduced this way,

* make sure none of libelf-dev, libelf-devel or elfutils-libelf-devel
installed.

 # make distclean

* generate a default .config where CONFIG_UNWINDER_ORC is enabled by
default.
 # make menuconfig (exit -> save)

 # grep CONFIG_UNWINDER_ORC .config
CONFIG_UNWINDER_ORC=y

 # make menuconfig (deselect CONFIG_UNWINDER_ORC)

 # grep CONFIG_UNWINDER_ORC .config
 # CONFIG_UNWINDER_ORC is not set

 # make
Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install
libelf-dev, libelf-devel or elfutils-libelf-devel

 # grep CONFIG_UNWINDER_ORC include/config/auto.conf
CONFIG_UNWINDER_ORC=y

Fixes: 3dd40cb320f (objtool: Upgrade libelf-devel warning to error for
CONFIG_ORC_UNWINDER)
Signed-off-by: Qian Cai <cai@lca.pw>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 56d5270f22f8..eeb4ec49d393 100644
--- a/Makefile
+++ b/Makefile
@@ -963,7 +963,7 @@ ifdef CONFIG_STACK_VALIDATION
     objtool_target := tools/objtool FORCE
   else
     ifdef CONFIG_UNWINDER_ORC
-      $(error "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
+      $(warning "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
     else
       $(warning "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel")
     endif
-- 
2.17.2 (Apple Git-113)

