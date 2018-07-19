Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F163C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2295C206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YqkH31gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2295C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeGSVMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:12:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43830 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbeGSVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:12:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 305618EE1DD;
        Thu, 19 Jul 2018 13:27:31 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X4BxADjUbOlu; Thu, 19 Jul 2018 13:27:31 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AE9DC8EE150;
        Thu, 19 Jul 2018 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1532032050;
        bh=sc0ZEWKf5NOBv4V125GnLV5jEbj1mYXGn2GszcsovII=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YqkH31gmOdoFxr+yRMo2RFlE+Bqbx71n9/hO9+zVJwJvGco2zrqh3VhTY6QAR2VnX
         vTH+ouda2cpN6Dyp+krDzZ5A4KJUWlvrT4Ue5MqWT47u8eQbYwltGshB4ii8fIR7qO
         rmFCQajxvS5t4PyJMHPiY5FeZUezHow972z4QGbo=
Message-ID: <1532032049.3061.1.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add support for partial reads
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Jul 2018 13:27:29 -0700
In-Reply-To: <0b9f0bb5-6620-0499-6680-5ec595167f23@intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
         <1532020750.5396.4.camel@HansenPartnership.com>
         <421c4b75-9e9d-7045-adad-797fd112898a@intel.com>
         <1532026030.3198.2.camel@HansenPartnership.com>
         <e8c17a40-7e5e-61e9-7088-32817766b614@intel.com>
         <1532029979.3198.4.camel@HansenPartnership.com>
         <0b9f0bb5-6620-0499-6680-5ec595167f23@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 13:12 -0700, Tadeusz Struk wrote:
> On 07/19/2018 12:52 PM, James Bottomley wrote:
> > The ABI break is the error case as I outlined above.  We can't
> > assume everyone uses the current interface without getting an error
> > and one error and your hosed is a nasty failure case to change the
> > interface to. 
> 
> Well, if there is a broken application out there that doesn't work
> today it will not work after this change neither.

It doesn't have to be broken ... it could be using EFAULT to probe the
buffer size for instance.  That's the point of not breaking the ABI:
you don't second guess what applications are doing.

James

