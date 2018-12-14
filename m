Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E9C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434C02080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790348;
	bh=BjX0dgq1/iREoFjAtcR2RH70gn2C5UICXJgp43/uSOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/FRwEZZdsxBDnyC8VBoqW0I+uKFnL3Na4KF2QZfeyP3itaTDvALX5iDGdx+2lze7
	 wSa/BIVQXER0AcpYCq+muTMWtHxGfDk59WH94e12O//St3GwYhKD9xilQxrfsEYi3X
	 Vt1r9CynqnptanwirySU3Hh4NuCzHcGp/63VKqsw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434C02080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbeLNMMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731885AbeLNMMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52798214D9;
        Fri, 14 Dec 2018 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789525;
        bh=BjX0dgq1/iREoFjAtcR2RH70gn2C5UICXJgp43/uSOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MplccDDlm3I+IX/PLXs10k1IG4JqG5xd9Vkwyq3hJ5ZWIdEjaEDJMWskMFa4p5s7W
         HodSzEWS4KS+lqsW1fxvdZcPpY7sNB1yGlcxtMlWJm1rrCdeAh3hTCiTlrP9FmCqvp
         j8XKvyaKlZSwsciDzN2rK9c/KFjsiMkYfhTljius=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/51] exportfs: do not read dentry after free
Date:   Fri, 14 Dec 2018 13:00:29 +0100
Message-Id: <20181214115715.773029553@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

[ Upstream commit 2084ac6c505a58f7efdec13eba633c6aaa085ca5 ]

The function dentry_connected calls dput(dentry) to drop the previously
acquired reference to dentry. In this case, dentry can be released.
After that, IS_ROOT(dentry) checks the condition
(dentry == dentry->d_parent), which may result in a use-after-free bug.
This patch directly compares dentry with its parent obtained before
dropping the reference.

Fixes: a056cc8934c("exportfs: stop retrying once we race with
rename/remove")

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exportfs/expfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index a4b531be9168..7a7bba7c2328 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -76,7 +76,7 @@ static bool dentry_connected(struct dentry *dentry)
 		struct dentry *parent = dget_parent(dentry);
 
 		dput(dentry);
-		if (IS_ROOT(dentry)) {
+		if (dentry == parent) {
 			dput(parent);
 			return false;
 		}
-- 
2.19.1



