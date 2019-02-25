Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA42BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2F320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130005;
	bh=xJreFzBxtrX3glRJomELtcnLzuHOB++/F6VHH/gZhqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uac1Plx8CbRu7XZ34Oq3X3nHilyvQxNvFw461u3VKCJrH8fpLdOI5QZcApPhaAN6G
	 YPiBtQtL4BY7hrVORJ+iwKjxsM9TwCLBk9sx0YZGvn8GC5YIbadnqRDievGYcdjbNd
	 LB6iJ18gdqF2RsZwpZvNm8caamsBjQgvOsjH3oSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfBYV0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbfBYV0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7966320C01;
        Mon, 25 Feb 2019 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130001;
        bh=xJreFzBxtrX3glRJomELtcnLzuHOB++/F6VHH/gZhqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqAOWEz80qoXwplkFKudtZfeN3U0RkeArl7PaX7CPmC6FrQwHVSXWbUGLTnWE43uN
         /jCR4mtmay06mmh4X2c005l9QdNYhHHic9/k6kTE+dNqCDsbbI9ekDQPyEoKrF1Pxg
         /DFGP7eYlLPnhvcrD1YroSxaYl1V/5vHh/AzFyKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 134/152] staging: erofs: fix a bug when appling cache strategy
Date:   Mon, 25 Feb 2019 22:12:06 +0100
Message-Id: <20190225195052.880349334@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 0734ffbf574ee813b20899caef2fe0ed502bb783 upstream.

As described in Kconfig, the last compressed pack should be cached
for further reading for either `EROFS_FS_ZIP_CACHE_UNIPOLAR' or
`EROFS_FS_ZIP_CACHE_BIPOLAR' by design.

However, there is a bug in z_erofs_do_read_page, it will
switch `initial' to `false' at the very beginning before it decides
to cache the last compressed pack.

caching strategy should work properly after appling this patch.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/unzip_vle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -624,7 +624,7 @@ repeat:
 	/* go ahead the next map_blocks */
 	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
 
-	if (!z_erofs_vle_work_iter_end(builder))
+	if (z_erofs_vle_work_iter_end(builder))
 		fe->initial = false;
 
 	map->m_la = offset + cur;


