Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489BBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E6421741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbeL0Io7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:44:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39190 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeL0Io6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:44:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so15672480ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 00:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jCjNMpwaULpBADjsdRbFO6gL3c5aDJgwhY8Rl9yMB+4=;
        b=lXBaTHFAbrbWPg7nWzY7Ij7cRsbk4iq34W3wpSnMvsVl+mLJXWeVe/uXW+zn5twvk+
         /mjq6UeBOzC4LeqFTdNG2lPIjCwaeRhMAMrRlj0C+z/hTRo5uwQsWnX+5KzV/NtUE0Bo
         PBfq1xFNmFd349NnJfrF+AXQlFOJt0oIOLLRVtbp25hbty8fp+jWIaDd7cq2T6XfTnZJ
         ACwZmDUwQhvCjEPnP2Xu35atywbKmdfijG7d9mlhZ8QKm8oeGdxn4qKseIgO4gtNYhnQ
         lxpPi97n//dSN3efTBXlo3FvVMxzKoA4lsj9jyPlcE0wOOK0NwVA5msoJ9w74RSFyuIt
         lcww==
X-Gm-Message-State: AA+aEWYQTpmUCTO0r8IY3sl54V2ErG2V4S6yweR888YRNrjXINAxnNB7
        USgDOx2pn0JBx67ylYtma6Q=
X-Google-Smtp-Source: AFSGD/WQFFh5r4EFvyOFdfzLw11OQMOVeBRf08Jb7/U8zPT+mO7Ma8UeLTYpiAl0PSbduAHEgZg9EQ==
X-Received: by 2002:a2e:4746:: with SMTP id u67-v6mr12908216lja.142.1545900296506;
        Thu, 27 Dec 2018 00:44:56 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d23sm7481528lfc.11.2018.12.27.00.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 00:44:55 -0800 (PST)
Date:   Thu, 27 Dec 2018 10:44:43 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: regmap-irq: silently ignore unsupported type settings
Message-ID: <20181227084443.GA23991@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not return error if irq-type setting is requested for
controlloer which does not support this. This is how
regmap-irq has previously handled the undupported type
settings and existing drivers seem to be upset if failure
is now reported.

Fixes: 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add level-irq support")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Geert reported that 1c2928e3e321 breaks da9063-rtc on the Renesas
Koelsch board:

https://lore.kernel.org/lkml/20181227075648.GB2461@localhost.localdomain/T/#m194616cc88d7b4c2a78f7ce07907608fdb64a092

Geert, do you know if anyone vould to test this?

 drivers/base/regmap/regmap-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 1bd1145ad8b5..d2d0014b0d23 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -258,7 +258,7 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	const struct regmap_irq_type *t = &irq_data->type;
 
 	if ((t->types_supported & type) != type)
-		return -ENOTSUPP;
+		return 0;
 
 	reg = t->type_reg_offset / map->reg_stride;
 
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
