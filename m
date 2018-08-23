Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE7EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503662147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503662147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbeHWL67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:58:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbeHWL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:58:59 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 13298C74;
        Thu, 23 Aug 2018 08:30:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 151/217] nvmem: Dont let a NULL cell_id for nvmem_cell_get() crash us
Date:   Thu, 23 Aug 2018 09:54:24 +0200
Message-Id: <20180823075512.404209999@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 87ed1405ef09d29a14df43295f7b6a93b63bfe6e ]

In commit ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on
Qcom chips") you can see a call like:

  devm_nvmem_cell_get(dev, NULL);

Note that the cell ID passed to the function is NULL.  This is because
the qcom-qusb2 driver is expected to work only on systems where the
PHY node is hooked up via device-tree and is nameless.

This works OK for the most part.  The first thing nvmem_cell_get()
does is to call of_nvmem_cell_get() and there it's documented that a
NULL name is fine.  The problem happens when the call to
of_nvmem_cell_get() returns -EINVAL.  In such a case we'll fall back
to nvmem_cell_get_from_list() and eventually might (if nvmem_cells
isn't an empty list) crash with something that looks like:

 strcmp
 nvmem_find_cell
 __nvmem_device_get
 nvmem_cell_get_from_list
 nvmem_cell_get
 devm_nvmem_cell_get
 qusb2_phy_probe

There are several different ways we could fix this problem:

One could argue that perhaps the qcom-qusb2 driver should be changed
to use of_nvmem_cell_get() which is allowed to have a NULL name.  In
that case, we'd need to add a patche to introduce
devm_of_nvmem_cell_get() since the qcom-qusb2 driver is using devm
managed resources.

One could also argue that perhaps we could just add a name to
qcom-qusb2.  That would be OK but I believe it effectively changes the
device tree bindings, so maybe it's a no-go.

In this patch I have chosen to fix the problem by simply not crashing
when a NULL cell_id is passed to nvmem_cell_get().

NOTE: that for the qcom-qusb2 driver the "nvmem-cells" property is
defined to be optional and thus it's expected to be a common case that
we would hit this crash and this is more than just a theoretical fix.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -865,6 +865,10 @@ struct nvmem_cell *nvmem_cell_get(struct
 			return cell;
 	}
 
+	/* NULL cell_id only allowed for device tree; invalid otherwise */
+	if (!cell_id)
+		return ERR_PTR(-EINVAL);
+
 	return nvmem_cell_get_from_list(cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);


