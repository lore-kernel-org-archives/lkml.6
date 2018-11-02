Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500EC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469DF2146D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0GoC7LwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469DF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeKBJvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725722AbeKBJvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:51:06 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9417620870;
        Fri,  2 Nov 2018 00:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541119551;
        bh=eGWdLigeZDOtgij6n8Z79KodKMOgiDR0Zmkl0A+dXVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0GoC7LwElt/6dKT3upfQstavbYToFT9Qquv2/L5cLos6sFrVXyLWizxBwQcERQ0un
         iiw+jZG+dR2EgzBJXuylfN6iZSvJ4JASGgPBl8xwvAshDXeBCmyXc0GOSKFX5gryQt
         Z5htbRISw7ArxHI+XjzeFJ/8utaNPVjAQIofhLWc=
Date:   Thu, 1 Nov 2018 20:45:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Message-ID: <20181102004550.GD194472@sasha-vm>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:16:02AM +0000, Dexuan Cui wrote:
>Hi all,
>When debugging a memory leak issue (https://github.com/coreos/bugs/issues/2516)
>with v4.14.11-coreos, we noticed the same issue may have been fixed recently by
>Roman in the latest mainline (i.e. Linus's master branch) according to comment #7 of
>https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1792349, which lists these
>patches (I'm not sure if the 5-patch list is complete):
>
>010cb21d4ede math64: prevent double calculation of DIV64_U64_ROUND_UP() arguments
>f77d7a05670d mm: don't miss the last page because of round-off error
>d18bf0af683e mm: drain memcg stocks on css offlining
>71cd51b2e1ca mm: rework memcg kernel stack accounting
>f3a2fccbce15 mm: slowly shrink slabs with a relatively small number of objects
>
>Obviously at least some of the fixes are also needed in the longterm kernels like v4.14.y,
>but none of the 5 patches has the "Cc: stable@vger.kernel.org" tag? I'm wondering if
>these patches will be backported to the longterm kernels. BTW, the patches are not
>in v4.19, but I suppose they will be in v4.19.1-rc1?

There was an issue with this series:
https://lkml.org/lkml/2018/10/23/586, so it's waiting on a fix to be
properly tested.

--
Thanks,
Sasha
