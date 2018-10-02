Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22885C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ACA20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ACA20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJBJXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:23:09 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:49550 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeJBJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:23:09 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g7AdU-0004bH-WA; Tue, 02 Oct 2018 10:42:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g7AdO-0002FI-BE; Tue, 02 Oct 2018 10:42:02 +0800
Date:   Tue, 2 Oct 2018 10:42:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kalyani Akula <kalyania@xilinx.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Query in Crypto framework
Message-ID: <20181002024202.kgnno6wrnmjkumpk@gondor.apana.org.au>
References: <BN7PR02MB51249DB95E4CCBC5257C1F45AFEF0@BN7PR02MB5124.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB51249DB95E4CCBC5257C1F45AFEF0@BN7PR02MB5124.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 09:30:35AM +0000, Kalyani Akula wrote:
> Hi ,
> 
> We wrote a Xilinx specific AES driver in the crypto framework, while testing we have seen one issue.
> We are trying to send a input data of size 1MB using sendmsg system call from the application, and we could see it is hanging in the af_alg_sendmsg.
> Our analysis is, it is waiting for the availability of the writable memory inside af_alg_wait_for_wmem (entered into infinite loop).
> 
> Is there any limitation on the maximum data that can sent via AF_ALG socket ?

When you make a send(2) system call, you're essentially allocating
kernel memory.  For obvious reasons we don't allow unbounded
allocation of kernel memory from user-space.

In order to process a large amount of data, you should use chaining
for algorithms that support it.  So instead of writing everything
at once, write a certain multiple of blocks and then read the partial
result before writing more.

For AEAD algorithms which do not support chaining, you can work
around this by adjusting the appropriate socket buffer limits.

Note that if you increase the socket buffer limits too much you will
run into system-wide limits which can also be adjusted under /proc.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
