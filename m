Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BEAC46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA06C20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcd0LLO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA06C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbeHABnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:43:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39037 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732851AbeHABne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:43:34 -0400
Received: by mail-pl0-f65.google.com with SMTP id m1-v6so7865094plt.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b+l7MhKf4lpWiZvBhHDJjBfM4XZLVidfK5I4zRVgcPA=;
        b=dcd0LLO3Vyzqzn1SYv/EktNKZ35n503yWimd+8FHvSJp1wEXFCcPtDVXAfZFPKEEUx
         3nPVqESowd57gvjrwFKvNJsh5r2OA8UdZ8tYY9DFuHINLeeWLIr3VAeyURTqzylqNRor
         ygFCkF9GjYI96HK61bSIl0ucS05EVDdH8gf54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b+l7MhKf4lpWiZvBhHDJjBfM4XZLVidfK5I4zRVgcPA=;
        b=VbBHWqPLcirvc2jea9t+2iCl44WbHh5xdMamNppmgTb07VL18Kjmx6vkb55gT9i8do
         54mN3ivmVCtL4v6L0rdcqqqb+8+qZdoLrgMR+sSkV2IpnAUsDxoLLs0j6ezCOSedB7PQ
         H591OzDPGtCI7CzAdOT5THbyDNPWIzUjaK9IujSmwKwWLdHGXRhdVhuQZGJBccIdzvF1
         XUrkW0wJF87Anq9ricB4LeRQv3GOr8lqBrLhED75XeP/ilAwEyBjQMbEtcX+RfkWqi7x
         Ax157tRBRT+WnEjJ6Dsj+Fa2MklKximwNi3n4Ub5NksU98vhUDYLF/PeJD/TFvEMeFkn
         Zgcg==
X-Gm-Message-State: AOUpUlHfGYgEYbYJq3r9lRD9Sxc2B7/m1aJi7S9sa90BjVsZtHXON6df
        Ytci/HdU62gxl6wt6Mu30VZO2g==
X-Google-Smtp-Source: AAOMgpdpmVBO9x9xd4xDxDFpRGDISk40j/3m1VPm5uFulecr05FTDuUG6fDF4+zym3aAxTkS5h0f6g==
X-Received: by 2002:a17:902:b60b:: with SMTP id b11-v6mr7391460pls.301.1533081648145;
        Tue, 31 Jul 2018 17:00:48 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o4-v6sm40633659pgq.16.2018.07.31.17.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 17:00:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] overflow.h: Add arithmetic shift helper
Date:   Tue, 31 Jul 2018 17:00:36 -0700
Message-Id: <20180801000039.44314-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the shift overflow helper, selftests, and first usage.

-Kees

Jason Gunthorpe (1):
  overflow.h: Add arithmetic shift helper

Kees Cook (1):
  test_overflow: Add shift overflow tests

Leon Romanovsky (1):
  RDMA/mlx5: Fix shift overflow in mlx5_ib_create_wq

 drivers/infiniband/hw/mlx5/qp.c |   5 +-
 include/linux/overflow.h        |  31 +++++++
 lib/test_overflow.c             | 140 +++++++++++++++++++++++++++++++-
 3 files changed, 174 insertions(+), 2 deletions(-)

-- 
2.17.1

