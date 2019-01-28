Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F535C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F04321741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690284;
	bh=ls3AhZjwC7GK8k7bFWtZRbM7UmJBD5Peezf5D6a88JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKDrgPwsPtZYNBJnS6ZzhHHMOj0Xj4A2jGYBjGpRffbUT14Y+stD7OsrmmIdSg5sR
	 Kp5l2fXojlya+gcl13Vhft8w6Hs5BPPviwqkiA1LH9rnmvjcA5PGQYwXCREB/iv2oU
	 tWtAuCOP21dx/YwChTKdroUETydapMOKOj/Pgaoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfA1Pom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:44:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfA1Pok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7363B20880;
        Mon, 28 Jan 2019 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690279;
        bh=ls3AhZjwC7GK8k7bFWtZRbM7UmJBD5Peezf5D6a88JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwtgTnt2FSLFOwqPoEhKdCUOu3QetnidmxSVRUe+CF0sp7X1xQxgQZFbmv/mEg37d
         yHdSzcKegWdi6M3+t2S3jz6ehFSaX//jnkg8IJQbeguRGuoBdgSxIViLpyZC4R9WQM
         XgtW1CT63Mwr9p8KQ45C5lwdsougifCS066y3gVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 030/304] bpftool: Improve handling of ENOENT on map dumps
Date:   Mon, 28 Jan 2019 10:39:07 -0500
Message-Id: <20190128154341.47195-30-sashal@kernel.org>
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

From: David Ahern <dsahern@gmail.com>

[ Upstream commit bf598a8f0f771302d4ecb0ef0003c54732221597 ]

bpftool output is not user friendly when dumping a map with only a few
populated entries:

    $ bpftool map
    1: devmap  name tx_devmap  flags 0x0
            key 4B  value 4B  max_entries 64  memlock 4096B
    2: array  name tx_idxmap  flags 0x0
            key 4B  value 4B  max_entries 64  memlock 4096B

    $ bpftool map dump id 1
    key:
    00 00 00 00
    value:
    No such file or directory
    key:
    01 00 00 00
    value:
    No such file or directory
    key:
    02 00 00 00
    value:
    No such file or directory
    key: 03 00 00 00  value: 03 00 00 00

Handle ENOENT by keeping the line format sane and dumping
"<no entry>" for the value

    $ bpftool map dump id 1
    key: 00 00 00 00  value: <no entry>
    key: 01 00 00 00  value: <no entry>
    key: 02 00 00 00  value: <no entry>
    key: 03 00 00 00  value: 03 00 00 00
    ...

Signed-off-by: David Ahern <dsahern@gmail.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/map.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7bf38f0e152e..9988d5c126b6 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -383,7 +383,10 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		printf(single_line ? "  " : "\n");
 
 		printf("value:%c", break_names ? '\n' : ' ');
-		fprint_hex(stdout, value, info->value_size, " ");
+		if (value)
+			fprint_hex(stdout, value, info->value_size, " ");
+		else
+			printf("<no entry>");
 
 		printf("\n");
 	} else {
@@ -398,8 +401,11 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		for (i = 0; i < n; i++) {
 			printf("value (CPU %02d):%c",
 			       i, info->value_size > 16 ? '\n' : ' ');
-			fprint_hex(stdout, value + i * step,
-				   info->value_size, " ");
+			if (value)
+				fprint_hex(stdout, value + i * step,
+					   info->value_size, " ");
+			else
+				printf("<no entry>");
 			printf("\n");
 		}
 	}
@@ -731,7 +737,11 @@ static int dump_map_elem(int fd, void *key, void *value,
 		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
 		jsonw_end_object(json_wtr);
 	} else {
-		print_entry_error(map_info, key, strerror(lookup_errno));
+		if (errno == ENOENT)
+			print_entry_plain(map_info, key, NULL);
+		else
+			print_entry_error(map_info, key,
+					  strerror(lookup_errno));
 	}
 
 	return 0;
-- 
2.19.1

