Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD0BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8963121738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699162;
	bh=Oy2jPIu/a/Vo7qzFlpCDeeWMsi4Ipf7nWsh5hIriZhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1qyO/FBMWv2RDuQlyYcEtvVHQ3mF0/fFkMiegp8ElHfnhaTry855Lt2Jxskmeiurq
	 yqAluaqg3YW91sJUnlpVJzcH4nNyw11ByJYqa59bKnmf6G9dqC+y5Ub9aFQQ7Zykfy
	 gzOl6AX57c+QAToqXvWtN/qKeowSLHdqHHSz4BCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfA1SMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:12:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfA1SMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:12:40 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C3A2147A;
        Mon, 28 Jan 2019 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548699159;
        bh=Oy2jPIu/a/Vo7qzFlpCDeeWMsi4Ipf7nWsh5hIriZhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmpVcY6wfhSgzhgR1e5Yl3JKjx0fL6mAo7jgAsOz9BvaAT4wHzWF2lby+H917rEPq
         N6zhaBr8LtiGUuooBEbRdrMHn5O2fOBLxyiQl9vrrZCvBB3Q+N5eGQL5aiobQffSsO
         y/5Tt9tLXh9eNcW0hdhpaCG55W+099vf6paCXqrs=
Date:   Mon, 28 Jan 2019 13:12:38 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 174/258] livepatch: check kzalloc return
 values
Message-ID: <20190128181238.GH3973@sasha-vm>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-174-sashal@kernel.org>
 <alpine.LSU.2.21.1901281826230.9332@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1901281826230.9332@pobox.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 06:28:14PM +0100, Miroslav Benes wrote:
>On Mon, 28 Jan 2019, Sasha Levin wrote:
>
>> From: Nicholas Mc Guire <hofrat@osadl.org>
>>
>> [ Upstream commit 5f30b2e823484ce6a79f2b59901b6351c15effa6 ]
>>
>> kzalloc() return should always be checked - notably in example code
>> where this may be seen as reference. On failure of allocation in
>> livepatch_fix1_dummy_alloc() respectively dummy_alloc() previous
>> allocation is freed (thanks to Petr Mladek <pmladek@suse.com> for
>> catching this) and NULL returned.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>> Fixes: 439e7271dc2b ("livepatch: introduce shadow variable API")
>> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>> Acked-by: Miroslav Benes <mbenes@suse.cz>
>> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Hi Sasha,
>
>I am not sure what stable policy is, but the patch is for samples/
>directory and I do not think it is something which should necessarily go
>to stable. It is your call though.

The thing with samples/ is that (I'm hopefull that) the code that lives
in there is being used as a basis for userspace code and is copy&pasted
shamelessly.

So on one hand, yes, samples/ isn't exactly critical code, but on the
other hand it's also very unlikely to cause a regression, so I've been
treating it similarily to tools/testing/.

If anyone disagrees I'd be happy to discuss it.

--
Thanks,
Sasha
