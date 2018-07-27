Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB4820894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB4820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbeG0LW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:22:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388412AbeG0LWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:22:25 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABEB7CBA;
        Fri, 27 Jul 2018 10:01:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 19/48] sock: fix sg page frag coalescing in sk_alloc_sg
Date:   Fri, 27 Jul 2018 12:00:04 +0200
Message-Id: <20180727095920.513756194@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 144fe2bfd236dc814eae587aea7e2af03dbdd755 ]

Current sg coalescing logic in sk_alloc_sg() (latter is used by tls and
sockmap) is not quite correct in that we do fetch the previous sg entry,
however the subsequent check whether the refilled page frag from the
socket is still the same as from the last entry with prior offset and
length matching the start of the current buffer is comparing always the
first sg list entry instead of the prior one.

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -135,9 +135,10 @@ static int alloc_sg(struct sock *sk, int
 		pfrag->offset += use;
 
 		sge = sg + num_elem - 1;
-		if (num_elem > first_coalesce && sg_page(sg) == pfrag->page &&
-		    sg->offset + sg->length == orig_offset) {
-			sg->length += use;
+
+		if (num_elem > first_coalesce && sg_page(sge) == pfrag->page &&
+		    sge->offset + sge->length == orig_offset) {
+			sge->length += use;
 		} else {
 			sge++;
 			sg_unmark_end(sge);


