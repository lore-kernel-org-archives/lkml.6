Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32773C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BE2218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfADT5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:57:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41395 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:57:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so22135769qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 11:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nu73my8EyoywVEqped8htPAV7wuMwc2otKpVbNgVKi8=;
        b=ogkir86uYMccCR1/VkzaNer/gUwHMB/CZJSagBPGMj42KQukX7NHvGC+A35Cp9EDEM
         SJ55nu0EROK3eEQRe+gInXdLbG+gbUHQuSk/0TJz/Qi+EJx+1XE4ACt+6RJ4maBV8dnV
         S14B2iOOJRf2HdlQ8CbR1rnmzcfRuQ5HloJ/HAKjuU9LzKDy7mqB+tr3eFWyrrQODGZp
         xtaARKxntIlBqjY0nGCTS75Kb2TPre6h5lJ03RaD8izdQEQMffEa1Wv/QdUfFZw3eTQn
         KZs9X01Ia1vdOJmE0BKshQ3w7Li+ywuWYET6hpfaooYJXzdGpAxAE7JHTgdlEf/03ppK
         +yOA==
X-Gm-Message-State: AJcUukcrB9JLEl69Iu97sw6J4fUal0ommv0vVV3i+SQhOg0+mMDekIkF
        KLaA64XnJpeB6eAo7lr/vbJUhQ==
X-Google-Smtp-Source: ALg8bN5P/1jjRM2lDhsRg4H6VUN3kA7+IjuknOjwkecgMojiSefjQ0Akib1ZEXt+274T8fS+9ABqeQ==
X-Received: by 2002:a37:5a05:: with SMTP id o5mr48160152qkb.126.1546631838774;
        Fri, 04 Jan 2019 11:57:18 -0800 (PST)
Received: from labbott-redhat.redhat.com ([2601:602:9800:dae6::814b])
        by smtp.gmail.com with ESMTPSA id p47sm38210529qta.36.2019.01.04.11.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 11:57:17 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Laura Abbott <labbott@redhat.com>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] vfio_pci: Add local source directory as include
Date:   Fri,  4 Jan 2019 11:57:14 -0800
Message-Id: <20190104195714.30045-1-labbott@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2]
subdriver") introduced a trace.h file in the local directory but
missed adding the local include path, resulting in compilation
failures with tracepoints:

In file included from drivers/vfio/pci/trace.h:102,
                 from drivers/vfio/pci/vfio_pci_nvlink2.c:29:
./include/trace/define_trace.h:89:42: fatal error: ./trace.h: No such file or directory
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)

Fix this by adjusting the include path.

Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I'd still like to echo my sentiment that this should not be a def_bool.
We hit this error on our internal testing and we couldn't even turn
off the driver until we fixed this.
---
 drivers/vfio/pci/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 9662c063a6b1..08d4676a8495 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,3 +1,4 @@
+ccflags-y                               += -I$(src)
 
 vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
-- 
2.20.1

