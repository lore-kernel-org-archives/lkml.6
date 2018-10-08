Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8327BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D20F2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8MFazlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D20F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbeJIB7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CAAC204FD;
        Mon,  8 Oct 2018 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024402;
        bh=0MDOfcpDuLPTOs+Gz6QH6M6PoAG6sktp0eRLNYjIGUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8MFazlXaZGL1nhIOluvrls5EIUTSzBTp+0fhyWA/Xmh0DjViLl6NjHJYSyyjhXM4
         repcpqwCNibEGbFl/vpHybaUlbJDHDY5F0+7/D0zT0Mh3prv1fc7EtjGuy2zHWeO5H
         Miz+YbSL8eFrD49CB2fEnY9AT7EcREP9cn/tpG10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 028/168] bpf: fix msg->data/data_end after sg shift repair in bpf_msg_pull_data
Date:   Mon,  8 Oct 2018 20:30:08 +0200
Message-Id: <20181008175621.114168057@linuxfoundation.org>
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

[ Upstream commit 0e06b227c5221dd51b5569de93f3b9f532be4a32 ]

In the current code, msg->data is set as sg_virt(&sg[i]) + start - offset
and msg->data_end relative to it as msg->data + bytes. Using iterator i
to point to the updated starting scatterlist element holds true for some
cases, however not for all where we'd end up pointing out of bounds. It
is /correct/ for these ones:

1) When first finding the starting scatterlist element (sge) where we
   find that the page is already privately owned by the msg and where
   the requested bytes and headroom fit into the sge's length.

However, it's /incorrect/ for the following ones:

2) After we made the requested area private and updated the newly allocated
   page into first_sg slot of the scatterlist ring; when we find that no
   shift repair of the ring is needed where we bail out updating msg->data
   and msg->data_end. At that point i will point to last_sg, which in this
   case is the next elem of first_sg in the ring. The sge at that point
   might as well be invalid (e.g. i == msg->sg_end), which we use for
   setting the range of sg_virt(&sg[i]). The correct one would have been
   first_sg.

3) Similar as in 2) but when we find that a shift repair of the ring is
   needed. In this case we fix up all sges and stop once we've reached the
   end. In this case i will point to will point to the new msg->sg_end,
   and the sge at that point will be invalid. Again here the requested
   range sits in first_sg.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2300,6 +2300,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (unlikely(start >= offset + len))
 		return -EINVAL;
 
+	first_sg = i;
 	/* The start may point into the sg element so we need to also
 	 * account for the headroom.
 	 */
@@ -2307,8 +2308,6 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (!msg->sg_copy[i] && bytes_sg_total <= len)
 		goto out;
 
-	first_sg = i;
-
 	/* At this point we need to linearize multiple scatterlist
 	 * elements or a single shared page. Either way we need to
 	 * copy into a linear buffer exclusively owned by BPF. Then
@@ -2390,7 +2389,7 @@ BPF_CALL_4(bpf_msg_pull_data,
 	if (msg->sg_end < 0)
 		msg->sg_end += MAX_SKB_FRAGS;
 out:
-	msg->data = sg_virt(&sg[i]) + start - offset;
+	msg->data = sg_virt(&sg[first_sg]) + start - offset;
 	msg->data_end = msg->data + bytes;
 
 	return 0;


