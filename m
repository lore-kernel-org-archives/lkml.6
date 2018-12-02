Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54EFC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9319B20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrjaxcMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9319B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbeLBUdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbeLBUdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:33:04 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2AAD20851;
        Sun,  2 Dec 2018 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543782782;
        bh=iFeEdHNWc+emyflgbMSpQuDUGw1sxlo6V8Yghqa8/+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrjaxcMr54LWXdS0qoery+T9rnXPJqsZNGjkvPV7VEVzL5ZufKalpmSoVbIZp1rES
         t9zNuVDHxoqLnMR35oHVcuMgukoJ6CVI/uC4O2icaKUS1/8Zbh5frW3mwypl5a0eJF
         ovn5zudN6TrRciUvij9XhRXKkKxc++I/0+8sFZWc=
Date:   Sun, 2 Dec 2018 15:32:56 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH 3.18 14/83] ARM: make lookup_processor_type() non-__init
Message-ID: <20181202203256.GB235790@sasha-vm>
References: <20181129140138.002176596@linuxfoundation.org>
 <20181129140138.869602566@linuxfoundation.org>
 <20181129142817.GW30658@n2100.armlinux.org.uk>
 <20181130151554.GA29005@kroah.com>
 <20181130151843.GB29005@kroah.com>
 <20181202151732.GH221015@sasha-vm>
 <20181202161535.GA27166@kroah.com>
 <20181202162532.GK221015@sasha-vm>
 <20181202201150.GC3932@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181202201150.GC3932@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 09:11:50PM +0100, Greg Kroah-Hartman wrote:
>On Sun, Dec 02, 2018 at 11:25:32AM -0500, Sasha Levin wrote:
>> On Sun, Dec 02, 2018 at 05:15:35PM +0100, Greg Kroah-Hartman wrote:
>> > On Sun, Dec 02, 2018 at 10:17:32AM -0500, Sasha Levin wrote:
>> > > On Fri, Nov 30, 2018 at 04:18:43PM +0100, Greg Kroah-Hartman wrote:
>> > > > On Fri, Nov 30, 2018 at 04:15:54PM +0100, Greg Kroah-Hartman wrote:
>> > > > > On Thu, Nov 29, 2018 at 02:28:18PM +0000, Russell King - ARM Linux wrote:
>> > > > > > Hi,
>> > > > > >
>> > > > > > As I've already fed back to Sascha about this, this patch on its own
>> > > > > > does not fix anything, and is not a stable kernel candidate without
>> > > > > > a patch that makes use of it (iow, the spectre fixes.)  It is a
>> > > > > > preparatory patch for mainline commit 383fb3ee8024.
>> > > > > >
>> > > > > > Every commit in:
>> > > > > >
>> > > > > > $ git rev-list v4.16..383fb3ee8024
>> > > > > >
>> > > > > > are the ARM spectre fixes, which are being back-ported by David Long.
>> > > > > >
>> > > > > > Please do not cherry-pick commits from within this series for _any_
>> > > > > > stable kernel, but please wait for David to send you the back-ported
>> > > > > > patches.
>> > > > >
>> > > > > Ugh, ok, that's a bunch here.
>> > > >
>> > > > Ok, not that bad, only 4:
>> > > > 	383fb3ee8024 ("ARM: spectre-v2: per-CPU vtables to work around big.Little systems")
>> > > > 	e209950fdd06 ("ARM: add PROC_VTABLE and PROC_TABLE macros")
>> > > > 	945aceb1db88 ("ARM: clean up per-processor check_bugs method call")
>> > > > 	899a42f83667 ("ARM: make lookup_processor_type() non-__init")
>> > > >
>> > > > I'll go drop them all from the trees now.  Turns out for 4.14 one of
>> > > > these patches broke the build anyway.  Sasha, how did that past your
>> > > > builder tests?
>> > >
>> > > Because it builds :)
>> >
>> > Really?  It broke Guenter's builds...
>>
>> I might be missing something, but Guenter's reply to this -rc thread
>> (https://www.spinics.net/lists/stable/msg272294.html) was:
>>
>> > For v3.18.127-83-gc3953c334bf6:
>> >
>> > Build results:
>> > 	total: 160 pass: 160 fail: 0
>> > Qemu test results:
>> > 	total: 223 pass: 223 fail: 0
>
>The breakage happened on the 4.14 tree with one of the patches above,
>which caused me to do a -rc2.

Oh, I see :(

I suspect that I have a bug somewhere in my scripts that deal with
removing patches from the middle of git branches, I'll try a few
testcases tomorrow.

--
Thanks,
Sasha
