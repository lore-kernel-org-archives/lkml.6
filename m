Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A4C2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tngTwcvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbeLQNUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:20:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37272 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732760AbeLQNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:19:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so11807398wrt.4;
        Mon, 17 Dec 2018 05:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MhoVGZhQI5ubACgByDgIY3ZaaMKZNNij7zzM5NcyL1w=;
        b=tngTwcvc8TDpaMXaw37A7gS/4xBS6OVnp/BKkpWWNLnY0ykB4MPe1LFvCBy0/ekD/K
         J68qmwSJte87FD7D+q7/yWtbsKs4ykbhLZf2Ls1MnyUYs9uzkGHW1CrcINB2MqjQpsKn
         nsvr75oG1AkED3l+06UrZtleFGXBp0gL9n18hmbI61jJxS9z7QsjAoRsWeKRC0D0LnAw
         MLgJck2I9HDJ8qQtf9rKNbxOfIZPT6D0pzlf+8N2KejiXYJpXgtvKQI05Jf2nSdi+FYq
         VN9piCQJshZ1PIdtlSYTSIF5xeZF7MOldylKV8ES1XdEvBY+IFSA+Yfi7m5LlIHLHNg3
         wYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhoVGZhQI5ubACgByDgIY3ZaaMKZNNij7zzM5NcyL1w=;
        b=gybXy5XXpPNUpcvOKylgXdHl6Aep/z56E+K+PbTxbti4T6Q9S/AEYDlb5DYYrOeSA1
         Oki020NbWtyDAOOSV2x3Xp6FhFPBkIDJGJ3dljqrffSYkOv1toD2dUCR04odi22/Tzrq
         kfqgRcqD785Tsq4nD2CRLrKXJgt1WD0SGGjA1OejsRRyPkh8ys3t1j52/j3BwRXXrBmq
         6zbqAtJxP0j1CxvzecGGseYF1b5XqOQwiZAZ/gAMxHaHdrvLoSwnYy5raeDASedOvMgJ
         XioHgXtKQZzLM/WSWnwa5NPA/VfOrzs+ToM/qfW990VjwHdRNFASOaDfTFE+SeGXDW6u
         aMcg==
X-Gm-Message-State: AA+aEWZGK/Ucjte9AY14SzuHljIicJpFmBSZ78J7/iFovP8H25YAHFcW
        Z7y+plfdPczAOlLDl6mhqA==
X-Google-Smtp-Source: AFSGD/XNm1WSFd+RfKtQKAUEXPuRdQA0WoEUOo+uM5vq0P26E6J0haUnSyYnRLkZ1vowW4j013WGTA==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr10353874wru.226.1545052787059;
        Mon, 17 Dec 2018 05:19:47 -0800 (PST)
Received: from kmo-pixel.syslink.intern ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id x20sm20406120wme.6.2018.12.17.05.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 05:19:46 -0800 (PST)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: [PATCH 6/7] sctp: Convert to genradix
Date:   Mon, 17 Dec 2018 08:19:28 -0500
Message-Id: <20181217131929.11727-7-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181217131929.11727-1-kent.overstreet@gmail.com>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This also makes sctp_stream_alloc_(out|in) saner, in that they no longer
allocate new flex_arrays/genradixes, they just preallocate more
elements.

This code does however have a suspicious lack of locking.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-sctp@vger.kernel.org
---
 include/net/sctp/structs.h   |  15 ++---
 net/sctp/stream.c            | 106 +++++++----------------------------
 net/sctp/stream_interleave.c |   2 +-
 3 files changed, 28 insertions(+), 95 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index a11f937904..ee606e0fff 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -48,6 +48,7 @@
 #define __sctp_structs_h__
 
 #include <linux/ktime.h>
+#include <linux/generic-radix-tree.h>
 #include <linux/rhashtable-types.h>
 #include <linux/socket.h>	/* linux/in.h needs this!!    */
 #include <linux/in.h>		/* We get struct sockaddr_in. */
@@ -57,7 +58,6 @@
 #include <linux/atomic.h>		/* This gets us atomic counters.  */
 #include <linux/skbuff.h>	/* We need sk_buff_head. */
 #include <linux/workqueue.h>	/* We need tq_struct.	 */
-#include <linux/flex_array.h>	/* We need flex_array.   */
 #include <linux/sctp.h>		/* We need sctp* header structs.  */
 #include <net/sctp/auth.h>	/* We need auth specific structs */
 #include <net/ip.h>		/* For inet_skb_parm */
@@ -1441,8 +1441,9 @@ struct sctp_stream_in {
 };
 
 struct sctp_stream {
-	struct flex_array *out;
-	struct flex_array *in;
+	GENRADIX(struct sctp_stream_out) out;
+	GENRADIX(struct sctp_stream_in)	in;
+
 	__u16 outcnt;
 	__u16 incnt;
 	/* Current stream being sent, if any */
@@ -1465,17 +1466,17 @@ struct sctp_stream {
 };
 
 static inline struct sctp_stream_out *sctp_stream_out(
-	const struct sctp_stream *stream,
+	struct sctp_stream *stream,
 	__u16 sid)
 {
-	return flex_array_get(stream->out, sid);
+	return genradix_ptr(&stream->out, sid);
 }
 
 static inline struct sctp_stream_in *sctp_stream_in(
-	const struct sctp_stream *stream,
+	struct sctp_stream *stream,
 	__u16 sid)
 {
-	return flex_array_get(stream->in, sid);
+	return genradix_ptr(&stream->in, sid);
 }
 
 #define SCTP_SO(s, i) sctp_stream_out((s), (i))
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index ffb940d3b5..09b9c7dc59 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -37,53 +37,6 @@
 #include <net/sctp/sm.h>
 #include <net/sctp/stream_sched.h>
 
-static struct flex_array *fa_alloc(size_t elem_size, size_t elem_count,
-				   gfp_t gfp)
-{
-	struct flex_array *result;
-	int err;
-
-	result = flex_array_alloc(elem_size, elem_count, gfp);
-	if (result) {
-		err = flex_array_prealloc(result, 0, elem_count, gfp);
-		if (err) {
-			flex_array_free(result);
-			result = NULL;
-		}
-	}
-
-	return result;
-}
-
-static void fa_free(struct flex_array *fa)
-{
-	if (fa)
-		flex_array_free(fa);
-}
-
-static void fa_copy(struct flex_array *fa, struct flex_array *from,
-		    size_t index, size_t count)
-{
-	void *elem;
-
-	while (count--) {
-		elem = flex_array_get(from, index);
-		flex_array_put(fa, index, elem, 0);
-		index++;
-	}
-}
-
-static void fa_zero(struct flex_array *fa, size_t index, size_t count)
-{
-	void *elem;
-
-	while (count--) {
-		elem = flex_array_get(fa, index);
-		memset(elem, 0, fa->element_size);
-		index++;
-	}
-}
-
 /* Migrates chunks from stream queues to new stream queues if needed,
  * but not across associations. Also, removes those chunks to streams
  * higher than the new max.
@@ -138,46 +91,32 @@ static void sctp_stream_outq_migrate(struct sctp_stream *stream,
 static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
 				 gfp_t gfp)
 {
-	struct flex_array *out;
-	size_t elem_size = sizeof(struct sctp_stream_out);
-
-	out = fa_alloc(elem_size, outcnt, gfp);
-	if (!out)
-		return -ENOMEM;
-
-	if (stream->out) {
-		fa_copy(out, stream->out, 0, min(outcnt, stream->outcnt));
-		fa_free(stream->out);
-	}
+	int ret;
 
-	if (outcnt > stream->outcnt)
-		fa_zero(out, stream->outcnt, (outcnt - stream->outcnt));
+	if (outcnt <= stream->outcnt)
+		return 0;
 
-	stream->out = out;
+	ret = genradix_prealloc(&stream->out, outcnt, gfp);
+	if (ret)
+		return ret;
 
+	stream->outcnt = outcnt;
 	return 0;
 }
 
 static int sctp_stream_alloc_in(struct sctp_stream *stream, __u16 incnt,
 				gfp_t gfp)
 {
-	struct flex_array *in;
-	size_t elem_size = sizeof(struct sctp_stream_in);
-
-	in = fa_alloc(elem_size, incnt, gfp);
-	if (!in)
-		return -ENOMEM;
-
-	if (stream->in) {
-		fa_copy(in, stream->in, 0, min(incnt, stream->incnt));
-		fa_free(stream->in);
-	}
+	int ret;
 
-	if (incnt > stream->incnt)
-		fa_zero(in, stream->incnt, (incnt - stream->incnt));
+	if (incnt <= stream->incnt)
+		return 0;
 
-	stream->in = in;
+	ret = genradix_prealloc(&stream->in, incnt, gfp);
+	if (ret)
+		return ret;
 
+	stream->incnt = incnt;
 	return 0;
 }
 
@@ -204,7 +143,6 @@ int sctp_stream_init(struct sctp_stream *stream, __u16 outcnt, __u16 incnt,
 	if (ret)
 		goto out;
 
-	stream->outcnt = outcnt;
 	for (i = 0; i < stream->outcnt; i++)
 		SCTP_SO(stream, i)->state = SCTP_STREAM_OPEN;
 
@@ -218,14 +156,11 @@ int sctp_stream_init(struct sctp_stream *stream, __u16 outcnt, __u16 incnt,
 	ret = sctp_stream_alloc_in(stream, incnt, gfp);
 	if (ret) {
 		sched->free(stream);
-		fa_free(stream->out);
-		stream->out = NULL;
+		genradix_free(&stream->out);
 		stream->outcnt = 0;
 		goto out;
 	}
 
-	stream->incnt = incnt;
-
 out:
 	return ret;
 }
@@ -250,8 +185,8 @@ void sctp_stream_free(struct sctp_stream *stream)
 	sched->free(stream);
 	for (i = 0; i < stream->outcnt; i++)
 		kfree(SCTP_SO(stream, i)->ext);
-	fa_free(stream->out);
-	fa_free(stream->in);
+	genradix_free(&stream->out);
+	genradix_free(&stream->in);
 }
 
 void sctp_stream_clear(struct sctp_stream *stream)
@@ -282,8 +217,8 @@ void sctp_stream_update(struct sctp_stream *stream, struct sctp_stream *new)
 
 	sched->sched_all(stream);
 
-	new->out = NULL;
-	new->in  = NULL;
+	new->out.tree.root = NULL;
+	new->in.tree.root  = NULL;
 	new->outcnt = 0;
 	new->incnt  = 0;
 }
@@ -535,9 +470,6 @@ int sctp_send_add_streams(struct sctp_association *asoc,
 		goto out;
 	}
 
-	stream->incnt = incnt;
-	stream->outcnt = outcnt;
-
 	asoc->strreset_outstanding = !!out + !!in;
 
 out:
diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index 0a78cdf864..afada93d9f 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -101,7 +101,7 @@ static void sctp_chunk_assign_mid(struct sctp_chunk *chunk)
 
 static bool sctp_validate_data(struct sctp_chunk *chunk)
 {
-	const struct sctp_stream *stream;
+	struct sctp_stream *stream;
 	__u16 sid, ssn;
 
 	if (chunk->chunk_hdr->type != SCTP_CID_DATA)
-- 
2.20.1

