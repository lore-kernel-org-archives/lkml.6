Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeCIVUj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:20:39 -0500
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:54144 "EHLO
        5.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeCIVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:20:38 -0500
Subject: [PATCH] net/9p: avoid -ERESTARTSYS leak to userspace
From: Greg Kurz <groug@kaod.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yiwen Jiang <jiangyiwen@huawei.com>
Date: Fri, 09 Mar 2018 21:41:38 +0100
Message-ID: <152062809886.10599.7361006774123053312.stgit@bahia.lan>
User-Agent: StGit/0.17.1-46-g6855-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17406975510168312198
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrkeeigddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it was interrupted by a signal, the 9p client may need to send some
more requests to the server for cleanup before returning to userspace.

To avoid such a last minute request to be interrupted right away, the
client memorizes if a signal is pending, clears TIF_SIGPENDING, handles
the request and calls recalc_sigpending() before returning.

Unfortunately, if the transmission of this cleanup request fails for any
reason, the transport returns an error and the client propagates it right
away, without calling recalc_sigpending().

This ends up with -ERESTARTSYS from the initially interrupted request
crawling up to syscall exit, with TIF_SIGPENDING cleared by the cleanup
request. The specific signal handling code, which is responsible for
converting -ERESTARTSYS to -EINTR is not called, and userspace receives
the confusing errno value:

open: Unknown error 512 (512)

This is really hard to hit in real life. I discovered the issue while
working on hot-unplug of a virtio-9p-pci device with an instrumented
QEMU allowing to control request completion.

Both p9_client_zc_rpc() and p9_client_rpc() functions have this buggy
error path actually. Their code flow is a bit obscure and the best
thing to do would probably be a full rewrite: to really ensure this
situation of clearing TIF_SIGPENDING and returning -ERESTARTSYS can
never happen.

But given the general lack of interest for the 9p code, I won't risk
breaking more things. So this patch simply fixes the buggy paths in
both functions with a trivial label+goto.

Thanks to Laurent Dufour for his help and suggestions on how to find
the root cause and how to fix it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 net/9p/client.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index b433aff5ff13..e6cae8332e2e 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -769,7 +769,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	if (err < 0) {
 		if (err != -ERESTARTSYS && err != -EFAULT)
 			c->status = Disconnected;
-		goto reterr;
+		goto recalc_sigpending;
 	}
 again:
 	/* Wait for the response */
@@ -804,6 +804,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		if (req->status == REQ_STATUS_RCVD)
 			err = 0;
 	}
+recalc_sigpending:
 	if (sigpending) {
 		spin_lock_irqsave(&current->sighand->siglock, flags);
 		recalc_sigpending();
@@ -867,7 +868,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		if (err == -EIO)
 			c->status = Disconnected;
 		if (err != -ERESTARTSYS)
-			goto reterr;
+			goto recalc_sigpending;
 	}
 	if (req->status == REQ_STATUS_ERROR) {
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
@@ -885,6 +886,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		if (req->status == REQ_STATUS_RCVD)
 			err = 0;
 	}
+recalc_sigpending:
 	if (sigpending) {
 		spin_lock_irqsave(&current->sighand->siglock, flags);
 		recalc_sigpending();
