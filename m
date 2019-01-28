Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F232BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B187320989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696078;
	bh=bXgKCgwKbKmk+XNWmCclBpfYVLrKk1rzJpQSrsPICn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zVHgwWSZwDPbfxUj5pcY9CyeP0H42PtYM2O5vxjrle1FpEPAYoYce2wz4Tds/hRxT
	 XCvE1jUoEm1ca5mGrs88bk/vWXbCClkVfTnN/lI/+qEqdEFHRjUEDjJAw0bkLKFY3K
	 r1FPrpSfJq0l7XA3OObe4LdkDQ6CxBwKY9VKtIJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfA1RVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbfA1RVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:21:13 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4BD20989;
        Mon, 28 Jan 2019 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548696073;
        bh=bXgKCgwKbKmk+XNWmCclBpfYVLrKk1rzJpQSrsPICn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzLAAaIAcaA455IGq4UwZPxgFof+Du94uedoqpeDyYLP2b52CxI/fbL8wX9azfHkM
         6T9XBbXrB3mRN5yv/0cE+zhdELNagxTS1E02eL8TbumVrpbE4z2Nei2b0+0gs/SPNc
         CxAit443i7mJfKbywPfTRteKSxzMurc9kWnyue7w=
Date:   Mon, 28 Jan 2019 12:21:11 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH AUTOSEL 4.20 175/304] ARM: mmp: fix timer_init calls
Message-ID: <20190128172111.GD3973@sasha-vm>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-175-sashal@kernel.org>
 <CAK8P3a3z8tOxz=Rem6N7m_0_8OaU9Sxf7yViZJP5fmYGeaxUvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a3z8tOxz=Rem6N7m_0_8OaU9Sxf7yViZJP5fmYGeaxUvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:41:55PM +0100, Arnd Bergmann wrote:
>On Mon, Jan 28, 2019 at 4:52 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> [ Upstream commit 12d3a30db4a3b3df5fbadf5974b9cf50544a9950 ]
>>
>> The change to passing the timer frequency as a function argument
>> was a good idea, but caused a build failure for one user that
>> was missed in the update:
>>
>> arch/arm/mach-mmp/time.c: In function 'mmp_dt_init_timer':
>> arch/arm/mach-mmp/time.c:242:2: error: implicit declaration of function 'timer_init'; did you mean 'hrtimer_init'? [-Werror=implicit-function-declaration]
>>
>> Change that as well to fix the build error, and rename the
>> function to put it into a proper namespace and make it clearer
>> what is actually going on.
>>
>> I saw that the high 6500000 HZ frequency was previously only
>> set with CONFIG_MMP2, but is now also used with MMP (pxa910),
>> so I'm changing that back here. Please make sure that the
>> frequencies are all correct now.
>>
>> Fixes: f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>I did not think that Lubumir's patch was meant for stable,
>but as you've picked that one already we clearly
>want mine as well, so this is good for all stable kernels.

I can drop both if you'd prefer that (they're both in this series).

--
Thanks,
Sasha
