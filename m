Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AD1C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639C020831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMPq6iOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639C020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeKBXEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBXEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:04:06 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0B32081F;
        Fri,  2 Nov 2018 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541167012;
        bh=BHdmFKzkqwAWsW5p7LSDTiP/ADfuKgJ3w/Fr3deJf0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMPq6iOZ6QqFnAmcOHW9eZC3AdgKfx7o7Vr6AfqrjnMreV3VqrF0T/1EHHEp7lVV/
         fZXCNufaVtNRrmYufeqW2AWuqoZUl9t3GbjBV2VjAeqDdsqWVGgsyniEBvSzmyko7D
         ozR4QGPWwX+eNkd/uOhFlwerO7c06ow5eJDj4tQc=
Date:   Fri, 2 Nov 2018 09:56:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <rong.a.chen@intel.com>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirsky <luto@kernel.org>
Subject: Re: [PATCH 4.9 23/35] x86/mm: Expand static page table for fixmap
 space
Message-ID: <20181102135645.GE194472@sasha-vm>
References: <20181011152520.174949126@linuxfoundation.org>
 <20181011152521.098965859@linuxfoundation.org>
 <5d134c818828ddecf1ab9768b126c15c267c099e.camel@decadent.org.uk>
 <20181102033813.mxauelisrform7ah@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181102033813.mxauelisrform7ah@shbuild888>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:38:13AM +0800, Feng Tang wrote:
>Hi Ben,
>
>On Thu, Nov 01, 2018 at 10:25:43PM +0000, Ben Hutchings wrote:
>> On Thu, 2018-10-11 at 17:35 +0200, Greg Kroah-Hartman wrote:
>> > 4.9-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Feng Tang <feng.tang@intel.com>
>> >
>> > commit 05ab1d8a4b36ee912b7087c6da127439ed0a903e upstream.
>>
>> This backport is incorrect.  The part that updated __startup_64() in
>> arch/x86/kernel/head64.c was dropped, presumably because that function
>> doesn't exist in 4.9.  However that seems to be an essential of the
>> fix.  In 4.9 the startup_64 routine in arch/x86/kernel/head_64.S would
>> need to be changed instead.
>>
>> I also found that this introduces new boot-time warnings on some
>> systems if CONFIG_DEBUG_WX is enabled.
>>
>> So, unless someone provides fixes for those issues, I think this should
>> be reverted for the 4.9 branch.
>
>Thanks for the catch, I'm fine with the revert for now.

I've queued the revert, thank you.

--
Thanks,
Sasha
