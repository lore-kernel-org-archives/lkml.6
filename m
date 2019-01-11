Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0212EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F7320874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/arqjGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfAKRCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:02:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46786 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfAKRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:02:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so15905161wrt.13;
        Fri, 11 Jan 2019 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LHSbZBpGFusKe1IsGJ7RVXHsLgK473H+pmS8ZdQfo9w=;
        b=X/arqjGTAhR+eZgqui44ET2i9c4F+pDRkdrU4upEQKIA0zM5AaTxhTyq1RrrcdK9E0
         fL/EqH8KMp+RvliTknwVLo1shJBuG6yZW6Pe0eu6xCnqKdKndiMiXJdQ+ruU2lNkDPuv
         lYutUxF089my30ZVEACP14h/lIEU5gTINr1Xigbekqx4+GroyFUTBn0hf4CD865/2gvD
         Fw8PNGiJd7s8uzZnFqdu4FXvz2vowld3CME9ybglWU63lNaxczhVD3zuT4ninfippO5q
         R//7zjN1tjcK6yTlbJCY5hu45rhH3RIhEvursmgDd8U0I/sN9VveLc7eyD0EGw8kPb17
         FhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LHSbZBpGFusKe1IsGJ7RVXHsLgK473H+pmS8ZdQfo9w=;
        b=QVPiX8e2P2nXEWDGEbqMfqu97Jy0t8Mj+5udsijDKYusv4JKQB1dYkQ4ZsK0h3cLB5
         nLTehNhFL7tJJhmzu8nj8KFqFizdp1jiSKoCBGoZ4KinH2ZF6XEqCnSs0e29MBXZkTA+
         fWJah1Ppp+XIG2z4FAoiyJyvmd/JCgAi7htf1VT+E5P/3qg4xFr0Wnl78IJ4bwxIEvkl
         0b0bEqaFWUsXBZoXzHxzaGLbrN4A8i7WMCv2ePCqzzfQy1KxXxkl7xFx8jl8/B1UHn2n
         Kp4gazTFdwtyABSDiqsIWb/BUIlpnqv8lIUF3fKfJFD2Ag9EEPEYrU0JB+qSuYtYuqNW
         7MEA==
X-Gm-Message-State: AJcUukcJ4zLQH1PZsMeBTmL2iikmAcmJIc1eryOw0iciGo+ijHSGDRlA
        eKLgqaCWCNnfcAUKFU8NpPqXHLyc
X-Google-Smtp-Source: ALg8bN6qWUSXoPscq3J5lpQbQUtOxCaRPRgFSeWpfLfQqPqGWi5ElPCKmDdQyED4ArpfFR7BUs8WeA==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr14877635wrm.239.1547226163393;
        Fri, 11 Jan 2019 09:02:43 -0800 (PST)
Received: from orange.redhat.com (ip-89-102-68-132.net.upcbroadband.cz. [89.102.68.132])
        by smtp.gmail.com with ESMTPSA id s3sm17174034wmj.23.2019.01.11.09.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 09:02:42 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 5.0-rc2
Date:   Fri, 11 Jan 2019 18:02:26 +0100
Message-Id: <20190111170226.19872-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.0-rc2

for you to fetch changes up to 85f5a4d666fd9be73856ed16bb36c5af5b406b29:

  rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set (2019-01-10 09:45:09 +0100)

----------------------------------------------------------------
A patch to allow setting abort_on_full and a fix for an old "rbd unmap"
edge case, marked for stable.

----------------------------------------------------------------
Dongsheng Yang (1):
      libceph: allow setting abort_on_full for rbd

Ilya Dryomov (1):
      rbd: don't return 0 on unmap if RBD_DEV_FLAG_REMOVING is set

Souptick Joarder (1):
      ceph: use vmf_error() in ceph_filemap_fault()

 drivers/block/rbd.c             |  9 ++++-----
 fs/ceph/addr.c                  |  5 +----
 fs/ceph/super.c                 |  4 ++--
 include/linux/ceph/libceph.h    |  6 ++++--
 include/linux/ceph/osd_client.h |  1 -
 net/ceph/ceph_common.c          | 11 ++++++++++-
 net/ceph/debugfs.c              |  2 +-
 net/ceph/osd_client.c           |  4 ++--
 8 files changed, 24 insertions(+), 18 deletions(-)
