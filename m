Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162F3ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA58214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA58214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJTJTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:19:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJTJTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:19:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38508308424F;
        Sat, 20 Oct 2018 01:11:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B96DD19495;
        Sat, 20 Oct 2018 01:11:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/24] afs: Set up the iov_iter before calling
 afs_extract_data()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:11:13 +0100
Message-ID: <153999787395.866.11218209749223643998.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 20 Oct 2018 01:11:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_extract_data sets up a temporary iov_iter and passes it to AF_RXRPC
each time it is called to describe the remaining buffer to be filled.

Instead:

 (1) Put an iterator in the afs_call struct.

 (2) Set the iterator for each marshalling stage to load data into the
     appropriate places.  A number of convenience functions are provided to
     this end (eg. afs_extract_to_buf()).

     This iterator is then passed to afs_extract_data().

 (3) Use the new ITER_DISCARD iterator to discard any excess data provided
     by FetchData.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |   40 +++---
 fs/afs/fsclient.c          |  282 +++++++++++++++-----------------------------
 fs/afs/internal.h          |   56 ++++++++-
 fs/afs/rxrpc.c             |   41 ++----
 fs/afs/vlclient.c          |  104 +++++++---------
 include/trace/events/afs.h |   22 ++-
 6 files changed, 236 insertions(+), 309 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 58f79301a716..4db62ae8dc1a 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -176,13 +176,13 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* extract the FID array and its count in two steps */
 	case 1:
 		_debug("extract FID count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -196,13 +196,12 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 				       GFP_KERNEL);
 		if (!call->buffer)
 			return -ENOMEM;
-		call->offset = 0;
+		afs_extract_to_buf(call, call->count * 3 * 4);
 		call->unmarshall++;
 
 	case 2:
 		_debug("extract FID array");
-		ret = afs_extract_data(call, call->buffer,
-				       call->count * 3 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -222,13 +221,13 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			cb->cb.type	= AFSCM_CB_UNTYPED;
 		}
 
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* extract the callback array and its count in two steps */
 	case 3:
 		_debug("extract CB count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -237,13 +236,12 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		if (call->count2 != call->count && call->count2 != 0)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_cb_count);
-		call->offset = 0;
+		afs_extract_to_buf(call, call->count2 * 3 * 4);
 		call->unmarshall++;
 
 	case 4:
 		_debug("extract CB array");
-		ret = afs_extract_data(call, call->buffer,
-				       call->count2 * 3 * 4, false);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
@@ -256,7 +254,6 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			cb->cb.type	= ntohl(*bp++);
 		}
 
-		call->offset = 0;
 		call->unmarshall++;
 	case 5:
 		break;
@@ -303,7 +300,8 @@ static int afs_deliver_cb_init_call_back_state(struct afs_call *call)
 
 	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
 
-	ret = afs_extract_data(call, NULL, 0, false);
+	afs_extract_discard(call, 0);
+	ret = afs_extract_data(call, false);
 	if (ret < 0)
 		return ret;
 
@@ -332,16 +330,15 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
 		call->buffer = kmalloc_array(11, sizeof(__be32), GFP_KERNEL);
 		if (!call->buffer)
 			return -ENOMEM;
+		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
 	case 1:
 		_debug("extract UUID");
-		ret = afs_extract_data(call, call->buffer,
-				       11 * sizeof(__be32), false);
+		ret = afs_extract_data(call, false);
 		switch (ret) {
 		case 0:		break;
 		case -EAGAIN:	return 0;
@@ -364,7 +361,6 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 		for (loop = 0; loop < 6; loop++)
 			r->node[loop] = ntohl(b[loop + 5]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
 	case 2:
@@ -407,7 +403,8 @@ static int afs_deliver_cb_probe(struct afs_call *call)
 
 	_enter("");
 
-	ret = afs_extract_data(call, NULL, 0, false);
+	afs_extract_discard(call, 0);
+	ret = afs_extract_data(call, false);
 	if (ret < 0)
 		return ret;
 
@@ -455,16 +452,15 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
 		call->buffer = kmalloc_array(11, sizeof(__be32), GFP_KERNEL);
 		if (!call->buffer)
 			return -ENOMEM;
+		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
 	case 1:
 		_debug("extract UUID");
-		ret = afs_extract_data(call, call->buffer,
-				       11 * sizeof(__be32), false);
+		ret = afs_extract_data(call, false);
 		switch (ret) {
 		case 0:		break;
 		case -EAGAIN:	return 0;
@@ -487,7 +483,6 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 		for (loop = 0; loop < 6; loop++)
 			r->node[loop] = ntohl(b[loop + 5]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
 	case 2:
@@ -572,7 +567,8 @@ static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *call)
 
 	_enter("");
 
-	ret = afs_extract_data(call, NULL, 0, false);
+	afs_extract_discard(call, 0);
+	ret = afs_extract_data(call, false);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index d9a5815945dc..fe2e9e39b388 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -20,12 +20,6 @@
 
 static const struct afs_fid afs_zero_fid;
 
-/*
- * We need somewhere to discard into in case the server helpfully returns more
- * than we asked for in FS.FetchData{,64}.
- */
-static u8 afs_discard_buffer[64];
-
 static inline void afs_use_fs_server(struct afs_call *call, struct afs_cb_interest *cbi)
 {
 	call->cbi = afs_get_cb_interest(cbi);
@@ -469,114 +463,93 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 	struct afs_read *req = call->reply[2];
 	const __be32 *bp;
 	unsigned int size;
-	void *buffer;
 	int ret;
 
-	_enter("{%u,%zu/%u;%llu/%llu}",
-	       call->unmarshall, call->offset, call->count,
-	       req->remain, req->actual_len);
+	_enter("{%u,%zu/%llu}",
+	       call->unmarshall, iov_iter_count(&call->iter), req->actual_len);
 
 	switch (call->unmarshall) {
 	case 0:
 		req->actual_len = 0;
-		call->offset = 0;
+		req->index = 0;
+		req->offset = req->pos & (PAGE_SIZE - 1);
 		call->unmarshall++;
-		if (call->operation_ID != FSFETCHDATA64) {
-			call->unmarshall++;
-			goto no_msw;
+		if (call->operation_ID == FSFETCHDATA64) {
+			afs_extract_to_tmp64(call);
+		} else {
+			call->tmp_u = htonl(0);
+			afs_extract_to_tmp(call);
 		}
 
-		/* extract the upper part of the returned data length of an
-		 * FSFETCHDATA64 op (which should always be 0 using this
-		 * client) */
-	case 1:
-		_debug("extract data length (MSW)");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
-		if (ret < 0)
-			return ret;
-
-		req->actual_len = ntohl(call->tmp);
-		req->actual_len <<= 32;
-		call->offset = 0;
-		call->unmarshall++;
-
-	no_msw:
 		/* extract the returned data length */
-	case 2:
+	case 1:
 		_debug("extract data length");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
-		req->actual_len |= ntohl(call->tmp);
+		req->actual_len = be64_to_cpu(call->tmp64);
 		_debug("DATA length: %llu", req->actual_len);
-
-		req->remain = req->actual_len;
-		call->offset = req->pos & (PAGE_SIZE - 1);
-		req->index = 0;
-		if (req->actual_len == 0)
+		req->remain = min(req->len, req->actual_len);
+		if (req->remain == 0)
 			goto no_more_data;
+
 		call->unmarshall++;
 
 	begin_page:
 		ASSERTCMP(req->index, <, req->nr_pages);
-		if (req->remain > PAGE_SIZE - call->offset)
-			size = PAGE_SIZE - call->offset;
+		if (req->remain > PAGE_SIZE - req->offset)
+			size = PAGE_SIZE - req->offset;
 		else
 			size = req->remain;
-		call->count = call->offset + size;
-		ASSERTCMP(call->count, <=, PAGE_SIZE);
-		req->remain -= size;
+		call->bvec[0].bv_len = size;
+		call->bvec[0].bv_offset = req->offset;
+		call->bvec[0].bv_page = req->pages[req->index];
+		iov_iter_bvec(&call->iter, READ, call->bvec, 1, size);
+		ASSERTCMP(size, <=, PAGE_SIZE);
 
 		/* extract the returned data */
-	case 3:
-		_debug("extract data %llu/%llu %zu/%u",
-		       req->remain, req->actual_len, call->offset, call->count);
+	case 2:
+		_debug("extract data %zu/%llu",
+		       iov_iter_count(&call->iter), req->remain);
 
-		buffer = kmap(req->pages[req->index]);
-		ret = afs_extract_data(call, buffer, call->count, true);
-		kunmap(req->pages[req->index]);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
-		if (call->offset == PAGE_SIZE) {
+		req->remain -= call->bvec[0].bv_len;
+		req->offset += call->bvec[0].bv_len;
+		ASSERTCMP(req->offset, <=, PAGE_SIZE);
+		if (req->offset == PAGE_SIZE) {
+			req->offset = 0;
 			if (req->page_done)
 				req->page_done(call, req);
 			req->index++;
-			if (req->remain > 0) {
-				call->offset = 0;
-				if (req->index >= req->nr_pages) {
-					call->unmarshall = 4;
-					goto begin_discard;
-				}
+			if (req->remain > 0)
 				goto begin_page;
-			}
 		}
-		goto no_more_data;
+
+		ASSERTCMP(req->remain, ==, 0);
+		if (req->actual_len <= req->len)
+			goto no_more_data;
 
 		/* Discard any excess data the server gave us */
-	begin_discard:
-	case 4:
-		size = min_t(loff_t, sizeof(afs_discard_buffer), req->remain);
-		call->count = size;
-		_debug("extract discard %llu/%llu %zu/%u",
-		       req->remain, req->actual_len, call->offset, call->count);
-
-		call->offset = 0;
-		ret = afs_extract_data(call, afs_discard_buffer, call->count, true);
-		req->remain -= call->offset;
+		iov_iter_discard(&call->iter, READ, req->actual_len - req->len);
+		call->unmarshall = 3;
+	case 3:
+		_debug("extract discard %zu/%llu",
+		       iov_iter_count(&call->iter), req->actual_len - req->len);
+
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
-		if (req->remain > 0)
-			goto begin_discard;
 
 	no_more_data:
-		call->offset = 0;
-		call->unmarshall = 5;
+		call->unmarshall = 4;
+		afs_extract_to_buf(call, (21 + 3 + 6) * 4);
 
 		/* extract the metadata */
-	case 5:
-		ret = afs_extract_data(call, call->buffer,
-				       (21 + 3 + 6) * 4, false);
+	case 4:
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
@@ -589,20 +562,19 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		if (call->reply[1])
 			xdr_decode_AFSVolSync(&bp, call->reply[1]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
-	case 6:
+	case 5:
 		break;
 	}
 
 	for (; req->index < req->nr_pages; req->index++) {
-		if (call->count < PAGE_SIZE)
+		if (req->offset < PAGE_SIZE)
 			zero_user_segment(req->pages[req->index],
-					  call->count, PAGE_SIZE);
+					  req->offset, PAGE_SIZE);
 		if (req->page_done)
 			req->page_done(call, req);
-		call->count = 0;
+		req->offset = 0;
 	}
 
 	_leave(" = 0 [done]");
@@ -1598,31 +1570,31 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 {
 	const __be32 *bp;
 	char *p;
+	u32 size;
 	int ret;
 
 	_enter("{%u}", call->unmarshall);
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
 		call->unmarshall++;
+		afs_extract_to_buf(call, 12 * 4);
 
 		/* extract the returned status record */
 	case 1:
 		_debug("extract status");
-		ret = afs_extract_data(call, call->buffer,
-				       12 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		bp = call->buffer;
 		xdr_decode_AFSFetchVolumeStatus(&bp, call->reply[1]);
-		call->offset = 0;
 		call->unmarshall++;
+		afs_extract_to_tmp(call);
 
 		/* extract the volume name length */
 	case 2:
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -1631,46 +1603,26 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		if (call->count >= AFSNAMEMAX)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_volname_len);
-		call->offset = 0;
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
 		/* extract the volume name */
 	case 3:
 		_debug("extract volname");
-		if (call->count > 0) {
-			ret = afs_extract_data(call, call->reply[2],
-					       call->count, true);
-			if (ret < 0)
-				return ret;
-		}
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
 
 		p = call->reply[2];
 		p[call->count] = 0;
 		_debug("volname '%s'", p);
-
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the volume name padding */
-		if ((call->count & 3) == 0) {
-			call->unmarshall++;
-			goto no_volname_padding;
-		}
-		call->count = 4 - (call->count & 3);
-
-	case 4:
-		ret = afs_extract_data(call, call->buffer,
-				       call->count, true);
-		if (ret < 0)
-			return ret;
-
-		call->offset = 0;
-		call->unmarshall++;
-	no_volname_padding:
-
 		/* extract the offline message length */
-	case 5:
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+	case 4:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -1679,46 +1631,27 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		if (call->count >= AFSNAMEMAX)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_offline_msg_len);
-		call->offset = 0;
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
 		/* extract the offline message */
-	case 6:
+	case 5:
 		_debug("extract offline");
-		if (call->count > 0) {
-			ret = afs_extract_data(call, call->reply[2],
-					       call->count, true);
-			if (ret < 0)
-				return ret;
-		}
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
 
 		p = call->reply[2];
 		p[call->count] = 0;
 		_debug("offline '%s'", p);
 
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the offline message padding */
-		if ((call->count & 3) == 0) {
-			call->unmarshall++;
-			goto no_offline_padding;
-		}
-		call->count = 4 - (call->count & 3);
-
-	case 7:
-		ret = afs_extract_data(call, call->buffer,
-				       call->count, true);
-		if (ret < 0)
-			return ret;
-
-		call->offset = 0;
-		call->unmarshall++;
-	no_offline_padding:
-
 		/* extract the message of the day length */
-	case 8:
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+	case 6:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -1727,38 +1660,24 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		if (call->count >= AFSNAMEMAX)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_motd_len);
-		call->offset = 0;
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
 		/* extract the message of the day */
-	case 9:
+	case 7:
 		_debug("extract motd");
-		if (call->count > 0) {
-			ret = afs_extract_data(call, call->reply[2],
-					       call->count, true);
-			if (ret < 0)
-				return ret;
-		}
+		ret = afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
 
 		p = call->reply[2];
 		p[call->count] = 0;
 		_debug("motd '%s'", p);
 
-		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the message of the day padding */
-		call->count = (4 - (call->count & 3)) & 3;
-
-	case 10:
-		ret = afs_extract_data(call, call->buffer,
-				       call->count, false);
-		if (ret < 0)
-			return ret;
-
-		call->offset = 0;
-		call->unmarshall++;
-	case 11:
+	case 8:
 		break;
 	}
 
@@ -2024,19 +1943,16 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 	u32 count;
 	int ret;
 
-	_enter("{%u,%zu/%u}", call->unmarshall, call->offset, call->count);
+	_enter("{%u,%zu}", call->unmarshall, iov_iter_count(&call->iter));
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* Extract the capabilities word count */
 	case 1:
-		ret = afs_extract_data(call, &call->tmp,
-				       1 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2044,24 +1960,17 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 
 		call->count = count;
 		call->count2 = count;
-		call->offset = 0;
+		iov_iter_discard(&call->iter, READ, count * sizeof(__be32));
 		call->unmarshall++;
 
 		/* Extract capabilities words */
 	case 2:
-		count = min(call->count, 16U);
-		ret = afs_extract_data(call, call->buffer,
-				       count * sizeof(__be32),
-				       call->count > 16);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
 		/* TODO: Examine capabilities */
 
-		call->count -= count;
-		if (call->count > 0)
-			goto again;
-		call->offset = 0;
 		call->unmarshall++;
 		break;
 	}
@@ -2215,13 +2124,13 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* Extract the file status count and array in two steps */
 	case 1:
 		_debug("extract status count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2234,11 +2143,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->count = 0;
 		call->unmarshall++;
 	more_counts:
-		call->offset = 0;
+		afs_extract_to_buf(call, 21 * sizeof(__be32));
 
 	case 2:
 		_debug("extract status array %u", call->count);
-		ret = afs_extract_data(call, call->buffer, 21 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2256,12 +2165,12 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		call->count = 0;
 		call->unmarshall++;
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 
 		/* Extract the callback count and array in two steps */
 	case 3:
 		_debug("extract CB count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2273,11 +2182,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->count = 0;
 		call->unmarshall++;
 	more_cbs:
-		call->offset = 0;
+		afs_extract_to_buf(call, 3 * sizeof(__be32));
 
 	case 4:
 		_debug("extract CB array");
-		ret = afs_extract_data(call, call->buffer, 3 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2294,11 +2203,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		if (call->count < call->count2)
 			goto more_cbs;
 
-		call->offset = 0;
+		afs_extract_to_buf(call, 6 * sizeof(__be32));
 		call->unmarshall++;
 
 	case 5:
-		ret = afs_extract_data(call, call->buffer, 6 * 4, false);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
@@ -2306,7 +2215,6 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		if (call->reply[3])
 			xdr_decode_AFSVolSync(&bp, call->reply[3]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
 	case 6:
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 73770a2a2311..36e9cc74ac11 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -98,11 +98,16 @@ struct afs_call {
 	struct afs_cb_interest	*cbi;		/* Callback interest for server used */
 	void			*request;	/* request data (first part) */
 	struct address_space	*mapping;	/* Pages being written from */
+	struct iov_iter		iter;		/* Buffer iterator */
+	struct iov_iter		*_iter;		/* Iterator currently in use */
+	union {	/* Convenience for ->iter */
+		struct kvec	kvec[1];
+		struct bio_vec	bvec[1];
+	};
 	void			*buffer;	/* reply receive buffer */
 	void			*reply[4];	/* Where to put the reply */
 	pgoff_t			first;		/* first page in mapping to deal with */
 	pgoff_t			last;		/* last page in mapping to deal with */
-	size_t			offset;		/* offset into received data store */
 	atomic_t		usage;
 	enum afs_call_state	state;
 	spinlock_t		state_lock;
@@ -127,7 +132,13 @@ struct afs_call {
 	unsigned int		debug_id;	/* Trace ID */
 	u32			operation_ID;	/* operation ID for an incoming call */
 	u32			count;		/* count for use in unmarshalling */
-	__be32			tmp;		/* place to extract temporary data */
+	union {					/* place to extract temporary data */
+		struct {
+			__be32	tmp_u;
+			__be32	tmp;
+		} __attribute__((packed));
+		__be64		tmp64;
+	};
 	afs_dataversion_t	expected_version; /* Updated version expected from store */
 	afs_dataversion_t	expected_version_2; /* 2nd updated version expected from store */
 };
@@ -185,6 +196,7 @@ struct afs_read {
 	refcount_t		usage;
 	unsigned int		index;		/* Which page we're reading into */
 	unsigned int		nr_pages;
+	unsigned int		offset;		/* offset into current page */
 	void (*page_done)(struct afs_call *, struct afs_read *);
 	struct page		**pages;
 	struct page		*array[];
@@ -550,6 +562,15 @@ struct afs_vnode {
 	afs_callback_type_t	cb_type;	/* type of callback */
 };
 
+static inline struct fscache_cookie *afs_vnode_cache(struct afs_vnode *vnode)
+{
+#ifdef CONFIG_AFS_FSCACHE
+	return vnode->cache;
+#else
+	return NULL;
+#endif
+}
+
 /*
  * cached security record for one user's attempt to access a vnode
  */
@@ -930,12 +951,39 @@ extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 extern void afs_flat_call_destructor(struct afs_call *);
 extern void afs_send_empty_reply(struct afs_call *);
 extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
-extern int afs_extract_data(struct afs_call *, void *, size_t, bool);
+extern int afs_extract_data(struct afs_call *, bool);
 extern int afs_protocol_error(struct afs_call *, int, enum afs_eproto_cause);
 
+static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
+{
+	call->kvec[0].iov_base = buf;
+	call->kvec[0].iov_len = size;
+	iov_iter_kvec(&call->iter, READ, call->kvec, 1, size);
+}
+
+static inline void afs_extract_to_tmp(struct afs_call *call)
+{
+	afs_extract_begin(call, &call->tmp, sizeof(call->tmp));
+}
+
+static inline void afs_extract_to_tmp64(struct afs_call *call)
+{
+	afs_extract_begin(call, &call->tmp64, sizeof(call->tmp64));
+}
+
+static inline void afs_extract_discard(struct afs_call *call, size_t size)
+{
+	iov_iter_discard(&call->iter, READ, size);
+}
+
+static inline void afs_extract_to_buf(struct afs_call *call, size_t size)
+{
+	afs_extract_begin(call, call->buffer, size);
+}
+
 static inline int afs_transfer_reply(struct afs_call *call)
 {
-	return afs_extract_data(call, call->buffer, call->reply_max, false);
+	return afs_extract_data(call, false);
 }
 
 static inline bool afs_check_call_state(struct afs_call *call,
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 9757c2d953f1..a3904a8315de 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -143,6 +143,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	INIT_WORK(&call->async_work, afs_process_async_call);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
+	call->_iter = &call->iter;
 
 	o = atomic_inc_return(&net->nr_outstanding_calls);
 	trace_afs_call(call, afs_call_trace_alloc, 1, o,
@@ -233,6 +234,7 @@ struct afs_call *afs_alloc_flat_call(struct afs_net *net,
 			goto nomem_free;
 	}
 
+	afs_extract_to_buf(call, call->reply_max);
 	call->operation_ID = type->op;
 	init_waitqueue_head(&call->waitq);
 	return call;
@@ -465,14 +467,12 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       state == AFS_CALL_SV_AWAIT_ACK
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
-			struct iov_iter iter;
-
-			iov_iter_kvec(&iter, READ, NULL, 0, 0);
+			iov_iter_kvec(&call->iter, READ, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
-						     call->rxcall, &iter, false,
-						     &remote_abort,
+						     call->rxcall, &call->iter,
+						     false, &remote_abort,
 						     &call->service_id);
-			trace_afs_recv_data(call, 0, 0, false, ret);
+			trace_afs_receive_data(call, &call->iter, false, ret);
 
 			if (ret == -EINPROGRESS || ret == -EAGAIN)
 				return;
@@ -516,7 +516,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 			if (state != AFS_CALL_CL_AWAIT_REPLY)
 				abort_code = RXGEN_SS_UNMARSHAL;
 			rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
-						abort_code, -EBADMSG, "KUM");
+						abort_code, ret, "KUM");
 			goto local_abort;
 		}
 	}
@@ -727,6 +727,7 @@ void afs_charge_preallocation(struct work_struct *work)
 			call->async = true;
 			call->state = AFS_CALL_SV_AWAIT_OP_ID;
 			init_waitqueue_head(&call->waitq);
+			afs_extract_to_tmp(call);
 		}
 
 		if (rxrpc_kernel_charge_accept(net->socket,
@@ -772,18 +773,15 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 {
 	int ret;
 
-	_enter("{%zu}", call->offset);
-
-	ASSERTCMP(call->offset, <, 4);
+	_enter("{%zu}", iov_iter_count(call->_iter));
 
 	/* the operation ID forms the first four bytes of the request data */
-	ret = afs_extract_data(call, &call->tmp, 4, true);
+	ret = afs_extract_data(call, true);
 	if (ret < 0)
 		return ret;
 
 	call->operation_ID = ntohl(call->tmp);
 	afs_set_call_state(call, AFS_CALL_SV_AWAIT_OP_ID, AFS_CALL_SV_AWAIT_REQUEST);
-	call->offset = 0;
 
 	/* ask the cache manager to route the call (it'll change the call type
 	 * if successful) */
@@ -887,30 +885,19 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 /*
  * Extract a piece of data from the received data socket buffers.
  */
-int afs_extract_data(struct afs_call *call, void *buf, size_t count,
-		     bool want_more)
+int afs_extract_data(struct afs_call *call, bool want_more)
 {
 	struct afs_net *net = call->net;
-	struct iov_iter iter;
-	struct kvec iov;
+	struct iov_iter *iter = call->_iter;
 	enum afs_call_state state;
 	u32 remote_abort = 0;
 	int ret;
 
-	_enter("{%s,%zu},,%zu,%d",
-	       call->type->name, call->offset, count, want_more);
-
-	ASSERTCMP(call->offset, <=, count);
-
-	iov.iov_base = buf + call->offset;
-	iov.iov_len = count - call->offset;
-	iov_iter_kvec(&iter, READ, &iov, 1, count - call->offset);
+	_enter("{%s,%zu},%d", call->type->name, iov_iter_count(iter), want_more);
 
-	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, &iter,
+	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, iter,
 				     want_more, &remote_abort,
 				     &call->service_id);
-	call->offset += (count - call->offset) - iov_iter_count(&iter);
-	trace_afs_recv_data(call, count, call->offset, want_more, ret);
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
 
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index d0f95c4ab05e..e18c51742daa 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -187,19 +187,18 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 	u32 uniquifier, nentries, count;
 	int i, ret;
 
-	_enter("{%u,%zu/%u}", call->unmarshall, call->offset, call->count);
+	_enter("{%u,%zu/%u}",
+	       call->unmarshall, iov_iter_count(call->_iter), call->count);
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_buf(call,
+				   sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32));
 		call->unmarshall++;
 
 		/* Extract the returned uuid, uniquifier, nentries and blkaddrs size */
 	case 1:
-		ret = afs_extract_data(call, call->buffer,
-				       sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -216,28 +215,28 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		call->reply[0] = alist;
 		call->count = count;
 		call->count2 = nentries;
-		call->offset = 0;
 		call->unmarshall++;
 
+	more_entries:
+		count = min(call->count, 4U);
+		afs_extract_to_buf(call, count * sizeof(__be32));
+
 		/* Extract entries */
 	case 2:
-		count = min(call->count, 4U);
-		ret = afs_extract_data(call, call->buffer,
-				       count * sizeof(__be32),
-				       call->count > 4);
+		ret = afs_extract_data(call, call->count > 4);
 		if (ret < 0)
 			return ret;
 
 		alist = call->reply[0];
 		bp = call->buffer;
+		count = min(call->count, 4U);
 		for (i = 0; i < count; i++)
 			if (alist->nr_addrs < call->count2)
 				afs_merge_fs_addr4(alist, *bp++, AFS_FS_PORT);
 
 		call->count -= count;
 		if (call->count > 0)
-			goto again;
-		call->offset = 0;
+			goto more_entries;
 		call->unmarshall++;
 		break;
 	}
@@ -318,44 +317,35 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 	u32 count;
 	int ret;
 
-	_enter("{%u,%zu/%u}", call->unmarshall, call->offset, call->count);
+	_enter("{%u,%zu/%u}",
+	       call->unmarshall, iov_iter_count(call->_iter), call->count);
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* Extract the capabilities word count */
 	case 1:
-		ret = afs_extract_data(call, &call->tmp,
-				       1 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		count = ntohl(call->tmp);
-
 		call->count = count;
 		call->count2 = count;
-		call->offset = 0;
+
 		call->unmarshall++;
+		afs_extract_discard(call, count * sizeof(__be32));
 
 		/* Extract capabilities words */
 	case 2:
-		count = min(call->count, 16U);
-		ret = afs_extract_data(call, call->buffer,
-				       count * sizeof(__be32),
-				       call->count > 16);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
 		/* TODO: Examine capabilities */
 
-		call->count -= count;
-		if (call->count > 0)
-			goto again;
-		call->offset = 0;
 		call->unmarshall++;
 		break;
 	}
@@ -426,22 +416,19 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 	u32 uniquifier, size;
 	int ret;
 
-	_enter("{%u,%zu/%u,%u}", call->unmarshall, call->offset, call->count, call->count2);
+	_enter("{%u,%zu,%u}",
+	       call->unmarshall, iov_iter_count(call->_iter), call->count2);
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_buf(call, sizeof(uuid_t) + 3 * sizeof(__be32));
 		call->unmarshall = 1;
 
 		/* Extract the returned uuid, uniquifier, fsEndpoints count and
 		 * either the first fsEndpoint type or the volEndpoints
 		 * count if there are no fsEndpoints. */
 	case 1:
-		ret = afs_extract_data(call, call->buffer,
-				       sizeof(uuid_t) +
-				       3 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -459,15 +446,11 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			return -ENOMEM;
 		alist->version = uniquifier;
 		call->reply[0] = alist;
-		call->offset = 0;
 
 		if (call->count == 0)
 			goto extract_volendpoints;
 
-		call->unmarshall = 2;
-
-		/* Extract fsEndpoints[] entries */
-	case 2:
+	next_fsendpoint:
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			size = sizeof(__be32) * (1 + 1 + 1);
@@ -481,7 +464,12 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		}
 
 		size += sizeof(__be32);
-		ret = afs_extract_data(call, call->buffer, size, true);
+		afs_extract_to_buf(call, size);
+		call->unmarshall = 2;
+
+		/* Extract fsEndpoints[] entries */
+	case 2:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -512,10 +500,9 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		 */
 		call->count2 = ntohl(*bp++);
 
-		call->offset = 0;
 		call->count--;
 		if (call->count > 0)
-			goto again;
+			goto next_fsendpoint;
 
 	extract_volendpoints:
 		/* Extract the list of volEndpoints. */
@@ -526,6 +513,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_yvl_vlendpt_type);
 
+		afs_extract_to_buf(call, 1 * sizeof(__be32));
 		call->unmarshall = 3;
 
 		/* Extract the type of volEndpoints[0].  Normally we would
@@ -533,17 +521,14 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		 * data of the current one, but this is the first...
 		 */
 	case 3:
-		ret = afs_extract_data(call, call->buffer, sizeof(__be32), true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		bp = call->buffer;
-		call->count2 = ntohl(*bp++);
-		call->offset = 0;
-		call->unmarshall = 4;
 
-		/* Extract volEndpoints[] entries */
-	case 4:
+	next_volendpoint:
+		call->count2 = ntohl(*bp++);
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			size = sizeof(__be32) * (1 + 1 + 1);
@@ -557,8 +542,13 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		}
 
 		if (call->count > 1)
-			size += sizeof(__be32);
-		ret = afs_extract_data(call, call->buffer, size, true);
+			size += sizeof(__be32); /* Get next type too */
+		afs_extract_to_buf(call, size);
+		call->unmarshall = 4;
+
+		/* Extract volEndpoints[] entries */
+	case 4:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -584,19 +574,17 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		/* Got either the type of the next entry or the count of
 		 * volEndpoints if no more fsEndpoints.
 		 */
-		call->offset = 0;
 		call->count--;
-		if (call->count > 0) {
-			call->count2 = ntohl(*bp++);
-			goto again;
-		}
+		if (call->count > 0)
+			goto next_volendpoint;
 
 	end:
+		afs_extract_discard(call, 0);
 		call->unmarshall = 5;
 
 		/* Done */
 	case 5:
-		ret = afs_extract_data(call, call->buffer, 0, false);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 		call->unmarshall = 6;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 5c60ade2c7d8..5e0f8dcede26 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -207,17 +207,16 @@ afs_edit_dir_reasons;
 #define EM(a, b)	{ a, b },
 #define E_(a, b)	{ a, b }
 
-TRACE_EVENT(afs_recv_data,
-	    TP_PROTO(struct afs_call *call, unsigned count, unsigned offset,
+TRACE_EVENT(afs_receive_data,
+	    TP_PROTO(struct afs_call *call, struct iov_iter *iter,
 		     bool want_more, int ret),
 
-	    TP_ARGS(call, count, offset, want_more, ret),
+	    TP_ARGS(call, iter, want_more, ret),
 
 	    TP_STRUCT__entry(
+		    __field(loff_t,			remain		)
 		    __field(unsigned int,		call		)
 		    __field(enum afs_call_state,	state		)
-		    __field(unsigned int,		count		)
-		    __field(unsigned int,		offset		)
 		    __field(unsigned short,		unmarshall	)
 		    __field(bool,			want_more	)
 		    __field(int,			ret		)
@@ -227,17 +226,18 @@ TRACE_EVENT(afs_recv_data,
 		    __entry->call	= call->debug_id;
 		    __entry->state	= call->state;
 		    __entry->unmarshall	= call->unmarshall;
-		    __entry->count	= count;
-		    __entry->offset	= offset;
+		    __entry->remain	= iov_iter_count(iter);
 		    __entry->want_more	= want_more;
 		    __entry->ret	= ret;
 			   ),
 
-	    TP_printk("c=%08x s=%u u=%u %u/%u wm=%u ret=%d",
+	    TP_printk("c=%08x r=%llu u=%u w=%u s=%u ret=%d",
 		      __entry->call,
-		      __entry->state, __entry->unmarshall,
-		      __entry->offset, __entry->count,
-		      __entry->want_more, __entry->ret)
+		      __entry->remain,
+		      __entry->unmarshall,
+		      __entry->want_more,
+		      __entry->state,
+		      __entry->ret)
 	    );
 
 TRACE_EVENT(afs_notify_call,

