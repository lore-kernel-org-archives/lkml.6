Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA891C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8E32133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217012;
	bh=4VM8GsvU5mCT6ta2pRuAGa4RHh/CzJJfBB+Oa8Vrsp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lq9CkjI8hYB1wpDvDhOHUSxgDrYhFChzlQ3i5BF1iHcIuVSqD9gVsi41JRXQNMDIE
	 DBGedNzT5GonO8V9qfSwIaU/1UqnQQITDb3gSCKSyJNlU3s9JwCN3DmxH6dHPMFckD
	 daxQAI7StfAEDKsJhE5LWql1dStYnqZM/EmOaIyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbfAKOaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbfAKOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 911A42063F;
        Fri, 11 Jan 2019 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217007;
        bh=4VM8GsvU5mCT6ta2pRuAGa4RHh/CzJJfBB+Oa8Vrsp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTrqJE9c5NyBLdcdIQSoO3qGWGan3sGqQGq7g0ei8Lpw4xwtb/5k82jDh4KuHsL8o
         oOdkYr2U5zRiy6R1t+APTv5RcMRiAl29niRzUgMyJcw1DjogcD1mUf0o61iz/2la7x
         8feS2byiL/gfejKzGhSSjV7YKKt9jCJs81DGZfRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.9 61/63] intel_th: msu: Fix an off-by-one in attribute store
Date:   Fri, 11 Jan 2019 15:15:04 +0100
Message-Id: <20190111131055.916324428@linuxfoundation.org>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit ec5b5ad6e272d8d6b92d1007f79574919862a2d2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/msu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1429,7 +1429,8 @@ nr_pages_store(struct device *dev, struc
 		if (!end)
 			break;
 
-		len -= end - p;
+		/* consume the number and the following comma, hence +1 */
+		len -= end - p + 1;
 		p = end + 1;
 	} while (len);
 


