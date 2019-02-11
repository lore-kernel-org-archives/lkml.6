Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D01C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FE920844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894907;
	bh=p0OEtxHDZiIjgC1wAPZL0XDuJ8LyaC9OCyMtjprPqeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahIYlu7UhhtuUOkgJMeB14hyCOXEV6e6HzJOiHt45NFdJ9yQFhb4REAcwxRKXtw3M
	 xgvf5e8RgSd0JBhCfCVbMOpQilnt4N1l6D9nWNkzRO3aFPAAOhmRtcHBlXz2msp47u
	 o6Hw8W9dpQQskEv9ewfVAt1KNoOnvCJ3A0fCtf28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfBKOVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfBKOVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C8720838;
        Mon, 11 Feb 2019 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894902;
        bh=p0OEtxHDZiIjgC1wAPZL0XDuJ8LyaC9OCyMtjprPqeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKYEQ0BF2nfUERXsBYsQ0ZwbzUW4/CmEle0OCMdI/6b8yqmjTVKVkJ0sQph9d1o+7
         KZnGlGWGS1hVXd2UIuMDtJhXDRwmenW1T9wGBorpR9mASep89RAGNW7yN9HnorVG6c
         VKb6Ge8isw8sd8I9+H25yN7Z6azt6BCZ4keDt030=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 027/352] bpftool: Improve handling of ENOENT on map dumps
Date:   Mon, 11 Feb 2019 15:14:14 +0100
Message-Id: <20190211141848.073427002@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



