Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E87C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F6720879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079041;
	bh=Nd2vwmN00wMPNG5BwvBZN6BMV670blATs9i7g6sdvwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2H+qGz4prhbG9/o6rkVk3VWhb/LVSlQHbh1IXb9vucDjV9PmXXrpg6ZIg5QNRj17O
	 f+sgCy0GAvETCPJ8+zIkBrIbw8Yz6DKvdxzRogpcK0lvC3SHjI31kaxS7LQerF362a
	 8QgnxpKLZ/wpldz9Z7QgbG34BWZ3oPoEccPIRwac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfAUN4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbfAUN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:56:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C42112089F;
        Mon, 21 Jan 2019 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078987;
        bh=Nd2vwmN00wMPNG5BwvBZN6BMV670blATs9i7g6sdvwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVspnVOlyvXOnIy6inoE/dM6duKLDanBtdiAVMgt3xXQmEAmSzCy9wPwycBLNIv8Z
         5qPV9197SEsLVNTV1vJ/AnZ6xF2rUF04QJDw1CwXi3yBuOMwIUxvYCdkOniCxOhmzQ
         ALdGHD+meKwhVzapxVHe2T2vIAi66aWzIT8nqaCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com,
        "J. Bruce Fields" <bfields@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.9 36/51] sunrpc: handle ENOMEM in rpcb_getport_async
Date:   Mon, 21 Jan 2019 14:44:32 +0100
Message-Id: <20190121122457.157030144@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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
@@ -770,6 +770,12 @@ void rpcb_getport_async(struct rpc_task
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
@@ -792,6 +798,8 @@ void rpcb_getport_async(struct rpc_task
 	rpc_put_task(child);
 	return;
 
+bailout_free_args:
+	kfree(map);
 bailout_release_client:
 	rpc_release_client(rpcb_clnt);
 bailout_nofree:


