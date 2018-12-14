Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE77C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333262070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2MwdUR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeLNPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:49:25 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39043 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLNPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:49:25 -0500
Received: by mail-wr1-f49.google.com with SMTP id t27so5886787wra.6;
        Fri, 14 Dec 2018 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pj9Yi825DhQN+/UZQYzaEUx8hPvqRAlstl1W+AMIA44=;
        b=a2MwdUR1E5BpQztxms+fyjySAPwY1DL198wU8Z9aUl6swuf9rTU/8Le8Tw32KZTo++
         vbe0wk8iL0DgyiSEJZwpW5WcFiGqZI3fF7bxk/StUPGuhl3H7CdkFZtXzFkQW86ENeFm
         ZvduIiqOvoPaEUCfDg7zi6e9zvLoyR9arQHry4KnzT7THpbXnbqLv6ZlPJc3CB/Gtqh8
         LFLnapYzWjwnreTbGqhJjLL+mx97a0AKiQDab8sNG0R4WZef4TSdiJ2qzGmSX/Obd7HZ
         C3k1sCFpI8R/98uNIgJqv2yit0rVdekjm3VvBLSqPlcLYfBCFon2HklrM/Wa7ZfCFlg8
         /mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pj9Yi825DhQN+/UZQYzaEUx8hPvqRAlstl1W+AMIA44=;
        b=kNJk+c2rUVrFDCQ5UWkVvPbIViMAmTDq8/Q222WpGHPL9eWYB/dfkyue6B2R9RZubh
         Sy6Sxwt2CcC9jizE1qNvXBWgpecoCLQsPmoZRQOII/SHD+nBij9gJsaZYdsvPvFcrlQK
         MPvQIDGLesIPyYsi7EXa+O5vIVi9rbOb9bi4LfKIVLpKN1u/IQAoj6JqepJzwoURd9am
         p7i2KDd3sounFFJ2uAo9FkY7hZ6tfcAebtEnI2QIU2WkA/7v+wKdbZkT87LKzAXO2Sr7
         104ckUW1pij9zVbQPTDpff1R9UAiufRaouvoC7oF7u7lMaRH+ENvb5JHrTxB6eWonZ1c
         K68Q==
X-Gm-Message-State: AA+aEWZ8qznaxQiggGVloR4JPqoCLcYmO94eGAg/qMQxmf9qIuUyO3LM
        vDgpSo1jn6OAN2EceOgUU8Wymm2k
X-Google-Smtp-Source: AFSGD/UgfhNROm/FvZP3TLNy2tJ0GLLagzeO3BnMIbUZFKjXMK8sk8rA1LJbzJk/z3QzjgzDYav/UA==
X-Received: by 2002:adf:e1c3:: with SMTP id l3mr3156754wri.36.1544802562963;
        Fri, 14 Dec 2018 07:49:22 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-136-201.net.upcbroadband.cz. [94.112.136.201])
        by smtp.gmail.com with ESMTPSA id n127sm5870298wmd.20.2018.12.14.07.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 07:49:22 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 4.20-rc7
Date:   Fri, 14 Dec 2018 16:48:58 +0100
Message-Id: <20181214154858.1155-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc7

for you to fetch changes up to 6f9718fe41c3a47e4362bddf145e2db6ad7d8e87:

  ceph: make 'nocopyfrom' a default mount option (2018-12-11 18:22:17 +0100)

----------------------------------------------------------------
Luis discovered a problem with the new copyfrom offload on the server
side.  Disable it for now.

----------------------------------------------------------------
Luis Henriques (1):
      ceph: make 'nocopyfrom' a default mount option

 fs/ceph/super.c | 4 ++--
 fs/ceph/super.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)
