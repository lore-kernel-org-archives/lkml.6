Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B0DC4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8FF21A70
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 01:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGNRtSpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8FF21A70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbeHGDb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 23:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731982AbeHGDb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 23:31:26 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92BC21A6D;
        Tue,  7 Aug 2018 01:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533604778;
        bh=heOaBTjqd+t5oSyYNBPEIC0q42qH1ICNZU0NPNpU5/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGNRtSpKjWQ9Yqu/cFG5Ik7jUx/kQca5Udwi+ALR2o4+pEDx6Htq1AFm4eaBRIg/C
         1Cy+UUcDmMSMLpI4htO3rc4JoLnHQd+4UFmJF1lnTTagNYR7m8kwxEdBRcdCp7/a/q
         gX0Wk3eZflDtUIKxDPHjunxlvFFCbpsO88rSXylk=
Date:   Mon, 6 Aug 2018 18:19:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        stable@vger.kernel.org
Subject: Re: [PATCH] crypto: remove speck
Message-ID: <20180807011937.GA133621@gmail.com>
References: <20180806223300.113891-1-ebiggers@kernel.org>
 <20180806230437.21431-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806230437.21431-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1+60 (20b17ca5) (2018-08-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Aug 07, 2018 at 01:04:37AM +0200, Jason A. Donenfeld wrote:
> These are unused, undesired, and have never actually been used by
> anybody. The original authors of this code have changed their mind about
> its inclusion. Therefore, this patch removes it.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: stable@vger.kernel.org

For context, in your commit message can you include a link to my email
mentioning Android's Speck decision
(https://marc.info/?l=linux-crypto-vger&m=153359499015659)?

Also: "speck" => "Speck".

Also I think the fscrypt code points should be reserved so they don't
get reused for something else:

#define FS_ENCRYPTION_MODE_SPECK128_256_XTS    7	/* removed */
#define FS_ENCRYPTION_MODE_SPECK128_256_CTS    8	/* removed */

Otherwise:

	Acked-by: Eric Biggers <ebiggers@google.com>

For the record, I think the statements Paul and I have made evaluating
Speck from a technical perspective remain substantially accurate.
However, clearly today there are more than just technical considerations
when choosing cryptographic primitives.  So ultimately, enough people
didn't *want* Speck that we weren't able to offer it, even though it was
only meant to replace no encryption.  We've also designed and proposed
an alternative solution for the ARMv7 disk encryption use case, HPolyC.

So given the above, and that I no longer know of any specific users of
the Speck code (so in principle it can still be removed without breaking
userspace), and that it's possible that similar considerations will make
Speck difficult for others to use, and that some people heavily object
to Speck being optionally supported in the kernel at all, I'm okay with
it being removed...

Thanks,

- Eric
