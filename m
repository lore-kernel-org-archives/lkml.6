Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522D3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132D12087A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132D12087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeHUJyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:54:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeHUJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:54:01 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 65FAEACC;
        Tue, 21 Aug 2018 06:35:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Karsten Keil <isdn@linux-pingi.de>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 22/22] isdn: Disable IIOCDBGVAR
Date:   Tue, 21 Aug 2018 08:21:48 +0200
Message-Id: <20180821055140.624675989@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055139.462620042@linuxfoundation.org>
References: <20180821055139.462620042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 5e22002aa8809e2efab2da95855f73f63e14a36c ]

It was possible to directly leak the kernel address where the isdn_dev
structure pointer was stored. This is a kernel ASLR bypass for anyone
with access to the ioctl. The code had been present since the beginning
of git history, though this shouldn't ever be needed for normal operation,
therefore remove it.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Karsten Keil <isdn@linux-pingi.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/i4l/isdn_common.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -1655,13 +1655,7 @@ isdn_ioctl(struct file *file, uint cmd,
 			} else
 				return -EINVAL;
 		case IIOCDBGVAR:
-			if (arg) {
-				if (copy_to_user(argp, &dev, sizeof(ulong)))
-					return -EFAULT;
-				return 0;
-			} else
-				return -EINVAL;
-			break;
+			return -EINVAL;
 		default:
 			if ((cmd & IIOCDRVCTL) == IIOCDRVCTL)
 				cmd = ((cmd >> _IOC_NRSHIFT) & _IOC_NRMASK) & ISDN_DRVIOCTL_MASK;


