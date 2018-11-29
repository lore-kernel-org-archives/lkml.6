Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2159206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2159206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeK2Sxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:53:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53833 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeK2Sxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:53:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAT7mw6Q2762489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 23:48:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAT7mvhj2762486;
        Wed, 28 Nov 2018 23:48:57 -0800
Date:   Wed, 28 Nov 2018 23:48:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-cb74635faa17cfa2991ddbe027596270af525c6d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        babu.moger@amd.com, dan.carpenter@oracle.com,
        reinette.chatre@intel.com, hpa@zytor.com, bp@suse.de,
        Babu.Moger@amd.com, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
          babu.moger@amd.com, dan.carpenter@oracle.com,
          reinette.chatre@intel.com, bp@suse.de, hpa@zytor.com,
          Babu.Moger@amd.com, mingo@redhat.com, x86@kernel.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20181128224234.22998-1-babu.moger@amd.com>
References: <20181128224234.22998-1-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Remove unnecessary check for
 cbm_validate()
Git-Commit-ID: cb74635faa17cfa2991ddbe027596270af525c6d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cb74635faa17cfa2991ddbe027596270af525c6d
Gitweb:     https://git.kernel.org/tip/cb74635faa17cfa2991ddbe027596270af525c6d
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 28 Nov 2018 22:42:47 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 29 Nov 2018 08:36:12 +0100

x86/resctrl: Remove unnecessary check for cbm_validate()

The Smatch static checker reports the following error after commit:

  a36c5ff560fb ("x86/resctrl: Bring cbm_validate() into the resource structure"):

  arch/x86/kernel/cpu/resctrl/ctrlmondata.c:227 parse_cbm()
  error: uninitialized symbol 'cbm_val'.
  arch/x86/kernel/cpu/resctrl/ctrlmondata.c:236 parse_cbm()
  error: uninitialized symbol 'cbm_val'.

This could happen if ->cbm_validate() is NULL which could leave cbm_val
uninitialized.

However, there is no case where ->cbm_validate() can be NULL as it is
initialized based on a vendor check. So it is either an Intel or an AMD
version it points to. And in both the cases it is initialized properly.
Thus, remove the first check.

Verified the fix running Smatch.

 [ bp: massage commit message. ]

Fixes: a36c5ff560fb ("x86/resctrl: Bring cbm_validate() into the resource structure")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181128224234.22998-1-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 03ee13235a45..ba11f54f5ab8 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -219,7 +219,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 		return -EINVAL;
 	}
 
-	if (r->cbm_validate && !r->cbm_validate(data->buf, &cbm_val, r))
+	if (!r->cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
 	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
