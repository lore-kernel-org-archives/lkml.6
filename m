Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F945C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B3820652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWP1iw6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B3820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966706AbeFSPMp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:12:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51498 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966469AbeFSPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:12:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so1006572wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DATBD+bfVSJYi0EGGsuGsSQSPfajgrHRQrhVJaxnXeI=;
        b=WWP1iw6bcA5vRuQB2uVMIoRdBRdWfMeGQfOHYRUVfREKn2/Ds4oplYrf392YjvpkGO
         NS/J/9E2rFA6TXLjVlHE+QgoDEwuJhZbG9Ci+ygJiLX/pmcmx+3oiKBjp3kb7BavC3ZG
         mu//NKSqon8sPI57P8mO8caTlHFjE0KaWdeRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DATBD+bfVSJYi0EGGsuGsSQSPfajgrHRQrhVJaxnXeI=;
        b=gbSXT6ryS9nR3irjtE0iFdmhRQZM8YXfbXeIooDmqX8AKpwSkm8vzXT7+r2fU7DbH8
         yICCk4WDIB6K4paehUQQUP60EQz5kKMRE5/b0gi+hdhPFzdqH1+enPT1DXQkMmbb85qJ
         5CnfVaHjuM53Y66hjEzHst9euSK4xRZ0H6G+FqyCRpbd3UtX6wGIAOp1lYOJKqwxtHoA
         buu2DuNdLpNuy4mXS+sTcAhGsGWHjMyvtligYe/wrJHtmZEgNQdMWZ8UXNp5kqSYAmQ0
         90wwwNbYE1PvQ5C8Yil4UqQ92u/0BgsPsYfD1D6bKuahmTtXucpU9kL+D6HNbzo1lb9u
         bx2A==
X-Gm-Message-State: APt69E1tLl39ZXr2iRRX3/ENSL2r43/K/lDC9niuNYP+CEIhX3CNyYMG
        qDE3xq+vfZKDSAPycNucszR/yw==
X-Google-Smtp-Source: ADUXVKI32//vm+ngJo82DKA4BufFupAWvNDyljrj3xWF5Qs54VCGLbVXux6KWNnyFjM6vVH+MxLYmA==
X-Received: by 2002:a1c:30d7:: with SMTP id w206-v6mr11417917wmw.153.1529421138356;
        Tue, 19 Jun 2018 08:12:18 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f81-v6sm473599wmh.32.2018.06.19.08.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 08:12:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: messaging: initialize completion correctly
Date:   Tue, 19 Jun 2018 16:12:04 +0100
Message-Id: <20180619151205.11300-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
References: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slim_val_inf can contain random value from stack, make sure the completion
is initialized to NULL while filling the msg.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 1c57b631031a..e3605ed1c459 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -246,6 +246,7 @@ static void slim_fill_msg(struct slim_val_inf *msg, u32 addr,
 	msg->num_bytes = count;
 	msg->rbuf = rbuf;
 	msg->wbuf = wbuf;
+	msg->comp = NULL;
 }
 
 /**
-- 
2.16.2

