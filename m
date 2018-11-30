Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33442C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0249520868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0249520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeLADtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeLADtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:49:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98807394D3E;
        Fri, 30 Nov 2018 16:39:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 327FB183C6;
        Fri, 30 Nov 2018 16:39:40 +0000 (UTC)
Subject: [PATCH 0/7] FS-Cache: Miscellaneous fixes
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shantanu Goel <sgoel01@yahoo.com>, NeilBrown <neilb@suse.com>,
        Daniel Axtens <dja@axtens.net>, Zhibin Li <zhibli@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:39:39 +0000
Message-ID: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 30 Nov 2018 16:39:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you pull these fixes for fscache and cachefiles?

 (1) Fix an assertion failure at fs/cachefiles/xattr.c:138 caused by a race
     between a cache object lookup failing and someone attempting to
     reenable that object, thereby triggering an update of the object's
     attributes.

 (2) Fix an assertion failure at fs/fscache/operation.c:449 caused by a
     split atomic subtract and atomic read that allows a race to happen.

 (3) Fix a leak of backing pages when simultaneously reading the same page
     from the same object from two or more threads.

 (4) Fix a hang due to a race between a cache object being discarded and
     the corresponding cookie being reenabled.

There are also some minor stuff.  Do you want me to punt these to the next
merge window instead?

 (5) Cast an enum value to a different enum type to prevent clang from
     generating a warning.  This shouldn't cause any sort of change in the
     emitted code.

 (6) Use ktime_get_real_seconds() instead of get_seconds().  This is just
     used to uniquify a filename for an object to be placed in the
     graveyard.  Objects placed there are deleted by cachfilesd in
     userspace immediately thereafter.

 (7) Remove an initialised, but otherwise unused variable.  This should
     have been entirely optimised away anyway.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	fscache-fixes-20181130

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-fixes

Thanks,
David
---
Arnd Bergmann (1):
      cachefiles: avoid deprecated get_seconds()

Colin Ian King (1):
      fscache, cachefiles: remove redundant variable 'cache'

David Howells (1):
      cachefiles: Fix an assertion failure when trying to update a failed object

Kiran Kumar Modukuri (1):
      cachefiles: Fix page leak in cachefiles_read_backing_file while vmscan is active

Nathan Chancellor (1):
      cachefiles: Explicitly cast enumerated type in put_object

NeilBrown (1):
      fscache: fix race between enablement and dropping of object

kiran.modukuri (1):
      fscache: Fix race in fscache_op_complete() due to split atomic_sub & read


 fs/cachefiles/namei.c         |    8 +++++---
 fs/cachefiles/rdwr.c          |    9 ++++++---
 fs/cachefiles/xattr.c         |    3 ++-
 fs/fscache/object.c           |    3 +++
 include/linux/fscache-cache.h |    3 +--
 5 files changed, 17 insertions(+), 9 deletions(-)

