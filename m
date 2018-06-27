Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902BC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D319C258B3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sy6aaIgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319C258B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966531AbeF0UHO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:07:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52281 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965695AbeF0UHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:07:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id e69-v6so4218507wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3+ahptcnPLjqv9RbpM+7gBj5KyJMOYqs7rGDbhiIQM4=;
        b=sy6aaIgJxFliL2ovU22p/sh7+9I1fr8QQxInV+pteaTRZNfG1oq8OZOjEs3lGgLACM
         G8Tie6JOaqU8bAznpSFUX1j5mbzdnpZv8fxmmSbt9kUcT0Erwj/lEUo4sjk9en9nLeIm
         QhIoTRG30u4syxRkB8HuAXB76tWsGSDjzwxUv1HNomqQfNUwYbL/Znp1oU1+aTuRQPh1
         b1rZngWD+AHE6tq5Wb0CTOFSQO/Nof9KqfZuhQxDely5eOY4MugmNwim288GNE/6C+iK
         cbSaIeLZ1JOQeJfIAsoZ3YGMgKlszt4HsagJFA7/3J+Lka4ThNBH8hmAbqFlBXDYAGpn
         h7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3+ahptcnPLjqv9RbpM+7gBj5KyJMOYqs7rGDbhiIQM4=;
        b=S2me8M7p6L6UCTeWrCjIAnJJAuyazas1V09w8tynx8W99zx3nERvJpSOkNe8akp6mj
         w+9PTOMLiTwAl9oBvDVzq69uoaCTJaU+91Qv1YvNS+BeYndWTpiXhV1vhaarRpWrSBSP
         bBpNV1B+babsVs9RO4d8cdc4d0q78UqHzbdszuW5eDoVAJl8zDgw84h9a6J234BtsBAn
         xn2lwFcImVKbPDb70dGW4XFLsIx19jWOjOuI2UF7Bj2TlVQYsY+ZpnSgg4UHXGtCA4OC
         +Z864HO0i3Ap7U6hV+ZKb+RzyKiqpZNZQPTmjtIehrwk4B7rXDJL7ZzI927mQnuYfmKz
         3mHg==
X-Gm-Message-State: APt69E13WZfoyTGield/+RfXNGXILAYvgDTvXL1+vBAoCo8uz51aHweL
        N3yMsT7lXAH7QwXLN06Ucw==
X-Google-Smtp-Source: AAOMgpfuHPoNqqvIYdURnkbbuEmbbi7C5Q+m5Y28CnKl2zHhsknUkcjFnBo0/HlgdTRdwFfQ1cTAQQ==
X-Received: by 2002:a1c:cb8e:: with SMTP id b136-v6mr6166140wmg.112.1530130032620;
        Wed, 27 Jun 2018 13:07:12 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id r15-v6sm4523605wro.21.2018.06.27.13.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:07:12 -0700 (PDT)
Date:   Wed, 27 Jun 2018 23:07:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use "unsigned int" in /proc/stat hook
Message-ID: <20180627200710.GC18434@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of CPUs is never high enough to force 64-bit arithmetic.
Save couple of bytes on x86_64.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/stat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -183,7 +183,7 @@ static int show_stat(struct seq_file *p, void *v)
 
 static int stat_open(struct inode *inode, struct file *file)
 {
-	size_t size = 1024 + 128 * num_online_cpus();
+	unsigned int size = 1024 + 128 * num_online_cpus();
 
 	/* minimum size to display an interrupt count : 2 bytes */
 	size += 2 * nr_irqs;
