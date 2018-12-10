Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5078A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544482906;
	bh=9kqY+F/oQkLwQllZIemzQu7Xm+h3PIfAzRLVDKU+FqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a8hA4SPSYnCHwr3Zb4GGB5HIRbp9GuC8STivPBzvNg7dDPHz1Lqgks6SYLQUuGhIu
	 crOXIl0Fl5sMD3Lkq32UZgPoI9BEiT6DU9OYMF1Xjl7j00PRDzoFxjqa8nBeHq6a83
	 SH05Y4PaBZ/t9XFGXNO2wYBffT+IyrbgSTl0ZbTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5078A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeLJXBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbeLJXBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:01:44 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1338820821;
        Mon, 10 Dec 2018 23:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544482904;
        bh=9kqY+F/oQkLwQllZIemzQu7Xm+h3PIfAzRLVDKU+FqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3x7RC9lEHSVIbjb9UCpJ7s+zRLxHKjJF3O/IykurORgpg3AlQ5NSCeYcyDDwbjfd
         wzgmksRLxrNYi8Mx5Xb70SDH4Byxle9rSt35w6uUyMvWjT21nzro77llK7pLt+dKSd
         b7dSHnAQkPyv6gQPhVRsasJ7wCEp/IpF6eTPm9t0=
Date:   Mon, 10 Dec 2018 18:01:42 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [patch] futex: Cure exit race
Message-ID: <20181210230142.GG97256@sasha-vm>
References: <20181210152311.986181245@linutronix.de>
 <20181210210920.75EBD20672@mail.kernel.org>
 <alpine.DEB.2.21.1812102215100.1667@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812102215100.1667@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:16:03PM +0100, Thomas Gleixner wrote:
>On Mon, 10 Dec 2018, Sasha Levin wrote:
>> This commit has been processed because it contains a -stable tag.
>> The stable tag indicates that it's relevant for the following trees: all
>>
>> The bot has tested the following trees: v4.19.8, v4.14.87, v4.9.144, v4.4.166, v3.18.128,
>>
>> v4.19.8: Build OK!
>> v4.14.87: Build OK!
>> v4.9.144: Build failed! Errors:
>>     kernel/futex.c:1186:28: error: ???uaddr??? undeclared (first use in this function)
>>
>> v4.4.166: Build failed! Errors:
>>     kernel/futex.c:1181:28: error: ???uaddr??? undeclared (first use in this function)
>>
>> v3.18.128: Build failed! Errors:
>>     kernel/futex.c:1103:28: error: ???uaddr??? undeclared (first use in this function)
>>
>> How should we proceed with this patch?
>
>I'll look into that once this is sorted... I so love these rotten kernels.

It seems we need:

	734009e96d19 ("futex: Change locking rules")

Which isn't trivial to backport.

--
Thanks,
Sasha
