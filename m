Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E5ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E8F214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E8F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJQWMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbeJQWMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66A67307D922;
        Wed, 17 Oct 2018 14:16:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B8AF5DEFC;
        Wed, 17 Oct 2018 14:16:44 +0000 (UTC)
Subject: [PATCH 0/4] FS-Cache: Miscellaneous fixes
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        syzbot+a95b989b2dde8e806af8@syzkaller.appspotmail.com,
        David Howells <dhowells@rdhat.com>, stable@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, viro@zeniv.linux.org.uk,
        sandeen@redhat.com, dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Oct 2018 15:16:44 +0100
Message-ID: <153978580402.7579.15833925372019979447.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 17 Oct 2018 14:16:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Attached are another couple of miscellaneous fixes for FS-Cache and
CacheFiles:

 (1) Fix a race between object burial in cachefiles and external rmdir.

 (2) Fix a race from a split atomic op.

 (3) Fix incomplete initialisation of cookie key space.

 (4) Fix out-of-bounds read.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	fscache-fixes-20181017

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-fixes

David
---
Al Viro (1):
      cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

David Howells (1):
      fscache: Fix incomplete initialisation of inline key space

Eric Sandeen (1):
      fscache: Fix out of bound read in long cookie keys

kiran.modukuri (1):
      fscache: Fix race in fscache_op_complete() due to split atomic_sub & read


 fs/cachefiles/namei.c         |    2 +-
 fs/fscache/cookie.c           |   31 ++++++++++---------------------
 fs/fscache/internal.h         |    1 -
 fs/fscache/main.c             |    4 +---
 include/linux/fscache-cache.h |    4 ++--
 5 files changed, 14 insertions(+), 28 deletions(-)

