Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC00121852
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129282;
	bh=9hiWdDQs20XkXRz/le2Y8shF1mvHY1Q6RDAWm0NEVbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yyP3TsMx2BFAIbgGMKpdIJ9kAOM63HO1kCFksOeSXD+X8MU31WH+ZyuSwlGmcLhFg
	 wi4j/vimBJgDkWkfkqKAwTc2nTVw/1LXeg8JGmcYLG/6tWHSoFJSgAup30Q4F0m+D4
	 j0iVPr7ll9zziMP+hcmajfbXi3+FqN4ni4lBSm4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfBYVOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbfBYVOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052A72147C;
        Mon, 25 Feb 2019 21:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129277;
        bh=9hiWdDQs20XkXRz/le2Y8shF1mvHY1Q6RDAWm0NEVbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQHVaqSuntVMxUZtt8GxJRhQGtDevwCvHjzNRVPcdpib86RO+W+NKd9EZ60CC+9CJ
         nI+uBXm/QtV+6g+HCNUUOGxPOgYUCHyDDdMFTi0O/mJT0q2n5NL/j/Lykvw2ESGZOw
         YbRME4DpGVxbdDEBaUSEIOOfRra0sIJv7iMe2pv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 42/63] hpet: Make cmd parameter of hpet_ioctl_common() unsigned
Date:   Mon, 25 Feb 2019 22:11:42 +0100
Message-Id: <20190225195039.026848745@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 5cd5e6ad0ede862432e1e766bfe02a9ad447533e upstream.

The value passed by the two callers of the function is unsigned anyway.

Making the parameter unsigned fixes the following warning when building
with clang:

drivers/char/hpet.c:588:7: error: overflow converting case value to switch condition type (2149083139 to 18446744071563667459) [-Werror,-Wswitch]
        case HPET_INFO:
             ^
include/uapi/linux/hpet.h:18:19: note: expanded from macro 'HPET_INFO'
                        ^
include/uapi/asm-generic/ioctl.h:77:28: note: expanded from macro '_IOR'
                                ^
include/uapi/asm-generic/ioctl.h:66:2: note: expanded from macro '_IOC'
        (((dir)  << _IOC_DIRSHIFT) | \

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hpet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -574,7 +574,7 @@ static inline unsigned long hpet_time_di
 }
 
 static int
-hpet_ioctl_common(struct hpet_dev *devp, int cmd, unsigned long arg,
+hpet_ioctl_common(struct hpet_dev *devp, unsigned int cmd, unsigned long arg,
 		  struct hpet_info *info)
 {
 	struct hpet_timer __iomem *timer;


