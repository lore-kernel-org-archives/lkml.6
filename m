Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37793C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71FE20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2jRX/OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71FE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbeHAXNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:13:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45925 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbeHAXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:13:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so9028pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jxNBccwBJhOjNSehNOYa6peZNnukJ0uEhyMfONEe2KU=;
        b=e2jRX/ORCzfYWWo8zwRFnr31EHJkGKgauIMX/rYrDSUnsgapk8Ts2IdB1VgczVUlcx
         ckbyZnKJAMETkb1/ChuKehOk6Hc7rh+rKeMLrQ1PgTcWhMcpC5eIEX8HBQURhMgCJWR9
         RuSkhO6a1PUj2DofXXEmN+q+m66yH5oKjVxYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jxNBccwBJhOjNSehNOYa6peZNnukJ0uEhyMfONEe2KU=;
        b=keWnziaBkrC3VxOEmoD9TTA0JnvVDiJ9wtPWUsGpUQGp1MclO+8AgoGhVJxi9N6F1O
         607iypN65vmMMNflu1i7FEAQQegD02E17mnOp1Rn0wVYXMSIyNe5k8DWzUIRXvG1orSR
         8iPKWVBu60O4Z8lo+6QFaPHc7RprJZYHfzMKoq4TN3CRlrGwHmYXuDBVhe3tdFkclT8W
         zvMadMIF+Pw4g/SSkno/7YhXkBIa8WuyUKAxcgXIHAaaiP1kfvuwy9QKuiFqHCTULbve
         WkvlOqC+9S/gh6rWPGMZhnf4XiU0Y3cz4QLjbdAzE3MwR7JruQqa0/vRrgOFGFa/UZjH
         hVtA==
X-Gm-Message-State: AOUpUlHaCrKnJH/3VacRLq+ZGH7FDsw6EtTIkkJeHru7K1zuceiydNrY
        yt5MF5NOdQ1fWh5pO0OKXydd7g==
X-Google-Smtp-Source: AAOMgpfWVHbmyfnDG9pH0pOtb1VPUbXvWW8MnMZz8paghwL1DU1edkrPLlaT5alehIcYSEkxQVI3xg==
X-Received: by 2002:a17:902:b08d:: with SMTP id p13-v6mr64370plr.0.1533158748927;
        Wed, 01 Aug 2018 14:25:48 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f67-v6sm40264pfe.75.2018.08.01.14.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:25:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v4 0/3] overflow.h: Add left-shift helper
Date:   Wed,  1 Aug 2018 14:25:38 -0700
Message-Id: <20180801212541.22889-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the left-shift overflow helper, selftests, and first usage.

-Kees

v4:
- actually fix docs typo
- rename to check_shl_overflow()
v3:
- add even more test cases (type mismatches, more signed overflows).
- fix documentation typo on argument name.
v2:
- swap out selftests with framework from Rasmus, add lots more tests.
- drop double-assignment in helper.


Jason Gunthorpe (1):
  overflow.h: Add arithmetic shift helper

Kees Cook (1):
  test_overflow: Add shift overflow tests

Leon Romanovsky (1):
  RDMA/mlx5: Fix shift overflow in mlx5_ib_create_wq

 drivers/infiniband/hw/mlx5/qp.c |   4 +-
 include/linux/overflow.h        |  31 +++++
 lib/test_overflow.c             | 198 +++++++++++++++++++++++++++++++-
 3 files changed, 231 insertions(+), 2 deletions(-)

-- 
2.17.1

