Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34014C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE7C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ktn2PMtK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BzO82hIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE7C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJIRKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:10:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:10:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4126860C4F; Tue,  9 Oct 2018 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539078855;
        bh=RB4YXzcsN5e/uv8WK6ub12iNf0wTmfEWvTQHD4CuHNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ktn2PMtKl7JkFU7YqLy0ul+LLLrGtvBCFyiq6HyPQxBb6n8sxpqvvVSc4VN6NRgvJ
         n0+1vkBBcP+Zv9Ic1TFgODY3x7GMCJhJvo9VeiyfpjHtpy8NADPJNyyBrP+oNOIQnO
         gY81XhbJ4tR5GHelihGBOeGMj07mni1br9m7rYfg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C7399600E6;
        Tue,  9 Oct 2018 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539078853;
        bh=RB4YXzcsN5e/uv8WK6ub12iNf0wTmfEWvTQHD4CuHNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BzO82hIf0qWr5XuapMFp+7OQI54UJHMyxFFJYuH73zDVrWJ2t8ILhAEp89JyRW5mj
         OuQdjT99Cqy5YGqlcnp4KlxreIiuke3ihZb+PWHESaze1X9uemYRn8C68DpJPO6ZBo
         YXtJ0t7aO+vQlEns/5V2B8DlK1QxG2qZPuMTOOs8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Oct 2018 15:24:13 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com, gregkh@linuxfoundation.org,
        osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <20181009092938.GH8528@dhcp22.suse.cz>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <20181009092938.GH8528@dhcp22.suse.cz>
Message-ID: <9b56e156b911e943eba3a1daa0a1cb31@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-09 14:59, Michal Hocko wrote:
> On Fri 05-10-18 13:40:05, Arun KS wrote:
>> When free pages are done with higher order, time spend on
>> coalescing pages by buddy allocator can be reduced. With
>> section size of 256MB, hot add latency of a single section
>> shows improvement from 50-60 ms to less than 1 ms, hence
>> improving the hot add latency by 60%. Modify external
>> providers of online callback to align with the change.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks for your patience with all the resubmission.

Hello Michal,

I got the below email few days back. Do I still need to resubmit the 
patch? or is it already on the way to merge?

Regards,
Arun

The patch titled
      Subject: mm/page_alloc.c: memory hotplug: free pages as higher 
order
has been added to the -mm tree.  Its filename is
      memory_hotplug-free-pages-as-higher-order.patch

This patch should soon appear at
     
http://ozlabs.org/~akpm/mmots/broken-out/memory_hotplug-free-pages-as-higher-order.patch
and later at
     
http://ozlabs.org/~akpm/mmotm/broken-out/memory_hotplug-free-pages-as-higher-order.patch

Before you just go and hit "reply", please:
    a) Consider who else should be cc'ed
    b) Prefer to cc a suitable mailing list as well
    c) Ideally: find the original patch on the mailing list and do a
       reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when 
testing your code ***

The -mm tree is included into linux-next and is updated
there every 3-4 working days

