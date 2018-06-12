Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1501C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E73F208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E73F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934821AbeFLAcz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:32:55 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38122 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934675AbeFLAcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:32:50 -0400
Received: by mail-pg0-f52.google.com with SMTP id c9-v6so10570876pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=88BcnQ/NtOVpXaOS+hMk79la6Z+N7cz6OMhcU6MW3io=;
        b=NASIeKhdKp/ioS0l8twgMmh0FTS6PfDRPt2GDK/RiFiXhbmm0DL9cT6V3RZmQMORgV
         kPR0HbAJZ8LP8QmFQpNT6ycAJZyMvZtLGY950agRw+zz1/hxrtVBgvkcZI90pr+5OulO
         OH3pOeP2ovWMsoyVtEIswU79hiKIAl+vOt4tiHoaE5LmXeSx0V6Qm4Nmuhv5DLnqa+HB
         tlMWLKVloxS51R4gAqJkpCO9bWlmAB/zblU8yH2G7eLv6myx5noe4xbWpkFBlhsORXO8
         xWQyoSw8sWbeLUyDDbrz9A5yR/ka3dwTwwCCz9V+GwaiXxaM+kcFeJuE6wMSOipEQLyr
         B6og==
X-Gm-Message-State: APt69E1xUTJlsu8vWIBfM/ujwkM86ZSe+T7wzSPL9oxWxQvGpKeEafpH
        Qz/CJQAT01hOajqiWOe+rQkqyg==
X-Google-Smtp-Source: ADUXVKI1xjIg3MnFA7LQmMq8I4aLwbFIjKEj4HJiEds7yf5g6EPXkOWmh2tBG/3y5P2nw1QPbG4DiA==
X-Received: by 2002:a63:6c03:: with SMTP id h3-v6mr1177871pgc.28.1528763569920;
        Mon, 11 Jun 2018 17:32:49 -0700 (PDT)
Received: from localhost.net ([2601:602:9802:a8dc::27e5])
        by smtp.gmail.com with ESMTPSA id c12-v6sm40866112pfi.177.2018.06.11.17.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 17:32:48 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org
Subject: [PATCHv4 1/3] scripts: Preprocess module-common.lds
Date:   Mon, 11 Jun 2018 17:32:22 -0700
Message-Id: <20180612003224.3658-2-labbott@redhat.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180612003224.3658-1-labbott@redhat.com>
References: <20180612003224.3658-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In preparation for some upcoming work, allow module-common.lds
to be run through the preprocessor.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 scripts/.gitignore                                 | 1 +
 scripts/Makefile                                   | 2 +-
 scripts/{module-common.lds => module-common.lds.S} | 0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename scripts/{module-common.lds => module-common.lds.S} (100%)

diff --git a/scripts/.gitignore b/scripts/.gitignore
index 0442c06eefcb..afd1de57d9c6 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -13,3 +13,4 @@ asn1_compiler
 extract-cert
 sign-file
 insert-sys-cert
+module-common.lds
diff --git a/scripts/Makefile b/scripts/Makefile
index 25ab143cbe14..631d9d1a71e4 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -25,7 +25,7 @@ HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTLOADLIBES_sign-file = -lcrypto
 HOSTLOADLIBES_extract-cert = -lcrypto
 
-always		:= $(hostprogs-y) $(hostprogs-m)
+always		:= $(hostprogs-y) $(hostprogs-m) module-common.lds
 
 # The following hostprogs-y programs are only build on demand
 hostprogs-y += unifdef
diff --git a/scripts/module-common.lds b/scripts/module-common.lds.S
similarity index 100%
rename from scripts/module-common.lds
rename to scripts/module-common.lds.S
-- 
2.18.0.rc1

