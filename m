Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A435C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B192087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHeLl8st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B192087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJJNk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:40:26 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36228 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJJNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:40:25 -0400
Received: by mail-wm1-f43.google.com with SMTP id a8-v6so4325428wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 23:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rpIQ9xMrfbWBySMz58EKaosktwyPMKzs93EOFxkBYlQ=;
        b=oHeLl8st+6/TJ+jQhy6+vuoNA6kMllT7/ejYQDtlrbKBA3+6RVqiO6U8HY3jlA0F8W
         YQGW28wITH6EBT0iAB4d6atrzpM3GidQdSXA2+r6P5EZWYqFhQWe3BB9iC1yd5sy81eH
         +BBd3bbginkZEEfxlix5CzwuK4oO9D6ws/+LKbyZ/KjMA1JSaQrxJN0RcGLI0IPTghuH
         rJV6H9/e0rgu0ci2wzF36J444UM4OlsFJtlPURSwmBg5Vy2xYD7lISfpHlaiehlkcY1w
         LbIofcrPwg0RvfhbxGrIb1NNdJXVnk7f8z32aDRwGQe4auF2m5InXuh7uAzajmAR3ArG
         eMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rpIQ9xMrfbWBySMz58EKaosktwyPMKzs93EOFxkBYlQ=;
        b=cxhNOdx4bxjoW/4cVSH0nNsdFTHObJU4ysA8NNqRhCP1NBSAoT/DNgQf7ovl7VxpaV
         ymbHcYjZ1Us/h31yWJQvqIX65jGyQHCFNQcp3S8txoXZRCNPBHwvKiawZu81yHjAjclW
         BtEN7Shy/6q93KSnmK+RNqZqP9Kdeu7EO/OBeptbQNa8RJIE7v0+o2KI5vDI2q74xbFv
         zFcxqb4JCYh+P6QtWq53Dqp3YNf+aW12hrLd5vF2KmWYhnj/SLEerv8XOXHsx1B9WIWo
         O1Yx10PDQUtcZIryvA0/NZJi+rnikypAZbVSF/D39YNDew1I/44E6WA2seHX/HlnZlop
         Gk8w==
X-Gm-Message-State: ABuFfoj8398NeEhLGdqtyUgesDOzl0cZr87v+GWJ3QL6OJDht7PnitRx
        64fmrf5pAqSXU20/VoPRwno=
X-Google-Smtp-Source: ACcGV60tN2iSp4ip2lVrPB0qGe3sbHX89ENMybn4Yt0cP4LUBlLtP/33fDlLmcJjn28ZD6nOVFspbw==
X-Received: by 2002:a1c:3383:: with SMTP id z125-v6mr4187612wmz.56.1539152388302;
        Tue, 09 Oct 2018 23:19:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l4-v6sm26119522wrb.92.2018.10.09.23.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:19:47 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:19:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Anthony LaTorre <tlatorre9@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: perf report segfault
Message-ID: <20181010061945.GB37224@gmail.com>
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava>
 <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
 <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
 <20181009214158.GB31206@krava>
 <CAO49af+5TaWrdYeM3XyHoti0obH--0txq9_a6_9ZPMuB-J=hjg@mail.gmail.com>
 <20181009222004.GA19295@krava>
 <f5ce21f8-6c80-b6a0-8b8a-e7a90c23a98c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ce21f8-6c80-b6a0-8b8a-e7a90c23a98c@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sandipan Das <sandipan@linux.ibm.com> wrote:

> Hi Jiri,
> 
> Yes, this happens when entry->map is NULL. While your fix seems correct, the
> following commit from Milian Wolff had already addressed this. I think this
> was pulled in with one of Arnaldo's recent perf/urgent updates.
> 
> ff4ce2885af8 ("perf report: Don't try to map ip to invalid map")

Ok, I'll send the pending perf/urgent tooling bits to Greg/Linus later today,
to make sure this is fixed upstream as well.

Thanks,

	Ingo
