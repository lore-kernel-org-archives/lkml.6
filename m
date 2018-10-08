Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C9DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9402087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD4dhyAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9402087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbeJIB7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1816204FD;
        Mon,  8 Oct 2018 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024376;
        bh=N8ZTt3vw901xzRZdQqYBjN+VFrad/N8E2vzPf7jvViA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vD4dhyAqxDlMRGZhpZATMfxvxjVjUPLphd98B6goULt2gVMiBX63fsogVUxcaHAOd
         BsMUdB3ri3rWw3mVM0lJvO2RCNSFERuwCDivtzsqq9Tc8CHSXpuiYZcUxWK+YUotdF
         09jzbxsFH1q/D6mtsOj4l5dBDwThh04I/ECUhD+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 021/168] bpf: fix several offset tests in bpf_msg_pull_data
Date:   Mon,  8 Oct 2018 20:30:01 +0200
Message-Id: <20181008175620.853029871@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 5b24109b0563d45094c470684c1f8cea1af269f8 ]

While recently going over bpf_msg_pull_data(), I noticed three
issues which are fixed in here:

1) When we attempt to find the first scatterlist element (sge)
   for the start offset, we add len to the offset before we check
   for start < offset + len, whereas it should come after when
   we iterate to the next sge to accumulate the offsets. For
   example, given a start offset of 12 with a sge length of 8
   for the first sge in the list would lead us to determine this
   sge as the first sge thinking it covers first 16 bytes where
   start is located, whereas start sits in subsequent sges so
   we would end up pulling in the wrong data.

2) After figuring out the starting sge, we have a short-cut test
   in !msg->sg_copy[i] && bytes <= len. This checks whether it's
   not needed to make the page at the sge private where we can
   just exit by updating msg->data and msg->data_end. However,
   the length test is not fully correct. bytes <= len checks
   whether the requested bytes (end - start offsets) fit into the
   sge's length. The part that is missing is that start must not
   be sge length aligned. Meaning, the start offset into the sge
   needs to be accounted as well on top of the requested bytes
   as otherwise we can access the sge out of bounds. For example
   the sge could have length of 8, our requested bytes could have
   length of 8, but at a start offset of 4, so we also would need
   to pull in 4 bytes of the next sge, when we jump to the out
   label we do set msg->data to sg_virt(&sg[i]) + start - offset
   and msg->data_end to msg->data + bytes which would be oob.

3) The subsequent bytes < copy test for finding the last sge has
   the same issue as in point 2) but also it tests for less than
   rather than less or equal to. Meaning if the sge length is of
   8 and requested bytes of 8 while having the start aligned with
   the sge, we would unnecessarily go and pull in the next sge as
   well to make it private.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2276,10 +2276,10 @@ BPF_CALL_4(bpf_msg_pull_data,
 	   struct sk_msg_buff *, msg, u32, start, u32, end, u64, flags)
 {
 	unsigned int len = 0, offset = 0, copy = 0;
+	int bytes = end - start, bytes_sg_total;
 	struct scatterlist *sg = msg->sg_data;
 	int first_sg, last_sg, i, shift;
 	unsigned char *p, *to, *from;
-	int bytes = end - start;
 	struct page *page;
 
 	if (unlikely(flags || end <= start))
@@ -2289,9 +2289,9 @@ BPF_CALL_4(bpf_msg_pull_data,
 	i = msg->sg_start;
 	do {
 		len = sg[i].length;
-		offset += len;
 		if (start < offset + len)
 			break;
+		offset += len;
 		i++;
 		if (i == MAX_SKB_FRAGS)
 			i = 0;
@@ -2300,7 +2300,11 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(start >= offset + len))
 		return -EINVAL;
 
-	if (!msg->sg_copy[i] && bytes <= len)
+	/* The start may point into the sg element so we need to also
+	 * account for the headroom.
+	 */
+	bytes_sg_total = start - offset + bytes;
+	if (!msg->sg_copy[i] && bytes_sg_total <= len)
 		goto out;
 
 	first_sg = i;
@@ -2320,12 +2324,12 @@ BPF_CALL_4(bpf_msg_pull_data,
 		i++;
 		if (i == MAX_SKB_FRAGS)
 			i = 0;
-		if (bytes < copy)
+		if (bytes_sg_total <= copy)
 			break;
 	} while (i != msg->sg_end);
 	last_sg = i;
 
-	if (unlikely(copy < end - start))
+	if (unlikely(bytes_sg_total > copy))
 		return -EINVAL;
 
 	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC, get_order(copy));


