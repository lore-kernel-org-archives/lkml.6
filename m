Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD5C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB820989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080356;
	bh=LuFmAiC5N0UnbUuVaLBNIfwD7mEdaeyPj80tFjd7c8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XA5o1nAyqWcnQcqgwREsrUqcZhyAPaqiKVMEazLmThPOHKUHNRyRRuyixfGcLmm4w
	 PBAAYgIIdVlyuvmvCZCttYLbk7h5dmUjjUF3otLMqKqd8vJpzOA6Anbhw9lLTsKr1D
	 dEWEc4MSwlBqWTiYxM+hqoII1Cg6ScSn7SrHV1T8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfAUNsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfAUNsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BA42063F;
        Mon, 21 Jan 2019 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078526;
        bh=LuFmAiC5N0UnbUuVaLBNIfwD7mEdaeyPj80tFjd7c8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNJIYLpAzIDs0TmuMOxDbLBoljretuUaP5DJnBw52Vtx/96dFgas2eMKlqeE1U6df
         quEUbcNbhsp0m+Sgry6kvQ9dKtIAWw8SUcGeBmRPrTafQhj3Mmpx1thrYHaNCgSp29
         xtDJdlLNRDoSOkPkvrKqCJEHfn3F8GniCIju+xr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yue Hu <huyue2@yulong.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.20 064/111] pstore/ram: Avoid allocation and leak of platform data
Date:   Mon, 21 Jan 2019 14:42:58 +0100
Message-Id: <20190121122503.436421257@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 5631e8576a3caf606cdc375f97425a67983b420c upstream.

Yue Hu noticed that when parsing device tree the allocated platform data
was never freed. Since it's not used beyond the function scope, this
switches to using a stack variable instead.

Reported-by: Yue Hu <huyue2@yulong.com>
Fixes: 35da60941e44 ("pstore/ram: add Device Tree bindings")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pstore/ram.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -723,18 +723,15 @@ static int ramoops_probe(struct platform
 {
 	struct device *dev = &pdev->dev;
 	struct ramoops_platform_data *pdata = dev->platform_data;
+	struct ramoops_platform_data pdata_local;
 	struct ramoops_context *cxt = &oops_cxt;
 	size_t dump_mem_sz;
 	phys_addr_t paddr;
 	int err = -EINVAL;
 
 	if (dev_of_node(dev) && !pdata) {
-		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata) {
-			pr_err("cannot allocate platform data buffer\n");
-			err = -ENOMEM;
-			goto fail_out;
-		}
+		pdata = &pdata_local;
+		memset(pdata, 0, sizeof(*pdata));
 
 		err = ramoops_parse_dt(pdev, pdata);
 		if (err < 0)


