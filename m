Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298BEECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAFF20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LKU1vdtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAFF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbeGXDJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:09:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbeGXDJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:09:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so466674pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qil8d6nnuQ+846reVzdNTxs85u/8USVpUIV+LZcO9FI=;
        b=LKU1vdtkxlkjesCCqUJt8AL0HUG/L00POIkC2UnYFIX8Dd59mIMMhTj4sRIK2g92+m
         Bb/DW7RPkq89l02Cs9vn18fcjG5hHpkL7/iTr/GbXSIcKdVqPWpEr2b4iWWJuRWsFZdl
         zIpQORwIQF6XhJCijsR7G6Fje94/PK4pjcp1BSb4R5+HY8uthFYm4cQy4MIjn1RFNAa6
         wbsPnWf3I3QheduTfLlrX6XGvEzXFyKAocbG1NANmoF3jwz9McwzLss9dQW51KEE5+E8
         tpFxZHDi7pb6pULtfmCV1y7uT5/S+Ny0b1qapCrCLF/dv9kOrRFnFDkd4NaiMWPOOqVI
         RjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qil8d6nnuQ+846reVzdNTxs85u/8USVpUIV+LZcO9FI=;
        b=HDb2FGZerNhp7V6whzDfaFy412vRdappEuLovec1FQ5XbQHv/7lEzyERSIR1Ix21YA
         9j3Rtt9itQz41xiF2vnCRSiY5FfablZELqnbOrG5uvH/+eHyHUv8fl6H0Pt4Gc5h/QMU
         igt71FdGUOZ1AnfOep6GVYbwKDJbXFfonIo6HxMQKvgKxGOYiLKIyYkEg8IfSNuvEPQt
         pM637RwycTTutZk8i0KUXpfnr+F9Pof08ECxWeBoB4Wu0m4IfwaxBKZ0eDbmUyT1sOb2
         aYXlIjSaeZGwObNUJ7d1t1rbMwTIkMfv4xOxpEQtK6ouw6vLa5y4ESsfjRAsxAnSNgsZ
         m5hg==
X-Gm-Message-State: AOUpUlGGue7Ap8UvXSDOdLeIF6qPkcew4uex6SRWJa24hVgtcG+kr3bS
        di2nvkr2BHu50mTOlOBSYgRjQw==
X-Google-Smtp-Source: AAOMgpdMP7hnBq7utBGmmWHM+aXPQ9pMCkKBZu2/aRNx3OSnFfPq2vnlIG4NDfbo4mlyZMdz5qfopg==
X-Received: by 2002:a63:1c13:: with SMTP id c19-v6mr14536732pgc.332.1532397956383;
        Mon, 23 Jul 2018 19:05:56 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id s184-v6sm14819383pfb.56.2018.07.23.19.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:05:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fhmi2-0002KC-GV; Mon, 23 Jul 2018 20:05:54 -0600
Date:   Mon, 23 Jul 2018 20:05:54 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for partial reads
Message-ID: <20180724020554.GL532@ziepe.ca>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
 <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
 <20180723215620.GH532@ziepe.ca>
 <dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
 <20180723220822.GJ532@ziepe.ca>
 <ee0f0ccf-f757-a7d4-bf55-316f81fb490b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0f0ccf-f757-a7d4-bf55-316f81fb490b@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:42:38PM -0700, Tadeusz Struk wrote:
> On 07/23/2018 03:08 PM, Jason Gunthorpe wrote:
> > On Mon, Jul 23, 2018 at 03:00:20PM -0700, Tadeusz Struk wrote:
> >> On 07/23/2018 02:56 PM, Jason Gunthorpe wrote:
> >>> The proposed patch doesn't clear the data_pending if the entire buffer
> >>> is not consumed, so of course it is ABI breaking, that really isn't OK.
> >> The data_pending will be cleared by the timeout handler if the user doesn't
> >> read the response fully before the timeout expires. The is the same situation
> >> if the user would not read the response at all.
> > That causes write() to fail with EBUSY
> > 
> > NAK from me on breaking the ABI like this
> 
> What if we introduce this new behavior only for the non-blocking mode
> as James suggested? Or do you have some other suggestions?

I think you should do it entirely in userspace.

But something sensible linked to O_NONBLOCK could be OK.

Jason
