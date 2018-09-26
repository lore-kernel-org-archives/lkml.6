Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28784C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E3D214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oVuYic0W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d4uApI+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E3D214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeIZRJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:09:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeIZRJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:09:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33CC060B7F; Wed, 26 Sep 2018 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537959429;
        bh=urXs/vuWlgUoV8sTCZnJNBxRcUZRM5qK76HzwwxSMQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVuYic0Wtj1YB8VvSG7cX8jmKSlysWVetMX3avmIvXjfBsMVWJ6+ENFUMT7lJNo8y
         Ea/BBGRXsABGZb0k1T90xM1oTs0Nel8QzOIXfRGYv6Pf7EXYU8GsTXY00hzS4q+oU0
         mpt6BU7lIA8pV5y+okDkghE9kg0oPaby/ty01Ejk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 20385605FD;
        Wed, 26 Sep 2018 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537959428;
        bh=urXs/vuWlgUoV8sTCZnJNBxRcUZRM5qK76HzwwxSMQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d4uApI+DrktoTjyrHJq/SnAZWOGmu5SXG5ZnJFI/e8GDSlOX7qYnAfCFGYT1wOkSa
         iV9lRvX4O6fuvhXJVhA110sR54Lk8p6/RlNbMvUQXeOyWJyGdN2VtJoLVkoamLyte2
         m1nPyu1rcMauYXubdUnEpg5sEwkAk0CSifUlPxdY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Sep 2018 16:27:08 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        iamjoonsoo.kim@lge.com, osalvador@suse.de, malat@debian.org,
        yasu.isimatu@gmail.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v2] memory_hotplug: Free pages as higher order
In-Reply-To: <20180925181826.GW18685@dhcp22.suse.cz>
References: <1537854158-9766-1-git-send-email-arunks@codeaurora.org>
 <ccdbaf76-cbdd-759e-c6de-c5b738f156e9@suse.cz>
 <20180925181826.GW18685@dhcp22.suse.cz>
Message-ID: <bdba4200b69f560af36967e2d23dde8f@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-25 23:48, Michal Hocko wrote:
> On Tue 25-09-18 11:59:09, Vlastimil Babka wrote:
> [...]
>> This seems like almost complete copy of __free_pages_boot_core(), 
>> could
>> you do some code reuse instead? I think Michal Hocko also suggested 
>> that.
> 
> Yes, please try to reuse as much code as possible
Sure, Will address in next spin.

Regards,
Arun
