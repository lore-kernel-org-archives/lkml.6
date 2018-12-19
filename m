Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A73C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3AA217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeLSLqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:46:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:6611 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeLSLqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:46:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 03:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,372,1539673200"; 
   d="scan'208";a="110628677"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 19 Dec 2018 03:46:47 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] stm class: Fix a module refcount leak in policy creation error path
Date:   Wed, 19 Dec 2018 13:46:37 +0200
Message-Id: <20181219114637.12955-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219084914.GA28855@kroah.com>
References: <20181219084914.GA28855@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c7fd62bc69d0 ("stm class: Introduce framing protocol drivers")
adds a bug into the error path of policy creation, that would do a
module_put() on a wrong module, if one tried to create a policy for
an stm device which already has a policy, using a different protocol.
IOW,

| mkdir /config/stp-policy/dummy_stm.0:p_basic.test
| mkdir /config/stp-policy/dummy_stm.0:p_sys-t.test # puts "p_basic"
| mkdir /config/stp-policy/dummy_stm.0:p_sys-t.test # "p_basic" -> -1

throws:

| general protection fault: 0000 [#1] SMP PTI
| CPU: 3 PID: 2887 Comm: mkdir
| RIP: 0010:module_put.part.31+0xe/0x90
| Call Trace:
|  module_put+0x13/0x20
|  stm_put_protocol+0x11/0x20 [stm_core]
|  stp_policy_make+0xf1/0x210 [stm_core]
|  ? __kmalloc+0x183/0x220
|  ? configfs_mkdir+0x10d/0x4c0
|  configfs_mkdir+0x169/0x4c0
|  vfs_mkdir+0x108/0x1c0
|  do_mkdirat+0xe8/0x110
|  __x64_sys_mkdir+0x1b/0x20
|  do_syscall_64+0x5a/0x140
|  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Correct this sad mistake by calling calling 'put' on the correct
reference, which happens to match another error path in the same
function, so we consolidate the two at the same time.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: c7fd62bc69d0 ("stm class: Introduce framing protocol drivers")
Reported-by: Ammy Yi <ammy.yi@intel.com>
---
 drivers/hwtracing/stm/policy.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 0910ec807187..4b9e44b227d8 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -440,10 +440,8 @@ stp_policy_make(struct config_group *group, const char *name)
 
 	stm->policy = kzalloc(sizeof(*stm->policy), GFP_KERNEL);
 	if (!stm->policy) {
-		mutex_unlock(&stm->policy_mutex);
-		stm_put_protocol(pdrv);
-		stm_put_device(stm);
-		return ERR_PTR(-ENOMEM);
+		ret = ERR_PTR(-ENOMEM);
+		goto unlock_policy;
 	}
 
 	config_group_init_type_name(&stm->policy->group, name,
@@ -458,7 +456,11 @@ stp_policy_make(struct config_group *group, const char *name)
 	mutex_unlock(&stm->policy_mutex);
 
 	if (IS_ERR(ret)) {
-		stm_put_protocol(stm->pdrv);
+		/*
+		 * pdrv and stm->pdrv at this point can be quite different,
+		 * and only one of them needs to be 'put'
+		 */
+		stm_put_protocol(pdrv);
 		stm_put_device(stm);
 	}
 
-- 
2.19.2

