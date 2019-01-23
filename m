Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8057AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61574218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAWSfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfAWSfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:35:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C9CB2CD805;
        Wed, 23 Jan 2019 18:35:37 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-23.phx2.redhat.com [10.3.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD73F5D6A9;
        Wed, 23 Jan 2019 18:35:28 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak100 V2 0/2] audit: avoid umount hangs on missing mount
Date:   Wed, 23 Jan 2019 13:34:58 -0500
Message-Id: <cover.1548196083.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 23 Jan 2019 18:35:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On user and remote filesystems, a forced umount can still hang due to
attemting to fetch the fcaps of a mounted filesystem that is no longer
available.

These two patches take different approaches to address this, one by
avoiding the lookup when the MNT_FORCE flag is included, the other by
providing a method to filter out auditing specified types of filesystems.

This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS or any
other userspace or remote filesystem.

Arguably the better way to address this issue is to avoid auditing
processes that touch removable filesystems.
Please see the github issue tracker
https://github.com/linux-audit/audit-kernel/issues/100
Passes audit-testsuite including ghak100 branch.

Changelog:
v2:
- rebase on v5.0-rc1 audit/next
- refactor 3 levels of *if* indentation down to 1 incl. orig
- rename LOOKUP_NO_REVAL to LOOKUP_NO_EVAL to avoid existing usage
  conflict
- don't depend on MNT_FORCE
- rename AUDIT_INODE_NOREVAL to AUDIT_INODE_NOREVAL to be consistent
- rename lflags to flags and flags to aflags
- document LOOKUP_ flags
- signal cap_* values unknown and set cap_* fields to "?" indicating so

Richard Guy Briggs (2):
  audit: more filter PATH records keyed on filesystem magic
  audit: ignore fcaps on umount

 fs/namei.c            |  2 +-
 fs/namespace.c        |  2 ++
 include/linux/audit.h | 15 ++++++++++-----
 include/linux/namei.h |  3 +++
 kernel/audit.c        | 10 +++++++++-
 kernel/audit.h        |  2 +-
 kernel/auditsc.c      | 41 ++++++++++++++++++++++++++++++-----------
 7 files changed, 56 insertions(+), 19 deletions(-)

-- 
1.8.3.1

