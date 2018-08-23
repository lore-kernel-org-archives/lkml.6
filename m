Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9871208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9871208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeHWL2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:28:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHWL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:28:36 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6DFECBA;
        Thu, 23 Aug 2018 08:00:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 59/79] drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()
Date:   Thu, 23 Aug 2018 09:53:35 +0200
Message-Id: <20180823074923.009781952@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7f073d011f93e92d4d225526b9ab6b8b0bbd6613 ]

The bo array has req->nr_buffers elements so the > should be >= so we
don't read beyond the end of the array.

Fixes: a1606a9596e5 ("drm/nouveau: new gem pushbuf interface, bump to 0.0.16")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -602,7 +602,7 @@ nouveau_gem_pushbuf_reloc_apply(struct n
 		struct nouveau_bo *nvbo;
 		uint32_t data;
 
-		if (unlikely(r->bo_index > req->nr_buffers)) {
+		if (unlikely(r->bo_index >= req->nr_buffers)) {
 			NV_PRINTK(err, cli, "reloc bo index invalid\n");
 			ret = -EINVAL;
 			break;
@@ -612,7 +612,7 @@ nouveau_gem_pushbuf_reloc_apply(struct n
 		if (b->presumed.valid)
 			continue;
 
-		if (unlikely(r->reloc_bo_index > req->nr_buffers)) {
+		if (unlikely(r->reloc_bo_index >= req->nr_buffers)) {
 			NV_PRINTK(err, cli, "reloc container bo index invalid\n");
 			ret = -EINVAL;
 			break;


