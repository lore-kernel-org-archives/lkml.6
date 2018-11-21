Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE91BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AC4206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1DDGAjW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AC4206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeKVFog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeKVFof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5267214D9;
        Wed, 21 Nov 2018 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827342;
        bh=baKAklJM3BM8ZGuxCSO5DafktI6aNqMuu/XyJIroHF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DDGAjW9ZzweZb05l//ePcfcufed4dBXVpBEWPoB3WHgtk3zKY0Xg3mQKfZaf4uFw
         wbhw4j2SENkyaQCpxQpxS7l6vIJPJKnGRSnJkyXQMUl44JZRILDFB5vHpK4Wust+Xv
         YzgvbcrDZ+ugeQJNWRmfAr1yLFNKz0cMXndMnVys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianwen Ji <jiji@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 14/21] sctp: not increase streams incnt before sending addstrm_in request
Date:   Wed, 21 Nov 2018 20:06:58 +0100
Message-Id: <20181121183422.714815106@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit e1e46479847e66f78f79d8c24d5169a5954b3fc2 ]

Different from processing the addstrm_out request, The receiver handles
an addstrm_in request by sending back an addstrm_out request to the
sender who will increase its stream's in and incnt later.

Now stream->incnt has been increased since it sent out the addstrm_in
request in sctp_send_add_streams(), with the wrong stream->incnt will
even cause crash when copying stream info from the old stream's in to
the new one's in sctp_process_strreset_addstrm_out().

This patch is to fix it by simply removing the stream->incnt change
from sctp_send_add_streams().

Fixes: 242bd2d519d7 ("sctp: implement sender-side procedures for Add Incoming/Outgoing Streams Request Parameter")
Reported-by: Jianwen Ji <jiji@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -310,7 +310,6 @@ int sctp_send_add_streams(struct sctp_as
 		goto out;
 	}
 
-	stream->incnt = incnt;
 	stream->outcnt = outcnt;
 
 	asoc->strreset_outstanding = !!out + !!in;


