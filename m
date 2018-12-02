Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DDC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D170E20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="HEe/STH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmYsrPj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D170E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbeLBVek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:34:40 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44623 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbeLBVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:34:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C1671286;
        Sun,  2 Dec 2018 16:34:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 02 Dec 2018 16:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=w9fPF0CgiqAC5KRgtPujhOhkKMF
        btYrkaBpbk+W90BY=; b=HEe/STH8zVipU2uJkTlhlRRkKqyyCEb8X7kOPViLdaP
        wyV6iaDo4Bm7r30YTV32D9DTwukiGWmf8jY1LjYN2i0/YjWhCVfO/3UoQ/AbF8qI
        8fKPMAgS962nHHBxl4yjkC7dCaaSIuUU6Xo0WWDkmxgTp/25huP5bBadzJsxF2va
        6tkDzYg+9wKHAOhWNXhXYmXtOjJBVkLurawBOY5yA0T0j42f1f1RBl+7QvVwtUPV
        sJhPn0Tp7VRJm7Q8pzs/dWahIC3RLZXnECcaLD4OODYhaNEXmDurmbdReD6dTvpD
        msZIZ7AzTA33OWYkMmthb4O6eRPnyiGRVd16lMyi04g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=w9fPF0
        CgiqAC5KRgtPujhOhkKMFbtYrkaBpbk+W90BY=; b=PmYsrPj9SCsz9QUgpZuHOq
        VFfYjc2NzCqRDtcyl0LZ2lFaoN4yOsVC0SOvgOGx7E1OvZ0p6wb1TJhEHdHxz6oJ
        s9fa6QaQagE6fSrT4+jTHdW42wHmSiI/8VFlgioWqd9XzYvlpiITfm1Ybkt/7Lsb
        UCpkpQjQCYDYtc1YzL6uIFeCHRoTzsRiCuNLJuYGTavqJ8FgbQ6lBomcqJsM7vNV
        4WsZfM03IJuaTMj0V9xaJZTMzs+TMmFdxrzzewdhZ0ru+lEWC5juXVyY7KMBOLss
        X4wsSpwbPjP1NOCATeig1e7rl7/4FjUvi85nHdkOPVOX4he7oWBn/S1JzXe5xkoA
        ==
X-ME-Sender: <xms:6U8EXFoSxkASJj6fe9LkGfkOfvVvbqwma2tDHmNCVNtT0xgcZHhxtQ>
X-ME-Proxy: <xmx:6U8EXLJLHkoDAR0WyFpHNPtzLmGXrcFakv1G0R4mBQfcky9pRX0HFg>
    <xmx:6U8EXCFFAftQkTJ5PFw_AGFPO53AAXOV1ukcoz1lUVbnYQaciWWXmw>
    <xmx:6U8EXL5p2rgqqj0VTtuzVFqa-oLAb43bySDiZrlzAtDZAXgzzKnUwQ>
    <xmx:6U8EXDNeIcz8pU-H1irbWsJOgVshgFBz2tdE7ZAKzq6yIuycsQD-9A>
    <xmx:6U8EXBJLrhIpTgVUdzPf4VL4Sk0zm6IE46Gt1YE66E-jdlHokWEqTQ>
    <xmx:6k8EXFduIyTxBUbBLvGeLHsyoMl7TY-P7KOGpMyRwT9in5AYgqf_YA>
Received: from localhost (pa49-181-174-11.pa.nsw.optusnet.com.au [49.181.174.11])
        by mail.messagingengine.com (Postfix) with ESMTPA id 44435E40A1;
        Sun,  2 Dec 2018 16:34:31 -0500 (EST)
Date:   Mon, 3 Dec 2018 08:34:28 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RFC 14/15] lib: replace **** with a hug
Message-ID: <20181202213428.GA17607@caerus>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:27:23AM -0800, Jarkko Sakkinen wrote:
> In order to comply with the CoC, replace **** with a hug.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 37a54a6dd594..b7a92f5d47bb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -6,7 +6,7 @@
>  
>  /* vsprintf.c -- Lars Wirzenius & Linus Torvalds. */
>  /*
> - * Wirzenius wrote this portably, Torvalds fucked it up :-)

This is my favourite comment to date in the kernel source tree.  Surely
there are still some people working on the kernel that do so for fun.  I
actually laughed out loud when I first stumbled upon this file.


	 Tobin
	 
