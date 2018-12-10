Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415CFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EC72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="esF0Mli6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EC72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeLJKgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:36:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37056 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJKgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:36:49 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so9029084edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHgtkUGVcvpgzhETYMo/2SzWCzk6dK1Ck+bZnuu58oU=;
        b=esF0Mli6FxxuMXFvxes55/PrWqaoTMxw0hUu4Xz+/OsOeeyN/4ksihAcNrt3ARkwPx
         n+jFHR8wx6zoKp/AD0o/FwjsgcxKBKxN+FN6Urymse2lPoy5jlGHF9rjQ2ph306rnTXc
         5DCHMnR2BCiAsL1d3BKqdnv8cr08rZqz6bUe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kHgtkUGVcvpgzhETYMo/2SzWCzk6dK1Ck+bZnuu58oU=;
        b=Na2lJbBQfX75r2vg3Lj8Ie3uiCFOKUlMNssTZLSrk+L5SsYNgpyhD+11yoAcTx8SmC
         VjYelBg+KvaP9aUfPziMAfudZ5m6MwrjFEm1TU7rnJfN56Bd4YMRDI1xYqZhmH2aPdIy
         YaEFt3NOZr8I5enYcsRUDgG1FgckW0aSz8+5uXIObXc61PIKR8XY+//VW4nefrB7hcGs
         qux8dJZZcCexOL0kzX4ulSt3V3/gS+u/pKHDLSaWnfPaPU6FGzwEw7jTBvNY4VqLdbYW
         RRsZ3VTap31nUvG7W51SRD96bKXWejZzLRGbR7DfjSGBHI+eLNUATKILAzeLcsFKfVQf
         0lJg==
X-Gm-Message-State: AA+aEWZ1ciE/5leRHKE4gTfg2DzSqJeU3eJ9hh5M+jS94vbKIdepoHcM
        itLhSqvxWlcyk/PsFjYFuColKl+nCBg=
X-Google-Smtp-Source: AFSGD/X9thuZziLfMKciJ/lloEpSjbW8YNS5f3BSsI9iIov+a41r0DESRxORBZOzbaPRhiXSvuhYgw==
X-Received: by 2002:a17:906:228d:: with SMTP id p13-v6mr748893eja.159.1544438207631;
        Mon, 10 Dec 2018 02:36:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm3223862edd.66.2018.12.10.02.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 02:36:46 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/4] mmu notifier debug checks v2
Date:   Mon, 10 Dec 2018 11:36:37 +0100
Message-Id: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's v2 of my mmu notifier debug checks.

I think the last two patches could probably be extended to all callbacks,
but I'm not really clear on the exact rules. But happy to extend them if
there's interest.

This stuff helps us catch issues in the i915 mmu notifier implementation.

Thanks, Daniel

Daniel Vetter (4):
  mm: Check if mmu notifier callbacks are allowed to fail
  kernel.h: Add non_block_start/end()
  mm, notifier: Catch sleeping/blocking for !blockable
  mm, notifier: Add a lockdep map for invalidate_range_start

 include/linux/kernel.h       | 10 +++++++++-
 include/linux/mmu_notifier.h |  6 ++++++
 include/linux/sched.h        |  4 ++++
 kernel/sched/core.c          |  6 +++---
 mm/mmu_notifier.c            | 18 +++++++++++++++++-
 5 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.20.0.rc1

