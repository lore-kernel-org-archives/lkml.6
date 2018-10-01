Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E219AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3E9204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3E9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeJAWEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:04:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43645 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbeJAWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:04:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so11490969oie.10;
        Mon, 01 Oct 2018 08:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfCjKvj/Rt0QdLyRoM+SklnSQ45TvYZysCa41HzJYLU=;
        b=KvhIB9veO0nFzraT152xz3NI1YDNJVRHTscU2YL7ekeKfl4dUTuIrRYaRmz2RsAOzh
         7QIdUpt5QHMqizFbiepFwXRAGieSUVCQFzOgCdeuI8+1hnNh4qctUoDIE92YhGCEXF//
         nvjccNbh1o99p+MWPFNK8SCHBjSsZTQuMxnwanMGlt2ZeHMc3liCEYGYdxvu0IvsHijm
         O/D148Rf18XWOVre2i8u4UKA7Z4dMrWfBvxE8VuMbvvJ7WQnO4OxZj9VYznpoaMJZsOi
         nSBRAYb1gpU9SdLaBX+VaUw5RboDXwfdH3rWDnc8AjawZ75ypyMDjfK2bmylP5LWG/rR
         BdRg==
X-Gm-Message-State: ABuFfoiMDXGG3Z2TgKYWBgOEy6w7zNU5Lv3oyJqZg9gH8vkgvWffAJci
        le87Mea8DBIdlEvgztAW1uEF/gM9tg==
X-Google-Smtp-Source: ACcGV60IkaEVrOdV8d83ro75sAA8zATQsygRoMJMJaAHVAc6ybMz0LkAuj0aA91oJ3JFaT3rUoQK8Q==
X-Received: by 2002:aca:bc54:: with SMTP id m81-v6mr5544107oif.308.1538407543040;
        Mon, 01 Oct 2018 08:25:43 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 7/9] powerpc: enable building all dtbs
Date:   Mon,  1 Oct 2018 10:25:29 -0500
Message-Id: <20181001152531.3385-8-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for powerpc. This allows building all the dts
files in arch/powerpc/boot/dts/ when COMPILE_TEST and OF_ALL_DTBS are
enabled.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/boot/dts/Makefile     | 5 +++++
 arch/powerpc/boot/dts/fsl/Makefile | 4 ++++
 2 files changed, 9 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index f66554cd5c45..fb335d05aae8 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -1 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+
+subdir-y += fsl
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
new file mode 100644
index 000000000000..3bae982641e9
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.17.1

