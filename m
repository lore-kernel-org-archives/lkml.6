Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F14C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424BA20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697702;
	bh=N+FyKejrxPe3KVocsSadp7TI6FSQvnMhFiFsz5FaOwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=apSgnLAW2QPVKIlrrut4L2kgpfPHysg1cbIsFxk0afaFkaI78yXVbOWM/kquBLcaB
	 wqvZ3WQfCJyAnQaM6aSa1T05a7SEKJtJcKwPPZwqmv2Sx8t5mmxqnlMGG38JUMfYGy
	 e/E+craLbP2QZLewPXpvWNo58EdjOV2X3w+bCsds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfA1RsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfA1Ppl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DF592147A;
        Mon, 28 Jan 2019 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690340;
        bh=N+FyKejrxPe3KVocsSadp7TI6FSQvnMhFiFsz5FaOwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OiyNAPWSpLIC2fYk39yPjjoQ91LEBbV3vkqy7CTxjFq0+8kfRZL4VpYDsJiY7njy9
         r9hGjHAUVgfORQmrnH28xJyT9HQKEcI/cQ0WS8Zr3QLARrLDtPaMd6VCw/1Up2KzFc
         X2r3XaiN3skuamY2o5sk5Sj7iUoQmUAW+Zr+VcOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 057/304] bpf: libbpf: retry map creation without the name
Date:   Mon, 28 Jan 2019 10:39:34 -0500
Message-Id: <20190128154341.47195-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 23499442c319412aa8e54e7a939e2eb531bdd77d ]

Since commit 88cda1c9da02 ("bpf: libbpf: Provide basic API support
to specify BPF obj name"), libbpf unconditionally sets bpf_attr->name
for maps. Pre v4.14 kernels don't know about map names and return an
error about unexpected non-zero data. Retry sys_bpf without a map
name to cover older kernels.

v2 changes:
* check for errno == EINVAL as suggested by Daniel Borkmann

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 03f9bcc4ef50..961e1b9fc592 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,7 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
 {
 	__u32 name_len = create_attr->name ? strlen(create_attr->name) : 0;
 	union bpf_attr attr;
+	int ret;
 
 	memset(&attr, '\0', sizeof(attr));
 
@@ -86,7 +87,15 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
 	attr.map_ifindex = create_attr->map_ifindex;
 	attr.inner_map_fd = create_attr->inner_map_fd;
 
-	return sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
+	ret = sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
+	if (ret < 0 && errno == EINVAL && create_attr->name) {
+		/* Retry the same syscall, but without the name.
+		 * Pre v4.14 kernels don't support map names.
+		 */
+		memset(attr.map_name, 0, sizeof(attr.map_name));
+		return sys_bpf(BPF_MAP_CREATE, &attr, sizeof(attr));
+	}
+	return ret;
 }
 
 int bpf_create_map_node(enum bpf_map_type map_type, const char *name,
-- 
2.19.1

