Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BBC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5774B20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGd5DExC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5774B20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeJMRmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:42:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45174 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeJMRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:42:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so15916221wrw.12;
        Sat, 13 Oct 2018 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dtmS436VhqJGsEKf0bweThZjTYZPJrcmRb9GRkbDIs8=;
        b=pGd5DExC+s2CZKTT4OfjPORqBkcVH8Itj5y9QYQH+CnXednsuKPwebqYRp6364TYdn
         YKydrsRGHkhH+qi8efjdizNoZAzV8FKHlrej4MNb+6slX3hRBPwmnEFexqdUWBNkA3eC
         O29vprxx5r3Ccau4if4bZLzTJ8DO5ydfFCi4ZQ90TeXRlhPRE/1FpOapciD+nH7KXR55
         xA7UeZZaQIZwkt0zwa43B0JbM6VPDoSWLI4w444eF6CSvzYP382GljkzRH5N5WZgYMrq
         g1XGb1AYWKHkLutNN/BQwuAJ9iCe/C45liWLWsfn0icyCf4WU4z42lJ6KqIl8YlgcOxk
         oXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dtmS436VhqJGsEKf0bweThZjTYZPJrcmRb9GRkbDIs8=;
        b=LlZ8mAsihz7gvv7fgHkfHWv//m5APzHxNvidLarbmOMW1I5GDhmPUNWSRFMylIRZm1
         PFJbMhWKp2+BgNZY6CY7nai3ieYhwK3YeD3+9HDSsEHJYgsuBglKjIp15dOR/BcjNhHN
         mQlSytKc44bQ7wVpVVBloTsHyjSYtwyli30OpH6qaMMwpUowsAgf3YhxnwEe/FZEgA01
         EpK2es3dzjGSHWRYyPGdsRfNiohrFczQ6j0f62Hnsq44+1v2k9bS72cv3r8GxJeE4iJJ
         TMHHFHm3DifcU7wYs+tQN+ujEotbRB9czLqIBJsTX21WfZ60xhBlHeyWe6E6cyGduak+
         gbjQ==
X-Gm-Message-State: ABuFfog7SsD51IiIGIcsxGSYGalk68KF6q93cvZ0rLsQy6ZLb0KBUNMd
        lsxLvVXyrfmqg7y+KtN4sMk=
X-Google-Smtp-Source: ACcGV6019r/LjOCdAQOkT+giLTFy3RiVhfpYK3VRhr06rQdliYzX3SiB+6iSMpQqsXujIjPBQvW0qA==
X-Received: by 2002:a5d:450d:: with SMTP id s13-v6mr7895648wrq.82.1539425147717;
        Sat, 13 Oct 2018 03:05:47 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4984308wmj.39.2018.10.13.03.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Oct 2018 03:05:46 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
Date:   Sat, 13 Oct 2018 14:04:46 +0400
Message-Id: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
with reboot; e.g. a ~60 second delay between issuing reboot and the
board power cycling (and in some OS configurations reboot will fail
and require manual power cycling).

Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
Co-Processor seems to depend on FCLK_DIV3 being operational.

Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
bad commit. This added support for the missing clock gates before the
fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
disabled all the unused fixed dividers, thus it disabled a critical
clock path for the SCPI Co-Processor.

This change simply sets the FCLK_DIV3 gate as critical to ensure
nothing can disable it.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/clk/meson/gxbb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 86d3ae5..4c8925d 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -509,6 +509,7 @@ static struct clk_fixed_factor gxbb_fclk_div3_div = {
 		.ops = &clk_fixed_factor_ops,
 		.parent_names = (const char *[]){ "fixed_pll" },
 		.num_parents = 1,
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.7.4
