Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9774E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfAHUdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:33:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36030 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfAHUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:33:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so2436631plo.3;
        Tue, 08 Jan 2019 12:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTXsaVss40almLHqHsDRF5KIiFFMihZGFy0rLMrD0mY=;
        b=s84Q+WI5X4aWLhsuT/0UygzIP4jAR0d2zCZss4IVH0/JyNs7UpjoeM5T4Va51i7pvY
         MHFmI4tQQayCNufGcQK7wbNz1p78vIg9vby4NH0FbZMprqUUP6Ck190bAf4ILQRwCFu6
         74/NTq4vvIQk/wJMMgtMAlO1gR7ZXPy4bTqhdfpY3OL4Ak93kWnMAH4geYD1oIL29ajn
         RBuKwuNuErK1Km3VDciO+ztNqL+A4hp/D2q0/VFKJHjOzgAYXJ1rjW0M/YNSTXMghubj
         lDtLxkxXqTXvReiIrL4L8u53Rv/IO69oIV4ylGGNL8731u1xjPB4lDmdG01UsFL+DSzY
         ed5w==
X-Gm-Message-State: AJcUukcD8kbQrvFQTCq3HrZg18BqqNTzvGDzbMaCE3HnfUQQv3xsJ4Yk
        OjUBXlQR20z9qzY5hrQuQbc=
X-Google-Smtp-Source: ALg8bN69VsdcY03pqQi5mjyG9gfxNb661+rftukSsb0tdOzKG0VQshGpLBhxAeI3NHnW7ieQkCQ6pg==
X-Received: by 2002:a17:902:b03:: with SMTP id 3mr3191295plq.91.1546979580490;
        Tue, 08 Jan 2019 12:33:00 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h10sm96687222pgn.11.2019.01.08.12.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 12:32:59 -0800 (PST)
Message-ID: <1546979577.83374.30.camel@acm.org>
Subject: Re: [PATCH] IB/srp: Use struct_size() in kzalloc()
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Jan 2019 12:32:57 -0800
In-Reply-To: <20190108160805.GA22698@embeddedor>
References: <20190108160805.GA22698@embeddedor>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 10:08 -0600, Gustavo A. R. Silva wrote:
+AD4 One of the more common cases of allocation size calculations is finding the
+AD4 size of a structure that has a zero-sized array at the end, along with memory
+AD4 for some number of elements for that array. For example:
+AD4 
+AD4 struct foo +AHs
+AD4     int stuff+ADs
+AD4     void +ACo-entry+AFsAXQA7
+AD4 +AH0AOw
+AD4 
+AD4 instance +AD0 kzalloc(sizeof(struct foo) +- sizeof(void +ACo) +ACo count, GFP+AF8-KERNEL)+ADs
+AD4 
+AD4 Instead of leaving these open-coded and prone to type mistakes, we can now
+AD4 use the new struct+AF8-size() helper:
+AD4 
+AD4 instance +AD0 kzalloc(struct+AF8-size(instance, entry, count), GFP+AF8-KERNEL)+ADs
+AD4 
+AD4 This code was detected with the help of Coccinelle.
+AD4 
+AD4 Signed-off-by: Gustavo A. R. Silva +ADw-gustavo+AEA-embeddedor.com+AD4
+AD4 ---
+AD4  drivers/infiniband/ulp/srp/ib+AF8-srp.c +AHw 3 +---
+AD4  1 file changed, 1 insertion(+-), 2 deletions(-)
+AD4 
+AD4 diff --git a/drivers/infiniband/ulp/srp/ib+AF8-srp.c b/drivers/infiniband/ulp/srp/ib+AF8-srp.c
+AD4 index 31d91538bbf4..0f855294ff3f 100644
+AD4 --- a/drivers/infiniband/ulp/srp/ib+AF8-srp.c
+AD4 +-+-+- b/drivers/infiniband/ulp/srp/ib+AF8-srp.c
+AD4 +AEAAQA -443,8 +-443,7 +AEAAQA static struct srp+AF8-fr+AF8-pool +ACo-srp+AF8-create+AF8-fr+AF8-pool(struct ib+AF8-device +ACo-device,
+AD4  	if (pool+AF8-size +ADwAPQ 0)
+AD4  		goto err+ADs
+AD4  	ret +AD0 -ENOMEM+ADs
+AD4 -	pool +AD0 kzalloc(sizeof(struct srp+AF8-fr+AF8-pool) +-
+AD4 -		       pool+AF8-size +ACo sizeof(struct srp+AF8-fr+AF8-desc), GFP+AF8-KERNEL)+ADs
+AD4 +-	pool +AD0 kzalloc(struct+AF8-size(pool, desc, pool+AF8-size), GFP+AF8-KERNEL)+ADs
+AD4  	if (+ACE-pool)
+AD4  		goto err+ADs
+AD4  	pool-+AD4-size +AD0 pool+AF8-size+ADs

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4-
