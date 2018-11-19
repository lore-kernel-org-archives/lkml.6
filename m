Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA1322353
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndQ7+afn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA1322353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405420AbeKTDYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405032AbeKTDYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B3221731;
        Mon, 19 Nov 2018 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646834;
        bh=l5Yr9yY8mQsv0yLJT3gH2+2coK5Kgi7pOiImeUfFtOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndQ7+afn7tJQvPk3y03WqMVgGAkSfMdjpmOMxgsdhaPlKcFUGY5pbbtIsvF8CUfT7
         f2KdmM/1W5AJcO+Az0rBnAT8GHbZmriBYiNnf3uHvN7oe8pSwdUMeUQPnvayTVrma6
         qyy9HCzJyvDeDp2icxOHuPfPmYLT7edooLcANpJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.4 070/160] lockd: fix access beyond unterminated strings in prints
Date:   Mon, 19 Nov 2018 17:28:29 +0100
Message-Id: <20181119162638.083297780@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -340,7 +340,7 @@ struct nlm_host *nlmsvc_lookup_host(cons
 	};
 	struct lockd_net *ln = net_generic(net, lockd_net_id);
 
-	dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
+	dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
 			(int)hostname_len, hostname, rqstp->rq_vers,
 			(rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
 


