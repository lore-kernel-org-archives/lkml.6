Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA913C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA61A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696108;
	bh=55vruckghI0CNrQauCA5Hmtstl5hw2rz4MEea9FQwQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KEOTfP27uv7jZojg5xWG/Nk5MxH2i29nD1xEphNW/LFdsnVHc+/qVaUZeupCeNnk8
	 vXnncYGXfzBFtrJIZjg+9QUoaLqGu4hNK7m4Po4WxS+F2Rxswrwra7qEAzO7e73N+5
	 weuUiw9blX+GrCj9wipU5Ar7627OiPDqhC4bcW5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfA1RVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbfA1RVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:21:44 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1756720989;
        Mon, 28 Jan 2019 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548696104;
        bh=55vruckghI0CNrQauCA5Hmtstl5hw2rz4MEea9FQwQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xBnE4dNWmkBgj0Sy0xp8qpSBlZGOHnYp2xUpKBHcWVxbhr+mgOmJfhpmBMUAzPKUM
         99wHAbEvcIwU1WrrODmHgUyGKzVlTCmyjsep/FLIe8qzgBtKG/hX8g9mlRlJcVlMFi
         lyjoAxO3m0dpc/vthPffNlbOfKvwNQhvkmXWleBA=
Date:   Mon, 28 Jan 2019 12:21:43 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 094/258] nfp: add locking around representor
 changes
Message-ID: <20190128172143.GE3973@sasha-vm>
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-94-sashal@kernel.org>
 <20190128082825.4c8394a6@cakuba.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190128082825.4c8394a6@cakuba.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 08:28:25AM -0800, Jakub Kicinski wrote:
>On Mon, 28 Jan 2019 10:56:40 -0500, Sasha Levin wrote:
>> From: Jakub Kicinski <jakub.kicinski@netronome.com>
>>
>> [ Upstream commit 71844fac1ed459024dd2a448d63d5b28b8c87daa ]
>>
>> Up until now we never needed to keep a networking locks around
>> representors accesses, we only accessed them when device was
>> reconfigured (under nfp pf->lock) or on fast path (under RCU).
>> Now we want to be able to iterate over all representors during
>> notifications, so make sure representor assignment is done
>> under RTNL lock.
>>
>> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Reviewed-by: John Hurley <john.hurley@netronome.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Hi Sasha!
>
>There is no need for backporting this unless 51a6588e8c08 ("nfp: add
>offloads on representors") is also back ported (which is a feature).

I'll drop it. Thanks for the heads-up.

--
Thanks,
Sasha
