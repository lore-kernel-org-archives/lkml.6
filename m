Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341582081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341582081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeKGTs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:48:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45883 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:48:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so13776131wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sxkTZHicSbXm+D7X6j1gdenRf/8OtsBZxrvgNV+3/Pg=;
        b=NZ/HNQKfXFk87vSx7WKyzfkP11KUm/XJu19ZWms8uWnX/vASH8gvGlj+XuPGIBXcHa
         yy9LNPP1Pb5R4shDnaGpmNLeFCn/cIMjjD6MGFA2094YlGC8EiI95s6RXp8kSbkPuy2V
         vu0h8AsG/7ZX3gsIld7E5seHgxdWj6Gu0kQb5j3mTxQ9Nr/YrsYf/8TQ4YC1eM7PJUzm
         TD8L1T5OP1vdN8zJQI+VpguARwfnctfyVMEqpQFICdwqBmdEH9OX0dksebXBnQ3/Lhnb
         P4x2zohFYV411r8aJYY/JKkzG+66qp8LuBzeD+Jd3pJ9fdHeRDlt3ogFfYIWhuOyvXW5
         OT/w==
X-Gm-Message-State: AGRZ1gI7nfgTtLJQV05Oi2ekTttvFr1mq8VaaJhPFPA9Bjgj1IsCgYx5
        JhqKdt2YMBAIJic3CDn/s1M=
X-Google-Smtp-Source: AJdET5da/PJmeqaS7uG3tevVjQEiAicJwUhwTYG/DXJZBvyXu+4NAQE6fmMLtBUfV9NkYzZKD8BCcg==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr1278377wrx.171.1541585922651;
        Wed, 07 Nov 2018 02:18:42 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-140-85.eurotel.cz. [37.188.140.85])
        by smtp.gmail.com with ESMTPSA id w18-v6sm217527wrn.66.2018.11.07.02.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:18:42 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/5] mm, memory_hotplug: improve memory offlining failures debugging
Date:   Wed,  7 Nov 2018 11:18:25 +0100
Message-Id: <20181107101830.17405-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have been promissing to improve memory offlining failures debugging
for quite some time. As things stand now we get only very limited
information in the kernel log when the offlining fails. It is usually
only
[ 1984.506184] rac1 kernel: memory offlining [mem 0x82600000000-0x8267fffffff] failed
without no further details. We do not know what exactly fails and for
what reason. Whenever I was forced to debug such a failure I've always
had to do a debugging patch to tell me more. We can enable some
tracepoints but it would be much better to get a better picture without
using them.

This patch series does 2 things. The first one is to make dump_page
more usable by printing more information about the mapping patch 1.
Then it reduces the log level from emerg to warning so that this
function is usable from less critical context patch 2. Then I have
added more detailed information about the offlining failure patch 4
and finally add dump_page to isolation and offlining migration paths.
Patch 3 is a trivial cleanup.

Does this look go to you?

Shortlog
Michal Hocko (5):
      mm: print more information about mapping in __dump_page
      mm: lower the printk loglevel for __dump_page messages
      mm, memory_hotplug: drop pointless block alignment checks from __offline_pages
      mm, memory_hotplug: print reason for the offlining failure
      mm, memory_hotplug: be more verbose for memory offline failures

Diffstat:
 mm/debug.c          | 23 ++++++++++++++++++-----
 mm/memory_hotplug.c | 52 +++++++++++++++++++++++++++++++---------------------
 mm/page_alloc.c     |  1 +
 3 files changed, 50 insertions(+), 26 deletions(-)


