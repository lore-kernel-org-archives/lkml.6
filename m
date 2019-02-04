Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D958C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11622217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277513;
	bh=DHzTtT0rNz/VpJaHMB7JrISdTWdKHnTranTVa9grBr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YE+MO+tk/PxHKqozSx8ZQsodTeICTms7g7yROelGpu1y6fxJg3o8A49AW9DIaiEFe
	 7VtC4mMlQa+tibKmb1kB+gTIv+yG/3eh0qLfwYM9jLLpaAXxv46nJGhZmh2DZGu9eF
	 ocmc0EXmlDuLdRCT0S5hy52g7EMcmtKetZW3B8Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbfBDKvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732417AbfBDKvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989712070C;
        Mon,  4 Feb 2019 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277507;
        bh=DHzTtT0rNz/VpJaHMB7JrISdTWdKHnTranTVa9grBr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M46KmnQfT9rO+QHmlbqS3RFmsWTh0P+Mhlep9pDMMjHgh677HUpQmN0HMi0lLa5wy
         zngB7t7qpj/n2Y/iE0w20P5enP0LxvtymcgCeFbF6VfhwyLxZvnrGNZyHiU3+qbdz4
         O05YukXTzKAh1uyWnyj5z3vW71+Y8+vL0V7j+WmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Amanakis <gamanakis@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 15/80] tun: move the call to tun_set_real_num_queues
Date:   Mon,  4 Feb 2019 11:36:35 +0100
Message-Id: <20190204103622.513162923@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: George Amanakis <gamanakis@gmail.com>

[ Upstream commit 3a03cb8456cc1d61c467a5375e0a10e5207b948c ]

Call tun_set_real_num_queues() after the increment of tun->numqueues
since the former depends on it. Otherwise, the number of queues is not
correctly accounted for, which results to warnings similar to:
"vnet0 selects TX queue 11, but real number of TX queues is 11".

Fixes: 0b7959b62573 ("tun: publish tfile after it's fully initialized")
Reported-and-tested-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -862,8 +862,6 @@ static int tun_attach(struct tun_struct
 	if (rtnl_dereference(tun->xdp_prog))
 		sock_set_flag(&tfile->sk, SOCK_XDP);
 
-	tun_set_real_num_queues(tun);
-
 	/* device is allowed to go away first, so no need to hold extra
 	 * refcnt.
 	 */
@@ -875,6 +873,7 @@ static int tun_attach(struct tun_struct
 	rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
 	tun->numqueues++;
+	tun_set_real_num_queues(tun);
 out:
 	return err;
 }


