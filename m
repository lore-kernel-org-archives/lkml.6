Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F302FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F952146F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543816;
	bh=DqizkAmhfvGS6CyZp3zp3BHnm6KSWhpOOg+YnQAUdJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2LuVEZOqbL+CB0c4AozhW9bR55xRUhkndRdvJfm1rGAL7xTseVKaktnoCNBfvKFv
	 uDe/VEywZmNzc1HwG5na5PXzScQ0CtoFKUMhc9Jd2oYFwc2qo5fBHGRlFPCO9cu3fR
	 kt+0ECWC7WB0XFQXHVVnqi4zQwOK20lGbXUi8lpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F952146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeLKP4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbeLKP4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067AF2146F;
        Tue, 11 Dec 2018 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543811;
        bh=DqizkAmhfvGS6CyZp3zp3BHnm6KSWhpOOg+YnQAUdJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypLUNKHqMyIfc3ZJ7A/63JEBHCXi9b9rvJgWoL9lLjNoSLzkLQLP9U9SZz0RdARvn
         Tcsf8unY/P3/X9AQ9ZJ75OXOAE4PDLLw95cujc3Y2rtRUZNl7lpLT6nELv+6C7AcP8
         v5dTpfzt5e/GKYuQEAmGm+HfJLPu9lYxKMuAPuJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 072/118] media: vicodec: fix memchr() kernel oops
Date:   Tue, 11 Dec 2018 16:41:31 +0100
Message-Id: <20181211151647.157643508@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil@xs4all.nl>

commit cb3b2ffb757e75fef40fb94bc093cbbf49a6bf6e upstream.

The size passed to memchr is too large as it assumes the search
starts at the start of the buffer, but it can start at an offset.

Cc: <stable@vger.kernel.org>      # for v4.19 and up
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vicodec/vicodec-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -438,7 +438,8 @@ restart:
 		for (; p < p_out + sz; p++) {
 			u32 copy;
 
-			p = memchr(p, magic[ctx->comp_magic_cnt], sz);
+			p = memchr(p, magic[ctx->comp_magic_cnt],
+				   p_out + sz - p);
 			if (!p) {
 				ctx->comp_magic_cnt = 0;
 				break;


