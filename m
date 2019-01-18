Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B5C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7D120850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eXV7shq/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n0aL9oQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfARSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:37:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbfARSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:37:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F914605A0; Fri, 18 Jan 2019 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836677;
        bh=xhK0pQ26sKJSUC1f1kIPs8LUyRu77O0nKq3fFpE+dAs=;
        h=From:To:Cc:Subject:Date:From;
        b=eXV7shq/uXw/BzJKs/85KFt74V3wEGxnM4GfxFN+UiW1fwghACVO9dQsd2sbkl1+Y
         k1Rub9AFc8GAtjkjx6i96e8fs1Bz3Noq4IVFW4j/I38hVN230My3epiSgbFBS7+nxu
         ouzbtXSqvFNVjf5lY9hKdtqHahC7ek8OEPaM1UoU=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0E0C601B4;
        Fri, 18 Jan 2019 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836676;
        bh=xhK0pQ26sKJSUC1f1kIPs8LUyRu77O0nKq3fFpE+dAs=;
        h=From:To:Cc:Subject:Date:From;
        b=n0aL9oQ5tWsKfhgfkbxNMdhicpbVR3KyNjNxPWD2oKcyBN7YbFkdFt3Gp3I46pCf2
         igP+kX6fYVBHJAiyFIBgdQfnN/DQjmqAAgRNyzEUrVvp6znJxD/JH4d9JJOcqgVLg7
         G8UroXgK/GO8qmDDlC29UWO90zzsWGPFi6qRCklQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0E0C601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
From:   Liam Mark <lmark@codeaurora.org>
To:     labbott@redhat.com, sumit.semwal@linaro.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org,
        Liam Mark <lmark@codeaurora.org>
Subject: [PATCH 0/4] ION stability and perf changes
Date:   Fri, 18 Jan 2019 10:37:43 -0800
Message-Id: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some stability changes to improve ION robustness and a perf related
change to make it easier for clients to avoid unnecessary cache
maintenance, such as when buffers are clean and haven't had any CPU
access.

Liam Mark (4):
  staging: android: ion: Support cpu access during dma_buf_detach
  staging: android: ion: Restrict cache maintenance to dma mapped memory
  dma-buf: add support for mapping with dma mapping attributes
  staging: android: ion: Support for mapping with dma mapping attributes

 drivers/staging/android/ion/ion.c | 33 +++++++++++++++++++++++++--------
 include/linux/dma-buf.h           |  3 +++
 2 files changed, 28 insertions(+), 8 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project

