Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD27C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E1D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFugVO1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E1D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbeKTDPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbeKTDPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C59208E4;
        Mon, 19 Nov 2018 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646295;
        bh=PN99ucA8TZB5N80SLvape4AZQT13eYnOTwS+e24kji8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFugVO1x6Re3A+47AWyadyoZ6L6n/ON42rQlvXtiW36vWNnhsh5+rYAghc/uy8Nv1
         A99KSf95g5LjmYND8ZRwXs8AGd8+gG4vcrlQnpkIOdLo6+onF9MTQ17RTsXpG2nxbY
         bcxHrEX+C7c8tLmV0kVpEYZoIS4pyZ5J5br+Vhgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Subject: [PATCH 4.14 110/124] drm/dp_mst: Check if primary mstb is null
Date:   Mon, 19 Nov 2018 17:29:24 +0100
Message-Id: <20181119162632.548736798@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>

commit 23d8003907d094f77cf959228e2248d6db819fa7 upstream.

Unfortunately drm_dp_get_mst_branch_device which is called from both
drm_dp_mst_handle_down_rep and drm_dp_mst_handle_up_rep seem to rely
on that mgr->mst_primary is not NULL, which seem to be wrong as it can be
cleared with simultaneous mode set, if probing fails or in other case.
mgr->lock mutex doesn't protect against that as it might just get
assigned to NULL right before, not simultaneously.

There are currently bugs 107738, 108616 bugs which crash in
drm_dp_get_mst_branch_device, caused by this issue.

v2: Refactored the code, as it was nicely noticed.
    Fixed Bugzilla bug numbers(second was 108616, but not 108816)
    and added links.

[changed title and added stable cc]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Cc: stable@vger.kernel.org
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108616
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107738
Link: https://patchwork.freedesktop.org/patch/msgid/20181109090012.24438-1-stanislav.lisovskiy@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_dp_mst_topology.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1232,6 +1232,9 @@ static struct drm_dp_mst_branch *drm_dp_
 	mutex_lock(&mgr->lock);
 	mstb = mgr->mst_primary;
 
+	if (!mstb)
+		goto out;
+
 	for (i = 0; i < lct - 1; i++) {
 		int shift = (i % 2) ? 0 : 4;
 		int port_num = (rad[i / 2] >> shift) & 0xf;


