Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3346EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9BA20645
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="feuHfR82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeLOFW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:22:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39436 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbeLOFWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:22:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so3802333pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLe9TDsF9ykXoskMy1MUV6N74DR2JxYIMBM3AVcxyko=;
        b=feuHfR826w2zbdrMCBmO9bQOCB5pu21rH6+y8utGYNdneyOMzlRKZMZ0yZ6M+vo6QB
         KB7YU4Mml7amEdcxZtogoLH3cVSGI1p8ggWLyDorL91rCi2VxEJkBRh3LBeriDPAtzts
         7rAdGGHOIvm52Vd5qsDvAAtByJvDhOzaPj2QTYBjeUwp3MuId1jeeWBRCDsSjFJNP1yA
         wbTZxQisvd/f92hIBUzBw9Y7Sdq3AE1NHi22vFwvqmgxy9aG82OVeoM2ITXwSARWTdb/
         nJztNtNnUVbCHtMvc/+nIamH3xYlWrP4C8GKObR8GSS19l0Tu0mR2p6vcbqExDJlzAru
         gK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLe9TDsF9ykXoskMy1MUV6N74DR2JxYIMBM3AVcxyko=;
        b=QvOUKl+H4uGSqcOXZem7hnR0pEsvVYchREWavSu0jWxgQ1fYExmGfMv9pcU1Vxisno
         Ov6MpNjNuET2CClZt16Yqwuq/SaEjZUCBnn7ZHEPG15Lj9fyIlujB0WaQlKhsQQgdwHM
         auHNpY6NVYBGFhEIK1VvhLRhp797nQwrrZtiEGboPvtpPoXIIL2EEbj6SLD0DFVZSM1p
         FtASqgChczsGpQBB0gQcdIHSJO+z5hF0WlTBTfUQ24QifcvsalbkeeKVi7r1onZ3Tl50
         uNTOQKx3bB4Q6MZsBXc9GYaQ+VflWb/k68zu86Gxx6Tdc+4vQN+3Jx0ZUMrJJTtEIeAX
         pXPw==
X-Gm-Message-State: AA+aEWZ/XqykqCq+SB9L4D3NKvzlcmQJeKNpK3f0ExB4Tim7JYyMGQvX
        9Fh921q3b68WMeLb6DBRW/Cjtd/uGF4=
X-Google-Smtp-Source: AFSGD/VKuAo7dsf/qapsT4rICerC5zin1uQkYOu2fmF1M+PTkeQRU4rRjdtOkiorie6yBwO0+PN5jw==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr5107167pgb.66.1544851350858;
        Fri, 14 Dec 2018 21:22:30 -0800 (PST)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z127sm11351282pfb.80.2018.12.14.21.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 21:22:30 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/7] dt-bindings: riscv: cpus: add E51 cores to the list of documented CPUs
Date:   Fri, 14 Dec 2018 21:21:50 -0800
Message-Id: <20181215052154.24347-4-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181215052154.24347-1-paul.walmsley@sifive.com>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for the SiFive E51 family of CPU cores to the
RISC-V CPU compatible string documentation.  The E51 CPU core is
described in:

https://static.dev.sifive.com/FU540-C000-v1.0.pdf

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
 Documentation/devicetree/bindings/riscv/cpus.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
index adf7b7af5dc3..fb9d4f86f41f 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.txt
+++ b/Documentation/devicetree/bindings/riscv/cpus.txt
@@ -68,8 +68,9 @@ described below.
         - compatible:
                 Usage: required
                 Value type: <stringlist>
-                Definition: must contain "riscv", may contain one of
-                            "sifive,rocket0"
+                Definition: must contain "riscv", may contain one or
+			    more of "sifive,rocket0", "sifive,e51",
+			    "sifive,e5"
         - mmu-type:
                 Usage: optional
                 Value type: <string>
-- 
2.20.0

