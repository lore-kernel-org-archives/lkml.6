Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230EFC10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64312084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRU42akJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBTQt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:49:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37314 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBTQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:49:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so26834094wrs.4;
        Wed, 20 Feb 2019 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f4W6oinkmGScKTJv+WgnLXI6I+CKPXVl9FXKRYf2lKU=;
        b=BRU42akJ6kXcJ4NhFWQzdoqwse1UaNOZC/E4TSXtnVYu3UrMBZclJyirl7rMYWmDIE
         gp0lviC/bYqSzH/QCG6YG25OAp40826AkbP6BqkB8M4y1+CFbM9jYvuN9Bd8ZB7Rb5mc
         GfuRdDnU//TH/8g/nLhHrUpzXHVN3gmhAjRzsj7zQV8eqQNYeNBu1nSItiVZlAMaGKIi
         RcVJhZr0zmy2H3GI2tD4y7xeYS0jHR9i5YkSecue03pss1zTwVeGpOYZpDbdwZUx4s5N
         8FLsy2qcluwiag5TagRL4k1J1erVPoE5ynjugQo+cReqOmJFAHMz/eMuSunSdKxBwfSc
         BWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f4W6oinkmGScKTJv+WgnLXI6I+CKPXVl9FXKRYf2lKU=;
        b=JyOCt25GUIZ8gF2ckFprtVVRm7d0TjXSkMcCMDQAqdyNUKhrAsAwuF++icCOovSH0g
         ZXyEjxuYOTEhL9PGtlEJ8Yb5AZk4aI1kIywQ5bxxQlxIRQXOoRMLQkTe/nklTsGFWuiq
         lof4FYXsVMtmc+4tLDd+mKXNt9zOr4xgzVtEd6zJKOkxXn5wwZyQuejj3WsTLY+JDgWT
         FQ9sYJWdlLZIxo1mKtnMqVma3VBWXwyPAYciGvoii0ue0dz9244Q/O4BED3HK6WhmZ1g
         378+0R60WHODi27UzgfHn5KP2r2FONuUc/D6G6lDRksjo6aWQUUM76aksoxTgO83qBIm
         McJA==
X-Gm-Message-State: AHQUAubRDHdI0y93S+NrYbmdCPwUyweOYaDux0sqn4E2+oPQdziW+L7X
        /xaxN68NKS26gHld6Uddcbk=
X-Google-Smtp-Source: AHgI3Ib1L97VOpXfBDsJM7EudtvIWCTmlfH9u32rTg0fDUy2yao+u8NpM3Xq8hntozmS52JV42tWwA==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr25227232wrp.180.1550681364399;
        Wed, 20 Feb 2019 08:49:24 -0800 (PST)
Received: from fuji.PARROT.BIZ (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id h17sm14912464wrq.17.2019.02.20.08.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 08:49:23 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v2] iio: trigger: Print an error if there is no available irq
Date:   Wed, 20 Feb 2019 17:49:10 +0100
Message-Id: <20190220164910.18517-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are more trigger consumers than
CONFIG_IIO_CONSUMERS_PER_TRIGGER, iio_trigger_attach_poll_func will
silently fail. Add an error message to inform the user that
CONFIG_IIO_CONSUMERS_PER_TRIGGER limit might be exceeded.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ce66699c7fcc..e5b538379ed1 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -254,8 +254,11 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 
 	/* Get irq number */
 	pf->irq = iio_trigger_get_irq(trig);
-	if (pf->irq < 0)
+	if (pf->irq < 0) {
+		pr_err("Could not find an available irq for trigger %s, CONFIG_IIO_CONSUMERS_PER_TRIGGER=%d limit might be exceeded\n",
+			trig->name, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 		goto out_put_module;
+	}
 
 	/* Request irq */
 	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
-- 
2.17.1

