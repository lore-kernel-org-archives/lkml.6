Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83052ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6BB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6BB2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeGRNZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:25:24 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38063 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbeGRNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:25:24 -0400
Received: by mail-wm0-f45.google.com with SMTP id 69-v6so2735473wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 05:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ulM6Uws4KEszfuHE1PFThmF06OUCNaEC8I4xhB7aV4Y=;
        b=FhBv8eT3H8BZE+iDBi6/lW3P1Qu7uzr03pdsCuXzLhjCyNlfDeY/1+fFgJBeA/DKO6
         MtPk2rajfrJCaTFmtA0HQ4IeF6+JhMOtZQ/JpcxMl00BNBHOxYBeLqnrSR+8twWXBCi5
         A/u8N7oxb2X958H0EvAEA3vU0pdwUn0nnr9m/jEHdc2paIHh9uqCOEqGw8hnn6mfBSw9
         TM2ugYnj4qlTTEmzVeDnSVbWxxSZ7YvxIe9npZRjJq208UyHy36mHxADD5v2ypbcT29M
         LzTObNqA9RGkGXLiYJFRKLXP1Ukou/jbhaRHd8LgUffaS5ePLi925p6ojOM67U+vUuw+
         GCXQ==
X-Gm-Message-State: AOUpUlGhIdN50Z+5OvMafKqtHfTEEBVWJraO8o7UgpFuC6/iqQ1KE6Vw
        Cq/sSHFBMPkpZzpYEApVmYk=
X-Google-Smtp-Source: AAOMgpfJ4Gr3jFHLFABCaaz0763WQl2T394k2Kg7jYqIdnG0kNek7X3GShROaAObFlMoqwq11G91mg==
X-Received: by 2002:a1c:1609:: with SMTP id 9-v6mr1515151wmw.12.1531918057291;
        Wed, 18 Jul 2018 05:47:37 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id s5-v6sm4229368wro.33.2018.07.18.05.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 05:47:36 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id ED2BA12401B;
        Wed, 18 Jul 2018 14:47:35 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/3] Re-structure free_area_init_node / free_area_init_core
Date:   Wed, 18 Jul 2018 14:47:19 +0200
Message-Id: <20180718124722.9872-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

When free_area_init_node()->free_area_init_core() get called
from memhotplug path, there are some things that we do need to run.

This patchset __pretends__ to make more clear what things get executed
when those two functions get called depending on the context (non-/memhotplug path).


I tested it on x86_64 / powerpc and I did not see anything wrong there.
But some feedback would be appreciated.

We might come up with the conclusion that we can live with the code as it is now.

Oscar Salvador (3):
  mm/page_alloc: Move ifdefery out of free_area_init_core
  mm/page_alloc: Refactor free_area_init_core
  mm/page_alloc: Split context in free_area_init_node

 mm/page_alloc.c | 181 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 114 insertions(+), 67 deletions(-)

-- 
2.13.6

