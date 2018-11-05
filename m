Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0DBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD302087A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OgXsWJ3W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XVNNqV7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD302087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeKETBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:01:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKETBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:01:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E9E2A60B7F; Mon,  5 Nov 2018 09:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541410948;
        bh=ZuW+AaqfCLSRA9Kf5pYu6vAZLi5tpItZrhXkNqTYJ60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OgXsWJ3We4v8zF1L97ZLIi+asYLUDSapbX74yRJWRbEKNj4kHaWE3nfq6AomRoXa4
         fT0j6oZ2w2JL7ma6j1aNwO5niLNKQVXiOjnx/obXeWnDBX/wBX4THM1yzwV9txPsxv
         L6eucLxVBmxzEUitKwki9S5ne/etaXK206g74M6A=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 502416074C;
        Mon,  5 Nov 2018 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541410947;
        bh=ZuW+AaqfCLSRA9Kf5pYu6vAZLi5tpItZrhXkNqTYJ60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XVNNqV7Ac/zE+BjjGFQXU8duKHFpHehzIBd4lLcQ3yaRtkIMyst6nrp6EMk1Z5MBc
         mWThZIdbPhqy7Bpjo7z0MfIy8raKGqoljE9GyLgZ6dcq8tKbUsFEPSKuABBnGoX06k
         sjgyxAEDkdLtlAb7Kb398BvbOq2sXLTDXy5c1dJw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Nov 2018 15:12:27 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
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
In-Reply-To: <c6289fada694462ed708174f9a1f3b6c@codeaurora.org>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
 <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
 <20181010173334.GL5873@dhcp22.suse.cz>
 <a2d576a5fc82cdf54fc89409686e58f5@codeaurora.org>
 <20181011075503.GQ5873@dhcp22.suse.cz>
 <20181018191825.fcad6e28f32a3686f201acdf@linux-foundation.org>
 <20181019080755.GK18839@dhcp22.suse.cz>
 <c6289fada694462ed708174f9a1f3b6c@codeaurora.org>
Message-ID: <beaa1acf7423da7ee0f9bbc4cee2d14a@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-22 16:03, Arun KS wrote:
> On 2018-10-19 13:37, Michal Hocko wrote:
>> On Thu 18-10-18 19:18:25, Andrew Morton wrote:
>> [...]
>>> So this patch needs more work, yes?
>> 
>> Yes, I've talked to Arun (he is offline until next week) offlist and 
>> he
>> will play with this some more.
> 
> Converted totalhigh_pages, totalram_pages and zone->managed_page to
> atomic and tested hot add. Latency is not effected with this change.
> Will send out a separate patch on top of this one.
Hello Andrew/Michal,

Will this be going in subsequent -rcs?

Regards,
Arun

