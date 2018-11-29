Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C080DC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 07:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DDCs3kLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5524A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeK2Swi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 13:52:38 -0500
Received: from m12-18.163.com ([220.181.12.18]:53103 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbeK2Swh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 13:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=1qvYh
        0HtzxaAtwDX9ZTAwiISs2FbFxsTz04hf0Xd5W0=; b=DDCs3kLQOYnomTGm+8UXs
        VSdOVqmclA8ooA1wja6mj5gwa7MKl8y8kla/6GD6M73LKJ9r6iDPwP7WbcZeRQ2/
        j50nHhOWCPDsX4C9zMPy1x/rOvzWKhBmcdTjFufMo1IapZw8yoTw9Uhi/LSjTxEQ
        ZQn0oU268eknZx4nC6bifQ=
Received: from bp (unknown [106.120.213.96])
        by smtp14 (Coremail) with SMTP id EsCowAC31Imrmf9buZxJCQ--.19691S2;
        Thu, 29 Nov 2018 15:47:56 +0800 (CST)
Date:   Thu, 29 Nov 2018 15:47:56 +0800
From:   PanBian <bianpan2016@163.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: do not free algorithm before using
Message-ID: <20181129074756.GA73370@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1542880816-63838-1-git-send-email-bianpan2016@163.com>
 <20181129065711.7renu7xnxzp7sr2d@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129065711.7renu7xnxzp7sr2d@gondor.apana.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: EsCowAC31Imrmf9buZxJCQ--.19691S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4fKr4UKw4fCF47Zw15twb_yoWfGrgEg3
        yUGr4jkw1DGr97Cw18AFWUur1FgF93Jr15WF1Sg3Zayr98J3yDJanrKwn3W3WUXrZ5Kr9r
        uFyrXFZxAr9FkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5UWrtUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZwwOcletsK4i6QAAs4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:57:11PM +0800, Herbert Xu wrote:
> On Thu, Nov 22, 2018 at 06:00:16PM +0800, Pan Bian wrote:
> > In multiple functions, the algorithm fields are read after its reference
> > is dropped through crypto_mod_put. In this case, the algorithm memory
> > may be freed, resulting in use-after-free bugs. This patch delays the
> > put operation until the algorithm is never used.
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> Patch applied.  Thanks!
> 
> BTW, this problem exists in almost every other skcipher template,
> e.g., in ctr.  Are you working on a fix for them too?

Probably not. Could you please provide patches to fix them?

Thanks,
Pan

> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

