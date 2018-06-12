Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8C1AEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34161208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAIE9b35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34161208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933681AbeFLNXZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:23:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46959 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932555AbeFLNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:23:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id j13-v6so35977783lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p1Q1yEwNeey+oxIVZ+zezx4DtlBToK5ptYp3rtMah/Q=;
        b=XAIE9b35WpB5Ur9aD+UdyFC2zuN9pOfhK5dAM0dF0o+YcszguD1KnNt+d9cYFVXCOX
         6wtgQYFXffhMdfP2xRvXn4FZU6kC7Z6M9vLx5EMzwhPbz2h5ICJnuQyseW3lOOoy4NQH
         G9VC3aoKUeeH8iJkqqbMCawsiKttqZYJOXVCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p1Q1yEwNeey+oxIVZ+zezx4DtlBToK5ptYp3rtMah/Q=;
        b=eJigMLDO5E0S7cLlA5eyE93AV/91gZyRQXWzywJ4+id/Dp/C2+e1aNylZop9lfPTN5
         vGj+LxGXTM+QXi8RJw3BkmluHL1pborq1bzj9hBdb4V3dtOtKXiZhgcqWqBBJ23xBgc4
         EzQfZVxzsdk16Dbo7RLnzXGazTWwBC8T7Hr+g6ckh+oqLYdg+4sKPKU5w7jfBoPmShmR
         Z9w3C+eHModhpu646CBr/XMRu1lWysVHMk15w7GrZ9UZhT2eXa3ZuobIli6mcWX65yF+
         qH79q4bho1xjzNNPlzxL1BUd/Nof2ySeQg9LVLvIVYTKrsHQX0+vt1QAYGSTARczJQXk
         IvOQ==
X-Gm-Message-State: APt69E3iZ1bCJvpbVNrGzUOQBveT5x+zeGewX37SpH5tFjBaJ2HZ34on
        gVY70CgqtfuLIVJFHqasy+1T1A==
X-Google-Smtp-Source: ADUXVKL3268C7cYkyVJs8oHdyLyIX1TAbgM1TpXYSj6s1XH4KTVu38x6ebxf2A8CLoVML2e/Tlx6ew==
X-Received: by 2002:a19:1797:: with SMTP id 23-v6mr225281lfx.95.1528809802767;
        Tue, 12 Jun 2018 06:23:22 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id q35-v6sm30869lfi.68.2018.06.12.06.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 06:23:22 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
Date:   Tue, 12 Jun 2018 15:23:13 +0200
Message-Id: <20180612132314.29762-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy qcom_scm_assign_mem() to enable building drivers when
CONFIG_COMPILE_TEST=y && CONFIG_QCOM_SCM=n.

All other qcom_scm_* functions already have a dummy version.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 include/linux/qcom_scm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index da63d84e1e91..06996ad4f2bc 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -89,6 +89,10 @@ static inline int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
 static inline int
 qcom_scm_pas_auth_and_reset(u32 peripheral) { return -ENODEV; }
 static inline int qcom_scm_pas_shutdown(u32 peripheral) { return -ENODEV; }
+static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
+				      unsigned int *src,
+				      struct qcom_scm_vmperm *newvm,
+				      int dest_cnt) { return -ENODEV; }
 static inline void qcom_scm_cpu_power_down(u32 flags) {}
 static inline u32 qcom_scm_get_version(void) { return 0; }
 static inline u32
-- 
2.17.1

