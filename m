Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F53420869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Zhka//Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F53420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJSXSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:18:20 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56884 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJSXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:18:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id BB6C683A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 15:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Shdtgeqzitm7 for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 10:11:47 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 8D069D12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:11:47 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id k69-v6so4073595ite.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KiNkAMv4vigjZ1KFfGZFY57CAVsceXIlagVNUKEhWKw=;
        b=Zhka//SmED2qrbLWPs1tc4W+mbNAKKC8sw+HdLMr+S94yZ3hUbtGXpL42n+/b2/ORp
         OcGj8v6EWnHm1P0W2vbvzn+6MD5Rxlf05WIx9Tb9UypOkM6CThIg4wqzc74BBxrRzEPn
         tXn3i5JMlJcGlxHKPNKX4MSWP7SO/jayQGABisTAaWrnz/mLhyQU+rbfhepo+woY8g/g
         v8lb1UDnG3EcKbuR4s9f5OSyVaxfYhSOiOg3KojCdQbgMH3tvLJ8IbnVic98qHNZQpZn
         TRUlYRXw0OzjAmWTOHgiSmbntegBEnht8h2n55uuEewzn1YTlBRJ7xkgAhrI+v9uFCkx
         /JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KiNkAMv4vigjZ1KFfGZFY57CAVsceXIlagVNUKEhWKw=;
        b=ZoZUkRdlr/MJHATLDPiheXLgxUrZuC52liG60D7oC58kJHvwYoyLEbu6PQssKiilIg
         jcLGTurkLT1/Cru2vVNVCE2MErzXcrRzb3Ng2yTRvrztznXlYKbY2Y1B57KHwJU+s2HT
         9MS5j9e/VV/1Y3cFwpHbj+SzV/+YfmvvJH4ni+rUbIqE57x2eJ/0oQeQBuC0gFBbCkp8
         ZVXEOOHDPs69HSCyxxGC+jHbu+tStX+bCMdIH0JyWVD2R1QLkjTdhAUCa94Ovtd9gxeR
         pnu+mrntwzDMD7hw6R1IfgESk0OMrfoLqF0QSlGe2MBZ/RSrNiwE8X2jxBIowRkdyXMN
         LpZg==
X-Gm-Message-State: ABuFfoi6R3WrBB3KYDjilM3yx0ufbx+CnZJ6ITxCKMcE4m87+B4yoNYo
        0f+zGvAoD+zQohElIXHEH70cvp8laK1Lt4cxI9bIdx6fvSY+vASCy8KGHIyJ5Rfa/Cidz8a7iHK
        Ab1EyaUwYmqD5X699T4Ql4UvoarhF
X-Received: by 2002:a05:660c:551:: with SMTP id w17mr3388311itk.63.1539961907005;
        Fri, 19 Oct 2018 08:11:47 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62wBmHCcdv09vcqxVpg6w2816s7zUCKM6bmq21FhDRvjGMlvK/8qOYoCiDcWw6OdIQgBDvjMQ==
X-Received: by 2002:a05:660c:551:: with SMTP id w17mr3388300itk.63.1539961906812;
        Fri, 19 Oct 2018 08:11:46 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id z13-v6sm7264935ioj.86.2018.10.19.08.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 08:11:45 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mcb: fix a missing-check bug
Date:   Fri, 19 Oct 2018 10:11:34 -0500
Message-Id: <1539961894-11928-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In chameleon_parse_cells(), to parse each cell, the descriptor type 'dtype'
is acquired from the IO memory region pointed by 'p' through readl() in
get_next_dtype(). Then 'dtype' is checked to see whether it is
CHAMELEON_DTYPE_GENERAL. If yes, chameleon_parse_gdd() is invoked to parse
Chameleon general device descriptor. In chameleon_parse_gdd(), the data in
the IO memory region is read again through readl() field by field.
Specifically, the 'reg1' field contains the type information. That means
the type is read twice. More importantly, no check is re-enforced after the
second read. Given that the IO memory region can also be accessed by the
device, it is possible that a malicious device controlled by an attacker
can modify the type information between the two reads. This can cause
undefined behavior of the kernel and introduce potential security risk.

This patch adds a necessary check after the second read to make sure the
descriptor type is CHAMELEON_DTYPE_GENERAL. Otherwise, an error code EINVAL
will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/mcb/mcb-parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 7369bda..f01a6c7 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -51,6 +51,10 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 		return -ENOMEM;
 
 	reg1 = readl(&gdd->reg1);
+	if ((reg1 >> 28) != CHAMELEON_DTYPE_GENERAL) {
+		ret = -EINVAL;
+		goto err;
+	}
 	reg2 = readl(&gdd->reg2);
 	offset = readl(&gdd->offset);
 	size = readl(&gdd->size);
-- 
2.7.4

