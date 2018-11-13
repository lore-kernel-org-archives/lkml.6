Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D06C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431C322419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431C322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbeKMT0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:26:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeKMT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:26:44 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gMV0h-0004qR-9H; Tue, 13 Nov 2018 09:29:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][bpf-next] bpf: fix null pointer dereference on pointer offload
Date:   Tue, 13 Nov 2018 09:29:26 +0000
Message-Id: <20181113092926.27081-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer offload is being null checked however the following statement
dereferences the potentially null pointer offload when assigning
offload->dev_state.  Fix this by only assigning it if offload is not
null.

Detected by CoverityScan, CID#1475437 ("Dereference after null check")

Fixes: 00db12c3d141 ("bpf: call verifier_prep from its callback in struct bpf_offload_dev")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/bpf/offload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 52c5617e3716..54cf2b9c44a4 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -130,9 +130,10 @@ int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
 
 	down_read(&bpf_devs_lock);
 	offload = prog->aux->offload;
-	if (offload)
+	if (offload) {
 		ret = offload->offdev->ops->prepare(prog);
-	offload->dev_state = !ret;
+		offload->dev_state = !ret;
+	}
 	up_read(&bpf_devs_lock);
 
 	return ret;
-- 
2.19.1

