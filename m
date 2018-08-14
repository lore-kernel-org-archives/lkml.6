Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B78C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904AA2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QZ4UvE7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904AA2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeHNXjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:39:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeHNXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rGNG1CjuHbGXkzpdmUlaJHmLofexCp3Sps+R8BVrkJE=; b=QZ4UvE7YnfLDJdON1go8SrWWM+
        U3aIoEbTf2BK00ILVzyuCIUbIF7iK3R0NwK5ri+8v0PsGZ8CbNklE4aakZW1G+XexBMvkyYYwUV5+
        kAJPz3H82J1AketysMF6/SgJhMB79fy3wAaaekn34QhE/EZtil7+nafZ0/zuq3iyl7d/h5e/kxl+y
        4jG8ZuyVWZtj3TD6l2SbSyWlw4fcaxLqXXdErJJn34EcNhXKiB28em4v2F8x26A2gurZcAK5PlhsG
        L7cwvQYPqlzaPuPuus/uAPoscYfr9AF3qAEyrjzHu2E2rfLJT2YY4PzsJBB1h9bXJ1imcx3hIDmH+
        nWbfaSFA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpgGj-0007hk-3M; Tue, 14 Aug 2018 20:50:21 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Yuexing Wang <wangyxlandq@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] modpost: check strdup() return value
Message-ID: <adc5b6e4-28c1-7fe2-b7b1-c6b1cd39f8ed@infradead.org>
Date:   Tue, 14 Aug 2018 13:50:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix missing error check for function strdup() in scripts/mod/modpost.c.

Fixes kernel bugzilla #200319:
https://bugzilla.kernel.org/show_bug.cgi?id=200319

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yuexing Wang <wangyxlandq@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 scripts/mod/modpost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180814.orig/scripts/mod/modpost.c
+++ linux-next-20180814/scripts/mod/modpost.c
@@ -672,7 +672,7 @@ static void handle_modversions(struct mo
 			if (ELF_ST_TYPE(sym->st_info) == STT_SPARC_REGISTER)
 				break;
 			if (symname[0] == '.') {
-				char *munged = strdup(symname);
+				char *munged = NOFAIL(strdup(symname));
 				munged[0] = '_';
 				munged[1] = toupper(munged[1]);
 				symname = munged;


