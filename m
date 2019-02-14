Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BDFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1C320823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404655AbfBNQTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:19:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbfBNQTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:19:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50243C04D293;
        Thu, 14 Feb 2019 16:19:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 818435C23D;
        Thu, 14 Feb 2019 16:19:46 +0000 (UTC)
Subject: [PATCH 0/4] keys: Miscellaneous fixes
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, ebiggers@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 16:19:45 +0000
Message-ID: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 14 Feb 2019 16:19:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Here are some keyrings fixes.

 (1) Handle quotas better, allowing full quota to be reached.

 (2) Fix the creation of shortcuts in the assoc_array internal
     representation when the index key needs to be an exact multiple of the
     machine word size.

 (3) Fix a dependency loop between the request_key contruction record and
     the request_key authentication key.  The construction record isn't
     really necessary and can be dispensed with.

 (4) Set the timestamp on a new key rather than leaving it as 0.  This
     would ordinarily be fine - provided the system clock is never set to a
     time before 1970.

The patches can be found here tagged thusly:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	keys-fixes-20190214

and also on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes

David
---
David Howells (3):
      assoc_array: Fix shortcut creation
      keys: Fix dependency loop between construction record and auth key
      keys: Timestamp new keys

Eric Biggers (1):
      KEYS: allow reaching the keys quotas exactly


 fs/nfs/nfs4idmap.c                   |   31 ++++++++-------
 include/keys/request_key_auth-type.h |   36 +++++++++++++++++
 include/linux/key-type.h             |   22 +++-------
 lib/assoc_array.c                    |    8 ++--
 security/keys/internal.h             |   13 ------
 security/keys/key.c                  |    5 +-
 security/keys/keyctl.c               |    1 
 security/keys/process_keys.c         |    1 
 security/keys/request_key.c          |   72 ++++++++++++++--------------------
 security/keys/request_key_auth.c     |   16 ++++----
 10 files changed, 108 insertions(+), 97 deletions(-)
 create mode 100644 include/keys/request_key_auth-type.h

