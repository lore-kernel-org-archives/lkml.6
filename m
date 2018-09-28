Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20EEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741642082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741642082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeI1WHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:07:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36250 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbeI1WHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:07:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id n23-v6so2681540wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ko/6pZM5qyC5tUYIuQ2NdJlXSEdirTohEeN5+ByLYX0=;
        b=m9GfYc9clKPX+zjGWmwURCgwjC53jzjiyr/P4o/FAAYuqoSuyWzmbJ+Oadu5mRtVhG
         +JrHpXx/x2/qmO1k4sL5jgCz6qeV/PIEgwW5I3U8qm3HArybHu/wOKsNyTR5OGHGPWs+
         cOOuKB7KcD2unndV29p+4aqpOI+Ko1i/uQ2O6eXnwEHnSB7ZwHCqfnASwOFKDgxnQibD
         kWS+2GoUp7wXPgjw5Xw41pxoZIBVgLZjuWIotzMH8rnRjpem+uhvz3VmcikUzgbDJu/T
         wLC/lKlFQ82yAg/CIJnAb5sdrkL/3TkBGVzh3dvgYRPoQ4hk2CJ7oghTcHookknDZKzw
         ap3g==
X-Gm-Message-State: ABuFfoiSBZH/lF+KSN8+pnefvhAygebKJInaPDqWLOYzcyOAOzLZxm/L
        SarLeZ9EyvbltCb7zxJbRuU23Q==
X-Google-Smtp-Source: ACcGV60gNkKTFneV8ohnchGRGRMPg0l+fY0NCflEW+p0d8scL9N3MEFAtN96rvazqaJljpyVat4uBQ==
X-Received: by 2002:a1c:c708:: with SMTP id x8-v6mr2198699wmf.116.1538149359555;
        Fri, 28 Sep 2018 08:42:39 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2009877wme.36.2018.09.28.08.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:42:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] fuse: readdir caching
Date:   Fri, 28 Sep 2018 17:42:25 +0200
Message-Id: <20180928154234.19270-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow caching readdir in fuse.  Use the page cache for this, which solves
cache shrinking on memory pressure.

I think it might make sense to extract something like this into a set of
VFS helpers, so that other filesystems can also make use of this facility.

Thanks,
Miklos

---
Miklos Szeredi (9):
  fuse: split out readdir.c
  fuse: add FOPEN_CACHE_DIR
  fuse: extract fuse_emit() helper
  fuse: allow caching readdir
  fuse: allow using readdir cache
  fuse: add readdir cache version
  fuse: use mtime for readdir cache verification
  fuse: use iversion for readdir cache verification
  fuse: reduce size of struct fuse_inode

 fs/fuse/Makefile          |   2 +-
 fs/fuse/dir.c             | 293 +++---------------------
 fs/fuse/file.c            |  10 +
 fs/fuse/fuse_i.h          |  83 ++++++-
 fs/fuse/inode.c           |  11 +-
 fs/fuse/readdir.c         | 567 ++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   7 +-
 7 files changed, 688 insertions(+), 285 deletions(-)
 create mode 100644 fs/fuse/readdir.c

-- 
2.14.3

