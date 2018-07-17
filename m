Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D985ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B75220C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B75220C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeGQL25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:28:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54467 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeGQL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:28:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so1027900wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8/ckz05765y3DTNEDB3T3WNjWl/CAJH1fHKMMtvJxDM=;
        b=CDsA6o4UKi9oCRS8CcqFs3fO9OG0Ip1oCRzxTjVb+WFztxuzGx45O7SuvQNBiR5TLb
         lzsJIcx2M9VyRCyyyLNYbBuDBiCBWlLT3kUqG4WurQLYqARLS6xrFNJPeOZizVCZdvfW
         /YFTY8HxKt/QMWNqvGBR8hA4uPPcbixh/+vjZe9Tokc50p1tH0yC62Vi2YwJ2A5GYMB9
         Q6qStoQ3UTQhm/8WZdzZiJ+RkMKlRsoDveD3LRPoHLHMEXkRGkRwR9drauyWsfnniieB
         NLIG0BdkbjOA+xqAgcCGSnKNp8V/1D9bBHueZgCbJXOD7xwzfgeXWB/s0nQVS7//mOq0
         KGmw==
X-Gm-Message-State: AOUpUlHHJtU/qxYRiITt2T3U67+717hFpDK82zN4spM/ksmeziIQ7bbo
        OW07DCJ7piY5MFjHEllgJoUFD6YY
X-Google-Smtp-Source: AAOMgpeNISCWhGr/uKqD/5xE0boN5eXLz8uA6ye1EluYmfnqPRY1l8k5IWpPRn8c2e5XMM5Tsb4KJA==
X-Received: by 2002:a1c:ad50:: with SMTP id w77-v6mr1097837wme.54.1531825013735;
        Tue, 17 Jul 2018 03:56:53 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1083583wre.21.2018.07.17.03.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 03:56:53 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 20BF2123F8B;
        Tue, 17 Jul 2018 12:56:52 +0200 (CEST)
From:   osalvador@techadventures.net
To:     linux-mm@kvack.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        akpm@linux-foundation.org, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 0/3] Cleanup for free_area_init_node / free_area_init_core
Date:   Tue, 17 Jul 2018 12:56:19 +0200
Message-Id: <20180717105622.12410-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

While trying to cleanup the memhotplug code, I found quite difficult to follow
free_area_init_node / free_area_init_core wrt which functions get called
from the memhotplug path.

This is en effort to try to refactor / cleanup those two functions a little bit,
to make them easier to read.

It compiles, but I did not test it.
I would like to get some feedback to see if it is worth or not. 

Signed-off-by: Oscar Salvador <osalvador@suse.de>

Oscar Salvador (3):
  mm: Make free_area_init_core more readable by moving the ifdefs
  mm: Refactor free_area_init_core
  mm: Make free_area_init_node call certain functions only when booting

 mm/page_alloc.c | 193 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 116 insertions(+), 77 deletions(-)

-- 
2.13.6

