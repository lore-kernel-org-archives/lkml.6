Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B070C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC8F20989
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544636617;
	bh=52O48gEOnrB1lIP08qeejaSzlFY+t34zCzgnG9ZJknY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vX3F9SRH9aWknOrQ0yZBAGfXKGdtQXdPb4pH3tIZf5usjwia2Cmc4mKxKkYzjfE8f
	 1UgSv5hw900DMH09QDjW0I+wSl+hxqukeJrvGjgzLDN6Ks5YOS/pIXwlII9/pK+2/g
	 b8x6W1OEJlws6o6BWOjba5LzfnUQwoYrZ79GGdhE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC8F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbeLLRng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbeLLRnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:43:35 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9D62080F;
        Wed, 12 Dec 2018 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544636615;
        bh=52O48gEOnrB1lIP08qeejaSzlFY+t34zCzgnG9ZJknY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AtfnjVmxMccVNB1InbF16AU6lZwskYBRF/RqsyvI7lKh719SgKr46g06LEnP4Jp3B
         gTpvObhb0KXxSG3MCtY583fwbwaWjFIzJE5atvNmwxR7cn/Z9j/1lqdI82A0zeYeXY
         FNNEHFkN22fsjvMDPMoWju3pT1ojmGy5RYGMaRqY=
Date:   Wed, 12 Dec 2018 12:43:33 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, Daniel Wang <wonderfly@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181212174333.GC2746@sasha-vm>
References: <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
 <20181212081034.GA32687@jagdpanzerIV>
 <20181212133603.yyu2zvw7g454zdqd@pathway.suse.cz>
 <20181212135939.GA10170@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181212135939.GA10170@tigerII.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:59:39PM +0900, Sergey Senozhatsky wrote:
>On (12/12/18 14:36), Petr Mladek wrote:
>> > OK, really didn't know that! I wasn't Cc-ed on that AUTOSEL email,
>> > and I wasn't Cc-ed on this whole discussion and found it purely
>> > accidentally while browsing linux-mm list.
>>
>> I am sorry that I did not CC you. There were so many people in CC.
>> I expected that all people mentioned in the related commit message
>> were included by default.
>
>No worries! I'm not blaming anyone.
>
>> > So if you are willing to backport this set to -stable, then I wouldn't
>> > mind, probably would be more correct if we don't advertise this as a
>> > "panic() deadlock fix"
>>
>> This should not be a problem. I guess that stable does not modify
>> the original commit messages unless there is a change.
>
>Agreed.

I'll be happy to add anything you want to the commit message. Do you
have a blurb you want to use?

--
Thanks,
Sasha
