Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874EBC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A505208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A505208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754394AbeGHUmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:42:40 -0400
Received: from verein.lst.de ([213.95.11.211]:39600 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754289AbeGHUmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:42:38 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 181427FDC5; Sun,  8 Jul 2018 22:44:00 +0200 (CEST)
Date:   Sun, 8 Jul 2018 22:44:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Adrian Reber <adrian@lisas.de>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Message-ID: <20180708204359.GA19198@lst.de>
References: <20180502211448.18276-1-hch@lst.de> <20180502211448.18276-8-hch@lst.de> <20180704142116.GM17048@lisas.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704142116.GM17048@lisas.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 04:21:16PM +0200, Adrian Reber wrote:
> In file included from /usr/include/linux/signal.h:5,
>                  from /usr/include/linux/aio_abi.h:32,
>                  from include.c:2:
> /usr/include/asm/signal.h:16:23: error: conflicting types for ‘sigset_t’
>  typedef unsigned long sigset_t;
>                        ^~~~~~~~
> In file included from /usr/include/signal.h:35,
>                  from include.c:1:
> /usr/include/bits/types/sigset_t.h:7:20: note: previous declaration of ‘sigset_t’ was here
>  typedef __sigset_t sigset_t;

I guess we could do something like the patch below, although it is
rather ugly:

diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 75846164290e..b7705ad66d78 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -29,7 +29,11 @@
 
 #include <linux/types.h>
 #include <linux/fs.h>
+#ifdef __KERNEL__
 #include <linux/signal.h>
+#else
+#include <signal.h>
+#endif
 #include <asm/byteorder.h>
 
 typedef __kernel_ulong_t aio_context_t;
