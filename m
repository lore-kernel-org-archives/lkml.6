Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C559C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FC720651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405414AbfAPQWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:22:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbfAPQWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:22:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3895A2D2BD3;
        Wed, 16 Jan 2019 16:22:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 960E910640FC;
        Wed, 16 Jan 2019 16:22:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190104102035.42qwwv4komjvnswh@sole.flsd.net>
References: <20190104102035.42qwwv4komjvnswh@sole.flsd.net> <20181211165938.1150-1-vt@altlinux.org> <20181213101233.6t7d5mxxkkavo46h@gondor.apana.org.au>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] akcipher: Introduce verify2 for public key algorithms
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21903.1547655757.1@warthog.procyon.org.uk>
Date:   Wed, 16 Jan 2019 16:22:37 +0000
Message-ID: <21904.1547655757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 16 Jan 2019 16:22:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:

> This will be hard to do since there is at least tree device that use
> this interface (and who know how much out of tree):
> 
>   drivers$ git grep cra_name.*rsa
>   crypto/caam/caampkc.c:          .cra_name = "rsa",
>   crypto/ccp/ccp-crypto-rsa.c:            .cra_name = "rsa",
>   crypto/qat/qat_common/qat_asym_algs.c:          .cra_name = "rsa",
> 
> Interface seems to be designed that verify() call is interchangeable
> with encrypt().
> 
> Two verify does not seem that bad since there is common code for the old
> interface that removes code duplication and simplifies driver
> implementation (RSA drivers only need to implement encrypt).

You could move the comparison into core crypto code if it's makes more sense
than moving the comparison to the crypto algorithm ->verify() call.  It makes
more sense than the upper layers having to cover the differences between the
algo modules.

David
