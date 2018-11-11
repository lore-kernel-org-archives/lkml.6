Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5670C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D007206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRdI4m1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D007206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403827AbeKLIWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390677AbeKLIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:41 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B58B223C8;
        Sun, 11 Nov 2018 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975564;
        bh=iYS39zyXV/xZ8hLQUWEvOmRMnsaBOmzs3HxmWRQYxcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRdI4m1NJsmJ3ZnF5s1bsBENIUxUnVcq+bsz/1SHE4JVBJKqVEIRvskrDBzhvV5N1
         MZEwg8WdTs0NdSgl/TQ9x0Wod2EUFfxIJQuRbXMcxRQqB62/haIXuCuiu1cbB2VKbL
         Gvlfe06x59avLsV9FfWnLdBzvLk67WikfYA4WznM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 132/222] libnvdimm, region: Fail badblocks listing for inactive regions
Date:   Sun, 11 Nov 2018 14:23:49 -0800
Message-Id: <20181111221659.405897588@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit 5d394eee2c102453278d81d9a7cf94c80253486a upstream.

While experimenting with region driver loading the following backtrace
was triggered:

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
 [..]
 Call Trace:
  dump_stack+0x85/0xcb
  register_lock_class+0x571/0x580
  ? __lock_acquire+0x2ba/0x1310
  ? kernfs_seq_start+0x2a/0x80
  __lock_acquire+0xd4/0x1310
  ? dev_attr_show+0x1c/0x50
  ? __lock_acquire+0x2ba/0x1310
  ? kernfs_seq_start+0x2a/0x80
  ? lock_acquire+0x9e/0x1a0
  lock_acquire+0x9e/0x1a0
  ? dev_attr_show+0x1c/0x50
  badblocks_show+0x70/0x190
  ? dev_attr_show+0x1c/0x50
  dev_attr_show+0x1c/0x50

This results from a missing successful call to devm_init_badblocks()
from nd_region_probe(). Block attempts to show badblocks while the
region is not enabled.

Fixes: 6a6bef90425e ("libnvdimm: add mechanism to publish badblocks...")
Cc: <stable@vger.kernel.org>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/region_devs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -513,10 +513,17 @@ static ssize_t region_badblocks_show(str
 		struct device_attribute *attr, char *buf)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
+	ssize_t rc;
 
-	return badblocks_show(&nd_region->bb, buf, 0);
-}
+	device_lock(dev);
+	if (dev->driver)
+		rc = badblocks_show(&nd_region->bb, buf, 0);
+	else
+		rc = -ENXIO;
+	device_unlock(dev);
 
+	return rc;
+}
 static DEVICE_ATTR(badblocks, 0444, region_badblocks_show, NULL);
 
 static ssize_t resource_show(struct device *dev,


