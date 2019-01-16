Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF82C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122AF205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394317AbfAPQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:48:24 -0500
Received: from foss.arm.com ([217.140.101.70]:52890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733068AbfAPQsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:48:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7696A78;
        Wed, 16 Jan 2019 08:48:23 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E5093F5AF;
        Wed, 16 Jan 2019 08:48:21 -0800 (PST)
Date:   Wed, 16 Jan 2019 16:48:18 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Kassey <kassey1216@gmail.com>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org, kassey@126.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org
Subject: Re: arm64: copy_from_user access the last page of ddr has problem on
 4.14 kernel
Message-ID: <20190116164817.GG1910@brain-police>
References: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwPUowmzZ2BNi-RmJm3=ENrZ5sxPf1SeT+b9A9iHHSCUQQAUw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm due to get on a long flight shortly, so I've added LAKML and a few
others to CC]

On Wed, Jan 16, 2019 at 11:25:15AM +0800, Kassey wrote:
> Hi, Will and team:
> 
>    we met a issue when copy_from_user to access the last page of DDR
> on 4.14 kenrel, below is the detail steps,
>    can you help to suggest if there is know fix or debug something ?
> 
> 1. we mmap ( in userspace)  a region of  phy address that is not
> continous  but include the last page of ddr
> 
>   for example our ddr end is 0x200000000
>   the last page is fall in below addr:
>   0x1fffff000  to  0x200000000
> 
> 2. we using copy_from_user to copy these mmap address to kernel buffer
> 
> 3. and we find everytime when trying to copy_from_user  the last page
> in phy of ddr,
>     the dst kernel buffer is looks overwrite by some same patten start
> with "mmap" in this last page ,but the src in the last page of ddr is
> still correct.
> 
> is there any know issue for copy_from_user to accces the last page of
> phy ddr mmaped by userspace  ?

Not that I'm aware of. Are you using defconfig and can you reproduce the
problem with mainline (e.g. v5.0-rc2)? What exactly do you mean by:

  "the fst kernel buffer is looks overwrite by some same patten start with
  "mmap""?

Does the copy_from_user fail (what does it return?) or does it succeed but
the data copied appears to be junk? Is it deterministic? Could you share an
example of what the corrupted data looks like, please?

Cheers,

Will
