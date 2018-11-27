Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2585C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A508208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4fvFEhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A508208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeK1BV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:21:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33160 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeK1BV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:21:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so15699469plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 06:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OTPP1UJpEGlBVLFdk2n9ayOEEi95oP37Qa1G21XpBtE=;
        b=p4fvFEhD6HxepNMWunl0UvIPOSODE0OOe1MEvrBUyjEffTc5zrpZJp9eGsYAFGZJe3
         9pMGbEFlR80M+pdRSK+xfuNrJfdms2IsGhwKDmCNA1KeVChPfV0IDGwLg+NfvIntG33q
         4ijJ6nWlGzAjSHmQL/BoIXOrp7J1ayx5t85H0DLP1AVcu3bNm7/K6qkYlCT+mDtCkltM
         iWURiATzSemvTzfavNURph86UgJ1DUAEfYz6KYQPIBXIL1MFGQdtSYi3U4Bno0UmrtwM
         qz8ZEFiSXGXLCR18LWIOylIGu+x7Lncp9OODLGb8QIC78UND2oSApiYLCk0yAEGkyRlM
         vIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OTPP1UJpEGlBVLFdk2n9ayOEEi95oP37Qa1G21XpBtE=;
        b=KFtzEDI+BFyShsxPG3rbKKRx9fQOIKIaoNwJWkjAmYqaI9pLWqamP60Vj0sV1/j9Ei
         2oTiMzYncnGVTewMCZi47IFF3sgy/PJnU+AdzMKxBHUnfRLhjiXNTuMLmUbIhKgn/ai8
         UNVg3cX04B3mkur8pt7ckVDdxw4i+9v5l9ujKaUM8j18EW+9ghIbXCnaC0BdJ3L7s43n
         A0zeqlyN7SoxfkDWfEZd5rMxsgVy1AdWVnqhVIWhza2iekRPo3zWR4ygzEVsLcUoYZ6Q
         Re4uSHUbUAp3vgpdKJ5itqN6D+k2IsY6RP4zdzdPrCo85Z2vRYhATatXuK8THDsfQd/I
         6MHQ==
X-Gm-Message-State: AA+aEWZhdH+Fqy4Qib3PiddK3aiEezJJDUaIcoLF8mpNmHMdz6sEZRO2
        dq+7At0XOWb9fdaqtUSS5U8O7JD50YM=
X-Google-Smtp-Source: AFSGD/X1yerW47rEX7MguTcmsVwnozhmLws5qQdm81NtbGy6gj2XVQ0yflgHto5q102Z71M3/kRoHA==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr32942172plm.154.1543328634363;
        Tue, 27 Nov 2018 06:23:54 -0800 (PST)
Received: from linuxKernel ([183.83.158.142])
        by smtp.gmail.com with ESMTPSA id 34sm5949384pgp.90.2018.11.27.06.23.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 06:23:53 -0800 (PST)
From:   Srikanth Boddepalli <boddepalli.srikanth@gmail.com>
To:     boris.ostrovsky@oracle.com
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        boddepalli.srikanth@gmail.com
Subject: [PATCH] xen: xlate_mmu: add missing header to fix 'W=1' warning
Date:   Tue, 27 Nov 2018 19:53:27 +0530
Message-Id: <1543328607-10546-1-git-send-email-boddepalli.srikanth@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing header otherwise compiler warns about missed prototype:

drivers/xen/xlate_mmu.c:183:5: warning: no previous prototype for 'xen_xlate_unmap_gfn_range?' [-Wmissing-prototypes]
  int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
      ^~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Srikanth Boddepalli <boddepalli.srikanth@gmail.com>
---
 drivers/xen/xlate_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 23f1387..e7df65d 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -36,6 +36,7 @@
 #include <asm/xen/hypervisor.h>
 
 #include <xen/xen.h>
+#include <xen/xen-ops.h>
 #include <xen/page.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
-- 
2.7.4

