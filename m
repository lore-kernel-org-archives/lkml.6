Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C72CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D7A208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="STi9DLl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D7A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390204AbeKTDPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389271AbeKTDPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD0AA206BA;
        Mon, 19 Nov 2018 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646264;
        bh=HHwRPvi5aEhKvrhCkVizNdyGDe0hiA1hHEv9o9nwVug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STi9DLl141NaQOX56yNNWc0aVhf8Mc4mK7EhKX9HDTd23EW1V6ayEUWwjBxEc98gf
         XahF4QReWak7HMV16vJVtH8EJ7JJwDNjqFAf6h6DKUBOqDtyUpjs3L+JwY2MPKJzqY
         FNqU1pX6Gd5Q3fgmYHE9feadWp52na5tY0HbSHzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 099/124] fuse: fix leaked notify reply
Date:   Mon, 19 Nov 2018 17:29:13 +0100
Message-Id: <20181119162631.191501803@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

commit 7fabaf303458fcabb694999d6fa772cc13d4e217 upstream.

fuse_request_send_notify_reply() may fail if the connection was reset for
some reason (e.g. fs was unmounted).  Don't leak request reference in this
case.  Besides leaking memory, this resulted in fc->num_waiting not being
decremented and hence fuse_wait_aborted() left in a hanging and unkillable
state.

Fixes: 2d45ba381a74 ("fuse: add retrieve request")
Fixes: b8f95e5d13f5 ("fuse: umount should wait for all requests")
Reported-and-tested-by: syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: <stable@vger.kernel.org> #v2.6.36
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1721,8 +1721,10 @@ static int fuse_retrieve(struct fuse_con
 	req->in.args[1].size = total_len;
 
 	err = fuse_request_send_notify_reply(fc, req, outarg->notify_unique);
-	if (err)
+	if (err) {
 		fuse_retrieve_end(fc, req);
+		fuse_put_request(fc, req);
+	}
 
 	return err;
 }


