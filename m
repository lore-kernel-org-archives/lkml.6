Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87208C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9D221934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550195675;
	bh=sZctXZ3iMiiEOmbwB5XNUGJOkyU0Oiyr3JpZ8jmmH64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bhFOBHZ4kwG/wh8MvnfITXt5yCAnO+5yKegFg6phriK2PpQ3NAw+1maX/fN6KQAaH
	 TaJU4TSd4rW2Wn4VhDbsflA3nuN1TepPmeykSjud+uFrE146i+RJde8S8Afmfxqufa
	 7ETGx8u9AFbGmi7CYBlSi84rBaSsoDqbF+UfHLk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfBOByd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbfBOByd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:54:33 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65CCE21934;
        Fri, 15 Feb 2019 01:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550195672;
        bh=sZctXZ3iMiiEOmbwB5XNUGJOkyU0Oiyr3JpZ8jmmH64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iasA3uimkw2BKBa0vUjVOcH8Ht4jU1iqzUR0bxh0McGc6p0cg1H8Poe1C2yABwLL2
         AjVijJx2kQwdFMXMWcejbawrtqrszaznEKw1FIIuZlkshyLaziS1l4TnHzZ1fMSwWp
         yDIRZRZlaTvTmpMGUpMeV/c21kGboZ+5+49QaTng=
Date:   Thu, 14 Feb 2019 20:54:31 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Message-ID: <20190215015431.GK69686@sasha-vm>
References: <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190131151958.GT3973@sasha-vm>
 <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <20190131174707.GA2055@ubu-Virtual-Machine>
 <PU1P153MB0169227534F832C2DAEC02B4BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190202200735.GA2637@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190202200735.GA2637@ubu-Virtual-Machine>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 03:07:35PM -0500, Kimberly Brown wrote:
>On Fri, Feb 01, 2019 at 06:24:24PM +0000, Dexuan Cui wrote:
>> > From: Kimberly Brown <kimbrownkd@gmail.com>
>> > Sent: Thursday, January 31, 2019 9:47 AM
>> > ...
>> > 2) Prevent a deadlock that can occur between the proposed mutex_lock()
>> > call in the vmbus_chan_attr_show() function and the sysfs/kernfs functions.
>> Hi Kim,
>> Can you please share more details about the deadlock?
>> It's unclear to me how the deadlock happens.
>>
>
>Hi Dexuan,
>
>I encountered the deadlock by:
>1) Adding a call to msleep() before acquiring the mutex in
>vmbus_chan_attr_show()
>2) Opening a hv_netvsc subchannel's sysfs file
>3) Removing hv_netvsc while the sysfs file is opening

Dexuan, any objections to pulling this fix in?

--
Thanks,
Sasha
