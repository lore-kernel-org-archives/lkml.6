Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2AC46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5FA20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GUbpiEnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5FA20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbeHAHxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:53:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37699 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733090AbeHAHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:53:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so10281325pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CpRCrukzwPkVZPwY6hxKTkGSn5bNvEkKc6CQz569+i0=;
        b=GUbpiEnEXwcRSgjf34pwFPQdPW9/HtsRrnf+1alaGiyXrksEdSUeeMr2DBw3jtwNTQ
         Dp/L5bvrBOy9aclfsl0U/SuyHS4acJjwV+yqhSNIKh83t6TQAHBw2FCBdOwPU8WRguIU
         reJ1vpGvEsh2+4qAkflAxb9mC7FG3rRG/S52M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CpRCrukzwPkVZPwY6hxKTkGSn5bNvEkKc6CQz569+i0=;
        b=Dfnc7ZwAUCN8On13OSAU92oH1sn47Nhrkef8lT7kuD4J+Linh8PrLseMZ9Qwry8DXo
         MAkcItjSJKfLCYt8HN2qAb/XQKLxdjeGwvmrJ3ADJTVlEiIwFExjcdq6Bci+pfBAgLax
         q8UJOCsmPKncuxJONnMiU2uTdfyR9fM/uwIDWRTnC5htMKc+6MUJ8r/ddElPVzziCR/Y
         hErJqFkezODvhLv3v8hysnELQdgfklwsd+IJUcIyk30FcfYFFucvRh8n22YVLUYg96i4
         GcbVTdz52coE3a74Y0mVL7+c37QcUA7Kh0DsNzuhHa2kThQJx0Q79bJ0+W2o82GnoFbC
         P1lQ==
X-Gm-Message-State: AOUpUlGUZWKTf/Dy1bxtyJ5WfFvLrLiRR4H737OkS1mn1tL0qragndxK
        +rwZ1MU5S3xDiXonijRZ0JWoug==
X-Google-Smtp-Source: AAOMgpfTo3FFXuv/DBnTLdbtqC5VlP8fTFjZh6cylcV3zOh3v4X9fgtUEGxKyrtwJj8rQKhlxRYFXQ==
X-Received: by 2002:a62:b604:: with SMTP id j4-v6mr16411687pff.199.1533103793666;
        Tue, 31 Jul 2018 23:09:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v20-v6sm44499362pfk.12.2018.07.31.23.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 23:09:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] overflow.h: Add arithmetic shift helper
Date:   Tue, 31 Jul 2018 23:09:44 -0700
Message-Id: <20180801060947.16670-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the shift overflow helper, selftests, and first usage.

-Kees

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

 drivers/infiniband/hw/mlx5/qp.c |   5 +-
 include/linux/overflow.h        |  31 +++++
 lib/test_overflow.c             | 198 +++++++++++++++++++++++++++++++-
 3 files changed, 232 insertions(+), 2 deletions(-)

-- 
2.17.1

