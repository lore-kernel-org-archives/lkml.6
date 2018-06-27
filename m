Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA7C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069132083B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7Vioxhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069132083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966023AbeF0Tyc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:54:32 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37442 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965955AbeF0Tyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:54:31 -0400
Received: by mail-wm0-f51.google.com with SMTP id n17-v6so6173863wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kjAxLXUn1nLsFkWB3kuL9d7ll+SHXW0S3SZ/AyR14O8=;
        b=p7Vioxhcv6m5ZZrJ3OswV2g1TsveTycJYSEVUxGaQSoPPKwRkMAr/9muUlGKdq+QfA
         Z0xTW9sY5z72+EQv03F95shTscTaUIcZUfPaIzdquJ572kgKYlki/Bc1UFsf2JLebfio
         rDPrCk9H2cnD+64TusYt5FibGuLdJlP5H31pk+NayxtWazO9Z1iOmzxMvobohCgAPywT
         v1ekwNoFML3IIOTKa2BvH6AolvCU9SBN2vkoz9BK895Xr8UyuyTJ9VLNCxFNB5qBtDnq
         J2z7FOelFXaXACsjaF1jiwhZckCoHClY7AsqDx8uQ3hQeK//2zLvD7dhH8EfYp9kMm6K
         AN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kjAxLXUn1nLsFkWB3kuL9d7ll+SHXW0S3SZ/AyR14O8=;
        b=Chi0IGN3NQGBKBe6rrhuhpVN7jE5/Dj4ZkyOAWGrs2go/gqXaQCfWnDi/Tx0gAa78y
         9p3rvZhwgy1twjt660d8peODD/P/6FaBMKX5ooGk+YQvTSduFX61A9mFiXQCCrFrm/c8
         LaOrrJHcLrSykQtwMbpmKMphbjm6fLo5IbTyzLv8p/I8huunBSwL84Gl/Hta5mZu0y5i
         M3DKR/AVar+aMdmI6/+LZJjz8Zpj9d7rZIZMFkkd4xY3fLnVzfXGn/E6iZxUdtuajuYs
         KIZF1qI3xA2DYm00/XRmX6talZWPiMk8Ip5iuv98kXsRxEUBuWsEUZGVl7Tdf4DSxt3F
         ucww==
X-Gm-Message-State: APt69E0IGQCXPJ2GnyjpRf4947+XtCRMUE88mkyezLPZIpDrKTpb83gO
        4eZOKg1oWQbDTYIaX+unhn0v
X-Google-Smtp-Source: AAOMgpdhUYsLdzNqfysbTs01vJbEMGCWCLudZTx9m3Q9oNF9NcBjPaygxjmFbD+F1gvQ368Icod9nw==
X-Received: by 2002:a1c:387:: with SMTP id 129-v6mr6069835wmd.53.1530129269947;
        Wed, 27 Jun 2018 12:54:29 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id j131-v6sm6861387wmb.25.2018.06.27.12.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:54:29 -0700 (PDT)
Date:   Wed, 27 Jun 2018 22:54:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: put task earlier in /proc/*/fail-nth
Message-ID: <20180627195427.GE18113@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1366,10 +1366,8 @@ static ssize_t proc_fail_nth_read(struct file *file, char __user *buf,
 	if (!task)
 		return -ESRCH;
 	len = snprintf(numbuf, sizeof(numbuf), "%u\n", task->fail_nth);
-	len = simple_read_from_buffer(buf, count, ppos, numbuf, len);
 	put_task_struct(task);
-
-	return len;
+	return simple_read_from_buffer(buf, count, ppos, numbuf, len);
 }
 
 static const struct file_operations proc_fail_nth_operations = {
