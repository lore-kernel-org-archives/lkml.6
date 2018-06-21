Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8FBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAED21946
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OQropncG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAED21946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932940AbeFUR4J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:56:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54469 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeFUR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:56:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so6476397wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DuO1Ofdlbp8EJhcL9UUhMWN0HhbNewTkGhy44D3euDg=;
        b=OQropncGzOsr2y6dgSFtZWaC913Q6ggvgF8Ez4kCwUaVAmFq1MBFTdLaGDjHH7xzAd
         mALWV9qRPmgvMRG/rHb775KGig6Jd7LLyTp9x+WMIVjUVSVUaOw/szywHny2WFfOsBYD
         aQWGxlWlhA2r28Sizfa9ptm4KvfvuJbsMTFhkVcQCGSXESZNevR3GlUI1fqS3ADHd7dL
         S5QjQ60zcE0NI8kSz3T6e69wZsnwXfpZpGaKiEBSRJCq+HZlWRLJQPiAyjFWbe99rwYo
         aLgY4tiev5UAy8dfdCmNeDcYW4MWpsQWn4lBwbsQxQ3MlTw66SXFdcIRnSyzWupvL1cr
         ZVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DuO1Ofdlbp8EJhcL9UUhMWN0HhbNewTkGhy44D3euDg=;
        b=g9zyBu5QyjKdg52f5ICZnJKX/w1JYk1EfSm0x+vAmH18TR0qbOsP8+iwfOpeGfQAor
         eA7BwCVPnEDxoaHt5ek2NNODi0YNTxVGpGyIsDmdV+261O+L95xKfXA+tzyMtzNUGy9n
         QivHOh1Hv760LjIjmr4zoTCtUEZHvjqHEsD+MBLh8NSDtIksT+wohhFO4wFsxWAm+rtI
         q5LxkoNJaewsM2PJd8YeBqM5OxY5psk69mQTsqcsQhCR/HOqaAONcrcSclvv29kh2+wv
         QpmEeSvA05xgumRpdkGhjWDXqLWr+PXHD9kNdBdF0eFb+9d36kItCgD2xsN2sReFUTul
         BTNg==
X-Gm-Message-State: APt69E1zdNc+RpBSC/fW/qoawfV3/p2DR0vip8fddcGSSPBKxy5wYSws
        +vtZU5LVPSOlGMOhkGp1NkVrpA==
X-Google-Smtp-Source: ADUXVKKlL6GBBZTOaly4EJArMQ6N/oKCUQfvYFfmHiLpc6niZWx8NcyCoC1OaMVq193g+1sfEvYt/A==
X-Received: by 2002:a1c:6d02:: with SMTP id i2-v6mr5578499wmc.62.1529603766175;
        Thu, 21 Jun 2018 10:56:06 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id n14-v6sm6088163wrm.23.2018.06.21.10.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:56:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fW3oP-00018T-NO; Thu, 21 Jun 2018 11:56:01 -0600
Date:   Thu, 21 Jun 2018 11:56:01 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621175601.GC19270@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180621171518.GI11859@linux.intel.com>
 <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b2970f-b71b-4cfc-c188-7ae7e8cb94c5@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:45:03PM -0400, Stefan Berger wrote:
> On 06/21/2018 01:15 PM, Jarkko Sakkinen wrote:
> >On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> >>Implement tpm_chip_find() for other subsystems to find a TPM chip and
> >>get a reference to that chip. Once done with using the chip, the reference
> >>is released using tpm_chip_put().
> >>
> >>Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >You should sort this out in a way that we don't end up with duplicate
> >functions.
> 
> Do you want me to create a function *like* tpm_chip_find_get() that takes an
> additional parameter whether to get the ops semaphore and have that function
> called by the existing tpm_chip_find_get() and the new tpm_chip_find(). The
> latter would then not get the ops semphore. I didn't want to do this since
> one time the function returns with a lock held and the other time not.

Another option, and I haven't looked, is to revise the callers of
tpm_chip_find_get to not require it to hold the ops semaphore for
them.

Either by giving them an API to do it, or revising the TPM entry
points to do it.

I didn't look, but how did the ops semaphore get grabbed in your
revised patches? They do grab it, right?

Jason
