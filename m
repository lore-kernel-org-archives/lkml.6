Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94877C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594E320643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197372;
	bh=2LKSxtW8WKuswaGRgeyrr33fBbuX2oHJ82AsNkVQnCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvukwht0bWRivtxCWlubyivuNKkbhsLmSYKmzmOaJK3rPDm8jRvbd5U/YUIPRWX0v
	 8cfwoAP9eau/mzADgwp/M+mOUWplOYDntsPesL/bq+ZZ1dzKdQ4R6ag6awi6B55RiP
	 xGJFn9eIs7AUMRy1IAZ6VS5zTnva1dGrFqcCMkuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfBOCWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391891AbfBOCOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F35D206BA;
        Fri, 15 Feb 2019 02:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196881;
        bh=2LKSxtW8WKuswaGRgeyrr33fBbuX2oHJ82AsNkVQnCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEl5VIyE7CrxJ+VsajEe65Oa49nsL8TYb+tJ3j866Cps1e0+8IQ+HKBbr8fMdHkuw
         KyW0pklM0mfOJhdCwK8TtUaywr6MBBLDg4Uj813bJcPf7cgXrdfXm6j4N7cTcFQOwc
         sEx0eEpmU5n3BmkgU7vqC46IHJNbeDkgjwOVL6LM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 08/27] ASoC: dapm: change snprintf to scnprintf for possible overflow
Date:   Thu, 14 Feb 2019 21:14:05 -0500
Message-Id: <20190215021424.178979-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021424.178979-1-sashal@kernel.org>
References: <20190215021424.178979-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Silvio Cesare <silvio.cesare@gmail.com>

[ Upstream commit e581e151e965bf1f2815dd94620b638fec4d0a7e ]

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dapm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8bfc534e3b34..ab647f1fe11b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1976,19 +1976,19 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 		out = is_connected_output_ep(w, NULL, NULL);
 	}
 
-	ret = snprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
+	ret = scnprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
 		       w->name, w->power ? "On" : "Off",
 		       w->force ? " (forced)" : "", in, out);
 
 	if (w->reg >= 0)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				" - R%d(0x%x) mask 0x%x",
 				w->reg, w->reg, w->mask << w->shift);
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
 	if (w->sname)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret, " stream %s %s\n",
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, " stream %s %s\n",
 				w->sname,
 				w->active ? "active" : "inactive");
 
@@ -2001,7 +2001,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 			if (!p->connect)
 				continue;
 
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					" %s  \"%s\" \"%s\"\n",
 					(rdir == SND_SOC_DAPM_DIR_IN) ? "in" : "out",
 					p->name ? p->name : "static",
-- 
2.19.1

