Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0447C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD3621712
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD3621712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeHXNFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:05:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35870 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeHXNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:05:42 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ft8Rd-0008Jf-46; Fri, 24 Aug 2018 03:31:53 -0600
Received: from [105.184.43.183] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ft8Rb-0007Iq-Qc; Fri, 24 Aug 2018 03:31:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <874lfkx4pl.fsf@xmission.com>
Date:   Fri, 24 Aug 2018 11:31:44 +0200
In-Reply-To: <874lfkx4pl.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 23 Aug 2018 21:28:38 +0200")
Message-ID: <87mutc156n.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ft8Rb-0007Iq-Qc;;;mid=<87mutc156n.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.43.183;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cRw8HGl0TuWzdz3FZGMYGfBcnAQIlREA=
X-SA-Exim-Connect-IP: 105.184.43.183
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] namespace fixes for v4.19-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

Resent because I somehow missed the [GIT PULL] tag when I sent this out
the first time.  I think travelling from GMT-0500 to GMT+0200 to visit
family is affecting more than I thought.

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
