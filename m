Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2234ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8519F2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 22:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tS1Vk/p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8519F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeIOD0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:26:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeIOD0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N/KV/FJ9M2KkQGomQ+5aPv4BlwTjGeXZFwzLOm5k2V4=; b=tS1Vk/p3JDGUvSVYskoqa/QGY
        +RjcYwRGJfVSAxflyt+MMIB5t7s1NGMO1mwnhRj6Ne5gSEbU7DWY+WYb+PVhbzvP4Ygku1LYIsuVM
        Z/rgWUl+TsIJqEELBuVJ4TERuovVQuCCsgIErbT0DZBf7by2uV6fyUh3BCXPG8tVfig2HSK+XqpE5
        k8hdNGfRskj5SJtCj0bmkyb6LRBn4NsI11O31BxIPXnFWRgcWoL9RECPVI5WnryHFqNwXPQYN1gEv
        9skCFq1Gjf/ouvGvVxp+rUJqJgYUuqEn4gI1WOKXCJKNTCSW7N3/2yzhX1sHQPo/YcVWfg7jENqag
        HZ2GEsDfw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0wII-0007S2-Eb; Fri, 14 Sep 2018 22:10:30 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PTCH] x86: APM: fix build warning when PROC_FS is not enabled
Message-ID: <be39ac12-44c2-4715-247f-4dcc3c525b8b@infradead.org>
Date:   Fri, 14 Sep 2018 15:10:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build warning in apm_32.c when CONFIG_PROC_FS is not enabled:

../arch/x86/kernel/apm_32.c:1643:12: warning: 'proc_apm_show' defined but not used [-Wunused-function]
 static int proc_apm_show(struct seq_file *m, void *v)

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/kernel/apm_32.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20180913.orig/arch/x86/kernel/apm_32.c
+++ linux-next-20180913/arch/x86/kernel/apm_32.c
@@ -1640,6 +1640,7 @@ static int do_open(struct inode *inode,
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
 static int proc_apm_show(struct seq_file *m, void *v)
 {
 	unsigned short	bx;
@@ -1719,6 +1720,7 @@ static int proc_apm_show(struct seq_file
 		   units);
 	return 0;
 }
+#endif
 
 static int apm(void *unused)
 {


