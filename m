Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39263C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B50D21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498812;
	bh=cqICbBnVNhGpmLuXkm4aGEd7BTEUkH+Am/Vdc6a3Ns8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m/iHPAmF3fCMvU7HzDsFkGrOAQPS0jidh5Y73ooT2wOMyqXLyUM0OpM8oMiZSWjbB
	 VF/9HsxqBfaRRfK/6N7jKaJpLIEfTCprlPdCU/JQQMHxjuUca319anbs4MCv6BT7Mk
	 09xdpnfQmXCtIrW6c9IO1x9EknV5mLOgvNR/NSrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbfBROGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390471AbfBROGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7EA21902;
        Mon, 18 Feb 2019 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498805;
        bh=cqICbBnVNhGpmLuXkm4aGEd7BTEUkH+Am/Vdc6a3Ns8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRPQAk7Dr5x9dIOSAjiRUclazGQAjvMvFmuhYAk9A0Lc9QOZSu5ixrX7gtEBL1CxR
         OPXhFpBX0SdJAzGK69xJHUBfLO3SxW14R3tR1sBWD8Lmw53lvXnkOxcGIHxdZjqX3Q
         oQj4dWxdAIu1aqcdBwVJmDwRelSjONN78s2wOqwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 4.4 101/143] misc: vexpress: Off by one in vexpress_syscfg_exec()
Date:   Mon, 18 Feb 2019 14:43:49 +0100
Message-Id: <20190218133532.731704341@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit f8a70d8b889f180e6860cb1f85fed43d37844c5a upstream.

The > comparison should be >= to prevent reading beyond the end of the
func->template[] array.

(The func->template array is allocated in vexpress_syscfg_regmap_init()
and it has func->num_templates elements.)

Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/vexpress-syscfg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/vexpress-syscfg.c
+++ b/drivers/misc/vexpress-syscfg.c
@@ -61,7 +61,7 @@ static int vexpress_syscfg_exec(struct v
 	int tries;
 	long timeout;
 
-	if (WARN_ON(index > func->num_templates))
+	if (WARN_ON(index >= func->num_templates))
 		return -EINVAL;
 
 	command = readl(syscfg->base + SYS_CFGCTRL);


