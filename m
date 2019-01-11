Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9107C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8926421848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217810;
	bh=lVAHxWYVszceiDGS7BJnn7DdpClBWDR9oIC27TBZrWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R0HaKw/WuRH+Pps48pNvv/A0RswcBCWR+lrvOtqj1lE0og+5dmA8YnYumyZYiiRza
	 taaSE4JR/9eeS3sgKYX3LDJRGF7lFAlo5a/KLSDB/pe46uj4qJT4UsTPOWZ5q0ki1B
	 zzGk6dK0fYFMb5HaX8PYoA94g0S+N0vbMMT3QC6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404384AbfAKOna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404355AbfAKOnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12EB21841;
        Fri, 11 Jan 2019 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217802;
        bh=lVAHxWYVszceiDGS7BJnn7DdpClBWDR9oIC27TBZrWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzGRkove3wuNubuHlmJJMFndonjsn2RL8KmMKhODpEWE8UTNxKeeF2PUM3gJDyH8s
         c9BzelkrXZm0h5Wv00WZyTSJYGPi7Do9tBkbstbpYglZZVWeAHSJ0YMQzqMKNYK7U0
         qbWM3tfVLwuibEpRhPILeM/PE4oE5QsyGTJxUNJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH 4.20 47/65] stm class: Fix a module refcount leak in policy creation error path
Date:   Fri, 11 Jan 2019 15:15:33 +0100
Message-Id: <20190111131102.760686276@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit c18614a1a11276837bdd44403d84d207c9951538 upstream.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/policy.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -440,10 +440,8 @@ stp_policy_make(struct config_group *gro
 
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
@@ -458,7 +456,11 @@ unlock_policy:
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
 


