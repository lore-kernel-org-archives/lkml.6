Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E370C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594E42082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896024;
	bh=YoGhWZgGsUdocZoxx/8M/1mTgE3j5R4oeZPM3n+2aX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qMeNh4PoPYtKO8XyWPrjSA3ulYLpulktjus+sz/pKpnDy7N0/yLI9DM4qYIwCXU+3
	 hlyJPukwm3su7fx4uqSLhWDEfgf7m6cl+kgeDikLMA6tAo6716mbz93LT59xZZ4ckP
	 MR3zX2aVEplxGQHnZ2w/5txeUSssdXHeudOUJbOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfBKOkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732047AbfBKOkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A6320700;
        Mon, 11 Feb 2019 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896017;
        bh=YoGhWZgGsUdocZoxx/8M/1mTgE3j5R4oeZPM3n+2aX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w+/IaKSJ9iyqpgowj0bR0FFcCd0HPg+gJkgJCCHsh9KV80O15sOa3b944KEh+WDLN
         q710d+S45UWsA7E4c5rugQTP4+fnRSvhCofjJQMLCP2RQeZFHZL1gs3UjIA/c+lDVB
         vkU+LBG21eEnUeeclanfemyBnc6W+93rqeQ2zwCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/313] bpf: libbpf: retry map creation without the name
Date:   Mon, 11 Feb 2019 15:15:25 +0100
Message-Id: <20190211141856.626879419@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



