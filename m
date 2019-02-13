Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB854C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3561218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550085916;
	bh=wp88X0n7T+oW/4jJeVP1LwxYcQsnaad4aiDkPEIVESg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fngwMZ8tJvDehpd81fKwEIR1GqeNhlEt+jUfnPxm9hizsMngK46NEnpGGp9oRqNvw
	 1TNyA74Q0T7EXhefNP6fc3uMli+MgASGM0eZOZ/9a9mWIz1AU5jN8j2ZZxt2G/j9zj
	 SNHxsbMV+qesf4oGhEgcwpw5LXMI+o1U6myX61TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394367AbfBMTZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfBMTZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:25:15 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36A0218D3;
        Wed, 13 Feb 2019 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550085914;
        bh=wp88X0n7T+oW/4jJeVP1LwxYcQsnaad4aiDkPEIVESg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7fF38VAjYGoMh9ztuD8OYJI6pSNlaXDcvqGOtmZqcF3KmSGICCypWjmmZdbbJ6ds
         XMdtNXg2N7BuRK1HanA9BA+TyPVn5PJG619hBDoDDL6Bs+qhygWzSM2qwbIONM4LiD
         Q2CYn/XxDXun2Fv3qnsJm1ly4G+iCSh1eZzGhw5Q=
Date:   Wed, 13 Feb 2019 14:25:12 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20190213192512.GH69686@sasha-vm>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
 <20190213091803.GA2308@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190213091803.GA2308@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:18:03AM +0100, Greg KH wrote:
>On Wed, Feb 13, 2019 at 11:01:25AM +0200, Amir Goldstein wrote:
>> Best effort testing in timely manner is good, but a good way to
>> improve confidence in stable kernel releases is a publicly
>> available list of tests that the release went through.
>
>We have that, you aren't noticing them...

This is one of the biggest things I want to address: there is a
disconnect between the stable kernel testing story and the tests the fs/
and mm/ folks expect to see here.

On one had, the stable kernel folks see these kernels go through entire
suites of testing by multiple individuals and organizations, receiving
way more coverage than any of Linus's releases.

On the other hand, things like LTP and selftests tend to barely scratch
the surface of our mm/ and fs/ code, and the maintainers of these
subsystems do not see LTP-like suites as something that adds significant
value and ignore them. Instead, they have a (convoluted) set of testing
they do with different tools and configurations that qualifies their
code as being "tested".

So really, it sounds like a low hanging fruit: we don't really need to
write much more testing code code nor do we have to refactor existing
test suites. We just need to make sure the right tests are running on
stable kernels. I really want to clarify what each subsystem sees as
"sufficient" (and have that documented somewhere).

--
Thanks,
Sasha
