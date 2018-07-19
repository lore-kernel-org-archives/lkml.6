Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DCDECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0320671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S7LMtSWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB0320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbeGSSDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:03:19 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41846 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731839AbeGSSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:03:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 61F458EE1DD;
        Thu, 19 Jul 2018 10:19:12 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kqhrVG2BgVMk; Thu, 19 Jul 2018 10:19:12 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C64E08EE150;
        Thu, 19 Jul 2018 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1532020752;
        bh=bJ52egUzu+gZLUu0nDfZyv2Is2cpr+GC1YHou2APOEo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S7LMtSWL+RBTqv6lBm6oyyKgHc+Worm7SZHGm6UrP2L6rJBmasOoaXPxFVousB94t
         v3W4lN8SBDrcCfXlxF9BVtwA6mSYQJV13f6NLTKXvaZ/tSx/qqDkizs2siP9rW3JUY
         jmOSzPLVLpWnoRgCivkRdpGrbmiZeMrjWwQwWqtY=
Message-ID: <1532020750.5396.4.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add support for partial reads
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Jul 2018 10:19:10 -0700
In-Reply-To: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 08:52 -0700, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide "big enough" buffer for the whole response and read it in one
> go.  The application doesn't know how big the response it beforehand
> so it always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough
> buffer the TCTI spec says that the library should set the required
> size and return TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that
> the application could allocate a bigger buffer and call receive
> again. To make it possible in the TSS library this requires being
> able to do partial reads from the driver.
> The library would read the header first to get the actual size of the
> response from the header and then read the rest of the response.
> This patch adds support for partial reads.
> 
> The usecase is implemented in this TSS commit:
> https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e2468
> 3d30b05800648d8a264c

That's just an implementation, though, what's the use case?

I'm curious because all the TPM applications I've written need to be
aware of TPM2B_MAX_BUFFER_SIZE, which is related to MAX_RESPONSE_SIZE
because you can't go over that for big buffer commands (mostly sealing
and unsealing).

The TCG supporting routines define MAX_RESPONSE_SIZE to be 4096, so you
know absolutely how large a buffer you have to have ... and the value
is rather handy for us because if it were larger we'd have to do
scatter gather.

I think the point is that knowing the max buffer size allows us to
behave like UDP: if your packet is the wrong size it gets dropped and
relieves the applications from having to do fragmentation and
reassembly.  Since the max size is so low, what's the benefit of not
assuming the application has to know it?

James

