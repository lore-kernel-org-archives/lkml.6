Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F40C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3F320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3F320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbeGSOK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:10:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33579 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbeGSOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:10:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so8094043wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7t58BQP9CBS2eZVfsdI7jeLRMaby0oLDAT14rxZK8rc=;
        b=t1E1q/6W2dcZ47VF2atMTmiH8W1N42NfX1DaTcHO1M0+2TsAx2aNAlIY2N/Avhlwf7
         xrNK6St8FcOhnE+jG+ZA3qZYdCO4ZivfAKJbP4h/J5mrSJbVVobCaIuS7E9Z09eCpBY7
         JFJis5/dmJi33tnsJqGJT8Ym4g2rZHmZ4WbmwpYSsyhjicvuRmz2IMgdUbPWAzA7kAU2
         SNwafSKAFEv8E3EFvHIcbwrPdyNjnM4D69760yRMQ+q7QjFTo/rslNI3UR4uyFBN6SpL
         4ixiDjJb7PkWiCd2Z2iDuwzCJcPlGhbo08fJQOWxJjRvobVmWWz+/JQk3bSIor9aH/lE
         kxVg==
X-Gm-Message-State: AOUpUlG9uw3d5exX+Hwosd8BP3e6lGsASGddXjrv2DyIbo+gzP3UNpzu
        C0XEj3ov88V8JFZoAbDhRBk=
X-Google-Smtp-Source: AAOMgpd7m3DD5oMoJlWY/XN6C5HqsU+dlXOTAWitKuH2Xb2p9LenU0f5Ez/7mnFSJaFCagbes3kdZA==
X-Received: by 2002:adf:8466:: with SMTP id 93-v6mr7152585wrf.274.1532006865794;
        Thu, 19 Jul 2018 06:27:45 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f20-v6sm10205500wrh.89.2018.07.19.06.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:27:45 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 72751124166;
        Thu, 19 Jul 2018 15:27:44 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/5] Refactor free_area_init_node/free_area_init_core
Date:   Thu, 19 Jul 2018 15:27:35 +0200
Message-Id: <20180719132740.32743-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset pretends to make free_area_init_core more readable by
moving the ifdefery to inline functions, and while we are at it,
it optimizes the function a little bit (better explained in patch 3).

Oscar Salvador (4):
  mm/page_alloc: Move ifdefery out of free_area_init_core
  mm/page_alloc: Optimize free_area_init_core
  mm/page_alloc: Inline function to handle
    CONFIG_DEFERRED_STRUCT_PAGE_INIT
  mm/page_alloc: Only call pgdat_set_deferred_range when the system
    boots

Pavel Tatashin (1):
  mm: access zone->node via zone_to_nid() and zone_set_nid()

 include/linux/mm.h     |   9 ---
 include/linux/mmzone.h |  26 ++++++--
 mm/mempolicy.c         |   4 +-
 mm/mm_init.c           |   9 +--
 mm/page_alloc.c        | 159 +++++++++++++++++++++++++++++--------------------
 5 files changed, 120 insertions(+), 87 deletions(-)

-- 
2.13.6

