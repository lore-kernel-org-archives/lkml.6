Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33197C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE53E214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Yua7By9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE53E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeJIScI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:32:08 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:36388 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJIScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:32:07 -0400
Received: by mail-pl1-f177.google.com with SMTP id y11-v6so673442plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evQI4Gz4N8LGWm/76tEq/RRDa+8TbPgOzrAOKpZRfSY=;
        b=Yua7By9oBlyrE3lwY42J8LxDLRkesDbinzmZIrYjAuZGiXC4gsyd+32GMqvvEet5Z/
         8C8iQR4sAcYMpnOH3hJCMAxZ7L4dNX1CvMfU+jpvgjN20GDKZp9yfX6KGc1a2Fajxxzj
         sEZLJpY4h7l+7AjFF+L2i8RTVP/Wu221lE14aqE60CmWmMp88vAWwzAMvUzbuize01V3
         8OGRgaGod7isXKHsHxRFfgiDLO6C6nnyNSFWLMSr554JRmC35EYSN8+F1AcYSpH930f2
         4usy4GaCMqtjj9dou45pT3/OHL2KoItd96XEtVACwldkVVGCOKjUN9O5Qo9/u4xOqC5X
         txQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evQI4Gz4N8LGWm/76tEq/RRDa+8TbPgOzrAOKpZRfSY=;
        b=l8/8ltJr1dfz8bblatWU+pNWulF7YIUAZG3Zqt84HhtZ5jN2Ck+7pc+v7kKQz+eBGc
         p4rxr3/1HalOceC2X1wwhlV/Vwxh+L+gAt8T/S1n/NvIjf2jhdvbYW3E3whcL/wYI3fr
         FN0T0IzUnVhDia4yANKgkuWRcjUp6ej2CZ7pro2hL0n5wUwzrs03CJnuC9XFitbpTlxz
         KTAQvKqau2QlYqoSi5wsESwjWF0+daN3fQKAE2EsgujAROu4jhcUJXD/h9okR75SgCvS
         ytdPQddLVQClkFFGnCzf2/vsQbzvc/FEdV9OcA1p+71rvuzJvmE5kZgYI1nhg6K4YzYG
         1a8Q==
X-Gm-Message-State: ABuFfoiCUxNEpL0NdC1jE27Qj/n8GRGdLnuSiv4AxF63oZFJdTc/l2B5
        1oopOc8wMjlGhKDesbzxqxYJEg==
X-Google-Smtp-Source: ACcGV63JUHc3kDom5OnydYjGTzS4fQod6Qt65dkYArTPeA+hWnMnCZKTa5DsM/37BtWj4bkGPXVrAQ==
X-Received: by 2002:a17:902:5a89:: with SMTP id r9-v6mr27885290pli.95.1539083740029;
        Tue, 09 Oct 2018 04:15:40 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:38 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 43/45] lightnvm: pblk: fix error handling of pblk_lines_init()
Date:   Tue,  9 Oct 2018 13:12:13 +0200
Message-Id: <20181009111215.7653-44-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In the too many bad blocks error handling case, we should release all
the allocated resources, otherwise it will cause memory leak.

Fixes: 2deeefc02dff ("lightnvm: pblk: fail gracefully on line alloc. failure")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e0db0cb3122d..e3573880dbda 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1024,7 +1024,8 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	if (!nr_free_chks) {
 		pblk_err(pblk, "too many bad blocks prevent for sane instance\n");
-		return -EINTR;
+		ret = -EINTR;
+		goto fail_free_lines;
 	}
 
 	pblk_set_provision(pblk, nr_free_chks);
-- 
2.17.1

