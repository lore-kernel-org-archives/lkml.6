Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977B821738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZCQ69BOf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bgwK6zku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfAILGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:06:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbfAILGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:06:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 516C56063A; Wed,  9 Jan 2019 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547031997;
        bh=OZbgaGFt9Xz4LT/DKSijRLnaugoQQXKpGMFVf1zvLBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZCQ69BOfZY+1Fy9P7Bcc1qW5GDYX3OX8FIrZ7AXn64Ts/DMqms5JBNsk/w9TEXY7q
         t50qxw4BBq5vgyk194OiO5jQCHQi/aO9qADfvSFn5z+tEeya4RK7DYhYNSfEVT+r4l
         k9uN858k1uA8k+M+3mZZ33cP/xIq1Mv4Wm4Pd3EU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8FD1C60300;
        Wed,  9 Jan 2019 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547031996;
        bh=OZbgaGFt9Xz4LT/DKSijRLnaugoQQXKpGMFVf1zvLBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bgwK6zkuyNp0rPUNso1nfFpesdzAL3E0cTGrNuMhQZu+3HpIzmRb5koB2vjPm7t4S
         f82MsdyZAST5fRRBflho3YzouADk7oIK6wo5gk6mbG2BWp6DzOoa/bkw7bmKY4W5lC
         hVLWGBB4HddM4xKtIEETEX1ep4F8Yi9tUF0IWJhs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 16:36:36 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
In-Reply-To: <20190109105754.GR31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
 <20190108181352.GI31793@dhcp22.suse.cz>
 <bfb543b6e343c21c3e263a110f234e08@codeaurora.org>
 <20190109073718.GM31793@dhcp22.suse.cz>
 <a053bd9b93e71baae042cdfc3432f945@codeaurora.org>
 <20190109084031.GN31793@dhcp22.suse.cz>
 <e005e71b125b9b8ddee668d1df9ad5ec@codeaurora.org>
 <20190109105754.GR31793@dhcp22.suse.cz>
Message-ID: <2efb06e91d9af48bf3d1d38bd50e0458@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-09 16:27, Michal Hocko wrote:
> On Wed 09-01-19 16:12:48, Arun KS wrote:
> [...]
>> It will be called once per online of a section and the arg value is 
>> always
>> set to 0 while entering online_pages_range.
> 
> You rare right that this will be the case in the most simple scenario.
> But the point is that the callback can be called several times from
> walk_system_ram_range and then your current code wouldn't work 
> properly.

Thanks. Will use +=

Regards,
Arun
