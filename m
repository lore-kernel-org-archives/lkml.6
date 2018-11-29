Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16008C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD313214D9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="luD0wds/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD313214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeK3KQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34953 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeK3KQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1801321plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hrVGyYTwvdgCGF6bcbLemjDmfoTY1xGQakJ1a8GNZ7w=;
        b=luD0wds/NeiE8ipN3F29SUnrIiEk8+uj/PCO5gE+CLkq4sziNqtpP5c+WaLwlktCZZ
         CK0wPfzOJvTfwx5dNSS6js5XxGD2/UtOR46awtq9J0MKeW9rH8esGMNAaewgca1yd0A3
         uaXpz56G8nM23JQCYWf31LuKv7i9kjSMCiFxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hrVGyYTwvdgCGF6bcbLemjDmfoTY1xGQakJ1a8GNZ7w=;
        b=CAelf6/+TAHZ76+oG9xFPVF4lolOrQMdbMlmNcoKobNxUHujpbk65moFQRpxm1nSwg
         X1svNfsS+KTUVdvU8LRkr7hHiqM29sO9Yk25fu42zCTSiF+Jrucpji+iMfTFByvzP1t3
         lJVB3xeIYMXCDjcADugRkN2FeK4ldAExtrqsMpYzG4Ridf/YFMqmI0K2TrCBsXJf6ji0
         aDDC7hMMf7serFnbiJGG5biSGZM0LxXg/2LdIbkZURlPhFF2kjYl2iERKSU4kfIyDVSz
         bLNV2VAPJQsJaqgX69jIG6ozQxcnITfTAky9hjXy0iQcJWmqOXSnbYLn0e/002Gv1SKI
         BBrg==
X-Gm-Message-State: AA+aEWZ2QDmTNp/TiQ0FsHNDcvLm+1vsfvTJ3URx3rRFRv9dlwgS0Kav
        tkwecIv43XHNEsiS/xuoPDQ8Yg==
X-Google-Smtp-Source: AFSGD/U83vOLKwfUAMUNXn2vAKsefInfRcag/OHQ0Lwm1yqPWuej5bBBcsgUoMLbXp0iPPKThE64Ow==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21mr3430854plo.183.1543532933368;
        Thu, 29 Nov 2018 15:08:53 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x19sm6173077pfk.14.2018.11.29.15.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 00/12] pstore: various clean-ups
Date:   Thu, 29 Nov 2018 15:08:29 -0800
Message-Id: <20181129230841.29955-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of clean-ups from Joel Fernandes, Peng Wang, and
myself. I wanted to put the entire series up for review since they've
changed a bit from their earlier incarnations. I intend to push them to
next shortly...

Thanks!

-Kees


Joel Fernandes (Google) (3):
  pstore: Map PSTORE_TYPE_* to strings
  pstore/ram: Simplify ramoops_get_next_prz() arguments
  pstore/ram: Do not treat empty buffers as valid

Kees Cook (8):
  pstore/ram: Correctly calculate usable PRZ bytes
  pstore: Do not use crash buffer for decompression
  pstore: Remove needless lock during console writes
  pstore/ram: Standardize module name in ramoops
  pstore/ram: Report backend assignments with finer granularity
  pstore/ram: Add kern-doc for struct persistent_ram_zone
  pstore: Improve and update some comments and status output
  pstore: Replace open-coded << with BIT()

Peng Wang (1):
  pstore: Avoid duplicate call of persistent_ram_zap()

 drivers/acpi/apei/erst.c   |   2 +-
 fs/pstore/inode.c          |  51 ++-------------
 fs/pstore/platform.c       | 129 ++++++++++++++++++++-----------------
 fs/pstore/ram.c            |  75 +++++++++------------
 fs/pstore/ram_core.c       |  45 ++++++++++---
 include/linux/pstore.h     |  32 ++++++---
 include/linux/pstore_ram.h |  50 +++++++++++++-
 7 files changed, 212 insertions(+), 172 deletions(-)

-- 
2.17.1

