Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0123EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E6E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VF77ai8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfA1Pzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36371 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbfA1PzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so18632232wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slmqeLOsa8d5rsqPApJzFEU02ClYEPT68CCNN/PckQ4=;
        b=VF77ai8zHtPKwML6aprf3N7NLb5YqyWZv6bQ/tnh93JpldM6Zrmc67BYxkg5nWwt6O
         t+IDXf39LvwmLE5l26SuQ48Gcf+C2NHUNboRbelNGTjQPdNPLsICqCsmqZC2wBFOjjy7
         Vla2rE2ojk0JDI6juZ7osloJP2gnADIrWd/Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slmqeLOsa8d5rsqPApJzFEU02ClYEPT68CCNN/PckQ4=;
        b=l6k1t7gnCbM+jEqNyeR+514C8/maC3edo0NXjD2zn4lQHYeP2fWp13Cq8D+gu1k3oe
         FEKRldpq3IE3njZASEqlhtp0GHbrIJUV9Jf3H0p145KY6H6VsoUNwiznH5bC7nVjGgsz
         TVCJxTtVE3qDiz78RwKuhtZ0k1Q9CwyIrHxVXuiX9DCtX2RryRmnt6Ee291oPF9o4ul1
         fCxOL3bcFzjn1E/WW3PPUg88Pd9pV48BZDgt6qEkwHsKXTWscP8795Ihz2ZB1g+vzz49
         nF/odAqqMXjFdbmoIc7/SuVAIlDitkzYz6VhmXNPi3qY03i1j8UG17ARKOEdx6+u0TfX
         xH8w==
X-Gm-Message-State: AJcUukcRYwTxjWpS+B9uYBYM04IcJkUpU7uw9F2xIaNEPJ+7lUF60pqB
        cBcnNHFu9KvmTPFgaiwpRuIJeQ==
X-Google-Smtp-Source: ALg8bN6f6pDlyJZzHXuw0J9nANXB//iC5Qtxik3yB2TYVr/9DBhxILxKnwAct60K+9FB+iAD99VebQ==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr23905340wru.245.1548690923025;
        Mon, 28 Jan 2019 07:55:23 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] nvmem: core: Avoid useless iterations in nvmem_cell_get_from_lookup()
Date:   Mon, 28 Jan 2019 15:55:06 +0000
Message-Id: <20190128155506.25566-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

Once the correct cell has been found there is no need to continue
iterating, just stop there. While at it replace the goto used to leave
the loop with simple break statements.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 5400017ef616..9dd07eae1f3e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -977,7 +977,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 			if (IS_ERR(nvmem)) {
 				/* Provider may not be registered yet. */
 				cell = ERR_CAST(nvmem);
-				goto out;
+				break;
 			}
 
 			cell = nvmem_find_cell_by_name(nvmem,
@@ -985,12 +985,11 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 			if (!cell) {
 				__nvmem_device_put(nvmem);
 				cell = ERR_PTR(-ENOENT);
-				goto out;
 			}
+			break;
 		}
 	}
 
-out:
 	mutex_unlock(&nvmem_lookup_mutex);
 	return cell;
 }
-- 
2.20.1

