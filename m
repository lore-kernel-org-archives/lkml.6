Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E0EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314B620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYJt/2jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfAPRoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:44:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42802 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAPRoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:44:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so8468504otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CjETfAnfRxtbE9MWGkPp2aHU9Y+vwQE7qZ1JQ/QEJmM=;
        b=SYJt/2jFty9uyfCQ+VSpn/7urDoH9zQ8wkSsk946KPg8eE+owKpIT4Z1tFPhbM4Ok4
         4Vp0rRlVH1jiKTXHbIkmRu8pBb8OKOiNXN3pgBbD7d2TtVRX/FX3/64X+Sv3ihvO524W
         yt/6XADt7d/tSDDPXihdxAJj9bP5hWC1ToYIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CjETfAnfRxtbE9MWGkPp2aHU9Y+vwQE7qZ1JQ/QEJmM=;
        b=meDK4F46EiykoUpqx/omVRWmS0zS+W+FVRGBamhyxt/jHznLnNcV8zNURKbtiD2Hae
         ED1/6MhvSaGp+WlOygR3RAa66NabZD1EOxDSoYFNW1myUEzOeaEQg9mTno9v4iC7Oerj
         4b64yXJGqCmDLzBusKe7Dm70EnWEtKKK5/2zsyvUh0j0A8VpbgrLNKTbL8hIALPKt2KZ
         ZutQx0jBMn4kByZmlg64KJaXIcS7ZnuDlc7VDIwpcPDaz56MDlLeVVdTA8we7+fIxt8L
         COmXVBJhDxygGEoRurQsYE+nnhXx2SccCNrD+VCOfXqC+iAM5uSMETNi+2q7tGSy4JTl
         RDsw==
X-Gm-Message-State: AJcUukcDTehWl3+EsmCOMmgOUZGOqd12THLGq8R6lIXi9deBbOlgEPzJ
        choYKXypkgR/Cj8WOmavOoSUqQ==
X-Google-Smtp-Source: ALg8bN7E2a+BrEjT0XTiStofNUshGEOMJ1QwK4HVMst67gq8PT3Ao7WA8OS97kdmjlyGgEJPWiOr2Q==
X-Received: by 2002:a9d:6191:: with SMTP id g17mr6481114otk.56.1547660650423;
        Wed, 16 Jan 2019 09:44:10 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-218-30-19.Hosts.InterCable.net. [189.218.30.19])
        by smtp.googlemail.com with ESMTPSA id m129sm3152973oif.50.2019.01.16.09.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:44:09 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Denys Dmytriyenko <denys@ti.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] selftests: lib: allow to override CC in the top-level Makefile
Date:   Wed, 16 Jan 2019 11:43:17 -0600
Message-Id: <20190116174320.14938-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fathi Boudra <fathi.boudra@linaro.org>

Relax CC assignment to allow to override CC in the top-level Makefile.

Signed-off-by: Denys Dmytriyenko <denys@ti.com>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 8b0f16409ed7..0f9c47eaaa6f 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,6 +1,6 @@
 # This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure.
-CC := $(CROSS_COMPILE)gcc
+CC ?= $(CROSS_COMPILE)gcc
 
 ifeq (0,$(MAKELEVEL))
 OUTPUT := $(shell pwd)
-- 
2.17.1

