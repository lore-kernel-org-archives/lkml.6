Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeBXQDi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:03:38 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:41924 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeBXQDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:03:35 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 3/3] crypto: ccp - protect RSA implementation from too large
 input data
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <4af6c02f-db3f-3d82-9685-367913c684ff@maciej.szmigiero.name>
Date: Sat, 24 Feb 2018 17:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCP RSA implementation uses a hardware input buffer which size depends only
on the current RSA key length. Key modulus and a message to be processed
is then copied to this buffer based on their own lengths.

Since the price for providing too long input data is a buffer overflow and
there already has been a case when this has happened let's better reject
such oversized input data and log an error message in this case so we know
what is going on.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/crypto/ccp/ccp-ops.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index 406b95329b3d..517aeee30abf 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -1770,10 +1770,6 @@ static int ccp_run_rsa_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	if (!rsa->exp || !rsa->mod || !rsa->src || !rsa->dst)
 		return -EINVAL;
 
-	memset(&op, 0, sizeof(op));
-	op.cmd_q = cmd_q;
-	op.jobid = CCP_NEW_JOBID(cmd_q->ccp);
-
 	/* The RSA modulus must precede the message being acted upon, so
 	 * it must be copied to a DMA area where the message and the
 	 * modulus can be concatenated.  Therefore the input buffer
@@ -1785,6 +1781,26 @@ static int ccp_run_rsa_cmd(struct ccp_cmd_queue *cmd_q, struct ccp_cmd *cmd)
 	o_len = 32 * ((rsa->key_size + 255) / 256);
 	i_len = o_len * 2;
 
+	if (rsa->mod_len > o_len) {
+		dev_err(cmd_q->ccp->dev,
+			"RSA modulus of %u bytes too large for key size of %u bits\n",
+			(unsigned int)rsa->mod_len,
+			(unsigned int)rsa->key_size);
+		return -EINVAL;
+	}
+
+	if (rsa->src_len > o_len) {
+		dev_err(cmd_q->ccp->dev,
+			"RSA data of %u bytes too large for key size of %u bits\n",
+			(unsigned int)rsa->src_len,
+			(unsigned int)rsa->key_size);
+		return -EINVAL;
+	}
+
+	memset(&op, 0, sizeof(op));
+	op.cmd_q = cmd_q;
+	op.jobid = CCP_NEW_JOBID(cmd_q->ccp);
+
 	sb_count = 0;
 	if (cmd_q->ccp->vdata->version < CCP_VERSION(5, 0)) {
 		/* sb_count is the number of storage block slots required
