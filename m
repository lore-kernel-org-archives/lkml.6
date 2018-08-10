Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE961C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06172244C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QSFj8qRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06172244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeHJVbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:31:55 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58686 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbeHJVbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:31:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8255C8EE251;
        Fri, 10 Aug 2018 12:00:48 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id teufXgcB4bEI; Fri, 10 Aug 2018 12:00:48 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E6A6F8EE092;
        Fri, 10 Aug 2018 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533927648;
        bh=RK+koxzZBfJyGPY745W9ywrtJ38uXj7b2xbtE04W9wQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QSFj8qRL15PaggKyipHIaBoWJBQuwePAdtZyELR/Vya1xih302AfnhthMtI9Pb0hz
         H8snM+paKxDDG8m9Dax2Z17/Wn54UIIcwSYnXGA1ta/EYUqqDVDNFVfdeXuUz4pN3V
         t1EystNB0dyTG2BaoxYW68rTXrTR0Euc56sHHkp8=
Message-ID: <1533927647.3143.7.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] tpm: add support for nonblocking operation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Aug 2018 12:00:47 -0700
In-Reply-To: <f49367fa-5af0-695e-342f-03a4bdcf35f2@intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
         <153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
         <20180810174320.GV4692@linux.intel.com>
         <ad02d89f-31d3-7d9f-4580-daf759c8d837@intel.com>
         <1533926908.3143.6.camel@HansenPartnership.com>
         <f49367fa-5af0-695e-342f-03a4bdcf35f2@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 11:56 -0700, Tadeusz Struk wrote:
> On 08/10/2018 11:48 AM, James Bottomley wrote:
> > On Fri, 2018-08-10 at 11:21 -0700, Tadeusz Struk wrote:
> > > and the feedback I got from Jason was:
> > > 
> > > "I wonder if it is worth creating this when the first file is
> > > opened.. Lots of systems have TPMs but few use the userspace.."
> > > 
> > > so I changed this to allocate the WQ on first open. I think it
> > > makes sense, but I leave it to you to decide.
> > 
> > If the reason is to not create a wq unless it's needed, shouldn't
> > the condition actually be first open with flag O_NONBLOCK?
> > 
> 
> Not really because one can do:
> 
> int fd = open("/dev/tpm0", O_RDWR);
> fcntl(fd, F_SETFL, O_NONBLOCK);

so move the condition to first need to queue ...

James

