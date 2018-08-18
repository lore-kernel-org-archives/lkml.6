Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F09C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9F3208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gzojv32N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9F3208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeHRQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:32:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42766 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeHRQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:32:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so5962244edp.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cL+amC/EhTEPmd41EAlHN3lVoQDtEfn6cmvZ4nKzOvo=;
        b=gzojv32NLct438Ce4rRbM6o630C3PjAaWL0pryspZG5NNJUFuplQufVtE/XCsXWWHO
         0p+tTKVI+F3srVFC8f5+gw6rVlt6FK3dNTq2IyRPpOBtRs8ot38ULJw/OJZGWbS3jkau
         snFCK56WRhNUKAW/ezp6+oinhPJ9mcCJScVXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cL+amC/EhTEPmd41EAlHN3lVoQDtEfn6cmvZ4nKzOvo=;
        b=fsYY87LCdIgymd/Pi+kVsrUW+zcCcQhzNjFjumGh45lB+lnEpKbf5tlS+yvts1uTR4
         FsvXNaUU5wSWYjD5W4vrokhxaU8K5DmTlP78RY33o2I656Kv8m/y842qIeAu9jqid73+
         2zuVnSKqMyRbcz4pjMn3nqRnYLg8TRhpcT2dNBQyn6zti15Q5W07kIAPZzvqwnlQ/8l+
         g7Vhomd4CDNb2iQyXx9s62z015gbFfJs9lTv3yShrOWWMssbg1rMHAxLdsVc+MNuszfT
         R0r35rbzrmelCd2nm/HkPwWKrpWdQqCIwkZHj7qBuUpWKq8C6Uk4a1hzyOiU2+ffB4Sy
         8gBw==
X-Gm-Message-State: AOUpUlFxkHh7/GVTdOYHfqe0zRG1ue0eFj2htMgcYTDRwIZ1UVZGQEox
        TdqfMkHse7b5ArripCcRgXl4vw==
X-Google-Smtp-Source: AA+uWPwWun/4mMAkZ0+BhUifYyVaxX75RDphjddyTbgQoclYbztLcvqPXPweZIf/ImOcuJ5wUEvIVQ==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr48377120edm.106.1534598684438;
        Sat, 18 Aug 2018 06:24:44 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2739032edn.95.2018.08.18.06.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:24:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/8] seq_file: use seq_open_data in single_open
Date:   Sat, 18 Aug 2018 15:24:28 +0200
Message-Id: <20180818132434.9515-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the somewhat hard to grok assignment by using the seq_open_data
helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/seq_file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index c8c86660f6db..518a72e444d9 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -582,10 +582,8 @@ int single_open(struct file *file, int (*show)(struct seq_file *, void *),
 		op->next = single_next;
 		op->stop = single_stop;
 		op->show = show;
-		res = seq_open(file, op);
-		if (!res)
-			((struct seq_file *)file->private_data)->private = data;
-		else
+		res = seq_open_data(file, op, data);
+		if (res)
 			kfree(op);
 	}
 	return res;
-- 
2.16.4

