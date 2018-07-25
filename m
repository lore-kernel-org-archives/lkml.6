Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571D5C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1491820882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1491820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeGYPOD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:14:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727691AbeGYPOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:14:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD549B5C2;
        Wed, 25 Jul 2018 14:02:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA8D420180EB;
        Wed, 25 Jul 2018 14:02:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, kiran.modukuri@gmail.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] fscache and cachefiles fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7827.1532527332.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 25 Jul 2018 15:02:12 +0100
Message-ID: <7828.1532527332@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 25 Jul 2018 14:02:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 25 Jul 2018 14:02:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you pull these fixes for fscache and cachefiles please?

There are five:

 (1) Allow cancelled operations to be queued so they can be cleaned up.

 (2) Fix a refcounting bug in the monitoring of reads on backend files
     whereby a race can occur between monitor objects being listed for work,
     the work processing being queued and the work processor running and
     destroying the monitor objects.

 (3) Fix a ref overput in object attachment, whereby a tentatively
     considered object is put in error handling without first being 'got'.

 (4) Fix a missing clear of the CACHEFILES_OBJECT_ACTIVE flag whereby an
     assertion occurs when we retry because it seems the object is now
     active.

 (5) Wait rather BUG'ing on an object collision in the depths of cachefiles
     as the active object should be being cleaned up - also depends on (4).

David
---
The following changes since commit fc36def997cfd6cbff3eda4f82853a5c311c5466:

  mm: teach dump_page() to correctly output poisoned struct pages (2018-07-03 17:32:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20180725

for you to fetch changes up to c2412ac45a8f8f1cd582723c1a139608694d410d:

  cachefiles: Wait rather than BUG'ing on "Unexpected object collision" (2018-07-25 14:49:00 +0100)

----------------------------------------------------------------
fscache fixes

----------------------------------------------------------------
Kiran Kumar Modukuri (5):
      fscache: Allow cancelled operations to be enqueued
      cachefiles: Fix refcounting bug in backing-file read monitoring
      fscache: Fix reference overput in fscache_attach_object() error handling
      cachefiles: Fix missing clear of the CACHEFILES_OBJECT_ACTIVE flag
      cachefiles: Wait rather than BUG'ing on "Unexpected object collision"

 fs/cachefiles/bind.c   |  3 ++-
 fs/cachefiles/namei.c  |  3 +--
 fs/cachefiles/rdwr.c   | 17 ++++++++++++-----
 fs/fscache/cache.c     |  2 +-
 fs/fscache/cookie.c    |  7 ++++---
 fs/fscache/object.c    |  1 +
 fs/fscache/operation.c |  6 ++++--
 7 files changed, 25 insertions(+), 14 deletions(-)

