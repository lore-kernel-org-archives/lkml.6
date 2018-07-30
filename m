Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386516256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4563C20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z9KQJpFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4563C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbeG3TaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:30:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47770 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeG3TaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jijkqbke+KlulpxFU8QfzKm63i1lUXpS4B7IzqkuFCY=; b=z9KQJpFaFByINWmDqFflNs49p4
        1nzJq4A93NJbv5qHKVaT8uBW77Xr4/stgbn3xw50XHAElz0w+HWPyZT4CMHKc8BrCX92tTkWfk6oU
        tt7C8p4KUh4122DKWbKT9sYGrbMMzAa1CSK4nZrSSdd60tuano1z5NBl1nCMe/gZAm2napCVS0Tsq
        fdFC0H7ecOuglOTsBNihKm4MyH8MtRYREi71dklG708YW7rvg+tHSmYuY22MBaJcA2Pcq0A3C35hJ
        THoDwvS85M27t2I1xGjiBxH/Xl+YCcPRQB4JHEBtBXmOkDEJ1ttrMwf4VjYYZztpluI27J0twTxOX
        X21V0zqw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkCMy-0008KU-57; Mon, 30 Jul 2018 17:54:08 +0000
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory, and
 IO v2
To:     Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180727220123.GB18879@amd> <20180730154035.GC4567@cmpxchg.org>
 <20180730173940.GB881@amd>
 <20180730175120.GJ1206094@devbig004.ftw2.facebook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfc3c810-8918-add4-b818-8b9c294f5ea4@infradead.org>
Date:   Mon, 30 Jul 2018 10:54:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730175120.GJ1206094@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 10:51 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 30, 2018 at 07:39:40PM +0200, Pavel Machek wrote:
>>> I'd rather have the internal config symbol match the naming scheme in
>>> the code, where psi is a shorter, unique token as copmared to e.g.
>>> pressure, press, prsr, etc.
>>
>> I'd do "pressure", really. Yes, psi is shorter, but I'd say that
>> length is not really important there.
> 
> This is an extreme bikeshedding without any relevance.  You can make
> suggestions but please lay it to the rest.  There isn't any general
> consensus against the current name and you're just trying to push your
> favorite name without proper justifications after contributing nothing
> to the project.  Please stop.
> 
> Thanks.

I'd say he's trying to make something that is readable and easier to
understand for users.

Thanks.


-- 
~Randy
