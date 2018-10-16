Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC674C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8334A21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjT/M0EN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8334A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeJQBFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BF92089E;
        Tue, 16 Oct 2018 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710028;
        bh=Qo/opxfR+PPQk3aPWluF7FLUlFpqLhMxBdid6Xz6VLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjT/M0ENWYoV8GAWDCGkHNrDu0/xKg7ts2wZawNTHzoitc4egMb1QKhenaExyzq5U
         4Psp2JP9Zn2OIDyf4jLNVcSBBnx4rS3AA6HX6TbbI+ayBNayfsKqbB4sQGtp1LhIFv
         S8on8oocR40FSHGt0675Tpa5Tae2hoxVYOBndD+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 078/135] Fix cg_read_strcmp()
Date:   Tue, 16 Oct 2018 19:05:08 +0200
Message-Id: <20181016170520.552373329@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Jay Kamat <jgkamat@fb.com>

[ Upstream commit 48c2bb0b9cf863e0ed78e269f188ce65b73e0fd1 ]

Fix a couple issues with cg_read_strcmp(), to improve correctness of
cgroup tests
- Fix cg_read_strcmp() always returning 0 for empty "needle" strings.
Previously, this function read to a size = 1 buffer when comparing
against empty strings, which would lead to cg_read_strcmp() comparing
two empty strings.
- Fix a memory leak in cg_read_strcmp()

Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")

Signed-off-by: Jay Kamat <jgkamat@fb.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/cgroup/cgroup_util.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -89,17 +89,28 @@ int cg_read(const char *cgroup, const ch
 int cg_read_strcmp(const char *cgroup, const char *control,
 		   const char *expected)
 {
-	size_t size = strlen(expected) + 1;
+	size_t size;
 	char *buf;
+	int ret;
+
+	/* Handle the case of comparing against empty string */
+	if (!expected)
+		size = 32;
+	else
+		size = strlen(expected) + 1;
 
 	buf = malloc(size);
 	if (!buf)
 		return -1;
 
-	if (cg_read(cgroup, control, buf, size))
+	if (cg_read(cgroup, control, buf, size)) {
+		free(buf);
 		return -1;
+	}
 
-	return strcmp(expected, buf);
+	ret = strcmp(expected, buf);
+	free(buf);
+	return ret;
 }
 
 int cg_read_strstr(const char *cgroup, const char *control, const char *needle)


