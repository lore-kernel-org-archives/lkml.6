Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5267F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJZzsP0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5267F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeK3VXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:23:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeK3VXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:23:34 -0500
Received: from localhost (84.94.36.10.cable.012.net.il [84.94.36.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A0F20863;
        Fri, 30 Nov 2018 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543572885;
        bh=kyp/RmuGkzHtyEb6sDDYkHyYZypxPEO2JH0cwYComVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJZzsP0F5mkIT+KnpzbExJcDVd+aDpdIQoieD66rwZ7ruwr0++7Go1Hpaw3ujb+0v
         9TGTDUxdqIT8RDBK613Tz/yg32daHb2pVXWFnhsF3807bZtb3NHQrc4yNmRU1pViQn
         alDW+jY8JI6xPkf/mMGdxrHP+Ji9feUnkgwk43mI=
Date:   Fri, 30 Nov 2018 05:14:41 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181130101441.GA213156@sasha-vm>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181130082203.GA26830@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:22:03AM +0100, Greg KH wrote:
>On Fri, Nov 30, 2018 at 09:40:19AM +1100, Dave Chinner wrote:
>> I stopped my tests at 5 billion ops yesterday (i.e. 20 billion ops
>> aggregate) to focus on testing the copy_file_range() changes, but
>> Darrick's tests are still ongoing and have passed 40 billion ops in
>> aggregate over the past few days.
>>
>> The reason we are running these so long is that we've seen fsx data
>> corruption failures after 12+ hours of runtime and hundreds of
>> millions of ops. Hence the testing for backported fixes will need to
>> replicate these test runs across multiple configurations for
>> multiple days before we have any confidence that we've actually
>> fixed the data corruptions and not introduced any new ones.
>>
>> If you pull only a small subset of the fixes, the fsx will still
>> fail and we have no real way of actually verifying that there have
>> been no regression introduced by the backport.  IOWs, there's a
>> /massive/ amount of QA needed for ensuring that these backports work
>> correctly.
>>
>> Right now the XFS developers don't have the time or resources
>> available to validate stable backports are correct and regression
>> fre because we are focussed on ensuring the upstream fixes we've
>> already made (and are still writing) are solid and reliable.
>
>Ok, that's fine, so users of XFS should wait until the 4.20 release
>before relying on it?  :)

It's getting to the point that with the amount of known issues with XFS
on LTS kernels it makes sense to mark it as CONFIG_BROKEN.

>I understand your reluctance to want to backport anything, but it really
>feels like you are not even allowing for fixes that are "obviously
>right" to be backported either, even after they pass testing.  Which
>isn't ok for your users.

Do the XFS maintainers expect users to always use the latest upstream
kernel?

--
Thanks,
Sasha
