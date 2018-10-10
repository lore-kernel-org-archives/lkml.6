Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00921C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2BE214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="juPdy6sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2BE214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeJKBwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJKBwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:52:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEDCD2098A;
        Wed, 10 Oct 2018 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539196123;
        bh=PQ7TJwB40uPtbMtqcMDVREnTVmgsRh6qcS1u7tSClaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juPdy6sMhM1XjX2E2NiCJ7re1fqnVUG3thVLzdGLP7IEpfQv7j+2vUKAq3ZM4N6y6
         l6QM/nlAr4jiHwreLvyyUMOJvTHMD9Pe8ouFQInWIo0J6x4KrR0E0+bJRTjt37Q5zz
         Km1TdKPZjWU5bZBDhNzrTHUa1S8HZ37Pu+mmJhsU=
Date:   Wed, 10 Oct 2018 20:28:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010182840.GB23517@kroah.com>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
 <20181010181148.GI32006@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010181148.GI32006@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:11:48PM -0400, Sasha Levin wrote:
> I think Greg's last estimate was that about 1/3 of the kernels in the
> wild are custom based on a kernel.org stable kernel, which means that we
> have no visibility as to what they do with the kernel. If you don't know
> who your users are, how can you prioritize some subsystems over others?

The numbers I had was 75% of the images a major cloud provider was using
was either a kernel.org stable kernel release, or Debian.  The remaining
25% was an "enterprise" kernel including CentOS.

Also note that all Android devices are now required to follow the stable
kernel releases as well, so add a few more million to that number :)

That being said, for a well-maintained subsystem like Input, whose
maintainer almost always marks patches for stable releases, having them
picked up by the autobot is unusual.  Dmitry, if you want your subsytem
to be excluded, just let Sasha know, other subsystems have been excluded
at the maintainer's request, and that's fine.

There are many other subsystems whose maintainers never mark stuff for
stable, and that's a much bigger issue that the autobot is working to
help solve.  I doubt we need to worrya bout Atari keyboards :)

thanks,

greg k-h
