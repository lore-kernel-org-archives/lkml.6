Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25EBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96B72083E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBTrCyGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96B72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJQWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbeJQWgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:36:36 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165A12083E;
        Wed, 17 Oct 2018 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539787236;
        bh=skwZqTpQh9KnWmfZtQwc61ZdE7dbsk1tNjTwjtFiZYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBTrCyGxVZEBqR+IQX0FZu7LdJkyKrhoWWI+DS051/JumxOjSm14FhJm0wsaoDXe6
         C8jnGeyczcCZJRacrK/kqDnmhhLJgOmcCpFJ56pbsyLMAXRLpPyeZ6KCkgqAuNCsWM
         Pkt/+WRaFW8H2KMZNhuPHFrgtRxSXtJRY6dRmrWY=
Date:   Wed, 17 Oct 2018 10:40:34 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Message-ID: <20181017144034.GB135013@sasha-vm>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170522.303317746@linuxfoundation.org>
 <DM5PR2101MB10138BCFD40D703FEE14EC35CAFE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
 <20181017074629.GD25537@kroah.com>
 <DM5PR2101MB1013C986EEC151F096313D17CAFF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
 <20181017131717.GA10130@kroah.com>
 <DM5PR2101MB101355087924D6C8442BDA4ACAFF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
 <20181017142621.GB366@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181017142621.GB366@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 04:26:21PM +0200, Greg Kroah-Hartman wrote:
>On Wed, Oct 17, 2018 at 02:15:30PM +0000, Haiyang Zhang wrote:
>> The VF NIC needs to be paired with synthetic NIC on HyperV  --  to do that we
>> use MAC address matching before the patch #A. But a non VF NIC can also
>> have the same MAC, which shouldn't be paired with synthetic NIC. So a better
>> method is implemented by #A to use VF serial number for matching.
>>
>> But, #A has a bug, which causes matching to fail. Patch #B fixed it by extracting
>> the VF serial number correctly from slot info.
>
>My question is, "what bug is patch #A fixing"?  Somehow things have been
>working just fine for people without this, right?  Remember, new
>features should not be backported to stable kernels if at all possible.

The current mechanism works fine most of the time, the problem is that
once in a while we'd see collisions between the synthetic device MAC
address and a different network device such as a bond device or just a
regular non-VF network device.

So while in most cases assuming that MAC is unique and looking up
devices based on it works, there's no guarantee that it's unique so
this assumption isn't true and things break.

This is why it (usually) works now, but still has a bug that needs
fixing.

If that makes sense, I'll requeue it when the fixes have soaked upstream
for a few weeks.

--
Thanks,
Sasha
