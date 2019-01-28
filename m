Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9750EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652B22177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548704553;
	bh=YcUa7sGe51t1SbX51dwo/LoOfVl2K260mbRpLuzpK5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ayZzJ4vijlTXPC/TjauDy2LhnjLPjFXFR3z3XEzXtFryiS0NQzYZ3kPBBfcSOXY1J
	 BaMjZ7BxzYZxuO4x66m6eVhGYfRAXKtogOSbgsfrBNKSSS+te2AB3muttHMtbZhj5e
	 J9jpyEv/yrGzbIXKaTgrFj+L0hUKc9MOeM3ZOxA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfA1Tmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfA1Tmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:42:31 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902A320989;
        Mon, 28 Jan 2019 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548704550;
        bh=YcUa7sGe51t1SbX51dwo/LoOfVl2K260mbRpLuzpK5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je3d7xEYrowdPritNTzi85RiH8u+UMHoSawbZwEfIJAD03CdeOtSV7HE3V26laFt7
         tfORFi7Uky6BPYJpml/2sXp5khJ2Zh/9ZduOSOupfSvfQ20fxCQyVFIA0ezhjuq01I
         1MRdyl0TPq4FRvI5noRC3eQDCGFp2vNDNdQfbj/Y=
Date:   Mon, 28 Jan 2019 14:42:29 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 4.14 revert "seccomp: add a selftest for get_metadata"
Message-ID: <20190128194229.GK3973@sasha-vm>
References: <8d246df3cdf19608cb6a043bf1dabe8f0adcae6d.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d246df3cdf19608cb6a043bf1dabe8f0adcae6d.camel@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:13:11PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
>Hi Greg,
>
>Can you please revert this commit in 4.14?
>
>commit e65cd9a20343ea90f576c24c38ee85ab6e7d5fec
>Author: Tycho Andersen <tycho@tycho.ws>
>Date:   Tue Feb 20 19:47:47 2018 -0700
>
>    seccomp: add a selftest for get_metadata
>
>    [ Upstream commit d057dc4e35e16050befa3dda943876dab39cbf80 ]
>
>    Let's test that we get the flags correctly, and that we preserve
>the filter
>    index across the ptrace(PTRACE_SECCOMP_GET_METADATA) correctly.
>
>
>
>PTRACE_SECCOMP_GET_METADATA was only added in 4.16
>(26500475ac1b499d8636ff281311d633909f5d20)
>
>
>And it's also breaking seccomp_bpf.c compilation for me:
>
>seccomp_bpf.c: In function ‘get_metadata’:
>seccomp_bpf.c:2878:26: error: storage size of ‘md’ isn’t known
>  struct seccomp_metadata md;

I've queued a revert, sorry about that.

--
Thanks,
Sasha
