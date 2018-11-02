Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D272EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9712B2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO5JXMMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9712B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeKCBJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeKCBJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:09:08 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27CD20657;
        Fri,  2 Nov 2018 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541174493;
        bh=fOyl0oaxqYmvNxHTm2OzvPAlu4VK2wP0N6wscGp8XWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO5JXMMkcke4nfwHMWWc8gZ30ELyMCcA7zHXb/vJKKfPRlSjUK7CH/+Gt+CqDlnWh
         VK97N6+bfcpx+ZOq9gKhHIB+8rrQHB3pJNMFuFbeUcbmnrLdMpT/IMfeUa4PpP6jtE
         5JcLr607IQQUWKLjrTBEnb77FFva1EJir2ijzKyg=
Date:   Fri, 2 Nov 2018 12:01:22 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Message-ID: <20181102160122.GH194472@sasha-vm>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:45:42AM +0000, Dexuan Cui wrote:
>> From: Roman Gushchin <guro@fb.com>
>> Sent: Thursday, November 1, 2018 17:58
>>
>> On Fri, Nov 02, 2018 at 12:16:02AM +0000, Dexuan Cui wrote:
>> Hello, Dexuan!
>>
>> A couple of issues has been revealed recently, here are fixes
>> (hashes are from the next tree):
>>
>> 5f4b04528b5f mm: don't reclaim inodes with many attached pages
>> 5a03b371ad6a mm: handle no memcg case in memcg_kmem_charge()
>> properly
>>
>> These two patches should be added to the serie.
>
>Thanks for the new info!
>
>> Re stable backporting, I'd really wait for some time. Memory reclaim is a
>> quite complex and fragile area, so even if patches are correct by themselves,
>> they can easily cause a regression by revealing some other issues (as it was
>> with the inode reclaim case).
>
>I totally agree. I'm now just wondering if there is any temporary workaround,
>even if that means we have to run the kernel with some features disabled or
>with a suboptimal performance?

I'm not sure what workload you're seeing it on, but if you could merge
these 7 patches and see that it solves the problem you're seeing and
doesn't cause any regressions it'll be a useful test for the rest of us.

--
Thanks,
Sasha
