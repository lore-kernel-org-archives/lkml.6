Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560F02183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216355;
	bh=MXcrlELUPTIodr0e286UIRdOoZOZqFzOEtrHirFXDY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EJCB5YUJqII+Z6xJOD7Q1vVX2QMXv22Wj5QeH4RTAnXsq+xnJoOK4ZhuQvhvINnsb
	 3iqr+c9Zd3kbQUfuW0/wqrHQKLIApmfZ9x98xDUKXUeHw/mYyIfUvQeLAA41ueGNtC
	 X5yNJVYIoBzmCnrenhniHUIwRyD2wh0CX5HZ8UBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfAKOTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbfAKOTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EAD21783;
        Fri, 11 Jan 2019 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216348;
        bh=MXcrlELUPTIodr0e286UIRdOoZOZqFzOEtrHirFXDY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxe2Lgo4ndnM2kasY8sYte2bJTi/T6sSQMo1HM5Q6qsMKYJdRGS6Dq5hBWnHWObVN
         ocB5pwlt4dDoKZY6K01xSOmQU+vjQeBzQigmQA9VzSMDz2I5YQFIiWDtKCUSxKn3W0
         m5xYJT2erXPiUkyICHhu0itvKXgji9bty2pPQp0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 67/88] mm, devm_memremap_pages: kill mapping "System RAM" support
Date:   Fri, 11 Jan 2019 15:08:36 +0100
Message-Id: <20190111131057.258741581@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 06489cfbd915ff36c8e36df27f1c2dc60f97ca56 upstream.

Given the fact that devm_memremap_pages() requires a percpu_ref that is
torn down by devm_memremap_pages_release() the current support for mapping
RAM is broken.

Support for remapping "System RAM" has been broken since the beginning and
there is no existing user of this this code path, so just kill the support
and make it an explicit error.

This cleanup also simplifies a follow-on patch to fix the error path when
setting a devm release action for devm_memremap_pages_release() fails.

Link: http://lkml.kernel.org/r/154275557997.76910.14689813630968180480.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: "Jérôme Glisse" <jglisse@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/memremap.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -171,15 +171,12 @@ void *devm_memremap_pages(struct device
 	struct page_map *page_map;
 	int error, nid;
 
-	if (is_ram == REGION_MIXED) {
-		WARN_ONCE(1, "%s attempted on mixed region %pr\n",
-				__func__, res);
+	if (is_ram != REGION_DISJOINT) {
+		WARN_ONCE(1, "%s attempted on %s region %pr\n", __func__,
+				is_ram == REGION_MIXED ? "mixed" : "ram", res);
 		return ERR_PTR(-ENXIO);
 	}
 
-	if (is_ram == REGION_INTERSECTS)
-		return __va(res->start);
-
 	page_map = devres_alloc_node(devm_memremap_pages_release,
 			sizeof(*page_map), GFP_KERNEL, dev_to_node(dev));
 	if (!page_map)


