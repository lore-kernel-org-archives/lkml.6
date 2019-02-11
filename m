Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EEF222B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897443;
	bh=iW6mC8q9qp44OB+XlsbuKgOUXFvnBfbZT40VslXRaxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=arfPmoXSr88iqvAkbxNqtzydZeDUAHmPyq4LW+K7BcOqKcGIymd54ikGc53E7KzEw
	 NOmrDr9pyMDo29I2vB30nxDODMPx7eXf3FBCAX8b0wW+2fpwR1xMa+8HNeGkGNGB3J
	 XRcYhNLTBOG78VsGyPzIFXz3bZ4+TaNMYcEpDu6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbfBKPEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390692AbfBKPD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4906222A7;
        Mon, 11 Feb 2019 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897435;
        bh=iW6mC8q9qp44OB+XlsbuKgOUXFvnBfbZT40VslXRaxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+1ZRgmuywKtGTJAn2U9xzaTONJ5QeIlyIJtBwES67aGQnU5+LzzBafT2/ZmeEIWq
         4R4sxn3zlCA43kY3JjyDoh/9rDpLp3UyrAfDmw6BSTVWEcnjeJSZ88avStp/vokL+h
         sofdqIzHdr2IP1ixBKjpMyxqR2pKa4IK7Vht6qcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <aglo@umich.edu>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: [PATCH 4.14 202/205] nfsd4: fix cached replies to solo SEQUENCE compounds
Date:   Mon, 11 Feb 2019 15:20:00 +0100
Message-Id: <20190211141841.648316810@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: J. Bruce Fields <bfields@redhat.com>

commit 085def3ade52f2ffe3e31f42e98c27dcc222dd37 upstream.

Currently our handling of 4.1+ requests without "cachethis" set is
confusing and not quite correct.

Suppose a client sends a compound consisting of only a single SEQUENCE
op, and it matches the seqid in a session slot (so it's a retry), but
the previous request with that seqid did not have "cachethis" set.

The obvious thing to do might be to return NFS4ERR_RETRY_UNCACHED_REP,
but the protocol only allows that to be returned on the op following the
SEQUENCE, and there is no such op in this case.

The protocol permits us to cache replies even if the client didn't ask
us to.  And it's easy to do so in the case of solo SEQUENCE compounds.

So, when we get a solo SEQUENCE, we can either return the previously
cached reply or NFSERR_SEQ_FALSE_RETRY if we notice it differs in some
way from the original call.

Currently, we're returning a corrupt reply in the case a solo SEQUENCE
matches a previous compound with more ops.  This actually matters
because the Linux client recently started doing this as a way to recover
from lost replies to idempotent operations in the case the process doing
the original reply was killed: in that case it's difficult to keep the
original arguments around to do a real retry, and the client no longer
cares what the result is anyway, but it would like to make sure that the
slot's sequence id has been incremented, and the solo SEQUENCE assures
that: if the server never got the original reply, it will increment the
sequence id.  If it did get the original reply, it won't increment, and
nothing else that about the reply really matters much.  But we can at
least attempt to return valid xdr!

Tested-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Donald Buczek <buczek@molgen.mpg.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |   20 +++++++++++++++-----
 fs/nfsd/state.h     |    1 +
 fs/nfsd/xdr4.h      |   13 +++++++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2331,14 +2331,16 @@ nfsd4_store_cache_entry(struct nfsd4_com
 
 	dprintk("--> %s slot %p\n", __func__, slot);
 
+	slot->sl_flags |= NFSD4_SLOT_INITIALIZED;
 	slot->sl_opcnt = resp->opcnt;
 	slot->sl_status = resp->cstate.status;
 
-	slot->sl_flags |= NFSD4_SLOT_INITIALIZED;
-	if (nfsd4_not_cached(resp)) {
-		slot->sl_datalen = 0;
+	if (!nfsd4_cache_this(resp)) {
+		slot->sl_flags &= ~NFSD4_SLOT_CACHED;
 		return;
 	}
+	slot->sl_flags |= NFSD4_SLOT_CACHED;
+
 	base = resp->cstate.data_offset;
 	slot->sl_datalen = buf->len - base;
 	if (read_bytes_from_xdr_buf(buf, base, slot->sl_data, slot->sl_datalen))
@@ -2365,8 +2367,16 @@ nfsd4_enc_sequence_replay(struct nfsd4_c
 	op = &args->ops[resp->opcnt - 1];
 	nfsd4_encode_operation(resp, op);
 
-	/* Return nfserr_retry_uncached_rep in next operation. */
-	if (args->opcnt > 1 && !(slot->sl_flags & NFSD4_SLOT_CACHETHIS)) {
+	if (slot->sl_flags & NFSD4_SLOT_CACHED)
+		return op->status;
+	if (args->opcnt == 1) {
+		/*
+		 * The original operation wasn't a solo sequence--we
+		 * always cache those--so this retry must not match the
+		 * original:
+		 */
+		op->status = nfserr_seq_false_retry;
+	} else {
 		op = &args->ops[resp->opcnt++];
 		op->status = nfserr_retry_uncached_rep;
 		nfsd4_encode_operation(resp, op);
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -174,6 +174,7 @@ struct nfsd4_slot {
 #define NFSD4_SLOT_INUSE	(1 << 0)
 #define NFSD4_SLOT_CACHETHIS	(1 << 1)
 #define NFSD4_SLOT_INITIALIZED	(1 << 2)
+#define NFSD4_SLOT_CACHED	(1 << 3)
 	u8	sl_flags;
 	char	sl_data[];
 };
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -651,9 +651,18 @@ static inline bool nfsd4_is_solo_sequenc
 	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
 }
 
-static inline bool nfsd4_not_cached(struct nfsd4_compoundres *resp)
+/*
+ * The session reply cache only needs to cache replies that the client
+ * actually asked us to.  But it's almost free for us to cache compounds
+ * consisting of only a SEQUENCE op, so we may as well cache those too.
+ * Also, the protocol doesn't give us a convenient response in the case
+ * of a replay of a solo SEQUENCE op that wasn't cached
+ * (RETRY_UNCACHED_REP can only be returned in the second op of a
+ * compound).
+ */
+static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
 {
-	return !(resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
+	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
 		|| nfsd4_is_solo_sequence(resp);
 }
 


