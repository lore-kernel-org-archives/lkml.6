Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94EC218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbeLSPTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:19:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:30409 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730173AbeLSPTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:19:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 07:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="260746551"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Dec 2018 07:19:50 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 3/3] intel_th: msu: Fix an off-by-one in attribute store
Date:   Wed, 19 Dec 2018 17:19:22 +0200
Message-Id: <20181219151922.44839-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219151922.44839-1-alexander.shishkin@linux.intel.com>
References: <20181219151922.44839-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'nr_pages' attribute of the 'msc' subdevices parses a comma-separated
list of window sizes, passed from userspace. However, there is a bug in
the string parsing logic wherein it doesn't exclude the comma character
from the range of characters as it consumes them. This leads to an
out-of-bounds access given a sufficiently long list. For example:

> # echo 8,8,8,8 > /sys/bus/intel_th/devices/0-msc0/nr_pages
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memchr+0x1e/0x40
> Read of size 1 at addr ffff8803ffcebcd1 by task sh/825
>
> CPU: 3 PID: 825 Comm: npktest.sh Tainted: G        W         4.20.0-rc1+
> Call Trace:
>  dump_stack+0x7c/0xc0
>  print_address_description+0x6c/0x23c
>  ? memchr+0x1e/0x40
>  kasan_report.cold.5+0x241/0x308
>  memchr+0x1e/0x40
>  nr_pages_store+0x203/0xd00 [intel_th_msu]

Fix this by accounting for the comma character.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: ba82664c134ef ("intel_th: Add Memory Storage Unit driver")
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/hwtracing/intel_th/msu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index d293e55553bd..ba7aaf421f36 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1423,7 +1423,8 @@ nr_pages_store(struct device *dev, struct device_attribute *attr,
 		if (!end)
 			break;
 
-		len -= end - p;
+		/* consume the number and the following comma, hence +1 */
+		len -= end - p + 1;
 		p = end + 1;
 	} while (len);
 
-- 
2.19.2

