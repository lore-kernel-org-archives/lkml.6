Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F21DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61782150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61782150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeHWW76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:59:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50122 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHWW76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:59:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fsvHk-0002DZ-Gz; Thu, 23 Aug 2018 13:28:48 -0600
Received: from [105.224.248.17] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fsvHj-000078-7m; Thu, 23 Aug 2018 13:28:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Date:   Thu, 23 Aug 2018 21:28:38 +0200
Message-ID: <874lfkx4pl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fsvHj-000078-7m;;;mid=<874lfkx4pl.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.224.248.17;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19RoPXuIYq8Lx+5y8Q81Ibewpzk/8FZA5o=
X-SA-Exim-Connect-IP: 105.224.248.17
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: namespace fixes for v4.19-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the userns-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-linus

   HEAD: 82c9a927bc5df6e06b72d206d24a9d10cced4eb5 getxattr: use correct xattr length

This is a set of 4 fairly obvious bug fixes.  A switch from d_find_alias
to d_find_any_alias because the xattr code perversely takes a dentry.
Two mutex vs copy_to_user fixes from Jann Horn and a fix to use a
sanitized size not the size userspace passed in from Christian Brauner.

This is coming late because I fell behind this last development cycle,
and because I have been travelling.  I do not intend to make a habit of
sending pull requests late.

The last fix by Christian Brauner has a very recent commit date.  I was
doing a final review of this pull request and I noticed it was mixing a
fixes tag.  I added the fixes tag so that the bug that is being fixed
can be put into perspective.

Christian Brauner (1):
      getxattr: use correct xattr length

Eddie.Horng (1):
      cap_inode_getsecurity: use d_find_any_alias() instead of d_find_alias()

Jann Horn (2):
      userns: move user access out of the mutex
      sys: don't hold uts_sem while accessing userspace memory

 arch/alpha/kernel/osf_sys.c      | 51 ++++++++++-----------
 arch/sparc/kernel/sys_sparc_32.c | 22 ++++++----
 arch/sparc/kernel/sys_sparc_64.c | 20 +++++----
 fs/xattr.c                       |  2 +-
 kernel/sys.c                     | 95 +++++++++++++++++++---------------------
 kernel/user_namespace.c          | 24 +++++-----
 kernel/utsname_sysctl.c          | 41 ++++++++++-------
 security/commoncap.c             |  2 +-
 8 files changed, 131 insertions(+), 126 deletions(-)

Eric
