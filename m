Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02293C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F68205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F68205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeJGW3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJGW3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:29:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F56030B8F83;
        Sun,  7 Oct 2018 15:21:36 +0000 (UTC)
Received: from rf.usersys.redhat.com (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E722910021B2;
        Sun,  7 Oct 2018 15:21:34 +0000 (UTC)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org, piastryyy@gmail.com
Subject: [PATCH v3 0/2] CIFS: Info-level log support, print message when attempting mount.
Date:   Sun,  7 Oct 2018 12:21:24 -0300
Message-Id: <cover.1538873915.git.rfreire@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 07 Oct 2018 15:21:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,
From our conversation over v2, I came out with this v3 patch, which I broke
in two commits:

* The first commit in cifs_debug.h, creating the cifs_info() function.
  - The aim of this commit is to allow to the developer to be able to print
    informational-level data without having to use pr_info, pr_notice etc,
    in line with other filesystems.
    . One interesting and noteworthy feature of cifs_info() is that it is
      transparent to the CIFS_DEBUG config state, either in "y" or "n".
    . Also, by using KERN_INFO level, it can be safely filtered by a
      maintainer / administrator, without cluttering their log monitors,
      since this is a low level alert.
  - I took the liberty to not add it inside the existing pr_debug, because
    of the eventual need of some developer to print stuff that should be
    printed not only in CIFS_DEBUG mode (as there are plenty of pr_notice
    scattered over the code).
  - Also, this is not a debug but a info message, so i liked cifs_info() 
    more ;-)
  - I saw plenty of pr_notice() in CIFS code, but I resisted the urge to
    convert them to cifs_info().

* The second commit contains the code printing a cifs_info() when attempting
  a CIFS mount operation.

Appreciate your review.

V3: Created a new cifs_info() function, moved the mount attempt message to
    cifs_info

V2: Created a loop to select the right cifs_dbg message to be printed,
    considering the current system's scenario, in order to avoid a
    duplicate message or stripping out important information in
    debug.

Rodrigo Freire (2):
  CIFS: Adds information-level logging function
  CIFS: Print message when attempting a mount

 fs/cifs/cifs_debug.h | 16 ++++++++++++++++
 fs/cifs/cifsfs.c     |  7 ++++++-
 fs/cifs/transport.c  |  2 +-
 3 files changed, 23 insertions(+), 2 deletions(-)

-- 
1.8.3.1

