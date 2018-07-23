Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1041EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FC320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cm4Ujzp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FC320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbeGWW7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:59:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbeGWW7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:59:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so2101937wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NsrF/6LDNI04b15Z28E8AJAidUKkkXlorkEs92scaew=;
        b=Cm4Ujzp+xN485hZHOrwbkoT8CqNLh4qGxxvThMpvEuZ1KuSjzGY2Fq6HO6gnDjyfFe
         kQDF9wQcgXyjMkqDNqYKLbaLrTBiDx9Qlq9cNB/JnMDiqH5vPsFo6n5jNu3yA78b008Q
         lKpCAhgc9Hp/X/lEOJ08sGIhPUDe85Pi4PbpKEFThpjKiiWh25KN/dl9z8O2+rdRdCCk
         XgvSDkYZFaMuD6lnCT26eT5Jxo6L8J0I/9OHE6nn6sBl8KDntyzdbrafATTAQMbl31EB
         KXo0PqMv3/1o+JLBF1CdGCw62Vwkg8y5iU7Awzs69qnrkKE/quLyDbJ2UEuZxC8X6gt1
         Lyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsrF/6LDNI04b15Z28E8AJAidUKkkXlorkEs92scaew=;
        b=eUCcPt3XEasZzECM67KtPEhD0mxRgRoL+CfgptnbuwLv0HVsH0ilsORUMmWR2M/uK1
         FXlk3+VgOr63y4TzSsEkAynsTpcjeOl0Jt6VIa2JkMcaByEdjaYRwvKlia+kFpUNhfOj
         8fmx9n8UItV5CPMEHxhGThG/hxbInpc92FRbMFo01jNUtWsOE4gbC5LU2TXfIjiT004T
         t8Neq+MXkZvm2tZGPWNAypSfes5z6DmD60zA04eT03OSjMx6xxpMpwRA4MPX+ZwN54KO
         KdUY1BLnA4Z/adWg3kvNc34d+Oo/Islsbj3swz8WQJqmU6oUQ5h/RqKS9oSs+8CopE2Y
         XRyQ==
X-Gm-Message-State: AOUpUlHg7YCnIyV10EmYg2xncUkyrJfA2uOgpugH3JUm6EsrcsWzKNes
        FHxCkYRp3AMo4vYAJKGnofpG9O3PWkQXqw==
X-Google-Smtp-Source: AAOMgpfLlmtjOzP20eyme3oGg4Li1o5hW4Qr+JCTdFTH/1vn2M7nQzJpy7uw+Cp2KuTxipkiKH+l8Q==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr9201284wrf.268.1532382983849;
        Mon, 23 Jul 2018 14:56:23 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v188-v6sm7510683wme.43.2018.07.23.14.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:56:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fhioW-0007qI-4U; Mon, 23 Jul 2018 15:56:20 -0600
Date:   Mon, 23 Jul 2018 15:56:20 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for partial reads
Message-ID: <20180723215620.GH532@ziepe.ca>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
 <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 02:38:08PM -0700, Tadeusz Struk wrote:
> On 07/23/2018 02:13 PM, James Bottomley wrote:
> > The current patch does, you even provided a use case in your last email
> >  (it's do command to get sizing followed by do command with correctly
> > sized buffer). 
> 
> The example I provided was: #1 send a command, #2 read the response header
> (10 bytes), get the actual response size from the header and then #3 read
> the full response (response size - size of the header bytes).

The proposed patch doesn't clear the data_pending if the entire buffer
is not consumed, so of course it is ABI breaking, that really isn't OK.

> > However, if you tie it to O_NONBLOCK, it won't because no-one currently
> > opens the TPM device non blocking so it's an ABI conformant
> > discriminator of the uses.  Tying to O_NONBLOCK should be simple
> > because it's in file->f_flags.
> 
> I think that it might be an option. Especially that I have this on top of
> the async patch. Let's discuss this when Jarkko is back.

Maybe you could do this by requiring the userspace to call pread()
with a non-zero offset to get the trailing segment of the last
executed command and leave normal read/pread(off=0) with the semantics
as they have today.

Jason
