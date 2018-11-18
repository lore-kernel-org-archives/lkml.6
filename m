Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3596C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADFE2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 12:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cc4NBjl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADFE2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKRWdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 17:33:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeKRWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 17:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8N2uwu2WwXKm7do23lFv47rcDmbHRiG2vYzjjyHjehg=; b=cc4NBjl/uy7TRdwBnxZywJdm3
        W0jiYFYyjRvPuWzp3Twd26LsvmvUzdz2W3Q2eL3bhNc+KE+Lgo/4xRnSDpRtQKyYNZlotEOXoXl5X
        KYJY8i/tS9frWaSh8ci5oVobI/jYFrQhV7nXQLduTmY3AxF10ic71SEE788MfFaPUJciRnUH776ka
        b6NjqzMayjjMpSkXyL6xESDpMbmY/xnWanwVKU0+S6gUGyoWfYjWayJ2QBGUisS5lBBsWA7eyuyZJ
        vAa0tpuP6SOMosYmn9Ee3Sbtf4+eIwyEuy6hwVnivoef93O0EJTDS5sJ7EJO7UTiSwxEaVr7ZEy9K
        PRraEWNjA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOLx0-0007eg-Dw; Sun, 18 Nov 2018 12:13:18 +0000
Date:   Sun, 18 Nov 2018 04:13:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, darrick.wong@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: minor optimization in write_iter file
 operation
Message-ID: <20181118121318.GC7861@bombadil.infradead.org>
References: <1542542538-11938-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542542538-11938-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 08:02:18PM +0800, Yafang Shao wrote:
> This little adjustment on bitwise operation could make the code a little
> faster.
> As write_iter is used in lots of critical path, so this code change is
> useful for performance.

Did you check the before/after code generation with this patch applied?

$ diff -u before.S after.S
--- before.S	2018-11-18 07:11:48.031096768 -0500
+++ after.S	2018-11-18 07:11:36.883069103 -0500
@@ -1,5 +1,5 @@
 
-before.o:     file format elf32-i386
+after.o:     file format elf32-i386
 
 
 Disassembly of section .text:

with gcc 8.2.0, I see no difference, indicating that the compiler already
makes this optimisation.
