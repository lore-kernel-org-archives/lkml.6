Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D55C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22C2177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rFr4Z+bL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D22C2177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeHMUrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:47:53 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39758 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729835AbeHMUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:47:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3836D8EE171;
        Mon, 13 Aug 2018 11:04:37 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0sRLQSQJn1jN; Mon, 13 Aug 2018 11:04:37 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ACC5B8EE0ED;
        Mon, 13 Aug 2018 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534183476;
        bh=XKaiUftx+2vnXBzHjIE9ornO5si0asIT6BxbrIMBKWw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rFr4Z+bLZ7L9DUI6mAuayZoAAm2Xq9fsHt1G7bzD3DDbplCowWOirsDJ3a4twmbvD
         ISTghDyImS4IBzEZ8ZwdvS90mTcAm4m455lLKT5ynUE2x39CvKxX12bIplSrSO9zsi
         bJTp+m3NJnVHtPQvlgKQnV7P+sAE+C3r4i7rzS9Y=
Message-ID: <1534183475.7872.14.camel@HansenPartnership.com>
Subject: Re: [PATCH v1 0/3] WireGuard: Secure Network Tunnel
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Date:   Mon, 13 Aug 2018 11:04:35 -0700
In-Reply-To: <CAHmME9pn+zm67mmDDrkMLpSAXNEugCT3z2L-QXO2eQw+31V=YQ@mail.gmail.com>
References: <20180731191102.2434-1-Jason@zx2c4.com>
         <1534174811.7872.3.camel@HansenPartnership.com>
         <CAHmME9raa81A_hH_Zykp2r8zOk0ySroFEsk+8384vnVOCuSa=g@mail.gmail.com>
         <1534181830.7872.10.camel@HansenPartnership.com>
         <CAHmME9pn+zm67mmDDrkMLpSAXNEugCT3z2L-QXO2eQw+31V=YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 10:55 -0700, Jason A. Donenfeld wrote:
> > but it's very hard for a flow classifier because you have to
> 
> The construction and identifier strings might not obviously help with
> the extremely narrow idea you've brought up, but it is very important
> for safely introducing additional versions. Namely, it prevents
> against cross-protocol key reuse attacks and type confusion bugs. So
> don't be too quick to dismiss the importance of these for
> accomplishing what we're after.

I'm not saying a hash check isn't important for safety; I'm saying that
if you only have a hash of a dynamic part plus the protocol identifier
to go on it makes far more work for the flow classifier.  You can see
this easily if you contemplate the idea that the hash might be the
algorithm being changed.

> > so lets pick one of the above and try it out.
> 
> We have, multiple times, and it's absolutely trivial to do and works
> well. The exact thing you're concerned about has already been
> researched and worked with on live systems quite a bit over the last
> 3 years, and it works in a pretty straight forward way. I'm not sure
> there's much more to add here: the thing you want is already there
> and has been tested extensively. At this point the "pick one and
> let's try it out!" is an old story, and the focus now is on making
> sure the code quality and netdev api usage is correct for merging

Great, thanks, I'll look forward to seeing it in v2 then.

James

