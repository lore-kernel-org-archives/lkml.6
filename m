Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3D7206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsmurEDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3D7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeIDW7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:59:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44386 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:59:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so2095832pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/1b21c7TXXIYptENM3vkWU/LhgwrOe4QldjnsHnHVgY=;
        b=lsmurEDi1XBXpErBJ0EI+knLZ+QWaqlMXwLARD1pbpL4j6dyGlQ8k+S9uigMNOpyaP
         Zi2t2XPkjPg7dD4kO54WRhX9XMW/DtD86MJyomGZ4Cv6t0zp2PGMiINICBJBk9hz1Rw/
         UipVvKqXJYElMHBFb9uYBAj396POUhGQeB47K/varr+Ob11PdjWYmndA9tGLLGtIfLMd
         0X6hLQo8ZNZROUpfbRHuPZ0o5hu/OGLFTkJlwBIIRQbywY+KNbcjANvkHkbjlWzkRTBB
         jTgXra5XYOd8CP40MCj0kK1ff+1Crnadc1+cCTagGUxabaQB+glKOk6IQs86CwN/9qdc
         qfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=/1b21c7TXXIYptENM3vkWU/LhgwrOe4QldjnsHnHVgY=;
        b=DhyvHs7ZgEQ8w6uqHYdnVYjVlWo5OP6t4Usa5tbnLQHuSqzIRN9itQMtGR/1aAXMe9
         awEMJ94e4BeeB+54qu+WqkfkvDekq+R6G6rps2hfGiNBLqYgheKhImaZmk3KpPIWXn8B
         q2LSxM4C1ZZ60IgrU1nOL8vNQJoSji8aKJochYK4LgNKfxZpTS0FKwhSuHSKn7RFu52/
         n0phihdzNDSBzAgQ8kTkZEt7bA0paYR5qewlv3AEHmA4edStDtRlwPtKPGyfxRRsQqQ/
         /UzwZjgO0URBi3WJ7KWdVvI0TTaVgt5BAI2/EackdY1nUAT5ZQFJRL552ZYDylJoIk5m
         69KQ==
X-Gm-Message-State: APzg51AgStuf5qXTG2N51HKsXQr8bbxz8W6gIbMRAeK6SliTC91h7xde
        SSdvLP7amZ4sBGDLBvwbncY8vLTM
X-Google-Smtp-Source: ANB0VdZYfn5ldnKv8+qots0aALnHztFQw63DqB20Kwb9i8RajiNV6IqGeg0++Mjv/GKOXH4Xo6y5eg==
X-Received: by 2002:a63:ed4f:: with SMTP id m15-v6mr32376551pgk.147.1536086014665;
        Tue, 04 Sep 2018 11:33:34 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id x23-v6sm10439168pge.61.2018.09.04.11.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 11:33:34 -0700 (PDT)
Subject: [PATCH 0/2] Address issues slowing memory init
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        mhocko@suse.com, akpm@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Tue, 04 Sep 2018 11:33:32 -0700
Message-ID: <20180904181550.4416.50701.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is meant to address some issues I consider to be
low-hanging fruit in regards to memory initialization optimization.

With these two changes I am able to cut the hot-plug memory initialization
times in my environment in half.

---

Alexander Duyck (2):
      mm: Move page struct poisoning from CONFIG_DEBUG_VM to CONFIG_DEBUG_VM_PGFLAGS
      mm: Create non-atomic version of SetPageReserved for init use


 include/linux/page-flags.h |    1 +
 mm/memblock.c              |    2 +-
 mm/page_alloc.c            |    4 ++--
 mm/sparse.c                |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

--
