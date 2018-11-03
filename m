Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835C6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA482082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ursb1cxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA482082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeKDIvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:51:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeKDIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:51:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id n4-v6so2670263plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zH76Ekb8R/DjW8u6iFYQoyAhlWthsLivqKF9Ulab3c=;
        b=ursb1cxGNtrFrImbZagBDEG3tGF3NSEouVyTdZWzN3EjeKaGR7d6j658VfRhl7dLbf
         1vsU3mgs/w+aiwEpq2QsTzodPKfsBWaXc4cK+aUjCIrnXcfNm/71Z+JEYDLv4J1n2tA2
         HeCnhnoJw03aFY7lasv9AMOPivPmsvPqpUeVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zH76Ekb8R/DjW8u6iFYQoyAhlWthsLivqKF9Ulab3c=;
        b=gBY9aMgafl54AYxks8F3tBVQMCZGcP1c8XiQ4FYpc/Qx8G03ReGWVv956ZM8ZyVFG+
         P+NAgTPWLQEp9vmnDMlHMPHZx9GlD8pz+V7sQShpxFQOS4H+MvQb65nGPKSV7bUAhFFn
         o7awFm9zgIxCIbmUHWx5D5E2uSyciIKI84lpGBkvpYQe/bJpVAqY8q5zx7i64yRJzto5
         RRqCW6plZzg7HawUgUQ38p9ztTRx6tyqpWoQUd8kk0ps5moKwRiU74YI82NapiaLBZSW
         gw/djqNxk5Y7lqCrxwnZ9D8EZ02ilIQXkqMWl7htiCxhII71dkmdhzSqTfIKiyHIM4ho
         76/g==
X-Gm-Message-State: AGRZ1gKE6yECB9jrwrQ/5XWLRJsZ8yur8tN9HLGeSGo7nJWhdMxyoqct
        xHs/LEsF4b0xsZvc7tRRzvqcm8gcQ4s=
X-Google-Smtp-Source: AJdET5e5jfS/mmbISCopvnOAsslnEimKlQkYbgySdri61Y8CfgvL0SzetLe+Jji6zKXt9fxAuCfbxA==
X-Received: by 2002:a17:902:6113:: with SMTP id t19-v6mr16742763plj.84.1541288307555;
        Sat, 03 Nov 2018 16:38:27 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id e8-v6sm9056385pfi.61.2018.11.03.16.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 16:38:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH RFC v2 0/3] cleanups for pstore and ramoops
Date:   Sat,  3 Nov 2018 16:38:15 -0700
Message-Id: <20181103233818.44615-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some simple cleanups and fixes for ramoops in pstore. Let me know
what you think, thanks.

Joel Fernandes (Google) (3):
pstore: map pstore types to names
pstore: simplify ramoops_get_next_prz arguments
pstore: donot treat empty buffers as valid

fs/pstore/inode.c          | 53 +++++---------------------------------
fs/pstore/ram.c            | 52 +++++++++++++++----------------------
fs/pstore/ram_core.c       |  2 +-
include/linux/pstore.h     | 37 ++++++++++++++++++++++++++
include/linux/pstore_ram.h |  2 ++
5 files changed, 67 insertions(+), 79 deletions(-)

--
2.19.1.930.g4563a0d9d0-goog

