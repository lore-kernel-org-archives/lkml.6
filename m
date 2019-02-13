Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C209C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F16222D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083341;
	bh=PH1yMMZkL2OvNNUxwFXqQURZ2kohHkqAQE84NPyXoZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cyBNYmX9IGtz9P/KqLt0aEYEna4Qd1ZLMdhXJkndZkeV2k7AwMzycwjVRlK7p9bx2
	 dAY6Olt79g0m0fNm+0biOoCIxsf9tFhx6EWykLzvLQmR5yxSfOWvsahka1TTROk7VP
	 CXyg7vJsE8rIwVf2p9cmSEidjMdi0iost83ysSQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405632AbfBMSmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403891AbfBMSmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ABA8222D5;
        Wed, 13 Feb 2019 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083337;
        bh=PH1yMMZkL2OvNNUxwFXqQURZ2kohHkqAQE84NPyXoZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PKL45AJw/kMJLpRmnMJtQLMlyrixQl6AlUOrdwFe7jTa2IHuU1zfZY29bfB09PjV
         rqEUFllcfPTGn2kLQ+a/DY981xLy9pdDeJeuocAj3zEeqDWO2kLssf1V+I8Q7KVvmC
         GlfeuvS1hct56J3Ok1Ub2a/kviYhJFz8Nj8X6fpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 4.14 06/35] misc: vexpress: Off by one in vexpress_syscfg_exec()
Date:   Wed, 13 Feb 2019 19:38:01 +0100
Message-Id: <20190213183706.475349477@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


