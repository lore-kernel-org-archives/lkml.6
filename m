Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A188DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DD920870
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DD920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeICVPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:15:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38322 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbeICVPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:15:18 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02A0DCFB;
        Mon,  3 Sep 2018 16:54:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Wang <liwang@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>,
        Huang Ying <huang.ying.caritas@gmail.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 31/80] zswap: re-check zswap_is_full() after do zswap_shrink()
Date:   Mon,  3 Sep 2018 18:49:09 +0200
Message-Id: <20180903164935.397528680@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
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

From: Li Wang <liwang@redhat.com>

[ Upstream commit 16e536ef47f567289a5699abee9ff7bb304bc12d ]

/sys/../zswap/stored_pages keeps rising in a zswap test with
"zswap.max_pool_percent=0" parameter.  But it should not compress or
store pages any more since there is no space in the compressed pool.

Reproduce steps:
  1. Boot kernel with "zswap.enabled=1"
  2. Set the max_pool_percent to 0
      # echo 0 > /sys/module/zswap/parameters/max_pool_percent
  3. Do memory stress test to see if some pages have been compressed
      # stress --vm 1 --vm-bytes $mem_available"M" --timeout 60s
  4. Watching the 'stored_pages' number increasing or not

The root cause is:

  When zswap_max_pool_percent is set to 0 via kernel parameter,
  zswap_is_full() will always return true due to zswap_shrink().  But if
  the shinking is able to reclain a page successfully the code then
  proceeds to compressing/storing another page, so the value of
  stored_pages will keep changing.

To solve the issue, this patch adds a zswap_is_full() check again after
  zswap_shrink() to make sure it's now under the max_pool_percent, and to
  not compress/store if we reached the limit.

Link: http://lkml.kernel.org/r/20180530103936.17812-1-liwang@redhat.com
Signed-off-by: Li Wang <liwang@redhat.com>
Acked-by: Dan Streetman <ddstreet@ieee.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Huang Ying <huang.ying.caritas@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zswap.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1018,6 +1018,15 @@ static int zswap_frontswap_store(unsigne
 			ret = -ENOMEM;
 			goto reject;
 		}
+
+		/* A second zswap_is_full() check after
+		 * zswap_shrink() to make sure it's now
+		 * under the max_pool_percent
+		 */
+		if (zswap_is_full()) {
+			ret = -ENOMEM;
+			goto reject;
+		}
 	}
 
 	/* allocate entry */


