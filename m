Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62526C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2819221850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130856;
	bh=YOkq5Q3SJmzg81zvqQEdwFNasK4tizKJl3yXR2ksoBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JpOmhGBE69K/yrb7PPIOkT6kJYL5Iv0MYQgKp4ClcKtqH+SR8BitSXrJQFR3SE8VV
	 mmubPoYBH+aAfTLD0IhWed1V86tj1kgdkaNClThvM2M+vkw0SgkV7P3+MxT9xIcOoH
	 1xBUymyLQw/8bamBp8KsChej9BmjKAK21JFS/n8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfBYVeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732564AbfBYVeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:34:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2134A2184D;
        Mon, 25 Feb 2019 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130447;
        bh=YOkq5Q3SJmzg81zvqQEdwFNasK4tizKJl3yXR2ksoBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOVCi7L/+6BZoYw+QsVSsMTZh0Q1gl7YAtig/Oo7LLdZW5wdsVUWblyznK+/Rag4r
         BbQxgzkMxH74CuTI/wfjztCzRglapuUflMw4WXWfKqMbxCdExlZolvz5mzkr2yn6vm
         +DRlx2aeH0CDi8dDxQJi4mVuess3V0xwD8SgZiqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 124/183] ipv6: propagate genlmsg_reply return code
Date:   Mon, 25 Feb 2019 22:11:37 +0100
Message-Id: <20190225195115.626567371@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


