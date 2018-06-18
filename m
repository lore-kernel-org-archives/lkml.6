Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADDDC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2D20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F2D20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936947AbeFRK2v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933600AbeFRK2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:28:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 472813086252;
        Mon, 18 Jun 2018 10:28:47 +0000 (UTC)
Received: from llong.com (ovpn-116-106.phx2.redhat.com [10.3.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 108D25C257;
        Mon, 18 Jun 2018 10:28:40 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 0/5] ipc: IPCMNI limit check for *mni & increase that limit
Date:   Mon, 18 Jun 2018 18:28:13 +0800
Message-Id: <1529317698-16575-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 18 Jun 2018 10:28:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7->v8:
 - Remove the __read_mostly tag for ipc_mni and related variables as their
   accesses are not really in performance critical path.
 - Add a new ipcmni_compat sysctl parameter that can be set to restore old
   range check behavior if desired.

v6->v7:
 - Drop the range clamping code and just return error instead for now
   until there is user request for clamping support.
 - Fix compilation error when CONFIG_SYSVIPC_SYSCTL isn't defined.

v5->v6:
 - Consolidate the 3 ctl_table flags into 2.
 - Make similar changes to proc_doulongvec_minmax() and its associates
   to complete the clamping change.
 - Remove the sysctl registration failure test patch for now for later
   consideration.
 - Add extra braces to patch 1 to reduce code diff in a later patch.

v4->v5:
 - Revert the flags back to 16-bit so that there will be no change to
   the size of ctl_table.
 - Enhance the sysctl_check_flags() as requested by Luis to perform more
   checks to spot incorrect ctl_table entries.
 - Change the sysctl selftest to use dummy sysctls instead of production
   ones & enhance it to do more checks.
 - Add one more sysctl selftest for registration failure.
 - Add 2 ipc patches to add an extended mode to increase IPCMNI from
   32k to 2M.
 - Miscellaneous change to incorporate feedback comments from
   reviewers.

v3->v4:
 - Remove v3 patches 1 & 2 as they have been merged into the mm tree.
 - Change flags from uint16_t to unsigned int.
 - Remove CTL_FLAGS_OOR_WARNED and use pr_warn_ratelimited() instead.
 - Simplify the warning message code.
 - Add a new patch to fail the ctl_table registration with invalid flag.
 - Add a test case for range clamping in sysctl selftest.

v2->v3:
 - Fix kdoc comment errors.
 - Incorporate comments and suggestions from Luis R. Rodriguez.
 - Add a patch to fix a typo error in fs/proc/proc_sysctl.c.

v1->v2:
 - Add kdoc comments to the do_proc_do{u}intvec_minmax_conv_param
   structures.
 - Add a new flags field to the ctl_table structure for specifying
   whether range clamping should be activated instead of adding new
   sysctl parameter handlers.
 - Clamp the semmni value embedded in the multi-values sem parameter.

v5 patch: https://lkml.org/lkml/2018/3/16/1106
v6 patch: https://lkml.org/lkml/2018/4/27/1094
v7 patch: https://lkml.org/lkml/2018/5/7/666

The sysctl parameters msgmni, shmmni and semmni have an inherent limit
of IPC_MNI (32k). However, users may not be aware of that because they
can write a value much higher than that without getting any error or
notification. Reading the parameters back will show the newly written
values which are not real.

The real IPCMNI limit is now enforced to make sure that users won't
put in an unrealistic value. The first 2 patches enforce the limits.

There are also users out there requesting increase in the IPCMNI value.
The last 2 patches attempt to do that by using a boot kernel parameter
"ipcmni_extend" to increase the IPCMNI limit from 32k to 2M if the users
really want the extended value.

Enforcing the range limit check may cause some existing applications to break
if they unwittingly set a value higher than 32k. To allow system administrators
to work around this issue, a new ipcmni_compat sysctl parameter can now be set
to restore the old behavior. This compatibility mode can only be set if the
ipcmni_extend boot parameter is not specified. Patch 5 implements this new
sysctl parameter.

Waiman Long (5):
  ipc: IPCMNI limit check for msgmni and shmmni
  ipc: IPCMNI limit check for semmni
  ipc: Allow boot time extension of IPCMNI from 32k to 2M
  ipc: Conserve sequence numbers in extended IPCMNI mode
  ipc: Add a new ipcmni_compat sysctl to fall back to old behavior

 Documentation/admin-guide/kernel-parameters.txt |  3 +
 Documentation/sysctl/kernel.txt                 | 15 +++++
 include/linux/ipc_namespace.h                   |  1 +
 ipc/ipc_sysctl.c                                | 78 ++++++++++++++++++++++++-
 ipc/util.c                                      | 41 ++++++++-----
 ipc/util.h                                      | 50 +++++++++++++---
 6 files changed, 164 insertions(+), 24 deletions(-)

-- 
1.8.3.1

