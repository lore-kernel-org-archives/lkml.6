Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80366C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D4220700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760675;
	bh=rSAB+hP5LNVIvBjKHSGH7OlJQwmRr213jbbYb4KfhUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZInTYrJQIeFtMfPA9D+9W1fDDfpfVdjf+kAu5pjzTufpYLz3PYzFvr07HwWP2nPst
	 xeHXtsjnaYnfCtQWCbbHpSC/oBOGtNgIBRMxDR33naviGvdpbkpQT8XTDr7cKE0+h7
	 A3Vy+yO/RA3jliFMfoJE9L8n8H3aaxw83R4bpWs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfBUOhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfBUOhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9C62075C;
        Thu, 21 Feb 2019 14:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759862;
        bh=rSAB+hP5LNVIvBjKHSGH7OlJQwmRr213jbbYb4KfhUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMp0hbUVh8r80PM8AqyVv2YjMo9i/uVqLa5zrF2zhCmG/MLHWrzQYxaz3ptY88FVO
         umfYCKCBoplsRkzV4WimURgPFmgiK75gPRTinfOa8hSn+9NsG5AjB7EhTaI9Vm1ipg
         2v+yEq8J3zi/Awh4JUl0FB8JEJcBsUu31gtrMcKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4.4 16/20] mfd: as3722: Mark PM functions as __maybe_unused
Date:   Thu, 21 Feb 2019 15:35:46 +0100
Message-Id: <20190221141947.236861069@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit a7b956fd38dd217dd78e3058110929f5ac914df1 upstream.

The newly introduced as3722_i2c_suspend/resume functions are built
unconditionally, but only used when power management is enabled,
so we get a warning otherwise:

drivers/mfd/as3722.c:427:12: warning: 'as3722_i2c_suspend' defined but not used [-Wunused-function]
drivers/mfd/as3722.c:438:12: warning: 'as3722_i2c_resume' defined but not used [-Wunused-function]

This marks them both as __maybe_unused, which avoids an ugly #ifdef
and gives us best compile-time coverage. When they are unused, the
compiler will silently drop the functions from its output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 35deff7eb212 ("mfd: as3722: Handle interrupts on suspend")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/as3722.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -424,7 +424,7 @@ static int as3722_i2c_remove(struct i2c_
 	return 0;
 }
 
-static int as3722_i2c_suspend(struct device *dev)
+static int __maybe_unused as3722_i2c_suspend(struct device *dev)
 {
 	struct as3722 *as3722 = dev_get_drvdata(dev);
 
@@ -435,7 +435,7 @@ static int as3722_i2c_suspend(struct dev
 	return 0;
 }
 
-static int as3722_i2c_resume(struct device *dev)
+static int __maybe_unused as3722_i2c_resume(struct device *dev)
 {
 	struct as3722 *as3722 = dev_get_drvdata(dev);
 


