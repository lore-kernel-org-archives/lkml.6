Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFDFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E9920864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E9920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965789AbeFRIZX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:25:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbeFRIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:15 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 461C7C5C;
        Mon, 18 Jun 2018 08:25:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 179/279] bpf: fix possible spectre-v1 in find_and_alloc_map()
Date:   Mon, 18 Jun 2018 10:12:44 +0200
Message-Id: <20180618080616.349022432@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 9ef09e35e521bf0df5325cc9cffa726a8f5f3c1b ]

It's possible for userspace to control attr->map_type. Sanitize it when
using it as an array index to prevent an out-of-bounds value being used
under speculation.

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/syscall.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -26,6 +26,7 @@
 #include <linux/cred.h>
 #include <linux/timekeeping.h>
 #include <linux/ctype.h>
+#include <linux/nospec.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PROG_ARRAY || \
 			   (map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
@@ -102,12 +103,14 @@ const struct bpf_map_ops bpf_map_offload
 static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
+	u32 type = attr->map_type;
 	struct bpf_map *map;
 	int err;
 
-	if (attr->map_type >= ARRAY_SIZE(bpf_map_types))
+	if (type >= ARRAY_SIZE(bpf_map_types))
 		return ERR_PTR(-EINVAL);
-	ops = bpf_map_types[attr->map_type];
+	type = array_index_nospec(type, ARRAY_SIZE(bpf_map_types));
+	ops = bpf_map_types[type];
 	if (!ops)
 		return ERR_PTR(-EINVAL);
 
@@ -122,7 +125,7 @@ static struct bpf_map *find_and_alloc_ma
 	if (IS_ERR(map))
 		return map;
 	map->ops = ops;
-	map->map_type = attr->map_type;
+	map->map_type = type;
 	return map;
 }
 


