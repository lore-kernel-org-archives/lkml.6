Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA2C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E32921557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR0vIGiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E32921557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJHWi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeJHWiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A342075E;
        Mon,  8 Oct 2018 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012370;
        bh=FvnJVQa0mZ4OdQsVV66SqaauScnP/PvqKlybLs9RqrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR0vIGiJwG5xjf9VHbFP/V1LfEC/8OqmnYeAEN3rHhdY7eYnXzDw36TH2a+YvYprN
         mcOL6+4a4yvxdiXPZPaPQim2Sr6DfBU/wkV+KCnZnPfo8lUouzZU+i2ZxxW5ucN1co
         PDEKJBLpFVSvvZqxDGbsSniWGkJdnUePETUVVASY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 46/58] bpf: test_maps, only support ESTABLISHED socks
Date:   Mon,  8 Oct 2018 11:25:11 -0400
Message-Id: <20181008152523.70705-46-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 5028027844cfc6168e39650abecd817ba64c9d98 ]

Ensure that sockets added to a sock{map|hash} that is not in the
ESTABLISHED state is rejected.

Fixes: 1aa12bdf1bfb ("bpf: sockmap, add sock close() hook to remove socks")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/bpf/test_maps.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 6c253343a6f9..70d18d0d39ff 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -566,7 +566,11 @@ static void test_sockmap(int tasks, void *data)
 	/* Test update without programs */
 	for (i = 0; i < 6; i++) {
 		err = bpf_map_update_elem(fd, &i, &sfd[i], BPF_ANY);
-		if (err) {
+		if (i < 2 && !err) {
+			printf("Allowed update sockmap '%i:%i' not in ESTABLISHED\n",
+			       i, sfd[i]);
+			goto out_sockmap;
+		} else if (i >= 2 && err) {
 			printf("Failed noprog update sockmap '%i:%i'\n",
 			       i, sfd[i]);
 			goto out_sockmap;
@@ -727,7 +731,7 @@ static void test_sockmap(int tasks, void *data)
 	}
 
 	/* Test map update elem afterwards fd lives in fd and map_fd */
-	for (i = 0; i < 6; i++) {
+	for (i = 2; i < 6; i++) {
 		err = bpf_map_update_elem(map_fd_rx, &i, &sfd[i], BPF_ANY);
 		if (err) {
 			printf("Failed map_fd_rx update sockmap %i '%i:%i'\n",
@@ -831,7 +835,7 @@ static void test_sockmap(int tasks, void *data)
 	}
 
 	/* Delete the elems without programs */
-	for (i = 0; i < 6; i++) {
+	for (i = 2; i < 6; i++) {
 		err = bpf_map_delete_elem(fd, &i);
 		if (err) {
 			printf("Failed delete sockmap %i '%i:%i'\n",
-- 
2.17.1

