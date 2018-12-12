Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3332AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDA22086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544651549;
	bh=B+scBadklJg7pskNURcPk2vwhRgv+xnMrkB6bENzD04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TJUL/B5cHrkB2zklpBAGq2eBBLmbQwC4QaeUQ0M2AxVvZCmFOfa0QNLzSy71Riyc/
	 0YPEBmPS3+c/9nOfoY/BicCxrxopwkChl5xgUnQry4nYOHKLfLw4H5hQHFG3YiQ2bb
	 EK6h0tqijF8HI9syijhQKvo+zbOw1lCVwmFxhDM4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDA22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeLLVw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeLLVw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:52:27 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE7320849;
        Wed, 12 Dec 2018 21:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544651546;
        bh=B+scBadklJg7pskNURcPk2vwhRgv+xnMrkB6bENzD04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=If4rk0jhw/GMqyZYrydYlRdL+zAoDqyGhZEFgHtI2IMaVI8uJe/d25zJri+2Bwl0z
         FNjaXIlty92fGddUxxYGM0FB++leCEnqDo/G4CdLZxC8zucR53/KdKf6lvFxNwi9Nq
         au6jMGSWnny87CXlsJST8fbhgi8W+68z8uYptUS8=
Date:   Wed, 12 Dec 2018 16:52:25 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Daniel Wang <wonderfly@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20181212215225.GE2746@sasha-vm>
References: <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
 <20181212081034.GA32687@jagdpanzerIV>
 <20181212133603.yyu2zvw7g454zdqd@pathway.suse.cz>
 <20181212135939.GA10170@tigerII.localdomain>
 <20181212174333.GC2746@sasha-vm>
 <CAJmjG2_zey77QxMzq997ALkD56d0UtHmGjF4dhq=TbEc2gox5A@mail.gmail.com>
 <20181212214337.GD2746@sasha-vm>
 <CAJmjG2_C0YRtVmNh2sg4JqhJJ11LMmbRHqwADxyO9CGh9ixQbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJmjG2_C0YRtVmNh2sg4JqhJJ11LMmbRHqwADxyO9CGh9ixQbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 01:49:25PM -0800, Daniel Wang wrote:
>Thanks for the clarification. So I guess I don't need to start another
>thread for it? What are the next steps?

Nothing here, I'll queue it once Sergey or Petr clarify if they wanted
additional information in the -stable commit message.

--
Thanks,
Sasha

