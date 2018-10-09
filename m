Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D80C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379ED214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="fWduV7tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379ED214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJISaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35527 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeJISaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id l17-v6so683804pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtVsjTkvQbAN09oTDSz4hY7949UmQWEI7FEtFfuaV7c=;
        b=fWduV7tzocHtyTeFvrl06goUFy9SHNN0odLZQ/3+c0MM6BlnsOd4+OMuneJkCesUDQ
         mwiQAW3qqdwNzeR/a22rzFZgs4yBOi596LWMlrRAKSaMUzCsx3A3/hxP314OLL8/BYQD
         eZywN2O6HGegG3OKrXZRI9EI5TcuYY8UjNH0hYVy3Uqwpc7WAVrcp8qS5A+wbK8MTeJU
         KPj+x22oK2u6280E6wPHdQWr2KjKxg1lCrKhFaqxuk0GMJ9RckifxB18WCcAHtMb7cp3
         4a6wpw+m/fl+jHsIGJq8BEKp2iuPp1xid5YeC3LOlK82atTyu7gNj5MK43VWX2YDXkRZ
         qVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtVsjTkvQbAN09oTDSz4hY7949UmQWEI7FEtFfuaV7c=;
        b=oGQAwRfqwQjkzrSqJvIkFjEuTU2Olo0/VV7dwNcNPCdPBxxVEOv9EXWjBuCF9KrNG+
         8mkrV7PzmxkpGZOHc2Cy3NK4MY1TB5FzGTd6A/oJKmDFTqiWCstoNRLGgHmcKPqHIBrs
         17hzpZqn8DzW8kXLeyjNinMXf9sSLErCN6kn97RmmA0AlyI/fIFXRohdXkpvDn2gJG01
         ExAWwVC2AlL2KCYQdr1b4x47a6I0fQWOs8E2UiBageGZF1lsqClx9hI44BG1NicCUtNW
         Fc9nHAgDKW8fmrmy2HFuan9H2FMVWvbK4YEeW9lzBRjO06Hdl7q6woFNnG+H+sdZe9WP
         44Ug==
X-Gm-Message-State: ABuFfoiTDi2+nE/kW/iH7Om8xayji1PJTAsYheVMeqKORWf4kGIzMNsk
        suQW8bTYzU997tvQIf5UywKtLQ==
X-Google-Smtp-Source: ACcGV63E1SgOO2LujH5mnk02FnPz39IzrrWu28PTMoPtaIND2K7WIAflutPv/kK4B4b6GB2Qfq0SyA==
X-Received: by 2002:a65:664e:: with SMTP id z14-v6mr24385603pgv.347.1539083626880;
        Tue, 09 Oct 2018 04:13:46 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:45 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 10/45] lightnvm: pblk: refactor put line fn on read completion
Date:   Tue,  9 Oct 2018 13:11:40 +0200
Message-Id: <20181009111215.7653-11-mb@lightnvm.io>
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

The read completion path uses the put_line variable to decide whether
the reference on a line should be released. The function name used for
that is pblk_read_put_rqd_kref, which could lead one to believe that it
is the rqd that is releasing the reference, while it is the line
reference that is put.

Rename and also split the function in two to account for either rqd or
single ppa callers and move it to core, such that it later can be used
in the write path as well.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Heiner Litz <hlitz@ucsc.edu>
---
 drivers/lightnvm/pblk-core.c | 19 +++++++++++++++++++
 drivers/lightnvm/pblk-read.c | 18 +-----------------
 drivers/lightnvm/pblk.h      |  2 ++
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e0b513d07e14..5f99cf396072 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1426,6 +1426,25 @@ struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
 	return line;
 }
 
+void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
+{
+	struct pblk_line *line;
+
+	line = &pblk->lines[pblk_ppa_to_line(ppa)];
+	kref_put(&line->ref, pblk_line_put_wq);
+}
+
+void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int i;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	for (i = 0; i < rqd->nr_ppas; i++)
+		pblk_ppa_to_line_put(pblk, ppa_list[i]);
+}
+
 static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
 {
 	lockdep_assert_held(&pblk->l_mg.free_lock);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index ba3dcb6be4c3..ad1d7713bbda 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -165,22 +165,6 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
 }
 
-static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
-{
-	struct ppa_addr *ppa_list;
-	int i;
-
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
-	for (i = 0; i < rqd->nr_ppas; i++) {
-		struct ppa_addr ppa = ppa_list[i];
-		struct pblk_line *line;
-
-		line = &pblk->lines[pblk_ppa_to_line(ppa)];
-		kref_put(&line->ref, pblk_line_put_wq);
-	}
-}
-
 static void pblk_end_user_read(struct bio *bio)
 {
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -208,7 +192,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 		bio_put(int_bio);
 
 	if (put_line)
-		pblk_read_put_rqd_kref(pblk, rqd);
+		pblk_rq_to_line_put(pblk, rqd);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 64ae0c7ed3bb..be67bbfa3d0a 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -787,6 +787,8 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
 struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
+void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa);
+void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
 struct pblk_line *pblk_line_get_data(struct pblk *pblk);
-- 
2.17.1

