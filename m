Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B0CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6C2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695520;
	bh=R/uENPLsGmwLG5uKoCoJUo6f63CE5U4vcMns/OQG2f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZQkXIwrNsd5WiyEEXO6Jo/LJAc5w0xSGEDTlHutJ9AztBrGijcT1vM4clSdALDiWZ
	 9h0BwoOzj4enrIrncoZq8+ooSJGpMB66qNwS7GABnC6kRW+XID7VI+6nOozZTjKLLo
	 RLJ8Ewz/tPq7c5h1SSgY4VcgxVCop1+5c1DQpozA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbfA1RL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbfA1RL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:11:56 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2DE2175B;
        Mon, 28 Jan 2019 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548695515;
        bh=R/uENPLsGmwLG5uKoCoJUo6f63CE5U4vcMns/OQG2f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcoGj3EkFdveeDWe35d8exPvbGKME1vCy2J3CPUaWoN+MK8TsqU6myQUxRoaNjFOk
         Qq0LvGODgXrRaHa1sTn+LOXCxeg/bGI7y8oKXIcz2TW4M0uLF3yae2XErLz0vC0l3i
         VtnKuRNKLclbA8QGbDeLb8u8vqUM2gPkuq5kMgH8=
Date:   Mon, 28 Jan 2019 12:11:54 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 028/304] srcu: Prevent __call_srcu() counter
 wrap with read-side critical section
Message-ID: <20190128171154.GA3973@sasha-vm>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-28-sashal@kernel.org>
 <20190128162318.GS4240@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190128162318.GS4240@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 08:23:18AM -0800, Paul E. McKenney wrote:
>On Mon, Jan 28, 2019 at 10:39:05AM -0500, Sasha Levin wrote:
>> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>>
>> [ Upstream commit 0607ba8403c4cdb253f8c5200ecf654dfb7790cc ]
>>
>> Ever since cdf7abc4610a ("srcu: Allow use of Tiny/Tree SRCU from
>> both process and interrupt context"), it has been permissible
>> to use SRCU read-side critical sections in interrupt context.
>> This allows __call_srcu() to use SRCU read-side critical sections to
>> prevent a new SRCU grace period from ending before the call to either
>> srcu_funnel_gp_start() or srcu_funnel_exp_start completes, thus preventing
>> SRCU grace-period counter overflow during that time.
>>
>> Note that this does not permit removal of the counter-wrap checks in
>> srcu_gp_end().  These check are necessary to handle the case where
>> a given CPU does not interact at all with SRCU for an extended time
>> period.
>>
>> This commit therefore adds an SRCU read-side critical section to
>> __call_srcu() in order to prevent grace period counter wrap during
>> the funnel-locking process.
>>
>> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Hello, Sasha,
>
>I recommend -against- backporting this one.  It is a theoretical bug
>that requires rather long preemption, so the risk of backporting likely
>greatly exceeeds the risk of the bug actually happening, especially on
>64-bit systems.

I'll drop it, thanks Paul!

--
Thanks,
Sasha
