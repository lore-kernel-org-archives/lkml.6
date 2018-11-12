Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACF3C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331572243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCb1S1vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331572243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeKLWUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:20:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39961 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeKLWUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:20:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id d3so6622211edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODYGFMdaycbKq0Th7g4PJEwwAYXx0ZmPhdkLx8Ug4NM=;
        b=iCb1S1vpH3DX0wnOqjR5CJ/8DFkbsdrzt1AWnyffajjseN2SMITZouYiSNVAHWwrlK
         dmoynyr1dyy2YRG1moxZAVAMbxvrcDauOhMGj7snCjo8w1AjYZI3eIxDDxZE5RPxttVn
         pX5aaTYAAbvZGDsMmKJ7yy5Vi4DPKY+eMGYvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODYGFMdaycbKq0Th7g4PJEwwAYXx0ZmPhdkLx8Ug4NM=;
        b=LNTcU8/s4jNw+pOa2KN9zfJj8Hx6IEuDk/67h4iWUuX6z/vWQJnHfuzffqz0kVEWTW
         NeRXxUqK8irvvXrY8adOJLKrVS51WUzLHTtKKz4QczOjYdDrwKaDj2hDhXk8N8HDGfiG
         H7ugevhEHvhRGrxxH2vk3zDVQnEZ5A5EcIIUfHS7bSdtApChbfsDKNfHuqxFCoK10S7+
         edmQv1Sz3aGj6nMPMlrw1AlFKQYaD7yq2VFODqViueuEZMqhdEV9hIGjSHDX/s86/wJJ
         Tqd1E67XOwAPPgLSYsMcVMZ8yXdQovUf+Z7w/+YQ/oiyug0g4RsVR3LPBzIyf0CoMeFU
         bEMg==
X-Gm-Message-State: AGRZ1gLVdSxKfpKbmVewl+/MaTfYpuY/8XXuuW+slXrT7lAVBM30At9q
        7km/4VSBJg52NYHcUZtm/k7BZjmckPA=
X-Google-Smtp-Source: AJdET5cXs6WA01FXx/silEO2CmCB6GB4jWpJw4OJJ/1ItVkJSWSaQrQVJ7iYDYraTjifbzegGLEFOw==
X-Received: by 2002:a17:906:74d7:: with SMTP id z23-v6mr9490417ejl.234.1542025651047;
        Mon, 12 Nov 2018 04:27:31 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f11-v6sm4358545eds.23.2018.11.12.04.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 04:27:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     niklas.cassel@linaro.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: ngd: Fix build error on x86
Date:   Mon, 12 Nov 2018 12:25:25 +0000
Message-Id: <20181112122526.10337-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112122526.10337-1-srinivas.kandagatla@linaro.org>
References: <20181112122526.10337-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on non DT platforms like x86 of_match_node is set to NULL, dereferencing
directly would throw an error.
Fix this by doing this in two steps, get the match then the data.

Reported-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7218fb963d0a..7de8907723a2 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1330,11 +1330,12 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 {
 	const struct ngd_reg_offset_data *data;
 	struct qcom_slim_ngd *ngd;
+	const struct of_device_id *match;
 	struct device_node *node;
 	u32 id;
 
-	data = of_match_node(qcom_slim_ngd_dt_match, parent->of_node)->data;
-
+	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
+	data = match->data;
 	for_each_available_child_of_node(parent->of_node, node) {
 		if (of_property_read_u32(node, "reg", &id))
 			continue;
-- 
2.19.1

