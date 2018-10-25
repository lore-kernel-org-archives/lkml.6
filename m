Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B488ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B142083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOxZz8N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B142083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJZGTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbeJZGTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:19:15 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D742F2075D;
        Thu, 25 Oct 2018 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540503892;
        bh=rRvv4UOXbX/8dKHiRNw4hn94FGXXeSI5iKjeuDLRB2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOxZz8N7IVtEQKymzQfPgm3JjbzOYZMxT7+bGl9iXG0pdBRJ7RqLnaX4n+5C8QYW5
         C7e/vUy5PK9oONXFBnhvuzprwVtJwt33L7WQktHB0l1Tr+97/PH89yesh5/EmfBuzF
         BUMGOcZJHfZpt2V+pDQ4Q2KktEY9xMkKMF9/oiCk=
Date:   Thu, 25 Oct 2018 17:44:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Message-ID: <20181025214449.GA2015@sasha-vm>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
 <20181025092352.GP18839@dhcp22.suse.cz>
 <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
 <20181025202014.GA216405@sasha-vm>
 <20181025202707.GL25444@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181025202707.GL25444@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 01:27:07PM -0700, Matthew Wilcox wrote:
>On Thu, Oct 25, 2018 at 04:20:14PM -0400, Sasha Levin wrote:
>> On Thu, Oct 25, 2018 at 12:44:42PM -0700, Andrew Morton wrote:
>> > Yup.  Sasha, can you please take care of this?
>>
>> Sure, I'll revert it from current stable trees.
>>
>> Should 172b06c32b94 and this commit be backported once Roman confirms
>> the issue is fixed? As far as I understand 172b06c32b94 addressed an
>> issue FB were seeing in their fleet and needed to be fixed.
>
>I'm not sure I see "FB sees an issue in their fleet" and "needs to be
>fixed in stable kernels" as related.  FB's workload is different from
>most people's workloads and FB has a large and highly-skilled team of
>kernel engineers.  Obviously I want this problem fixed in mainline,
>but I don't know that most people benefit from having it fixed in stable.

I don't want to make backporting decisions based on how big a certain
company's kernel team is. I only mentioned FB explicitly to suggest that
this issue is seen on real-life scenarios rather than on synthetic tests
or code review.

So yes, let's not run to fix it just because it's FB but also let's not
ignore it because FB has a world-class kernel team. This should be done
purely based on how likely this patch will regress stable kernels vs the
severity of the bug it fixes.

--
Thanks,
Sasha
