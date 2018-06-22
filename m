Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C70C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F7B23ABD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F7B23ABD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932752AbeFVLTJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:19:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39092 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFVLTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:19:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id b8-v6so900812wro.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+he5sRaxbjfcKTu9ZUfLopJPqHtyIfy96fFbxNAyckg=;
        b=p1GcjB7jPQO9hZxS3XXFN6417ugerJkgnaWu6wS1UJIDNqy0G9VbXve6zHkxRLO05f
         64KoLwp/g2Z+yFOB8+MB6DleTTGqlMpIAWSSnv/RQH/c0XIM7XsyAsTnAGo3rq+2ceQP
         iBbqpgLAWUrtyZo7VRogMe4m6kfcxTVkpPwF8a7mHSiaqRL56WwHm5H0/6RzKzCisImw
         0Dgj908O2A4UE4sAtJeclGR42v86+ieOAv8YDOQERCDnRo0VeDlnrYZQGvahVwqR88mm
         S8mWW2d4V6ITr6yJWdDzTaqGXvGH1wZ1IpWCjQWDoM4xybbjGfkQlOsNG6CCZK9+SgGy
         36YA==
X-Gm-Message-State: APt69E3uNusYHuqFrSd4MnkMmT8w3VhlXN0R1z9CCSjSqjPbRvV3APnJ
        JjJHSECGR+lTEt8l0LIAtDs=
X-Google-Smtp-Source: AAOMgpeKcBUXyu55VGaUKtnlTqZNNVF9L1mS20ymeuo7IiEVm/+TgnWVxOWNbasaUWkyCUrfKFXAWg==
X-Received: by 2002:adf:824e:: with SMTP id 72-v6mr1269355wrb.127.1529666347263;
        Fri, 22 Jun 2018 04:19:07 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2297587wmh.38.2018.06.22.04.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 04:19:06 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id B31F4123759;
        Fri, 22 Jun 2018 13:19:05 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        Jonathan.Cameron@huawei.com, arbab@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/4] Small cleanup for memoryhotplug
Date:   Fri, 22 Jun 2018 13:18:35 +0200
Message-Id: <20180622111839.10071-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Hi,

I this is a small cleanup for the memhotplug's code.
A lot more could be done, but it is better to start somewhere.
I tried to unify/remove duplicated code.

The following is what this patchset does:

1) add_memory_resource() has code to allocate a node in case it was offline.
   Since try_online_node has some code for that as well, I just made add_memory_resource() to
   use that so we can remove duplicated code..
   This is better explained in patch 1/4.

2) register_mem_sect_under_node() will be called only from link_mem_sections()

3) Make register_mem_sect_under_node() a callback of walk_memory_range()

4) Drop unnecessary checks from register_mem_sect_under_node()

I have done some tests and I could not see anything broken because of
this patchset.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since v1:
- Address issues/suggestions in the provided feedback (Pavel Tatashin)
- Rebased

Oscar Salvador (4):
  mm/memory_hotplug: Make add_memory_resource use __try_online_node
  mm/memory_hotplug: Call register_mem_sect_under_node
  mm/memory_hotplug: Make register_mem_sect_under_node a cb of
    walk_memory_range
  mm/memory_hotplug: Drop unnecessary checks from
    register_mem_sect_under_node

 drivers/base/memory.c |  2 --
 drivers/base/node.c   | 49 ++++----------------------
 include/linux/node.h  | 12 ++++---
 mm/memory_hotplug.c   | 96 +++++++++++++++++++++++++--------------------------
 4 files changed, 60 insertions(+), 99 deletions(-)

-- 
2.13.6

