Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E658C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11DB21852
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691304;
	bh=04JFyb4oLAhGZ2NFy3SOSeScfuCQpZn7/Bxw8pJ+GVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HqGF13WReKCJMO7XXBurBGkjoDV8zaoXXA9P61LlHQ7uLO93Fdv+oVrwjsjbo5Lx+
	 BpnCg+YABI+DmrVKPDbUp6ymObcL31jju0SlYArMsbuPhFq/Aw/RA8aKTz6UnC3cvi
	 3mFGZ+G9DxDsXy+Ua9nG5r9GbS16NFAQmyEeDdJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfA1QBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbfA1QBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58EE2175B;
        Mon, 28 Jan 2019 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691299;
        bh=04JFyb4oLAhGZ2NFy3SOSeScfuCQpZn7/Bxw8pJ+GVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+we9ExoP9Q+vapx4zt//iOiMI8UCGNv4WpCuLcMjh29GWV63UhFE8GTfioqRQXV2
         WTcg1uGoLX7R8klp0cy3a2GE1jdVpMpAkQQ9eEW1nQtRXZ4HMIlFPClrVYXJaznvIh
         Ru7qGhtYbRWse98W/ToRTamcRrxKR0mGng3MOgrc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 050/258] bpf: libbpf: retry map creation without the name
Date:   Mon, 28 Jan 2019 10:55:56 -0500
Message-Id: <20190128155924.51521-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index 60aa4ca8b2c5..7a0014794bff 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -77,6 +77,7 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
 {
 	__u32 name_len = create_attr->name ? strlen(create_attr->name) : 0;
 	union bpf_attr attr;
+	int ret;
 
 	memset(&attr, '\0', sizeof(attr));
 
@@ -94,7 +95,15 @@ int bpf_create_map_xattr(const struct bpf_create_map_attr *create_attr)
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

