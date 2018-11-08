Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7292AECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4518D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4518D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeKICAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:00:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46866 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeKICAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:00:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so21875072wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pRJEuZpsP/isRWp0fK+g9nX6y2RlIuO7JNJ59TU/ORU=;
        b=OQedu5E3WxH15cExN01z9yLYqNE/NV9SUkUn3qvSF0seVyQDo4V5dONlqr3UVJQ+n1
         dHLOGBqhg4n0ZAalWFTnPX+MSVYRS9Lw4GwXbQ02vuMCbhsqmK/2JZ+DR+JgRjA+X3GU
         Ml4Qd8Fm9HGxUutvIhL7qS0Mh4+LIpaG/aBygeDS4z9K7cTD9DAatx2S3gGlL8UARHvV
         xcPaBqK0dQGpTQqkShnvhmbrTcs9V6/kAk9MKUDUeT16x1cnLHEemvzRa86QLBchqjtX
         FittJzV+WXmy0HAHwDlfTt6OP6HQcAoLvt4nd2yCP/pc9xNRx7JRTDysUd/KThKsf2zw
         2IBQ==
X-Gm-Message-State: AGRZ1gLLffbJr3EbWrDxJcAUAfhts9YFraN+W5KUpdg4Z08fluFEp0eK
        ZdVMV5/TTSvh51JpnQAoXYq8XA==
X-Google-Smtp-Source: AJdET5ekGrcgL9KmPpXAouiJA0Xe5LLTNyRp1En0dcWJAv4a9eKgzxvZSoLAygyJ3RUPOWc1aweGCQ==
X-Received: by 2002:adf:fb12:: with SMTP id c18-v6mr4868721wrr.200.1541694232737;
        Thu, 08 Nov 2018 08:23:52 -0800 (PST)
Received: from localhost.localdomain ([151.15.207.85])
        by smtp.gmail.com with ESMTPSA id 74-v6sm5637931wmi.23.2018.11.08.08.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 08:23:51 -0800 (PST)
Date:   Thu, 8 Nov 2018 17:23:48 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman9394@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 4/5] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20181108162348.GF18091@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-5-juri.lelli@redhat.com>
 <20181003154230.4b8792fb@gandalf.local.home>
 <20181004090401.GB12774@localhost.localdomain>
 <16587a21-ed6e-809d-78a8-5f76d1787665@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16587a21-ed6e-809d-78a8-5f76d1787665@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/11/18 10:49, Waiman Long wrote:
> On 10/04/2018 05:04 AM, Juri Lelli wrote:

[...]

> > +/**
> > + * cpuset_read_only_lock - Grab the callback_lock from cpuset subsystem.
> > + *
> > + * Description: As described in full details the comment above cpuset_mutex
> > + * and callback_lock definitions, holding callback_lock gives the holder
> > + * read-only access to cpusets. Even though it might look counter-intuitive
> > + * (as callback_lock is a spinlock), in fact a task must hold both
> > + * callback_lock _and_ cpuset_mutex to modify cpusets (write access).
> > + */
> > +void cpuset_read_only_lock(void)
> > +{
> > +	raw_spin_lock(&callback_lock);
> > +}
> > +
> > +/**
> > + * cpuset_read_only_unlock - Release the callback_lock from cpuset subsystem.
> > + */
> > +void cpuset_read_only_unlock(void)
> > +{
> > +	raw_spin_unlock(&callback_lock);
> > +}
> > +
> 
> Maybe you can drop the "_only" part to be consistent with the rwlock
> APIs (read_lock/write_lock).

I called it this way because it looked more descriptive of which kind of
guarantee the holder gets using these. Can change of course, what others
think?

Thanks for reviewing!

Best,

- Juri
