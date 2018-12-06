Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96901C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB1820989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131769;
	bh=MZAzHw5ST7NvmQtUcvq25uIbJr8rDH8tkExy8emJXIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XgT6pkcN7vxYyykVSa6xWLNWJw5wOtYknC+Md5QktpY1Qhlgkqk6mHGLHyBd8+GBL
	 FCPRf4t5cgTlGaRCcF9E4DsrKbf7HuITylggV6z5/A1OBB5vtdtD0lRSnJvLpvG24f
	 gP1daLfbyyPeHol9JCf4iEOB1rvurgcb/65FkOxQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB1820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeLFV32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLFV3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:24 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA4C2082B;
        Thu,  6 Dec 2018 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131763;
        bh=MZAzHw5ST7NvmQtUcvq25uIbJr8rDH8tkExy8emJXIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYB27twQ6JDmJbR/mOOkTwiAxfucJ7YblPKLYlw1qDyqa3lL3sZtDvmNT7/Nbd7u6
         Fm/H8BnO2ur0oozSqCzD4KRCUtXE0cJrlQCawlpMfaycon0Gx2mGv6bDTjsjd46XPC
         afY+4TQTZbbzsXp1k3G9YOoJcuY6gOuUwXZujcx8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D99B4042C; Thu,  6 Dec 2018 18:29:20 -0300 (-03)
Date:   Thu, 6 Dec 2018 18:29:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf script: Fix LBR skid dump problems in brstackinsn
Message-ID: <20181206212920.GC32567@kernel.org>
References: <20181120050617.4119-1-andi@firstfloor.org>
 <20181206170140.GJ19069@kernel.org>
 <20181206205146.hsiehbf6fyee2uec@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206205146.hsiehbf6fyee2uec@two.firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 06, 2018 at 12:51:48PM -0800, Andi Kleen escreveu:
> On Thu, Dec 06, 2018 at 02:01:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Nov 19, 2018 at 09:06:17PM -0800, Andi Kleen escreveu:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > This is a fix for another instance of the skid problem Milian
> > > recently found [1]

I think you forgot to add the reference, i.e. what is the url or
message-id that this [1] refers to?

> > Milian, have you tested this?
> 
> It won't fix Milians problem, which were with call graphs.
> 
> For Milian's issue you would need Milian's patches,
> which AFAIK haven't been reviewed by anyone.

/me trying to find these patches...

- Arnaldo
