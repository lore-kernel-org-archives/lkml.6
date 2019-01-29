Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7391BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EC920880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763137;
	bh=lw0zFGn2+C3mzvA/gMa3oF+FCZf7EEs/lScnGQFvuRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JxpIG03KEHDes9KJgx7cqwGXk+v2ed2UURuiB1/iWmoRx8NptY/cCkbUIrvEPi4Z0
	 CwvN5BB6n9LNJbHePYu5GwNBXUVzOvBMjOqITlKAD586qFLuRiffnvBs3/ysBW5PwE
	 ecrMiOXi+f8fk1a+Cjn9kqkWoDIq1yPN2KBaETXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfA2L64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730866AbfA2Lrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F2B921852;
        Tue, 29 Jan 2019 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762452;
        bh=lw0zFGn2+C3mzvA/gMa3oF+FCZf7EEs/lScnGQFvuRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHYtuwYocQel8YHujj3laAMztNHZdo5aXzl8OcCEjEzgmVywgqHOl83vU7ZbIQvX/
         98jXfvk/p5kzq/VbRMscuH294Z/plyFC1juJFJpRk3qSXzFHVkEvSRch9bXbFhXork
         kxDYQG7DiqBPQNXflL9g55uG50DcyEHZMD6pDU8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 10/68] ipfrag: really prevent allocation on netns exit
Date:   Tue, 29 Jan 2019 12:35:32 +0100
Message-Id: <20190129113132.466376383@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

[ Upstream commit f6f2a4a2eb92bc73671204198bb2f8ab53ff59fb ]

Setting the low threshold to 0 has no effect on frags allocation,
we need to clear high_thresh instead.

The code was pre-existent to commit 648700f76b03 ("inet: frags:
use rhashtables for reassembly units"), but before the above,
such assignment had a different role: prevent concurrent eviction
from the worker and the netns cleanup helper.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -90,7 +90,7 @@ static void inet_frags_free_cb(void *ptr
 
 void inet_frags_exit_net(struct netns_frags *nf)
 {
-	nf->low_thresh = 0; /* prevent creation of new frags */
+	nf->high_thresh = 0; /* prevent creation of new frags */
 
 	rhashtable_free_and_destroy(&nf->rhashtable, inet_frags_free_cb, NULL);
 }


