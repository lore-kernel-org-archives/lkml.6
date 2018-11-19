Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA99C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F308214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xV2oUBkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F308214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406649AbeKTD3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405697AbeKTD3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC7C2148E;
        Mon, 19 Nov 2018 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647087;
        bh=FzPpF7pX1tc6AM9nykCS6Xtdlw5fNun/qj4Jk4kfDfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xV2oUBkfOpCOy6x+2xUDaDuK0lO54EVlX6SraPS7PzrAmBnr74hgxXzenr3tt+Q9y
         bprI59NRt9SSiTISq2r9f5IM5Lh9KnvGIEQjTNuCzGeW/c/ybPfZx586OQB069wcJY
         TdOfa4MFBJaSXOXENpJ9MbvYbI+FsvBJRsxiUZJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3.18 45/90] lockd: fix access beyond unterminated strings in prints
Date:   Mon, 19 Nov 2018 17:29:27 +0100
Message-Id: <20181119162628.094090854@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 93f38b6fae0ea8987e22d9e6c38f8dfdccd867ee upstream.

printk format used %*s instead of %.*s, so hostname_len does not limit
the number of bytes accessed from hostname.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/lockd/host.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -339,7 +339,7 @@ struct nlm_host *nlmsvc_lookup_host(cons
 	};
 	struct lockd_net *ln = net_generic(net, lockd_net_id);
 
-	dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
+	dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
 			(int)hostname_len, hostname, rqstp->rq_vers,
 			(rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
 


