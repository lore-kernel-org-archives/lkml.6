Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFA5C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009882089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079285;
	bh=AJdADQgYhIcahebbaQJp5XDB+tEG37nckWQPfBr0mLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNf9TIpj9E9QplsIgzI99K92ppe2GIAdWlDBZdJg8d2xpqq/YK7NwxKB3CjacEVX2
	 VxdkrCVmb95U9JiAl8yDQ8aLuhF4AelMcMHaTEXyrM/3tMi9S+UvBXnzbCfOx0wwYS
	 /RETx6PtOyLuKsfLWA3uRBTUomGrKXcwBtugJ+lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfAUOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732618AbfAUOBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:01:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E916217D4;
        Mon, 21 Jan 2019 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079278;
        bh=AJdADQgYhIcahebbaQJp5XDB+tEG37nckWQPfBr0mLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GH9JTi3pgbXkRkEOQ9H19zit9ihWQVgFKN28VLzsXhIbRIS6MVF10lr1HJRCJhfvX
         XgjfQE837sW5Kvc4Q5a8woKG69KngB/V3BoEQjjV81e1U6HA7k1jqOogBQJhM3CEUo
         L5oFC+s3T5xRlhEbrpZvPZ3JzH5qvcVOU4etlKdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com,
        "J. Bruce Fields" <bfields@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.19 68/99] sunrpc: handle ENOMEM in rpcb_getport_async
Date:   Mon, 21 Jan 2019 14:49:00 +0100
Message-Id: <20190121134916.561998532@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -771,6 +771,12 @@ void rpcb_getport_async(struct rpc_task
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
@@ -793,6 +799,8 @@ void rpcb_getport_async(struct rpc_task
 	rpc_put_task(child);
 	return;
 
+bailout_free_args:
+	kfree(map);
 bailout_release_client:
 	rpc_release_client(rpcb_clnt);
 bailout_nofree:


