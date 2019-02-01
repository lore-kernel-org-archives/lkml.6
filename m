Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37997C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047C021872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549030410;
	bh=I8akS79tUx9oVa9CgYZTlPzpJGHTpteDbCFbQN9+eAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IENgg8mXxw0WgFUNf64GmDTM81dtGK0E2KRwTa8PaocY0Z2NY2SLTlGwPi6w3xJPx
	 aLWJXHaO8dLtheQ9YmHEGYyRFH0O2KQDn9kBz6ur5F/f/qM0LCNpHjtUDtiZZGMi2J
	 A9mnyzMzRVPEMhgO+E2CPjOsSNskS/J/JwX+pjgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfBAON2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:13:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfBAON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:13:28 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9A82086C;
        Fri,  1 Feb 2019 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549030407;
        bh=I8akS79tUx9oVa9CgYZTlPzpJGHTpteDbCFbQN9+eAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOwqcVd/ooJBchD6+3HpIi1+2Q0AvpzSNZK72vinb2xJ0odP/TKWUF9xfz0lNBYa1
         em8H3OxIcnO2GhjeQNbYvpjar7T0+GPnBISQEawliQugNCxAtnSiANmi3MjHh/Ny25
         W0Q1JbF00fMS1vtkDWlrVeM8Se5doFASFY5e8bWg=
Date:   Fri, 1 Feb 2019 09:13:25 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Message-ID: <20190201141325.GV3973@sasha-vm>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190131151958.GT3973@sasha-vm>
 <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <20190131174707.GA2055@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190131174707.GA2055@ubu-Virtual-Machine>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:47:07PM -0500, Kimberly Brown wrote:
>On Thu, Jan 31, 2019 at 04:45:35PM +0000, Michael Kelley wrote:
>> From: Sasha Levin <sashal@kernel.org> Sent: Thursday, January 31, 2019 7:20 AM
>> >
>> > I've queued this one for hyper-fixes, thanks all!
>> >
>>
>> Actually, please hold off on queuing this one.  In a conversation I had yesterday with Kim, they had identified a deadlock.  Kim was going to be looking at some revisions to avoid the deadlock.
>>
>> Kim -- please confirm.
>>
>> Michael
>
>This is correct. I need to send a v2 of this patch which addresses two
>issues:

Now dropped, thanks for the heads-up.

--
Thanks,
Sasha
