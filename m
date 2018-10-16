Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B953C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D256B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WGlQ2pnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D256B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeJQBfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:35:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42739 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeJQBfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:35:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id y71-v6so21721452lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdabV/sgKBvvccjjsOAMlvUJaP4/pMcygvoftqw2KQ8=;
        b=WGlQ2pnu8k8Br7WX9ZAeZqUF28iw6BQbnJWfcE+C419xkiNDRt9+D46PnrGwZxz9j8
         /rjCydIDmDSdw21sztvdlB4s247LMjeI0MogrSTfeQEcn+Zz2ELIAA2RiT2bJxBAFs7T
         HvGEZ4HFXyUs9VhLcOC+3aLibQfo2MUEFoo3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdabV/sgKBvvccjjsOAMlvUJaP4/pMcygvoftqw2KQ8=;
        b=SiTWVDWOFKusTQyYvITEalJA/BZnkEtcLQ2IDemPB1lrtfKR1am465jTHX4eIBRX0F
         30USTbocGEdpOxVe04SLuC95aZJ4I2Cv1iNmNbKlMeCykCpYU8gdcgyzydVkQNKUy/Pu
         9eyoMrFrP30Gz/lrZ+ueepjSxvNBx3rKeiEGpIT39Rq9RxYnkHYqKXnUNt3LLA3Ni9xT
         HeazZ4xvcCjAXCHJNVPc0jXAoS1zsqVTNj4/dioU8YBWN9wouFs6LrdsZGBBKfnSJHat
         WmyAPIOAoC+CEDe2i3mwZrXvM5CPD1Kxq7nu80TuZD6MN4t96vfcDJgvBf0mlJGfu86H
         cKhQ==
X-Gm-Message-State: ABuFfoi/9vn/JkBNJdmH9TsexLZQD43BCZ450dCa5vTEa1HzjRD8wP9I
        AbqpTcv08SAeUdS2bjs2nPwUCj/PU9WpaW0=
X-Google-Smtp-Source: ACcGV60n3KxRuwWbMx9TRgbL+ZmsufZC6eWQZjQ3HGgqZAlHY8MpzRj9CGcLzN+F8E4/xA7lRbyotQ==
X-Received: by 2002:a2e:b017:: with SMTP id y23-v6mr13922375ljk.82.1539711837360;
        Tue, 16 Oct 2018 10:43:57 -0700 (PDT)
Received: from vovoy-z840.tpe.corp.google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id r4-v6sm3358752ljg.12.2018.10.16.10.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 10:43:56 -0700 (PDT)
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     mhocko@suse.com, akpm@linux-foundation.org,
        chris@chris-wilson.co.uk, peterz@infradead.org,
        dave.hansen@intel.com, corbet@lwn.net, hughd@google.com,
        joonas.lahtinen@linux.intel.com, marcheu@chromium.org,
        hoegsberg@chromium.org, Kuo-Hsin Yang <vovoy@chromium.org>
Subject: [PATCH 0/2] shmem, drm/i915: Mark pinned shmemfs pages as unevictable
Date:   Wed, 17 Oct 2018 01:42:58 +0800
Message-Id: <20181016174300.197906-1-vovoy@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a graphics heavy application is running, i915 driver may pin a lot
of shmemfs pages and vmscan slows down significantly by scanning these
pinned pages. This patch is an alternative to the patch by Chris Wilson
[1]. As i915 driver pins all pages in an address space, marking an
address space as unevictable is sufficient to solve this issue.

[1]: https://patchwork.kernel.org/patch/9768741/

Kuo-Hsin Yang (2):
  shmem: export shmem_unlock_mapping
  drm/i915: Mark pinned shmemfs pages as unevictable

 Documentation/vm/unevictable-lru.rst | 4 +++-
 drivers/gpu/drm/i915/i915_gem.c      | 8 ++++++++
 mm/shmem.c                           | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.19.1.331.ge82ca0e54c-goog

