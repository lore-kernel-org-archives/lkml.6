Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF56C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725AB218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357999;
	bh=EC1Y8kfB2s9Y0ympO8Dh2+xya5tjrA7Rs+sDZjWqFuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oHtwWEfDyv2kBNDFiPCYSCKd0O+1ToFrA094NtLn+rXHNEx4taQ8WcIse6Kpshx/x
	 2FrFZEO1pBDYvRXFuHUgVA5nLsSpXy1aQgIVBPtXnLZV2/1XQPjPWz7i0PEVUYzJfB
	 Vwhtsh/f/8qvBhMjjEMOa/zTtIGiC0gGE2640vxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfAXT0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:26:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730570AbfAXT0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:26:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EECCA217D7;
        Thu, 24 Jan 2019 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357990;
        bh=EC1Y8kfB2s9Y0ympO8Dh2+xya5tjrA7Rs+sDZjWqFuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jL5eTTdurdSbjZH+V9uJNsIWkJoGo0OAHNejGjeLnvYDBdfgVQh71UlOoDC1/W98v
         F3+3sXhf9JQV6SXmbYcgnv//9tWdkH6L2klMXu0lJ1MuMVTsZ72OooJKgCuL/hZ6q+
         reB85yy6On24ct9L5zsb0qsEZxKuYyJ+d5sU+pZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com,
        "J. Bruce Fields" <bfields@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.4 059/104] sunrpc: handle ENOMEM in rpcb_getport_async
Date:   Thu, 24 Jan 2019 20:19:48 +0100
Message-Id: <20190124190202.192333101@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit 81c88b18de1f11f70c97f28ced8d642c00bb3955 upstream.

If we ignore the error we'll hit a null dereference a little later.

Reported-by: syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/rpcb_clnt.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -772,6 +772,12 @@ void rpcb_getport_async(struct rpc_task
 	case RPCBVERS_3:
 		map->r_netid = xprt->address_strings[RPC_DISPLAY_NETID];
 		map->r_addr = rpc_sockaddr2uaddr(sap, GFP_ATOMIC);
+		if (!map->r_addr) {
+			status = -ENOMEM;
+			dprintk("RPC: %5u %s: no memory available\n",
+				task->tk_pid, __func__);
+			goto bailout_free_args;
+		}
 		map->r_owner = "";
 		break;
 	case RPCBVERS_2:
@@ -794,6 +800,8 @@ void rpcb_getport_async(struct rpc_task
 	rpc_put_task(child);
 	return;
 
+bailout_free_args:
+	kfree(map);
 bailout_release_client:
 	rpc_release_client(rpcb_clnt);
 bailout_nofree:


