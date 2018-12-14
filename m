Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3510C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769DA2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789022;
	bh=ekwwVQBVJdzEm/3Q/5fC1Iu/yowF31+HLNgWHZefEWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yullzWX6RzZOv93VhUsW+rtG8osg7OzJYiBLYABDttogjmoKLo/IkdjlkMU6gOtV1
	 P0hqksWa5ETaistrKYVd7DplRTVL3TghNxqX3TAP/n6GFibadNEA4nygqZv/22uiHZ
	 60HI8KnHa7HzvS38f+C2FLxt8mKpN6Ku/ppSk1H0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769DA2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbeLNMDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeLNMDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF352145D;
        Fri, 14 Dec 2018 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789016;
        bh=ekwwVQBVJdzEm/3Q/5fC1Iu/yowF31+HLNgWHZefEWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5W3kA6woHadQVSfut90kwehTo+ZK0nPL5kWKr8BsfcTk1xhUeT8j5cKQu52764db
         Q2CpIqZpmNOf8Em9SwAur5CXa9xIGgDlOUpkvb/4qhris89k/EMsWVOWwYlgKlWQ+d
         fw4582pNHjo0D9nL0bgUbLmKCKr9ZmO0GnlGdAhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/142] s390/cio: Fix cleanup of pfn_array alloc failure
Date:   Fri, 14 Dec 2018 12:58:49 +0100
Message-Id: <20181214115748.811441563@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 806212f91c874b24cf9eb4a9f180323671b6c5ed ]

If pfn_array_alloc fails somehow, we need to release the pfn_array_table
that was malloc'd earlier.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20181109023937.96105-2-farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index fd77e46eb3b2..ef5ab45d94b3 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -528,7 +528,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 
 	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
 	if (ret < 0)
-		goto out_init;
+		goto out_unpin;
 
 	/* Translate this direct ccw to a idal ccw. */
 	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
-- 
2.19.1



