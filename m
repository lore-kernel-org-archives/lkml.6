Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D452C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD032083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlkrkWIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD032083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406935AbeHATMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:12:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41814 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405142AbeHATMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:12:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so11141939pgu.8;
        Wed, 01 Aug 2018 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wKDvMPLIToyxehuCUNZAOFyH1ae0ahcPDeOYUYfqv0=;
        b=RlkrkWIf2r9so9ZSJSaU7XcrjUiT+wShaiBjzHtHcba54xCs5hBY8gvHT29yJ7622I
         h7jHYia5VNkgRY1HWWoFDijfoXu5AnxoZv5w19V0ewJpvd9ZU98WOFwERtr7+KmebYhQ
         YeHk7OASjbFaHwIghJcLkqjIiKM6vWF4w1GQjATzec6ynN64hi07EzlXI3GceukmI2Xw
         1e51XtuwrsHtYU0NJaEqCqNTeY2FRkkyiIcXdTyngHuwFpgarjTQErkwC1PINBIsa+DP
         sHyxvHEWd57hlh9qlXW+A3E/KWdt/rWDLJU8VBgvzKZBTyMhZJHixsd3CQ+Be42RRHng
         hFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wKDvMPLIToyxehuCUNZAOFyH1ae0ahcPDeOYUYfqv0=;
        b=esMpnanS290ldrXIGY5NWPYHhn9nHDgoY9qEiS0rwQG3i9sSpQPi7J45rMrwFGs/1q
         WUx0ZU6jY3+kCtOqjYNuAZS4cdK+e+rVeSNiI7fesludWfR+PCalbf1KVEWQ+D3HWM/k
         2hKPuuOlHey60IukL/N0YUmRhq5Uyl1LTVcr2VJYlVedlm1Gz+SMOOYiijKp+kDigl5n
         aAuhWFulHJegzriCtavdMW48x10f3hTzqz78sRSAQhETVRgToto88afyNkiCTulcWnvk
         XLrOIN0ydOYwzPIjToqu35f7VTjDnp+HTHFmJh6DxcnHBNOh0BRRMbRlrJCo0hddZuZM
         SfSQ==
X-Gm-Message-State: AOUpUlFDMruEb7if+yDv6cRpw2xrMMoR3mhT0ISa2hLN2hpu/IwAf1P8
        2CyXsr2ReSb2RqZ67Y0wf1s=
X-Google-Smtp-Source: AAOMgpcbKvBMGifjSC4/UjM9DEhcBE1LCjavq5ZS4PXTfARwPLbh9CJLscTV9d9Z6/PP9ylBoPTshw==
X-Received: by 2002:a63:9311:: with SMTP id b17-v6mr25485053pge.261.1533144351271;
        Wed, 01 Aug 2018 10:25:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a77-v6sm34114050pfj.38.2018.08.01.10.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 10:25:50 -0700 (PDT)
Date:   Wed, 1 Aug 2018 10:25:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ivid Suvarna <ivid.suvarna@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@redhat.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, linux-arm-msm@vger.kernel.org
Subject: Re: arm64: pstore: printk causing hang during boot in __memcpy_toio
 with pstore enabled
Message-ID: <20180801172549.GA16774@roeck-us.net>
References: <CABXF_AAVhadw=+rtcD-L06-zBTMb3v7C2QqvN-6vcx5w2T0sYg@mail.gmail.com>
 <8ab731b4-2929-e92e-6536-35096ee66baa@roeck-us.net>
 <CABXF_ACKZXe+3J76bfyr4V1qdyhJ--cTekSXSVPksKOTxCBfTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXF_ACKZXe+3J76bfyr4V1qdyhJ--cTekSXSVPksKOTxCBfTQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 10:46:06PM +0530, Ivid Suvarna wrote:
> On Wed, Aug 1, 2018 at 6:49 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 08/01/2018 05:35 AM, Ivid Suvarna wrote:
> >>
> >> Hi,
> >>
> >> When pstore is enabled and a *pr_info(any printk) in
> >> __memcpy_toio(arch/arm64/kernel/io.c)* is added, kernel wont boot and
> >> just hangs.
> >>
> >> The path where __memcpy_toio is called is below:
> >>
> >> ->persistent_ram_update
> >>    -> memcpy_toio
> >>      -> __memcpy_toio
> >>
> >> I tried with trace_printk and kernel boots fine. I understand that
> >> printk has overhead, but is this expected when we use some printk
> >> statement in __memcpy_toio?
> >>
> >
> > I think the problem may be that the printk() output is copied to pstore.
> > Since pstore calls memcpy_toio(), you get a nice recursion if you add a
> > printk() call to it.
> >
> 
> Is there any solution to this other than not adding printk :p

Well, disabling pstore would help. You could also use a trace function,
as you already found out, or you could use gdb for debugging. Since
this is obviously a debug image, you should be willing to accept some
limitations/restrictions.

Guenter
