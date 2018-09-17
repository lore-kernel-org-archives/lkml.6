Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB28ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4A02146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4A02146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbeIREgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbeIREgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:39 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F7A2C49;
        Mon, 17 Sep 2018 23:07:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 013/158] block: bfq: swap puts in bfqg_and_blkg_put
Date:   Tue, 18 Sep 2018 00:40:43 +0200
Message-Id: <20180917211711.318678529@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit d5274b3cd6a814ccb2f56d81ee87cbbf51bd4cf7 upstream.

Fix trivial use-after-free. This could be last reference to bfqg.

Fixes: 8f9bebc33dd7 ("block, bfq: access and cache blkg data only when safe")
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bfq-cgroup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -275,9 +275,9 @@ static void bfqg_and_blkg_get(struct bfq
 
 void bfqg_and_blkg_put(struct bfq_group *bfqg)
 {
-	bfqg_put(bfqg);
-
 	blkg_put(bfqg_to_blkg(bfqg));
+
+	bfqg_put(bfqg);
 }
 
 /* @stats = 0 */


