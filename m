Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32700C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0071721848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216919;
	bh=lkkwx6SDIxgxBQUA0uEUJ2389JFELuekCf6uFfNB1ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d53YapAdZGfMqyUnHM5R7QkksKdDcUWYHZtXoTewCJ2AcXrmPsk4Z+XmFWZ+TOCa5
	 Yyqsn2TtG+kV2GIIuYt5P/eXFz/RpUe1HcagjEJqFBkuw7K6oogB/AbwFKljyfJpUm
	 UrMD5B0AHBzO9/ed5a3soi+Ka3dOQTlu1nRDrATU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfAKO2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:28:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388530AbfAKO2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605512133F;
        Fri, 11 Jan 2019 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216914;
        bh=lkkwx6SDIxgxBQUA0uEUJ2389JFELuekCf6uFfNB1ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+3SOk1oLKZ+zJkH+ZgRkWxnMdPECE6ir90vnw0IhV5Qvcq1wTfIGrFSe2LvTcTR3
         xCuQBv8mQ9GktsOAgh5BiU117rTbsZfu4T9XvJ6Usw6Kb2igCqG3JozWoQ6ZjP5r+G
         yxS3NZbOU0B2usavAC7ACQ/L83rDr9s8i3q62D3k=
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
Subject: [PATCH 4.9 38/63] mm, devm_memremap_pages: kill mapping "System RAM" support
Date:   Fri, 11 Jan 2019 15:14:41 +0100
Message-Id: <20190111131051.598353345@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -305,15 +305,12 @@ void *devm_memremap_pages(struct device
 	is_ram = region_intersects(align_start, align_size,
 		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
 
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
 	if (!ref)
 		return ERR_PTR(-EINVAL);
 


