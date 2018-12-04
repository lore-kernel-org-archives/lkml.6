Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E52C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886FD214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX/I1R5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886FD214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLDIMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:12:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeLDIMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:12:45 -0500
Received: from localhost (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9487208A3;
        Tue,  4 Dec 2018 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543911164;
        bh=DUlLIcvguGHqIePA2vjrq9jc2vMepwIoKQECDIBtENI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sX/I1R5AsHmXvW5g+7ypKH9coBmfBvxoYabXaD9V9y6lx8pLLmoH5m56d1tutq6ao
         qQZDYOLwcHZyC5cPnLNOSY26obRt0pAqxKwjJx1zgj7tmIkXzQRGtEOaTxCvxAxGCE
         64vewM3LKFdbZZOmEYRj8Y5D986CBwz/M/5M0KgY=
Date:   Tue, 4 Dec 2018 03:12:40 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181204081237.GO235790@sasha-vm>
References: <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
 <20181202232302.GT19305@dastard>
 <20181203092241.GC235790@sasha-vm>
 <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:22:46PM +0159, Thomas Backlund wrote:
>Den 2018-12-03 kl. 11:22, skrev Sasha Levin:
>
>>
>> This is a case where theory collides with the real world. Yes, our QA is
>> lacking, but we don't have the option of not doing the current process.
>> If we stop backporting until a future data where our QA problem is
>> solved we'll end up with what we had before: users stuck on ancient
>> kernels without a way to upgrade.
>>
>
>Sorry, but you seem to be living in a different "real world"...
>
>People stay on "ancient kernels" that "just works" instead of updating
>to a newer one that "hopefully/maybe/... works"

If users are stuck at older kernels and refuse to update then there's
not much I can do about it. They are knowingly staying on kernels with
known issues and will end up paying a much bigger price later to update.

>> With the current model we're aware that bugs sneak through, but we try
>> to deal with it by both improving our QA, and encouraging users to do
>> their own extensive QA. If we encourage users to update frequently we
>> can keep improving our process and the quality of kernels will keep
>> getting better.
>
>And here you want to turn/force users into QA ... good luck with that.

Yes, users are expected to test their workloads with new kernels - I'm
not sure why this is a surprise to anyone. Isn't it true for every other
piece of software?

I invite you to read Jon's great summary on LWN of a related session
that happened during the maintainer's summit:
https://lwn.net/Articles/769253/ . The conclusion reached was very
similar.

>In reality they wont "update frequently", instead they will stop
>updating when they have something that works... and start ignoring
>updates as they expect something "to break as usual" as they actually
>need to get some real work done too...

Again, this model was proven to be bad in the past, and if users keep
following it then they're knowingly shooting themselves in the foot.

>
>>
>> We simply can't go back to the "enterprise distro" days.
>>
>
>Maybe so, but we should atleast get back to having "stable" or
>"longterm" actually mean something again...
>
>Or what does it say when distros starts thinking about ignoring
>(and some already do) stable/longterm trees because there is
>_way_ too much questionable changes coming through, even overriding
>maintainers to the point where they basically state "we dont care
>about monitoring stable trees anymore, as they add whatever they want
>anyway"...

I'm assuming you mean "enterprise distros" here, as most of the
community distros I'm aware of are tracking stable trees.

Enterprise distros are a mix of everything: on one hand they would
refuse most stable patches because they don't have any demand from
customers to fix those bugs, but on the other hand they will update
drivers and subsystems as a whole to create these frankenstein kernels
that are very difficult to support.

When your kernel is driven by paying customer demands it's difficult to
argue for the technical merits of your process.

>And pretending that every fix is important enough to backport,
>and saying if you dont take everything you have an "unsecure" kernel
>wont help, as reality has shown from time to time that backports
>can/will open up a new issue instead for no good reason
>
>Wich for distros starts to mean, switch back to selectively taking fixes
>for _known_ security issues are considered way better choice

That was my exact thinking 2 years ago (see my stable-security project:
https://lwn.net/Articles/683335/). I even had a back-and-forth with Greg
on LKML when I was trying to argue your point: "Lets only take security
fixes because no one cares about the other crap".

If you're interested, I'd be happy to explain further why this was a
complete flop.

--
Thanks,
Sasha
