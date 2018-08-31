Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D752083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8QKNv6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D752083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeHaXxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:53:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44398 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeHaXxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:53:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so10814787lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F9DaonvEapl6YnvqzHacv5ImpGQxDeye4uIerD81AMI=;
        b=O8QKNv6gtif/f8leEzF/Ix20gGFZfauHfN1PnrqDZGF/5CmhaQ9ZwAOAZxqSpifsGB
         2ImpsOiN13AmVJMiJLJfMv5wmVcNF2mIEieHbp+q4kdz5gPhzQu4F1yUyvC6kJ/MmkeA
         hFBD1SdCVID70FUP5Z9LdEW2rEq5K1DiQVtFZfKrE/8596YpgCaKapTOiEU2eIiSW+S6
         K9YO4C3t7jjTR7TLoaLzAioy1+d4XgmOgs5xUWyol+yM9MuO8cuwUE+kiMPVwr6xVayE
         EY8+GdoFwJiHKUtwFWwaoMxZIYrEyV9C1biWnltzpfYnlWte0yuZE6b1IH2HorVvVwr+
         Iwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F9DaonvEapl6YnvqzHacv5ImpGQxDeye4uIerD81AMI=;
        b=EL8gYHn8kH3pVRMTkhnuEos+dMh3v4VEbXLrMwnqkcjKG//sLv41KEhjOqjFSjIPdN
         L/DHh8hOravIevclYHDylcAqzZyPfdUMinFtM+czYbDZ4yBEYK6mRzMo444RqQpjXent
         Xr0QnAfjJM3zegSonxjL++Gy5VmCuqXKYVJJPesoykQTZsj8V0qHj0A1rDJUkoszlXfa
         KvtuHmhpVoOgP0y52DACjTaZba7vEuXV+Akq1DOuQHv4NFyjx23zV7IUX6Qf7SoZ6Qb6
         QaTP2Lb1tAMVceehS8LYgm123Xeg+8PfoZSaEcqUB1p0UJ+2dtS5h94EYt8Hd9t7wyBa
         cD8w==
X-Gm-Message-State: APzg51BASX1VDLuJm3tbNp3kYFb2vlvl+5gnNrEdFjqTN7mDzt8oYBur
        DCPDnSTIdPMUuuJHsNbzIs0=
X-Google-Smtp-Source: ANB0VdZOstdlD9LmkCLlD3qB7hQy2Q5Hrf6pfFndIUBXwwamAhc8+qx5YnoubdyW4mJX64+Ko0QhkA==
X-Received: by 2002:a19:ce50:: with SMTP id e77-v6mr9337261lfg.81.1535744673069;
        Fri, 31 Aug 2018 12:44:33 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id v18-v6sm1774960ljv.49.2018.08.31.12.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:44:32 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Tejun Heo <tj@kernel.org>, zijun_hu <zijun_hu@htc.com>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: percpu: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 22:44:22 +0300
Message-Id: <20180831194422.13730-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Acked-by: Dennis Zhou <dennisszhou@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: zijun_hu <zijun_hu@htc.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a749d4d96e3e..f5c2796fe63e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2588,7 +2588,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 	BUG_ON(ai->nr_groups != 1);
 	upa = ai->alloc_size/ai->unit_size;
 	nr_g0_units = roundup(num_possible_cpus(), upa);
-	if (unlikely(WARN_ON(ai->groups[0].nr_units != nr_g0_units))) {
+	if (WARN_ON(ai->groups[0].nr_units != nr_g0_units)) {
 		pcpu_free_alloc_info(ai);
 		return -EINVAL;
 	}
-- 
2.17.1

