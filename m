Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FEDC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7680C21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bybu+W6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBGWqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:46:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40857 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:46:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so677936plq.7;
        Thu, 07 Feb 2019 14:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bRm+DeA+dYc+/LF/LLY2nCch+/hS6OI43ZsdtxjCS1o=;
        b=bybu+W6uLpYGRUybaiK1kYRLb9qnEC9cVhKFKyrWfJvOwAyhYT7AQAXvEnKT1QNkXZ
         jl6UXNnb/RroTNsSG+P7UIzch0HGQw8OQAR5CexAmk4PUomPAge7f72hZU/+IuTkZCuY
         N2beFUdePeMciapL/Wyg70qaqHT92MunZP4+iO0a50RWQuKjB8dba2KBaFbGDA0yOavY
         anMlD0SFS5PKp5wEWFfd0vIayTjU4tICWkJYPgDonJnX2kY1pYw8QxD4GtEdb210LzmG
         1ck2eo9zNcFbdKTjKrZkBOaiMdjQPNiuQc8gZb786mWiHlv2QA4yxtLlNOKSsOKQbe5P
         hj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bRm+DeA+dYc+/LF/LLY2nCch+/hS6OI43ZsdtxjCS1o=;
        b=W4YcIJTJhozxsivoAASjdRAiWQM+awT7VXzgNPr64kPQJJBBWiI/5DIzOx2sTiaslM
         KA91Go7BTWkU3bWwycAudTm4wU7AKUes/wZByZftFmA3hQdtwUf5x37AtuFT5wTlhZjk
         UIRolAkqQLHS3YvjOqDKfWgSCsWdRu+gpAU2CQEpAlsrXMfBRZ2aUSa5Mc9yzp/Tsc46
         fEG6Poi7zO/dWhp8fVnajPhatfH+If+hiuUA3pDV7n1Y36eK4MJzuPNgCXc8U4mBw//4
         nEMyZb41J1G4HLHv9Zfww0rV9w1+R+eEX8J6X9VP9eKxp30CQKqBvPsWRpu5HAhXYrxr
         9FOA==
X-Gm-Message-State: AHQUAubuii9IWuqvMh0tyn/pOnhFcf8rm8c9vBQ1JdtWaptwojh1TOsn
        EHDpnqyWKAuNGeI8bQpBVItDyz6c
X-Google-Smtp-Source: AHgI3IbDFp08RYf0wkR3b1vuaXvFedrzV3+Jt8yYKxZS+Q/UHrFFHwXmVnng74YY0WGFpJMGQYY0qg==
X-Received: by 2002:a17:902:bc83:: with SMTP id bb3mr4212176plb.266.1549579612814;
        Thu, 07 Feb 2019 14:46:52 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r12sm154975pgv.83.2019.02.07.14.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 14:46:52 -0800 (PST)
Date:   Thu, 7 Feb 2019 14:46:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: matrix_keypad - use flush_delayed_work()
Message-ID: <20190207224650.GA49861@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should be using flush_delayed_work() instead of flush_work() in
matrix_keypad_stop() to ensure that we are not missing work that is
scheduled but not yet put in the workqueue (i.e. its delay timer has not
expired yet).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 403452ef00e6..3d1cb7bf5e35 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -222,7 +222,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
 	keypad->stopped = true;
 	spin_unlock_irq(&keypad->lock);
 
-	flush_work(&keypad->work.work);
+	flush_delayed_work(&keypad->work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
 	 * we should disable them now.
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
