Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B03C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D9720842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131397;
	bh=voHB6Liu72Q046PqLbS1LoTMRBGx2aYGZjMj2Vv0OEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O+7iaIchgXA/Op/hq0Zikjnm8e5i8RW6oL3K7vGyvITAb2dHx9+c0+34A2Dx5x17W
	 2jz8oTA1fx6o+CgD7WCgBgUq0MEMVI0Pl0TOef8+oaukB8g44pHCSj0NldtA+B38qa
	 O058mTc8M6IR+QAhS+gyg1YcI1GUybE3mLf3HSqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfBYVtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731361AbfBYVZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B68C2084D;
        Mon, 25 Feb 2019 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129913;
        bh=voHB6Liu72Q046PqLbS1LoTMRBGx2aYGZjMj2Vv0OEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtFpn5ZeuXdWjTARZI8Y7ANi3kEgp5y2wgZa0Ge8C8H0PXqVQda3UsO1M0vbOfo9x
         DPEqm2kXH9MzuYhm5SDJ5Cb8awgSxii+q5yThrIk62R5+fRq55ixZYsTX4zGbF8pvi
         iW6GveIixm5R/XaVtEbFmLQ1yjCOKdLOhKXo7D0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 100/152] ipv6: propagate genlmsg_reply return code
Date:   Mon, 25 Feb 2019 22:11:32 +0100
Message-Id: <20190225195049.849212340@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit d1f20798a119be71746949ba9b2e2ff330fdc038 ]

genlmsg_reply can fail, so propagate its return code

Fixes: 915d7e5e593 ("ipv6: sr: add code base for control plane support of SR-IPv6")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -221,9 +221,7 @@ static int seg6_genl_get_tunsrc(struct s
 	rcu_read_unlock();
 
 	genlmsg_end(msg, hdr);
-	genlmsg_reply(msg, info);
-
-	return 0;
+	return genlmsg_reply(msg, info);
 
 nla_put_failure:
 	rcu_read_unlock();


