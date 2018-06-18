Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9368AC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F42E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gsz6F+/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F42E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935472AbeFRRay (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:30:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50450 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755076AbeFRRax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:30:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so15428407wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BW0mPsFy5Hjtsf+iYw1mJMnHI+/88ZFKWRxjkWK7qf0=;
        b=Gsz6F+/q3I+tlhZ3oIqGv6O8mg97MO29LXg1YpdYY86SQcJSCF6mOBGGWPPPaI8JH8
         y13xC8cEgr05WqoNCVfeU2p4ATTVFzDwvoVwvoLi++CIqq2hzK8hnEcwzTy41EJIRXj5
         oKt4p2k7Uf8ynuG+ek7sNFIxkena1PC0VG4MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BW0mPsFy5Hjtsf+iYw1mJMnHI+/88ZFKWRxjkWK7qf0=;
        b=GajuG1CHn+0h+d8RC/cmHFNAn7ZhNwGHWqebMo8aUNcNetdSCQkJLRvXcguJtW1svw
         Bnk0WhIuZSk2Uks/PBNpyDcwYuCFNoNYM/2Fsy+HkMKv4jFRMth5F1HIV496u+YMb7uB
         jxhYFV2Dex6qXW1CH/gllwOGKVIzkioK7K8qrXu0MqzUF+s1cuE6e4n1c0VSzoQxik6+
         ohiVVctwUQRyBPu/vHCdqF5tRMIq+BVJ0P14j8CC0zdZUr0BQq+rAMsYRVplwqoWZNzZ
         VwwRr0KpCeyIyEm5GvAb7Cj01wVFw5DGOKiuqV1akZSK20HgvsW9shT7Nz2jhzjhKStV
         Jf1A==
X-Gm-Message-State: APt69E1Py79TwWO6QFdDz/P1+yoLmG+0EIiiUHFywEq5AFsHoyqampxM
        /HpcHS2JClU8bs782PQTDlvuVo92r3w=
X-Google-Smtp-Source: ADUXVKIbCkpxV6gESh4BNA2SKDYCoQ10mnCj17m7Og+nkMh3HUoNAWE8VZPyM7ty4HujlpfgflG4MQ==
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr4620240wmf.146.1529343052019;
        Mon, 18 Jun 2018 10:30:52 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id t11-v6sm12846787wrp.94.2018.06.18.10.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 10:30:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us
Date:   Mon, 18 Jun 2018 18:30:43 +0100
Message-Id: <20180618173043.8880-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

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
---
Hi Greg, 
Can you please pick this one for next possible rc.

thanks,
srini

 drivers/nvmem/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5b0cdc21d01..514d1dfc5630 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -936,6 +936,10 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 			return cell;
 	}
 
+	/* NULL cell_id only allowed for device tree; invalid otherwise */
+	if (!cell_id)
+		return ERR_PTR(-EINVAL);
+
 	return nvmem_cell_get_from_list(cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
-- 
2.16.2

