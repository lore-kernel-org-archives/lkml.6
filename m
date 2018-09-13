Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C9C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D86F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D86F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeIMTG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:06:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731192AbeIMTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:06:59 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 167E1D0E;
        Thu, 13 Sep 2018 13:57:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 097/197] bpf: fix bpffs non-array map seq_show issue
Date:   Thu, 13 Sep 2018 15:30:46 +0200
Message-Id: <20180913131845.418454675@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Yonghong Song <yhs@fb.com>

[ Upstream commit dc1508a579e682a1e5f1ed0753390e0aa7c23a97 ]

In function map_seq_next() of kernel/bpf/inode.c,
the first key will be the "0" regardless of the map type.
This works for array. But for hash type, if it happens
key "0" is in the map, the bpffs map show will miss
some items if the key "0" is not the first element of
the first bucket.

This patch fixed the issue by guaranteeing to get
the first element, if the seq_show is just started,
by passing NULL pointer key to map_get_next_key() callback.
This way, no missing elements will occur for
bpffs hash table show even if key "0" is in the map.

Fixes: a26ca7c982cb5 ("bpf: btf: Add pretty print support to the basic arraymap")
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/inode.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -196,19 +196,21 @@ static void *map_seq_next(struct seq_fil
 {
 	struct bpf_map *map = seq_file_to_map(m);
 	void *key = map_iter(m)->key;
+	void *prev_key;
 
 	if (map_iter(m)->done)
 		return NULL;
 
 	if (unlikely(v == SEQ_START_TOKEN))
-		goto done;
+		prev_key = NULL;
+	else
+		prev_key = key;
 
-	if (map->ops->map_get_next_key(map, key, key)) {
+	if (map->ops->map_get_next_key(map, prev_key, key)) {
 		map_iter(m)->done = true;
 		return NULL;
 	}
 
-done:
 	++(*pos);
 	return key;
 }


