Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE57A20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE57A20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbeHWLkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:40:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeHWLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:40:06 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F184BB6;
        Thu, 23 Aug 2018 08:11:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 109/130] drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()
Date:   Thu, 23 Aug 2018 09:53:45 +0200
Message-Id: <20180823074934.106934465@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -601,7 +601,7 @@ nouveau_gem_pushbuf_reloc_apply(struct n
 		struct nouveau_bo *nvbo;
 		uint32_t data;
 
-		if (unlikely(r->bo_index > req->nr_buffers)) {
+		if (unlikely(r->bo_index >= req->nr_buffers)) {
 			NV_PRINTK(err, cli, "reloc bo index invalid\n");
 			ret = -EINVAL;
 			break;
@@ -611,7 +611,7 @@ nouveau_gem_pushbuf_reloc_apply(struct n
 		if (b->presumed.valid)
 			continue;
 
-		if (unlikely(r->reloc_bo_index > req->nr_buffers)) {
+		if (unlikely(r->reloc_bo_index >= req->nr_buffers)) {
 			NV_PRINTK(err, cli, "reloc container bo index invalid\n");
 			ret = -EINVAL;
 			break;


