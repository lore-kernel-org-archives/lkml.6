Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB982146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551132061;
	bh=/vO0RDMzxy+6G5fq46pNRPqTL2pFbJcXU0Y0Zb6XJ4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=spcY/tRpYqBwu5lHO/aZMJGGMIzoWLSnWw1nCYTbk5Ff0FRgKQcTTVGzg3YXecU2v
	 qcu/9EBxtryE3MwCnm6Dm0AVjE6uLgmQ5D45Nx0/6gk1XLEjgG5ZFC8JlDylN70rmO
	 EhYG4Y0WMkacAUshN1EpOO52U1s5NQO4vxhcghOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfBYWA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbfBYVRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:17:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC8942173C;
        Mon, 25 Feb 2019 21:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129442;
        bh=/vO0RDMzxy+6G5fq46pNRPqTL2pFbJcXU0Y0Zb6XJ4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT8BhfdaXYgq1GrrPcZE/G3DedelpiDr6uB57XT7+6JlA+AYcy2LWjbyyr7fyFwR5
         yQyy1G6m2nHnIdC5MzWaikmeiLfASsOzEurFTfXP8+vcWzYYaUKBepti2LOEJLGXIR
         x9u22OwSZehMQGZhdXCDfZ8GorSBw2uLIUP8m+1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/71] bpf: correctly set initial window on active Fast Open sender
Date:   Mon, 25 Feb 2019 22:11:33 +0100
Message-Id: <20190225195036.839248046@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

[ Upstream commit 31aa6503a15ba00182ea6dbbf51afb63bf9e851d ]

The existing BPF TCP initial congestion window (TCP_BPF_IW) does not
to work on (active) Fast Open sender. This is because it changes the
(initial) window only if data_segs_out is zero -- but data_segs_out
is also incremented on SYN-data.  This patch fixes the issue by
proerly accounting for SYN-data additionally.

Fixes: fc7478103c84 ("bpf: Adds support for setting initial cwnd")
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Lawrence Brakmo <brakmo@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 542fd04bc44da..a8a9ff0568b91 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3128,7 +3128,7 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 			/* Only some options are supported */
 			switch (optname) {
 			case TCP_BPF_IW:
-				if (val <= 0 || tp->data_segs_out > 0)
+				if (val <= 0 || tp->data_segs_out > tp->syn_data)
 					ret = -EINVAL;
 				else
 					tp->snd_cwnd = val;
-- 
2.19.1



