Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C50C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD9520866
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D67Wh/6C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zaxpz2nh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD9520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeKFOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:55:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43216 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeKFOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:55:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EFDC860ADD; Tue,  6 Nov 2018 05:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541482315;
        bh=Zz17MESrRTFKfiSvnQj/8XeZ/iRXMkMk3sv6/91+8ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D67Wh/6CDzZIr+vFHkDCNsx+e1DzHWDh9UJ35GJpUf/lupJoryyhXMYJz+MwdSTyA
         me6hAvPbyxCz6Si/0TtlW++6xDuglnN8N87BJwVrnwGpF1TqRlPVVxN7nFbYMjsslF
         GvYvhqycq0BOISC280f9ER0SfXsg6XJLz+njdmmI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 49C67601D7;
        Tue,  6 Nov 2018 05:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541482313;
        bh=Zz17MESrRTFKfiSvnQj/8XeZ/iRXMkMk3sv6/91+8ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zaxpz2nh8GxIUDF2vbGo3oyYccT7XFzS54/F1IKNPzzaKs+rVNd1mHtPOp+iu/Yym
         PASR+raa/wS4fQmB1GAbKzEnlRvZ/LUfcJWH2zQcmNrLgyW0H3ZgBEER6xbl1X98fO
         Rnr8erau0S11d4li7PXjXU6VJuIFKbM/zujdgCJY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 06 Nov 2018 11:01:53 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        dan.j.williams@intel.com, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <20181105134400.f6f52f4db0f8d6a21446476e@linux-foundation.org>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
 <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
 <20181010173334.GL5873@dhcp22.suse.cz>
 <a2d576a5fc82cdf54fc89409686e58f5@codeaurora.org>
 <20181011075503.GQ5873@dhcp22.suse.cz>
 <20181018191825.fcad6e28f32a3686f201acdf@linux-foundation.org>
 <20181019080755.GK18839@dhcp22.suse.cz>
 <c6289fada694462ed708174f9a1f3b6c@codeaurora.org>
 <beaa1acf7423da7ee0f9bbc4cee2d14a@codeaurora.org>
 <20181105134400.f6f52f4db0f8d6a21446476e@linux-foundation.org>
Message-ID: <7bfdb58cbd896a9f62c7dc2219ea1c08@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-06 03:14, Andrew Morton wrote:
> On Mon, 05 Nov 2018 15:12:27 +0530 Arun KS <arunks@codeaurora.org> 
> wrote:
> 
>> On 2018-10-22 16:03, Arun KS wrote:
>> > On 2018-10-19 13:37, Michal Hocko wrote:
>> >> On Thu 18-10-18 19:18:25, Andrew Morton wrote:
>> >> [...]
>> >>> So this patch needs more work, yes?
>> >>
>> >> Yes, I've talked to Arun (he is offline until next week) offlist and
>> >> he
>> >> will play with this some more.
>> >
>> > Converted totalhigh_pages, totalram_pages and zone->managed_page to
>> > atomic and tested hot add. Latency is not effected with this change.
>> > Will send out a separate patch on top of this one.
>> Hello Andrew/Michal,
>> 
>> Will this be going in subsequent -rcs?
> 
> I thought were awaiting a new version?  "Will send out a separate patch
> on top of this one"?

Sorry for confusion. I sent out an incremental patch converting counters 
to atomics.

https://patchwork.kernel.org/cover/10657217/


> 
> I do think a resend would be useful, please.  Ensure the changelog is
> updated to capture the above info and any other worthy issues which
> arose during review.

Will do that.

Regards,
Arun
