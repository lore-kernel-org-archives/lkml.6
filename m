Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CB4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3202B2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3202B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbeKQDr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:47:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeKQDr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:47:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7019C3097065;
        Fri, 16 Nov 2018 17:34:09 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53A9360CBA;
        Fri, 16 Nov 2018 17:34:01 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak100 V1 0/2] audit: avoid umount hangs on missing mount
Date:   Fri, 16 Nov 2018 12:33:12 -0500
Message-Id: <cover.1542149969.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 16 Nov 2018 17:34:09 +0000 (UTC)
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

This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.

Arguably the better way to address this issue is to disable auditing
processes that touch removable filesystems.
Please see the github issue tracker
https://github.com/linux-audit/audit-kernel/issues/100

Richard Guy Briggs (2):
  audit: avoid fcaps on MNT_FORCE
  audit: moar filter PATH records keyed on filesystem magic

 fs/namei.c            |  2 +-
 fs/namespace.c        |  3 +++
 include/linux/audit.h |  8 ++++++--
 kernel/audit.c        |  5 +++--
 kernel/audit.h        |  2 +-
 kernel/auditsc.c      | 29 ++++++++++++++++++++++++++---
 6 files changed, 40 insertions(+), 9 deletions(-)

-- 
1.8.3.1

