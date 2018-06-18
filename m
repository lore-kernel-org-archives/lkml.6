Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F48C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A044420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A044420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeFREz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754383AbeFREz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7D28AC64;
        Mon, 18 Jun 2018 04:55:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Date:   Mon, 18 Jun 2018 14:55:20 +1000
Subject: [RFC PATCH 0/5] kbuild: build modules from code in multiple
 directories.
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <152929708853.17463.17302660556961083137.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches makes it possible to build a module from
code in multiple directories without needing to list files from one
directory in the Makefile of another directory.

The code was developed for lustre (which is now out-of-tree :-( ) but
can be useful elsewhere, such as for xfs and btrfs and others.

In fs/xfs/Makefile the section:

xfs-y				+= $(addprefix libxfs/, \
				   xfs_ag.o \
				   xfs_alloc.o \
				.....

could become

xfs-y += libxfs/

and then in fs/xfs/libxfs/Makefile we would have

modobj-$(CONFIG_XFS_FS) += xfs_ag.o \
			   xfs_alloc.o \
			   .....

A similar process could move filenames for scrub/* from the
fs/xfs/Makefile to fs/xfs/scrub/Makefile

Apart from improving modularity, this means that partial makes such
as:

  make fs/xfs/libxfs/

or

  make fs/xfs/scrub/attr.s

can work.

Comments and review most welcome.

Thanks,
NeilBrown

---

NeilBrown (5):
      kbuild: detect directories in components of a module.
      kbuild: treat a directory listed in a composite object as foo/mod.a
      kbuild: support building of per-directory mod.a
      kbuild: disable KBUILD_MODNAME when building for mod.a
      kbuild: Add documentation for modobj-m


 Documentation/kbuild/makefiles.txt |   65 ++++++++++++++++++++++++++++++++++--
 scripts/Makefile.build             |   57 ++++++++++++++++++++++----------
 scripts/Makefile.lib               |   63 ++++++++++++++++++++++-------------
 3 files changed, 141 insertions(+), 44 deletions(-)

--
Signature

