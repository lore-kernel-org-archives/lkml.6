Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B302C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2607720656
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="J62dUlTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeLOFWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40649 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbeLOFWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so3622014pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rns3Vf+c9+ywyiS18gu90x3HnhyKwds1kllzbtX3Q60=;
        b=J62dUlTtyNLNHvnZF04YuUru8ICvHmE2SBsJz8NXX1KtrklTO5+cFaZHMwOdIrzVFY
         koLJRAqW2pUloCu2eg08Va4ACLiTRZJvrPufVf+RtYFmgFWlBisGxokUUMLZvW7Qvner
         YuoYzGxY8gOMEV7RUoIxlsyFQz8dhLdPTZV4TFcMbqQZUdlrYSVi03ys8INnwfXKuk6D
         oP9xgLCVUXepcvWHn936uwFkYT7PvgzOwtV9AOZUBosrnjvSJmtzZ3IFCYL2Buc7dR3K
         4cnnHhzoONPIfuv+Kms9dm/qQ7Mlkc03aDqZKOmfAnhAd91rdqzzunYUjIaDLhZdSE5X
         8oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rns3Vf+c9+ywyiS18gu90x3HnhyKwds1kllzbtX3Q60=;
        b=mT3KtalmNK86my8PFZMgJ/1rmCZvHdh1tT64BC36eYAaIMTTeT0jGjkaYp4ScgBPqP
         LPpT9EY8e9MMRtsaeoax4I5pJdeE4VPzRStUNxCkAZ/gHBNpQbUpJEOKgOr7S69+qj5O
         lFnc7lJLhoIYkmKlCsXo3ri4YIp0nnd5fZUWi4ecFICWmJa8pBAztH1AYnLO6t/zOluW
         YpmTTFr43ZKNB5CGh5onbVaF+3/vTDtM6Uu8GRCqtMKtVz4P+W2nudaJWvgvezBpizpH
         SDu27g0gINFcBW/6t4ayntGHyjWVeARbB75V9mL/5of8R6QzcEQMAANFQO8V/rw2gSr/
         7KrA==
X-Gm-Message-State: AA+aEWZS/ieBHxJ+sTkJezDjPKNTl4qrQSBQGMWph1Ka8ulBfoaycIQp
        iWhZb9FRVeTZ9T4TbCLeiYkBXjtzCng=
X-Google-Smtp-Source: AFSGD/UlDogYikK2Cu7CiIW3fzMSnX3vpdEhbHO5y3FfDwfYMWATZKkjw4s4RbAGp85j6uQfccSa+Q==
X-Received: by 2002:a62:d885:: with SMTP id e127mr5346845pfg.197.1544851349513;
        Fri, 14 Dec 2018 21:22:29 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:29 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] dt-bindings: riscv: sifive: add documentation for the SiFive FU540
Date:   Fri, 14 Dec 2018 21:21:49 -0800
Message-Id: <20181215052154.24347-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the SiFive FU540 SoC.  This
SoC is documented at:

https://static.dev.sifive.com/FU540-C000-v1.0.pdf

This file is originally based on
Documentation/devicetree/bindings/arm/ti/k3.txt.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../devicetree/bindings/riscv/sifive/fu540.txt     | 14 ++++++++++++++
 MAINTAINERS                                        |  9 +++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive/fu540.txt

diff --git a/Documentation/devicetree/bindings/riscv/sifive/fu540.txt b/Documentation/devicetree/bindings/riscv/sifive/fu540.txt
new file mode 100644
index 000000000000..b5cf2b9f9a75
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive/fu540.txt
@@ -0,0 +1,14 @@
+SiFive FU540 SoC architecture device tree bindings
+--------------------------------------------------
+
+Platforms based on the SiFive FU540 RISC-V SoC should follow the
+scheme described below:
+
+SoCs
+----
+
+Each device tree root node must specify one of the following
+compatible-string values:
+
+- Freedom Unleashed 540 rev. C000, or "FU540"
+  compatible = "sifive,fu540-c000", "sifive,fu540"
diff --git a/MAINTAINERS b/MAINTAINERS
index 8119141a926f..dee555ceb175 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13626,6 +13626,15 @@ S:	Supported
 K:	sifive
 N:	sifive
 
+SIFIVE FU540 SYSTEM-ON-CHIP
+M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Palmer Dabbelt <palmer@sifive.com>
+L:	linux-riscv@lists.infradead.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
+S:	Supported
+K:	fu540
+N:	fu540
+
 SILEAD TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.20.0

