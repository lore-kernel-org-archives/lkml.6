Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E12C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A32322453
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="JgoSFh5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A32322453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHJVTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:19:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58576 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbeHJVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:19:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 26BD68EE251;
        Fri, 10 Aug 2018 11:48:30 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pX-LtTscMfQX; Fri, 10 Aug 2018 11:48:29 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 919028EE092;
        Fri, 10 Aug 2018 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533926909;
        bh=G1gsbHc0JLZNfNKOh0mThzMtgzNdDtUwpN4jiJWu8sA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JgoSFh5+XjdQMtXy8kWZkwQQZPafR3/JOxdYu/KnWQvD5wQUHftlipoFu0UILDBir
         JdcyUoAnZfJ34fQxPfvc1qT4FH3uD2zsV6kMNzcMg/wZ2AjX5c+xOIZpmlBF/yuDFL
         hcdKnBhBLGQ2CsJQsBCfkqIYz7mcHkxcrwNK06F4=
Message-ID: <1533926908.3143.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] tpm: add support for nonblocking operation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Aug 2018 11:48:28 -0700
In-Reply-To: <ad02d89f-31d3-7d9f-4580-daf759c8d837@intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
         <153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
         <20180810174320.GV4692@linux.intel.com>
         <ad02d89f-31d3-7d9f-4580-daf759c8d837@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 11:21 -0700, Tadeusz Struk wrote:
> and the feedback I got from Jason was:
> 
> "I wonder if it is worth creating this when the first file is
> opened.. Lots of systems have TPMs but few use the userspace.."
> 
> so I changed this to allocate the WQ on first open. I think it makes
> sense, but I leave it to you to decide.

If the reason is to not create a wq unless it's needed, shouldn't the
condition actually be first open with flag O_NONBLOCK?

James

