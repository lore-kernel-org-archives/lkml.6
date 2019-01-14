Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867E120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMyZkmzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfANUdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:33:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46794 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:33:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so377331wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRCHRN2zgbtb9dhSutp8UExL6ln3N5IjtJiROzv5+EY=;
        b=dMyZkmzGuBkiuiX9QEqhmTwAO2uepDIlG1/kHyocEEQz/j52tzpAIvBu8q8jRqAWIl
         e76Ahav0SDRH+xbt4IHPqIP3rTqofB6PEu6SEy4nieMQch+mk5ITJ/SOdRUz073SiV4z
         DpIvLsB6OFiRehQUAUfFM613vB6qeyD37Hz6mJkUJjSG5cU5zDJXzAyE2F/Fhg9urNcX
         B+IiRSGjIoElXrf02yk6NqejBBKVKK5vfAHKYXUdU3on2ksmiSbniiqQZHjaRFr8y1J+
         Ef3lRESLz9PXxb4gi/3u8zmzc1XR+trlXV/6Rc/I4MQmUm1C9u4YML+6t1QUTwQKUY97
         iPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VRCHRN2zgbtb9dhSutp8UExL6ln3N5IjtJiROzv5+EY=;
        b=m6Z1UprCA7FowbVYP6RGTzfT8sFvEPPkfDwlG9TiRrDtmiBsSXxJhB3hrbxTPc91WW
         8YLZAfrMGES0906csiNNPPd+9OtR4P7ftryxaXkfxMtopsICcljwUv92hKZ+HlCXTK6+
         GdyrguAFr9ApTX5H0ivBYZoM0zgWd8RfsOQfwd5u+y08JhoK3qyicNmgyTgBPbxUWluX
         cZgtR6CSK4C6r0oYhP/SDqXmvj8KX/AUZMSDiOYc7SkC41sAfcnT1sPt2sVnEGDElA6O
         02zigscxLxl4UBZIYZh5oAAw00ve9jmrX3etQtoB27NPJtDJs4Eetvu387fS3dt29ZlX
         Ae9g==
X-Gm-Message-State: AJcUukdGYXIfGBng5wUCgy80uxVBWJ8N0O2OQknd9mfXpDi9rMk7kuoB
        pFptMZ4HnyFzTXki2ZNJCBhZ14kx
X-Google-Smtp-Source: ALg8bN4eLhppAZc7/JRw4NQoBqBjWGJFk8weR3/ODNI1uv0Ajqcmior+QgUMOv7RW7YKnip8Co30uA==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr173250wrx.259.1547498030198;
        Mon, 14 Jan 2019 12:33:50 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id e17sm57309842wrs.79.2019.01.14.12.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:33:49 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 48CC611422AD; Mon, 14 Jan 2019 21:33:48 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sys: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:33:46 +0100
Message-Id: <20190114203347.17530-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  kernel/sys.c:1748:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index f7eb62eceb24..dc5d9e636d48 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1747,6 +1747,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 
 		if (who == RUSAGE_CHILDREN)
 			break;
+		/* fall through */
 
 	case RUSAGE_SELF:
 		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-- 
2.19.2

