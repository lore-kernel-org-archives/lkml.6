Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165A3C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03CB20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107578;
	bh=fCz0n6FbSNZoTEgTJK8U257SQiqY2q6ougPhJSPiGr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jQw7XpgSYMJb52ro6Rhx3ZHpl/S0OFEonmK74PuewAPs+ODx0WHE8NcZAF5I7kaxd
	 uTBA2nbL7KTHR+clfle/nqlST4/4MSpAq6Lwc0GYpARbWCCU+YTXCbB1ceX2wlhKeH
	 KVpvE4A+fF9iGFqckhpaOUDYBriBVdLCQbI+mOMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03CB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeLFOqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730430AbeLFOqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0918520892;
        Thu,  6 Dec 2018 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107573;
        bh=fCz0n6FbSNZoTEgTJK8U257SQiqY2q6ougPhJSPiGr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0eivHiUIOGTXQcPZvZ3f3hXJgkaua7kMTEJIPF/ac227eSJxpf4q9GTJNt1bAHgll
         f3Kvwg7mqPLb7TJX0O1ppThL5uuU5pBWpD58fgKGfMI6V39Al4oQeOleS7/+Wk2r5q
         n0ZsVahMCSLmCV14Rth3Yz8yte/sTSUbFWlgVEbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 057/101] libceph: check authorizer reply/challenge length before reading
Date:   Thu,  6 Dec 2018 15:38:56 +0100
Message-Id: <20181206143014.880913448@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 130f52f2b203aa0aec179341916ffb2e905f3afd upstream.

Avoid scribbling over memory if the received reply/challenge is larger
than the buffer supplied with the authorizer.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1738,6 +1738,13 @@ static int read_partial_connect(struct c
 
 	if (con->auth) {
 		size = le32_to_cpu(con->in_reply.authorizer_len);
+		if (size > con->auth->authorizer_reply_buf_len) {
+			pr_err("authorizer reply too big: %d > %zu\n", size,
+			       con->auth->authorizer_reply_buf_len);
+			ret = -EINVAL;
+			goto out;
+		}
+
 		end += size;
 		ret = read_partial(con, end, size,
 				   con->auth->authorizer_reply_buf);


