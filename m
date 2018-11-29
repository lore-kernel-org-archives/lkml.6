Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D85C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42244205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCIAq3gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42244205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbeK3BY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbeK3BY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:24:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2908205C9;
        Thu, 29 Nov 2018 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501167;
        bh=SstcGJkuP4W0yF4FjNwpUuMkH7LpDlmMy7C4T6VFQ/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hCIAq3gui6LkneKj+NAkJvLtPljwi8OWt+dKGHIpkKqZigRHdCFfurZUhDFOAuUE0
         RRw8qLjm9eiq/VLwB2kmRwdlfieauDCLjaFLCKQ3fzKytBMwJ17QmJ6YH0jUZWnbK2
         Amq3K+ZjLbZxWaLEyQvI6RJsRKYuilEP9g3w24lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 69/86] cw1200: Dont leak memory if krealloc failes
Date:   Thu, 29 Nov 2018 15:12:34 +0100
Message-Id: <20181129140115.644648095@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 9afdd6128c39f42398041bb2e017d8df0dcebcd1 upstream.

The call to krealloc() in wsm_buf_reserve() directly assigns the newly
returned memory to buf->begin. This is all fine except when krealloc()
failes we loose the ability to free the old memory pointed to by
buf->begin. If we just create a temporary variable to assign memory to
and assign the memory to it we can mitigate the memory leak.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/cw1200/wsm.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/net/wireless/cw1200/wsm.c
+++ b/drivers/net/wireless/cw1200/wsm.c
@@ -1805,16 +1805,18 @@ static int wsm_buf_reserve(struct wsm_bu
 {
 	size_t pos = buf->data - buf->begin;
 	size_t size = pos + extra_size;
+	u8 *tmp;
 
 	size = round_up(size, FWLOAD_BLOCK_SIZE);
 
-	buf->begin = krealloc(buf->begin, size, GFP_KERNEL | GFP_DMA);
-	if (buf->begin) {
-		buf->data = &buf->begin[pos];
-		buf->end = &buf->begin[size];
-		return 0;
-	} else {
-		buf->end = buf->data = buf->begin;
+	tmp = krealloc(buf->begin, size, GFP_KERNEL | GFP_DMA);
+	if (!tmp) {
+		wsm_buf_deinit(buf);
 		return -ENOMEM;
 	}
+
+	buf->begin = tmp;
+	buf->data = &buf->begin[pos];
+	buf->end = &buf->begin[size];
+	return 0;
 }


