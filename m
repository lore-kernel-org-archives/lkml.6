Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCC9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E238F2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E238F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbeKPSlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:41:52 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40390 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:41:52 -0500
Received: by mail-ed1-f51.google.com with SMTP id d3so18356353edx.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 00:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNJ+m15LciZQg8455eEFiwq59fDC0IvIzYdogCG8KR8=;
        b=rT28BlQrAsCqiZr+inAmias7lYnlsTGdTaj+Jko6gEDx/twzGIFwqV/t7kttCrlngN
         SS7biSjPdawnZrHsnf9UYNQTTWlqH1QJsR7GCL/e0kHQMPxiDDOXxhYvvAXvIi6wjKci
         bB2yf0hellrb6Ox+7oejLrZatqicoaNH4vBZwPa2OvncAlnOhaOPBf0tnPeIrl6BxprW
         gs9WjPHNjTh1E32xp6TlVuJjqi9btSlrz+I2Gw79uoQuq2nExpQuSqRsHqGoTNbmv/W4
         iJMa54Cl85BWIQJaY70iYAxVHVEPWwLLqsUCNzF0inGbKMuDDz1hGLYQu2q0WQzGcKP/
         1NVA==
X-Gm-Message-State: AGRZ1gIUxpQ035sN0QjkVPi7k1v4aLeQGZthryEwWLW/F22f1QwlUj9t
        Hl+qD5FvQ6DCqTDKxXGT5mk=
X-Google-Smtp-Source: AJdET5dR7/BVul/SXsyz6L4/TIem+WYYb1wKMnbnBzxsamXQOdR6tBj3/H2oaDM/D207uoo0yeixVQ==
X-Received: by 2002:a50:88c3:: with SMTP id d61-v6mr9024807edd.14.1542357031214;
        Fri, 16 Nov 2018 00:30:31 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m13sm5305393edd.2.2018.11.16.00.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 00:30:30 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <OSalvador@suse.com>, Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] mm, memory_hotplug: improve memory offlining failures debugging
Date:   Fri, 16 Nov 2018 09:30:15 +0100
Message-Id: <20181116083020.20260-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this has been posted as an RFC [1]. I have screwed during rebasing so
there were few compilation issues in the previous version. I have also
integrated review feedback from Andrew and Anshuman.

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

[1] http://lkml.kernel.org/r/20181107101830.17405-1-mhocko@kernel.org

Shortlog
Michal Hocko (5):
      mm: print more information about mapping in __dump_page
      mm: lower the printk loglevel for __dump_page messages
      mm, memory_hotplug: drop pointless block alignment checks from __offline_pages
      mm, memory_hotplug: print reason for the offlining failure
      mm, memory_hotplug: be more verbose for memory offline failures

Diffstat
 mm/debug.c          | 23 ++++++++++++++++++-----
 mm/memory_hotplug.c | 52 +++++++++++++++++++++++++++++++---------------------
 mm/page_alloc.c     |  1 +
 3 files changed, 50 insertions(+), 26 deletions(-)


