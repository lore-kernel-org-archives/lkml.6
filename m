Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939254AbeE1Nb4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033644AbeE1Kqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helen Chao <helen.chao@oracle.com>,
        Bill Baker <bill.baker@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 124/496] nfs: system crashes after NFS4ERR_MOVED recovery
Date: Mon, 28 May 2018 11:58:29 +0200
Message-Id: <20180528100325.154908088@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Bill.Baker@oracle.com" <Bill.Baker@oracle.com>

[ Upstream commit ad86f605c59500da82d196ac312cfbac3daba31d ]

nfs4_update_server unconditionally releases the nfs_client for the
source server. If migration fails, this can cause the source server's
nfs_client struct to be left with a low reference count, resulting in
use-after-free.  Also, adjust reference count handling for ELOOP.

NFS: state manager: migration failed on NFSv4 server nfsvmu10 with error 6
WARNING: CPU: 16 PID: 17960 at fs/nfs/client.c:281 nfs_put_client+0xfa/0x110 [nfs]()
	nfs_put_client+0xfa/0x110 [nfs]
	nfs4_run_state_manager+0x30/0x40 [nfsv4]
	kthread+0xd8/0xf0

BUG: unable to handle kernel NULL pointer dereference at 00000000000002a8
	nfs4_xdr_enc_write+0x6b/0x160 [nfsv4]
	rpcauth_wrap_req+0xac/0xf0 [sunrpc]
	call_transmit+0x18c/0x2c0 [sunrpc]
	__rpc_execute+0xa6/0x490 [sunrpc]
	rpc_async_schedule+0x15/0x20 [sunrpc]
	process_one_work+0x160/0x470
	worker_thread+0x112/0x540
	? rescuer_thread+0x3f0/0x3f0
	kthread+0xd8/0xf0

This bug was introduced by 32e62b7c ("NFS: Add nfs4_update_server"),
but the fix applies cleanly to 52442f9b ("NFS4: Avoid migration loops")

Reported-by: Helen Chao <helen.chao@oracle.com>
Fixes: 52442f9b11b7 ("NFS4: Avoid migration loops")
Signed-off-by: Bill Baker <bill.baker@oracle.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4client.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -858,8 +858,10 @@ static int nfs4_set_client(struct nfs_se
 	if (IS_ERR(clp))
 		return PTR_ERR(clp);
 
-	if (server->nfs_client == clp)
+	if (server->nfs_client == clp) {
+		nfs_put_client(clp);
 		return -ELOOP;
+	}
 
 	/*
 	 * Query for the lease time on clientid setup or renewal
@@ -1217,11 +1219,11 @@ int nfs4_update_server(struct nfs_server
 				clp->cl_proto, clnt->cl_timeout,
 				clp->cl_minorversion, net);
 	clear_bit(NFS_MIG_TSM_POSSIBLE, &server->mig_status);
-	nfs_put_client(clp);
 	if (error != 0) {
 		nfs_server_insert_lists(server);
 		return error;
 	}
+	nfs_put_client(clp);
 
 	if (server->nfs_client->cl_hostname == NULL)
 		server->nfs_client->cl_hostname = kstrdup(hostname, GFP_KERNEL);
