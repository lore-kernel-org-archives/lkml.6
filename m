Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E957C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4308E214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNMLInWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4308E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbeJIB75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeJIB74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9B42087D;
        Mon,  8 Oct 2018 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024410;
        bh=ooIXQuIFSSmFtWLm6cbCKyRpf/mXx/WAxqDIL0KpLHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNMLInWwjXNnpv/rYEwIWDJdm9OgjxuNf+R5LmsFDf/U0O14Tj0WTuORrf7lnozl2
         wquQACnsOOq1HeUKv3Hjsa2Ru5zCXI7rwcTksN4nK/eDGT0T/pz7avcdC9VBAz/ste
         R1pjSesr2ma1UPVAR3DNr9F2yA8XU4Q+jW8cDzfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 029/168] bpf: fix shift upon scatterlist ring wrap-around in bpf_msg_pull_data
Date:   Mon,  8 Oct 2018 20:30:09 +0200
Message-Id: <20181008175621.153149806@linuxfoundation.org>
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

[ Upstream commit 2e43f95dd8ee62bc8bf57f2afac37fbd70c8d565 ]

If first_sg and last_sg wraps around in the scatterlist ring, then we
need to account for that in the shift as well. E.g. crafting such msgs
where this is the case leads to a hang as shift becomes negative. E.g.
consider the following scenario:

  first_sg := 14     |=>    shift := -12     msg->sg_start := 10
  last_sg  :=  3     |                       msg->sg_end   :=  5

round  1:  i := 15, move_from :=   3, sg[15] := sg[  3]
round  2:  i :=  0, move_from := -12, sg[ 0] := sg[-12]
round  3:  i :=  1, move_from := -11, sg[ 1] := sg[-11]
round  4:  i :=  2, move_from := -10, sg[ 2] := sg[-10]
[...]
round 13:  i := 11, move_from :=  -1, sg[ 2] := sg[ -1]
round 14:  i := 12, move_from :=   0, sg[ 2] := sg[  0]
round 15:  i := 13, move_from :=   1, sg[ 2] := sg[  1]
round 16:  i := 14, move_from :=   2, sg[ 2] := sg[  2]
round 17:  i := 15, move_from :=   3, sg[ 2] := sg[  3]
[...]

This means we will loop forever and never hit the msg->sg_end condition
to break out of the loop. When we see that the ring wraps around, then
the shift should be MAX_SKB_FRAGS - first_sg + last_sg - 1. Meaning,
the remainder slots from the tail of the ring and the head until last_sg
combined.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2360,7 +2360,10 @@ BPF_CALL_4(bpf_msg_pull_data,
 	 * had a single entry though we can just replace it and
 	 * be done. Otherwise walk the ring and shift the entries.
 	 */
-	shift = last_sg - first_sg - 1;
+	WARN_ON_ONCE(last_sg == first_sg);
+	shift = last_sg > first_sg ?
+		last_sg - first_sg - 1 :
+		MAX_SKB_FRAGS - first_sg + last_sg - 1;
 	if (!shift)
 		goto out;
 


