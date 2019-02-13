Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F830C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BD7222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRsFmn7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbfBMN6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:58:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbfBMN6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:58:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so2627529wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oa2C9YpwVP4acC+vx0vAyuhET6Eq6DJxoD9AMTm5eV0=;
        b=kRsFmn7OVbjdcREztoEjmqqR5rmyygYeAE+WMFiiQ6sFhAi82Q5MDKUh9A16xtT5JW
         /SQv2U5Wlbn6W94LeKGcEiCI+F4m8OdDclPsSMhUqBw5fApBz1U/toUIZKSY8MuAUBjO
         6M1ff8yThJPJ2dJ1ZPZtsat1y+jg2xvHBF04I2qBkl6GcEr0Xfwk3k2Vf9eqPvNmQeho
         /pY/KmEJrzpHXFKDr7ZWEJOaQXGCR3YmssPvpdi0UJOts5yXPZr7sP2Ejw3l4VAsY3dS
         963mQxVU+K1gxD9d4wiRrR9fHIQjBq3/rl7SL549MH0Lb3to/bDI/FukbcVC1H2Qrqtf
         eEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oa2C9YpwVP4acC+vx0vAyuhET6Eq6DJxoD9AMTm5eV0=;
        b=g687eMFxOSedZr2Yj177PiA1jUU3Fyvw2R+VajbW7s9HbJZwQNNv5wd8hKEcRNMHMn
         LpnhwlKXCdHLOnwx5A+XRavwzPsWJimEQLbDwZbcL21o3VRDS/vBCEhd6CxC39YxWbyG
         mY7HNEunWoXZk2j6jLZFZE7S23m6faAZCFx0J+WwoyGZIecLpeLCc7+sEmOuxF//tLdE
         RqZjghULZ4IK15JQn+oivosdZC19KGY+04EF64bhAdhrd5tE4qWCl3xfzU6YdGEEwAw2
         wCybl6NTKqPt78mJZGtCs8xZWtqNie8qsZNy7P74W8TnlcbqcAh0mC/4WD8uFeUEzYoI
         YmFw==
X-Gm-Message-State: AHQUAuaSm4x7cJ3VR/Kb/312KONSdwREmCD+16SxNG/TGkO72s0lAXMU
        MfNRvY0+MPSWd15M6qwv7yMc2A==
X-Google-Smtp-Source: AHgI3IblUdp24VTe0Xsfg2eryeBWFR0ujqHQHBSOoLBlpfNOPNi1X8GGdCQvSSPbkVuV1YEk3IDGzA==
X-Received: by 2002:adf:b783:: with SMTP id s3mr552411wre.274.1550066316297;
        Wed, 13 Feb 2019 05:58:36 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id v9sm11195866wrt.82.2019.02.13.05.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:58:35 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 0/5] kasan: more tag based mode fixes
Date:   Wed, 13 Feb 2019 14:58:25 +0100
Message-Id: <cover.1550066133.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Add comments about kmemleak vs KASAN hooks order.
- Fix compilation error when CONFIG_SLUB_DEBUG is not defined.

Andrey Konovalov (5):
  kasan: fix assigning tags twice
  kasan, kmemleak: pass tagged pointers to kmemleak
  kmemleak: account for tagged pointers when calculating pointer range
  kasan, slub: move kasan_poison_slab hook before page_address
  kasan, slub: fix conflicts with CONFIG_SLAB_FREELIST_HARDENED

 mm/kasan/common.c | 29 +++++++++++++++++------------
 mm/kmemleak.c     | 10 +++++++---
 mm/slab.h         |  7 +++----
 mm/slab_common.c  |  3 ++-
 mm/slub.c         | 43 +++++++++++++++++++++++++------------------
 5 files changed, 54 insertions(+), 38 deletions(-)

-- 
2.20.1.791.gb4d0f1c61a-goog

