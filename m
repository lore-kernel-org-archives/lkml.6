Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58C2C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9892083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9892083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbeJBUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbeJBUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:53 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A7A6C4D;
        Tue,  2 Oct 2018 13:30:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 187/228] drm/amdgpu: fix preamble handling
Date:   Tue,  2 Oct 2018 06:24:44 -0700
Message-Id: <20181002132510.893750150@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Christian König <christian.koenig@amd.com>

[ Upstream commit d98ff24e8e9be3329eea7c84d5e244d0c1cd0ab3 ]

At this point the command submission can still be interrupted.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -975,13 +975,9 @@ static int amdgpu_cs_ib_fill(struct amdg
 		if (r)
 			return r;
 
-		if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE) {
-			parser->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
-			if (!parser->ctx->preamble_presented) {
-				parser->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
-				parser->ctx->preamble_presented = true;
-			}
-		}
+		if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
+			parser->job->preamble_status |=
+				AMDGPU_PREAMBLE_IB_PRESENT;
 
 		if (parser->job->ring && parser->job->ring != ring)
 			return -EINVAL;
@@ -1206,6 +1202,12 @@ static int amdgpu_cs_submit(struct amdgp
 
 	amdgpu_cs_post_dependencies(p);
 
+	if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
+	    !p->ctx->preamble_presented) {
+		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
+		p->ctx->preamble_presented = true;
+	}
+
 	cs->out.handle = seq;
 	job->uf_sequence = seq;
 


