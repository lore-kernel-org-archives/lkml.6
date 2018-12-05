Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0ACC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56BF20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+p18QLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56BF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeLEJgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeLEJgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:40 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734122084C;
        Wed,  5 Dec 2018 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002600;
        bh=yjNlL2FoLQbG+m0P1sxh2bkCdfq1pIixvqTUi6yqTa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+p18QLspmK2NDJBm3aNMpmgEt4NXZVI5PkjKuNp43O1yWbbvYOH9mbE5QNFKxqk+
         REkmY2NpQW8h/X6WR7nIJKVqB0Pfg1F/6maicJX2H9f4m9PEMRGLcDRj6lNCiaT6+M
         FqNtS9qxJ+xASqZlrzSD9lhhYWLk8990faql1PPk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 013/123] tools: bpftool: prevent infinite loop in get_fdinfo()
Date:   Wed,  5 Dec 2018 04:34:05 -0500
Message-Id: <20181205093555.5386-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Monnet <quentin.monnet@netronome.com>

[ Upstream commit 53909030aa29bffe1f8490df62176c2375135652 ]

Function getline() returns -1 on failure to read a line, thus creating
an infinite loop in get_fdinfo() if the key is not found. Fix it by
calling the function only as long as we get a strictly positive return
value.

Found by copying the code for a key which is not always present...

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index b3a0709ea7ed..fcaf00621102 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -304,7 +304,7 @@ char *get_fdinfo(int fd, const char *key)
 		return NULL;
 	}
 
-	while ((n = getline(&line, &line_n, fdi))) {
+	while ((n = getline(&line, &line_n, fdi)) > 0) {
 		char *value;
 		int len;
 
-- 
2.17.1

