Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A92C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6149221486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU2gHZTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6149221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeJSCAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeJSCAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:00:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9F9C2145D;
        Thu, 18 Oct 2018 17:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885487;
        bh=vgQRyVfDxrpS5RoXKk+8a2ETI646bbm0ywHAkpgZsCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UU2gHZTpG9xe1K1PSbEYXQNCFeDLG+CHvlapAb8yMLgb3uSLncKZ77OD786649GIx
         S/111Mux3pAWhHWnZYbDSSMezs1zG2/gYX+gi52RRkiJnfi6c3gRp20xaC1U7XMzUh
         I1x3dZdknGgDE2+w557eAcqHZ+FM7SkjPPVjWONc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 38/53] bpf: test_maps, only support ESTABLISHED socks
Date:   Thu, 18 Oct 2018 19:54:31 +0200
Message-Id: <20181018175423.172687610@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 5028027844cfc6168e39650abecd817ba64c9d98 ]

Ensure that sockets added to a sock{map|hash} that is not in the
ESTABLISHED state is rejected.

Fixes: 1aa12bdf1bfb ("bpf: sockmap, add sock close() hook to remove socks")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/test_maps.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -566,7 +566,11 @@ static void test_sockmap(int tasks, void
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
@@ -727,7 +731,7 @@ static void test_sockmap(int tasks, void
 	}
 
 	/* Test map update elem afterwards fd lives in fd and map_fd */
-	for (i = 0; i < 6; i++) {
+	for (i = 2; i < 6; i++) {
 		err = bpf_map_update_elem(map_fd_rx, &i, &sfd[i], BPF_ANY);
 		if (err) {
 			printf("Failed map_fd_rx update sockmap %i '%i:%i'\n",
@@ -831,7 +835,7 @@ static void test_sockmap(int tasks, void
 	}
 
 	/* Delete the elems without programs */
-	for (i = 0; i < 6; i++) {
+	for (i = 2; i < 6; i++) {
 		err = bpf_map_delete_elem(fd, &i);
 		if (err) {
 			printf("Failed delete sockmap %i '%i:%i'\n",


