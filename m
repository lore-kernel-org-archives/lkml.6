Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AC720652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AC720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbeGTNcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:32:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbeGTNcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:32:46 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04DF4CDB;
        Fri, 20 Jul 2018 12:38:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c226690f7b3126c5ee04@syzkaller.appspotmail.com,
        syzbot+709f2810a6a05f11d4d3@syzkaller.appspotmail.com,
        Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 071/101] tls: Stricter error checking in zerocopy sendmsg path
Date:   Fri, 20 Jul 2018 14:14:17 +0200
Message-Id: <20180720121426.323488713@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Watson <davejwatson@fb.com>

commit 32da12216e467dea70a09cd7094c30779ce0f9db upstream.

In the zerocopy sendmsg() path, there are error checks to revert
the zerocopy if we get any error code.  syzkaller has discovered
that tls_push_record can return -ECONNRESET, which is fatal, and
happens after the point at which it is safe to revert the iter,
as we've already passed the memory to do_tcp_sendpages.

Previously this code could return -ENOMEM and we would want to
revert the iter, but AFAIK this no longer returns ENOMEM after
a447da7d004 ("tls: fix waitall behavior in tls_sw_recvmsg"),
so we fail for all error codes.

Reported-by: syzbot+c226690f7b3126c5ee04@syzkaller.appspotmail.com
Reported-by: syzbot+709f2810a6a05f11d4d3@syzkaller.appspotmail.com
Signed-off-by: Dave Watson <davejwatson@fb.com>
Fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tls/tls_sw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -440,7 +440,7 @@ alloc_encrypted:
 			ret = tls_push_record(sk, msg->msg_flags, record_type);
 			if (!ret)
 				continue;
-			if (ret == -EAGAIN)
+			if (ret < 0)
 				goto send_end;
 
 			copied -= try_to_copy;


