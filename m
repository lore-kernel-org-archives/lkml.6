Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8414C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C0020823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBHQqcBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfARK6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:58:14 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38483 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfARK6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:58:13 -0500
Received: by mail-wr1-f53.google.com with SMTP id v13so14516249wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqW5bTVxkyVuhKIuJPQ4C2gt3hYjohFMEMSFlFTILDw=;
        b=FBHQqcBVe9XWvqjl7p0lAbyelhPo4Wjc+flSeDUNBh1yBYsC7PFqrIlTApVzAG8GlX
         S3cWyjqFO0KmRL4b+zpRfqksGic4JQ9J1ut7hR8kIH1igg48FN8TMou1irQPjvh8jqTp
         dOP3KQAtl0Cg47pppSHKiH5KWSypx2IXMQAhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqW5bTVxkyVuhKIuJPQ4C2gt3hYjohFMEMSFlFTILDw=;
        b=IjUNJipV9xlf2JETYUOI81WGuXrz4CZN7YjaBwqktTwbe6QKge67oGXHBTMvaKB0eA
         uKNM4Kk+S6lsZjfM3lyHjddtekAqiz3bh8sBAZOHm/srJp7+2deEMxjkrSDPBwmo3URI
         A7gGgy6gxLWqb81k2ZF53FXIf3oSBkLfADJ8D6fjPLgFz0Zb6VVOV2JuI+9tvFMEXmrj
         Y/eBJaYBJ6BJIrsHDi4tg1fLJ2pMajIiZVgqjxkXXpFp2qUapqTufdSe4LeKuWTADUgH
         GtLOhsNw9H0l7mW9VXHsbMqSR3lBg+STf+Xctb+QMNRcWzcHI5nvcjtZMtr3GXMQgipk
         fRJQ==
X-Gm-Message-State: AJcUukfvxdX/OwjMHG+hPdxQyWkfRxfksy10oZZ9Hjeshc2T8nwRygWN
        Z7kzIKArmtghjwOte7nz9QFeIQ==
X-Google-Smtp-Source: ALg8bN673NWhROkhM1FbMUMUTAyInYEvWlgIhuba1o6HieQgJ8Wac6e7YuABjrz6fHf0NBSAwnvZpg==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr16590868wrm.218.1547809091644;
        Fri, 18 Jan 2019 02:58:11 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-20-152.w90-86.abo.wanadoo.fr. [90.86.223.152])
        by smtp.gmail.com with ESMTPSA id y13sm65345467wrn.73.2019.01.18.02.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:58:10 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     keescook@chromium.org
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/2] gcc-plugins: fixes for arm_ssp_per_task_plugin
Date:   Fri, 18 Jan 2019 11:58:05 +0100
Message-Id: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of fixes to permit newer versions of GCC to use the stack
protector plugin for ARM.

Ard Biesheuvel (2):
  gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
  gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+

 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.20.1

