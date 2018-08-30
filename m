Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF11C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF2C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt8rp+8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF2C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH3Vf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:35:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33156 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeH3Vf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:35:28 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so16908813oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OXupEqQWUgBYsleXbnpoJLQQLT96XlnXIOZ83WdQfo4=;
        b=Wt8rp+8DRZebe0n4XaNKe9FKxT0vcYeKgwLiMzH/+tEbJ5noCYcA0aMfc5T0vt47iV
         +z0XRqj+71T7FNBbjsho96ZNHU87mDo6FTkKnRqgFvt3rpMWybycxfrmLGGyjP/JhsRy
         XoQIFaJmAx6Sj2HHv/97MYG7SwBtr7ThiBapqF6SpWnQcbnAog9xL83uwSttbjQtN7hZ
         NKy9Rex0Dp8NAmYxBXBLUD37zE76/ZsHNtkl1w3PZPHHWeZCKYe+qgltDSazu2S8G/k2
         PYu980g6XcRmJ0gezsai2YJg7n527wrXx8FHIAytneaijhLipT30fITQytUdpjb3I+WU
         z3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OXupEqQWUgBYsleXbnpoJLQQLT96XlnXIOZ83WdQfo4=;
        b=DAsu2u6F3qTHRqzx6CfxVFihltrW/MbmyxeXfvi24OfBMT2dSrwHJ2ZIDMCSy66u8S
         GirYXDT0SpqYgV5JZzK1LKQZDnF9G+TT2RbVx/w2cxBPBajsmss8be4KX5pFKM5u4dqn
         lM1DeElFaSmIucnAOineJk61PJm4l+qQSCWfVbvl2zBJYr6aXUpZzwjKjtKkKUUr2+wJ
         kjJKT9OwEmfbnJ38Omh/+nTJ6ssQzWe1YbHRS+N8hlpKPoKonYgkqrlsEY4VmE+nkI7z
         mdba7Nxzr6yUeDgiBczAsm4CFbMrYvYkO46Voom7g9hia7W7Ah6wLEt6eNOLKEo5nBZv
         01fQ==
X-Gm-Message-State: APzg51B0O/sLuwI30BLXYjp0XLl2Crgeeuh7J2a2JLteEmYe2QTD2Wha
        AH72O76qzAeShwVt8VAsUsT8L7nbL4243d2ctaU=
X-Google-Smtp-Source: ANB0VdYGtr/DxZjRHQ5RpeT+HSXrb9yfisEbWDm7xML0SH9qSwJA//HruJake/UFNVZuvoq2HxVTuMwEmedLPmb+KUE=
X-Received: by 2002:aca:f58f:: with SMTP id t137-v6mr3395813oih.244.1535650336606;
 Thu, 30 Aug 2018 10:32:16 -0700 (PDT)
MIME-Version: 1.0
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Thu, 30 Aug 2018 13:32:12 -0400
Message-ID: <CAPMnawvndQUGj4ohrTCPrwcvZdS-3FrHGsNeN4N7OJ_YGK-QfQ@mail.gmail.com>
Subject: [PATCH 1/4] staging: comedi: Correct multiline dereference as per TODO
To:     greg@kroah.com
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using checkpatch.pl I was able to find a multiline dereference which goes
again the coding style for the kernel. I'm still working on my email client so
the indentation looks bad here (in gmail) but the arguments for
comedi_check_trigger_arg_min should go just under the opening (


Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
---
 drivers/staging/comedi/drivers/dt3000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt3000.c
b/drivers/staging/comedi/drivers/dt3000.c
index 2edf3ee..6bc5c86 100644
--- a/drivers/staging/comedi/drivers/dt3000.c
+++ b/drivers/staging/comedi/drivers/dt3000.c
@@ -439,9 +439,9 @@ static int dt3k_ai_cmdtest(struct comedi_device *dev,

                if (cmd->scan_begin_src == TRIG_TIMER) {
                        arg = cmd->convert_arg * cmd->scan_end_arg;
-                       err |= comedi_check_trigger_arg_min(&cmd->
-                                                           scan_begin_arg,
-                                                           arg);
+                       err |= comedi_check_trigger_arg_min(
+                                                          &cmd->scan_begin_arg,
+                                                          arg);
                }
        }

--
2.7.4
