Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B372175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXSjT1Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBGW1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:27:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:27:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so411005plb.10;
        Thu, 07 Feb 2019 14:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lb7ocCcoTVCzqHwnwbLdIJbHy25WuLw1BTbro070VbQ=;
        b=HXSjT1HkvYwU4vOsDKPiUM+//gFc/MqvxJXUZHYsi9lBPil04qLGFEeeEpvNu8Zd67
         1t1Pr959GHVKGcusbAJXxng/iCM7zvXa54lEMBmtXHepJLcZlKOciZYqV7fnr3tuvcGV
         e/Z+Ve3RJc9wqxR7bOdfO6hvMg4S1WjD42cGqwdCFVVd6Oe8iZo/RnhZrdL0tRayVaC2
         IFUObpcmpojCD2Kw1XiRezEEfrG3guwggLBtL9VbYtNzkmPPHsLHlDp8FZJJr+H2RI6a
         jhWtDKiE/5Q/lgo3h89WzUY04zLwB0DCsLayLoAawSHEdhBLu32Smqln6NioyCMkHCrT
         l+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lb7ocCcoTVCzqHwnwbLdIJbHy25WuLw1BTbro070VbQ=;
        b=czQjQKSGxFNhP6AuOK18Hh0eE5VGIJEbtVTflMTI70/eQzpNUi2AOGKN1IU+KUi4/2
         /7MT2qHbHxj1YWXQq9JZWtuGX/7AetqUjgegUBaqa7S/2G1LZssaeWKRJaQjyPRwhfrj
         Wj42mY2sFDBiFTuEpmZlduRnn0XsruEiZsLzxk5zjynZv7gOWEiUsoDfuwAjQcl8NF2S
         Zk1+ABqanqWzr4/9cNCBO3ht6mInY1snbYIwmhNhxTewbdID+dLMBVI+VjScbGji+ZzF
         xEuxeU5oHn88ZTdJ1ylQSygPLx8M1773tTOVun7+ukolhH03enOJoNRh/DlqDgjI1sTW
         OVDA==
X-Gm-Message-State: AHQUAubNV1g+Wxe3944c44QodVt6c3g+vkpPo7U78Ba4WzGSSITnYYwW
        Xg7+N/u96HiN9CkIoCvhpc7tiOA8
X-Google-Smtp-Source: AHgI3IYy/PE8CV2AqWJXpMS4ctzJ/inJqU+kylmbxGkil/p/ceMyczCLnAcqLQD2x3abQVvFWYD9HA==
X-Received: by 2002:a17:902:be10:: with SMTP id r16mr19100022pls.304.1549578462617;
        Thu, 07 Feb 2019 14:27:42 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e21sm317746pfh.45.2019.02.07.14.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 14:27:41 -0800 (PST)
Date:   Thu, 7 Feb 2019 14:27:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ps2-gpio - flush TX work when closing port
Message-ID: <20190207222740.GA38612@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure that TX work is not running after serio port has been torn down,
let's flush it when closing the port.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/ps2-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index c62cceb97bb1..9e1dbde2e15b 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -76,6 +76,7 @@ static void ps2_gpio_close(struct serio *serio)
 {
 	struct ps2_gpio_data *drvdata = serio->port_data;
 
+	flush_work(&drvdata->tx_work.work);
 	disable_irq(drvdata->irq);
 }
 
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
