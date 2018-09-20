Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB5DECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7896D21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7896D21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbeITU4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:56:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46279 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:56:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so9768665wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PixDkZ3uDuUfclJ04YDcQovTKTSj85ueyCuV+zhluC4=;
        b=p1sUtlJJzzImm0oSMqibOr7/jso1KLzyaXeF0vbseD045XT23IhuwWaJGWgtrvWaAg
         DFXEjskii5k3UdawY9M3WaNFvC2BHG17u2M8IM5D4+XXtCxNVITp+xQBjS/A8J9abAE3
         H2T74oJkrd/XDf+ILgOpTNHRrGIyi41etX0D93PnwOHzHgCuWM6f0CSKbDiqTuwCeUSt
         E65apz0FLjy/MSUYYyX4+hJ5r6O+Q8tEwV2O+PTUE7IF4O/+HzAm1JLjHcgOe8LJqcK1
         mujnZCCnAxOlN6G8msWtpZJUmYRv/UIJLNZMrXOhIVuaUnaOAMIR4rP2+yBuYEd0ZM5R
         OY5Q==
X-Gm-Message-State: APzg51CFwwNtz7g+BMWAaBUt46DbzOkdImEt0ut+NZhWRqqCi8jCIOiv
        BO1fkBVkhSLNN5e94Y4DLDtcmw==
X-Google-Smtp-Source: ANB0VdbifnqSDSQvyEj7a/ZrQXxD8L4N6EpsHcbX5jD9GlDJGJT4mC2P8spP6J4TQiTPyht6pmdy1w==
X-Received: by 2002:adf:bd90:: with SMTP id l16-v6mr34070573wrh.250.1537456339999;
        Thu, 20 Sep 2018 08:12:19 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id p89-v6sm55286201wrc.97.2018.09.20.08.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:12:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] mount-api: fixes and cleanups
Date:   Thu, 20 Sep 2018 17:12:08 +0200
Message-Id: <20180920151214.15484-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fix issues with handling subtype (fuse specific thing) and rename
some constants on the new API to make me happy.  I realize the last patch
could be viewed as bikeshedding, but I do think suggesting falsehood in a
constant name can lead to painful real life bugs, so now is the time to
think about these issues.

Miklos Szeredi (6):
  selinux: fold superblock_doinit() into only caller
  vfs_submount: use SB_SUBMOUNT instead of MS_SUBMOUNT
  mount: fix regression in setting "subtype" from legacy API
  fsconfig: parse "subtype" param for old internal API
  fsmount: do not use legacy MS_ flags
  fsconfig: rename FSCONFIG_CMD_CREATE to FSCONFIG_CMD_OBTAIN

 fs/fs_context.c            | 44 +++++++++------------------------------
 fs/fsopen.c                |  6 +++---
 fs/namespace.c             | 51 +++++++++++++++++++++++++++++++---------------
 include/uapi/linux/fs.h    |  2 +-
 include/uapi/linux/mount.h |  9 ++++++++
 samples/vfs/test-fsmount.c |  2 +-
 security/selinux/hooks.c   | 37 ++++++++-------------------------
 7 files changed, 68 insertions(+), 83 deletions(-)

-- 
2.14.3

