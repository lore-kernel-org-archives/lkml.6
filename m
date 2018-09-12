Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43297C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E021220C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiV0tdzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E021220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIMCQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:16:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37655 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeIMCQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:16:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so1613206pfd.4;
        Wed, 12 Sep 2018 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lF693kOryfM0lsbwApVjB7ntRHLxj+Pawlf7Vyb2jx8=;
        b=EiV0tdzT6eo3YjyYx9a2ErPvrOjmzss22Y35Mip6klz8Z3XH/ylzWodvZR8v94wzLz
         nEUfRFH5LFXev8dr7LVeffm2NcV3JNHFWvCJtNWBoW4kByr9eta0Ww9/E7DQAj+PO41d
         d+V5+CVIYmMWrN6rixjka7aQVefs5NF14b9eSsjhwEEJ3cb8M5LiMtjU50dhCwUOl0fx
         LhkOo/vnjHLlH/CJs9ltfPGA4AwrktuWICDHH8nsaLzTlBpx+lBCkFnUDtEB8T9y2tBz
         ZI70sxP3Dy9mr6ABQoRuX5nqbXRFx0etIGMt/lebDsXBLV0qOjy6Xhr8LiYqq3EeGRCv
         wDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lF693kOryfM0lsbwApVjB7ntRHLxj+Pawlf7Vyb2jx8=;
        b=n5tmAYQ2Fak5o597WcHucwJ6ldDolls+bjLJmjpxvmeNJoumGIqWHc+YslWEAvS2qZ
         z/fAQn2BxIi1758IEq2lUchAAtHHdd+0qVhNxx9ozycXA6NZxkiHF25gcUUyUXZiM4YP
         n/dWnepc/gBEjEfgb2F/Vmec5wmoirogbHu1Ead6r+RBd58pYqiSMr4oNVUrCg81B8tG
         xgcBZIH1QG16Lc3Af4SFlSyS9npuVr2+Hcan9PSuInKWJaljRgg+3273hUhrmdUrlOwV
         W6SFh7tBv4TcIB1ET9l7AWPotF5VNYXoj6S5u17fwIMeBAaZ5i5ydFsZAVoz7BQsB+aX
         uHUA==
X-Gm-Message-State: APzg51CRRDEUA52DEz630qttfYf6/VXtD0ISjPC9sE94SgT2Pe06WGpK
        sU73aMvJS0zghmONn67psbY=
X-Google-Smtp-Source: ANB0VdY7CUJhe7FLwWIkBWIeKle55KPMlWbovYMNSZYXfkhR6gnSVjDPL1afJTwDH1r5OEKIQHFEeg==
X-Received: by 2002:a62:5290:: with SMTP id g138-v6mr4268539pfb.46.1536786613915;
        Wed, 12 Sep 2018 14:10:13 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t21-v6sm3529753pfi.73.2018.09.12.14.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 14:10:12 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:10:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: vpd: fix spelling mistake "partion" ->
 "partition"
Message-ID: <20180912211011.GA20199@roeck-us.net>
References: <20180911165858.3015-1-colin.king@canonical.com>
 <50220bc9-326f-7a93-fecb-9b67fbac98b9@roeck-us.net>
 <20180912052448.GA8481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912052448.GA8481@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 07:24:48AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 11, 2018 at 09:58:48PM -0700, Guenter Roeck wrote:
> > On 09/11/2018 09:58 AM, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Trivial fix to spelling mistake in comment
> > > 
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Interesting - drivers/firmware/google/ does not have a maintainer.
> > Greg - is it correct to assume that you are the de-facto maintainer ?
> 
> Yeah, I am :(
> 

Hmm .. the :( doesn't sound too happy. Do you think we should have one ?

Guenter
