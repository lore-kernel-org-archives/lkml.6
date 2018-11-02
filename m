Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0532082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ7hsPwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0532082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKBVHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:07:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39539 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:07:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so924345pla.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=80SoBM4vcEp7w8ioWDz9BcEWqjki9aw1JnhQvsmBBDw=;
        b=iQ7hsPwLyi7ngXT8VDiQlN/+B3dAzc0WLzwLDdNrT+DL/EdWBE+4W5gqI23104a9px
         mSAm0tOUHGIRstaynw4jNIzt2MlCF4vB/4v7rdho1f0FgQQ6PwIMF8C7Ggz1GTujGzpZ
         RJC+3WJuZHdRhFLK5+GLGD2KW8mYsM7lsgb4OSUKhEJ0nQomh5YXf/UFSNGGHHUUo25g
         33U6WdML9JnNgWCCWY8hvWP7iZgTlfzh12Ze1af9n44M8lT0fTNMboMzOGU909vdlqji
         Oykzuy9r62/bJLq6RZ2LAQlt/Rqdh+MrCG9lPwG+U1jFv1IWhU/4B412ta8VKftoXFTA
         4lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=80SoBM4vcEp7w8ioWDz9BcEWqjki9aw1JnhQvsmBBDw=;
        b=gmGWmrp1/71Z34Vch+0LP1Ve/zZY18RcsMEBVCJgLpzaUU4v+uUQW8DmX6EDXuHgJF
         TGucImbNMwMQ2ZE+ZYCbwTQTi3RTMHoUGbGqchpk+MWKpbNtr8g/CFjh3O+VOZ3CzRzT
         aClBnvi6eNwZIgP5VQqPJQ98Q/OfbOHNRTTjRj1MBmY/Gtvb0r3F1sQIK0vR8P48wgnH
         CpLbJ2DLpfCNjUJoEqbv/Pmo+DDI1TNO/i2unx2rx+Tkt3QgMkF3hb80EbRyotwfu2dg
         Dj2w2LMOABpxcUByqCwVLRI/+tYeZKmyV/MpsMBcZmQNKja+UkAHflrlx8O2NLTTDUSX
         VsCw==
X-Gm-Message-State: AGRZ1gL8M/50S0Sa1HhkUI0PMH+EJomBREaPfNZrP44h5Qx57lMCJtIg
        m2Cs0Ec5ZfM2ikIs5u6fH4s=
X-Google-Smtp-Source: AJdET5dKfaQ5ARoZ8+i3NiAesv3oYx6oGkdd/WEeBK1QPawnarZ5CfBggBR5q2sUivd0bDGthaIQTQ==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36-v6mr11362308plg.234.1541160018086;
        Fri, 02 Nov 2018 05:00:18 -0700 (PDT)
Received: from localhost.localdomain (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id o30-v6sm27691325pgm.89.2018.11.02.05.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 05:00:17 -0700 (PDT)
From:   Balbir Singh <bsingharora@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] mm/hotplug: Optimize clear_hwpoisoned_pages
Date:   Fri,  2 Nov 2018 23:00:01 +1100
Message-Id: <20181102120001.4526-1-bsingharora@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hot remove, we try to clear poisoned pages, but
a small optimization to check if num_poisoned_pages
is 0 helps remove the iteration through nr_pages.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 mm/sparse.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 33307fc05c4d..16219c7ddb5f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -724,6 +724,16 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 	if (!memmap)
 		return;
 
+	/*
+	 * A further optimization is to have per section
+	 * ref counted num_poisoned_pages, but that is going
+	 * to need more space per memmap, for now just do
+	 * a quick global check, this should speed up this
+	 * routine in the absence of bad pages.
+	 */
+	if (atomic_long_read(&num_poisoned_pages) == 0)
+		return;
+
 	for (i = 0; i < nr_pages; i++) {
 		if (PageHWPoison(&memmap[i])) {
 			atomic_long_sub(1, &num_poisoned_pages);
-- 
2.17.1

