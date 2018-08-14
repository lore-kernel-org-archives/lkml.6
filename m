Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F32C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FF02173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FF02173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbeHNHjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:39:23 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:33167 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbeHNHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:39:23 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2018 03:39:22 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 8D1F61804763F;
        Tue, 14 Aug 2018 04:45:09 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A71BA100E86C4;
        Tue, 14 Aug 2018 04:45:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: woman94_83e70023d5d50
X-Filterd-Recvd-Size: 2870
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 04:45:06 +0000 (UTC)
Message-ID: <81ae2b1b7ea395217dbf3494457a232bdfdc79c5.camel@perches.com>
Subject: Re: [PATCH 1/2] ia64: Use ARRAY_SIZE to replace its implementation
From:   Joe Perches <golf@perches.com>
To:     zhong jiang <zhongjiang@huawei.com>, tony.luck@intel.com,
        fenghua.yu@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, oleg@redhat.com, rppt@linux.vnet.ibm.com,
        dhowells@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Mon, 13 Aug 2018 21:45:05 -0700
In-Reply-To: <1534214814-9043-2-git-send-email-zhongjiang@huawei.com>
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
         <1534214814-9043-2-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 10:46 +0800, zhong jiang wrote:
> We prefer to ARRAY_SIZE rather than duplicating its implementation.
> So just replace it.
[]
> diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
[]
> @@ -4645,7 +4645,7 @@ static char *pfmfs_dname(struct dentry *dentry, char *buffer, int buflen)
>  /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
>  /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
>  };
> -#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
> +#define PFM_CMD_COUNT	ARRAY_SIZE(pfm_cmd_tab)

Better would be to remove the #define altogether and change
the one place where it's used to ARRAY_SIZE(...)
---
 arch/ia64/kernel/perfmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index a9d4dc6c0427..08ece2c7b6e1 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -4645,7 +4645,6 @@ static pfm_cmd_desc_t pfm_cmd_tab[]={
 /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
 /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
 };
-#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
 
 static int
 pfm_check_task_state(pfm_context_t *ctx, int cmd, unsigned long flags)
@@ -4770,7 +4769,7 @@ sys_perfmonctl (int fd, int cmd, void __user *arg, int count)
 	 */
 	if (unlikely(pmu_conf == NULL)) return -ENOSYS;
 
-	if (unlikely(cmd < 0 || cmd >= PFM_CMD_COUNT)) {
+	if (unlikely(cmd < 0 || cmd >= ARRAY_SIZE(pfm_cmd_tab)) {
 		DPRINT(("invalid cmd=%d\n", cmd));
 		return -EINVAL;
 	}

