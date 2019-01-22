Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19275C282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0312085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H7jiZuvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfAVC6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:58:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34113 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfAVC6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:58:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so10719295plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 18:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a5JfqlRB8d08NKHQ+Y2k/1n98WJrQMCzg/lSbr2I8jw=;
        b=H7jiZuvNlmrsmsLRVoiGjfJl6Uks7DwBqHRkA187HLSisqMf9WsYOxOF4pBMWDH2KG
         +8XImc0RJEpceRF7rASvUOUd/KBej57Vx7xmzuwdssHhseilOyhOWC97enmx39eLMPE4
         Wr/LkQ/uuK0uByOophBICWTp1SWGSqVNXrM8BSViYcCPZaEq9x/nTfWJt1KS9zexzJxf
         ZDJKGFDGuHwxR5evZT65ktGkYoXYKiU+Z+nkcqN1iPsipzK807UVNPlohnla1UL1OStY
         p3NKSlhVTCRPuX5aa4jykNDWxQVVeVYflUbNcqaMQiDflNEcZ/lBtAnl9zTMHdOoLODo
         TNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a5JfqlRB8d08NKHQ+Y2k/1n98WJrQMCzg/lSbr2I8jw=;
        b=d/0jD4P4oahGJiDYc3vZEeaVjnqywSodziQIzscyljGdMx/V4jvsJ51N6BDlwcBWyV
         o7JdI/DMsNAzDWUNZkpOXMZq511ZlcA2isUfA/UntF5kBPyBgfbTroUfZjYuQ+zJXDQt
         dPF6cI1sbWfvRoqvaMOzZT5FI2qgkRKgofT5nOjFmohNQyG1gfa/OSTy5pbizcupcU0t
         A0L42ZiI3rNJ502oufDxEePXUcEJWoc8WeUmf6EPjJeSK1Ouv8fXsZ0di1AfWKq0ECIA
         2BxBNT+0IgIaF1H84bymwT7wCJID/gBZ/KFOCF7xvNXdmcdkgdJxcgaw2LEk3Q0H3TKh
         +bbg==
X-Gm-Message-State: AJcUukcfbvmH4a9iJEGAbsLQ77b0DM+WOSa5Lj5Ugc8OQSxk+hFFHfoF
        AUR1r2KbsvIkyy+jtTWSq2PLgoV8k8Q=
X-Google-Smtp-Source: ALg8bN4wyPYsjMkaKjzfjXGhOOAvMtYPcKW1KeikiTh+2ogPqrLu4Suavr2RXc+e7+ekyacT8eBF+A==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr31402866pla.252.1548125918903;
        Mon, 21 Jan 2019 18:58:38 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v191sm33180592pgb.77.2019.01.21.18.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 18:58:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1glmGq-0004YG-T5; Mon, 21 Jan 2019 19:58:36 -0700
Date:   Mon, 21 Jan 2019 19:58:36 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190122025836.GH25163@ziepe.ca>
References: <20190118142559.GA4080@linux.intel.com>
 <1547849358.2794.90.camel@HansenPartnership.com>
 <20190120160413.GB30478@linux.intel.com>
 <20190122010218.GA26713@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122010218.GA26713@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:02:18AM +0200, Jarkko Sakkinen wrote:
> On Sun, Jan 20, 2019 at 06:04:13PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Jan 18, 2019 at 02:09:18PM -0800, James Bottomley wrote:
> > > On Fri, 2019-01-18 at 16:25 +0200, Jarkko Sakkinen wrote:
> > > > I get this on a Geminilake NUC after rebasing my maintainer trees:
> > > > 
> > > > tpm tpm0: A TPM error (-1) occurred attempting the self test
> > > > 
> > > > I checked the latest commit ID from drivers/char/tpm to make sure
> > > > that I did not put anything broken to my last PR [1]. It works
> > > > without issues.
> > > > 
> > > > In addition [2] gives me an empty diff.
> > > > 
> > > > Something outside of the TPM driver must have happened that breaks
> > > > the driver. Any ideas?
> > > > 
> > > > [1] commit 9488585b21bef0df1217e510c7134905d1d376a7
> > > > [2] git diff 9488585b21bef0df1217e510c7134905d1d376a7 master
> > > > drivers/char/tpm/
> > > 
> > > I'm afraid you're going to have to bisect to find the offending in-
> > > kernel commit, which is going to be painful since it seems to depend on
> > > physical hardware.  My first instinct is that we're getting a zero
> > > length read somewhere, but I still can't see anything in the merge
> > > window that would cause that behaviour.
> > 
> > Yeah, I've started to bisect it (still 9 rounds to go).
> 
> Fails on commit 170d13ca3a2fdaaa0283399247631b76b441cca2. Still works on
> preceding commit a959dc88f9c8900296ccf13e2f3e1cbc555a8917.

This changes the IO access pattern in memcpy_to/fromio.. Presumably
CRB HW doesn't like the new 4 byte move? Swap each one in crb to
memcpy to confirm..

If the HW requires particular access patterns you can't use
memcpy_to/fromio

Jason
