Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93B920855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93B920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeKIUOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:14:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33514 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeKIUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:14:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so1364895wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIZ0c4ixWdnPoPAaGgY0DHkj4kdDvn+oJD5dkziU3Jo=;
        b=TiMT6kZINC9upFZbmLyNsk9NH7DLNifYUi6tH13DEPjTyGzaDfsf+1fzAyl3r4HqmA
         o8Tc5v4G/G7ebGMZ+tO8yT9uNgzo6/PgNDJ1cZQU9xjfjpG/SnOyPWEZnVNkq30C9M1F
         t17At2t09szw9ibppIEcZ0EIzUHdHwky03NzC1WNTUQjs6eMNUQaY0CFCLDmGAKRqhtB
         adSt0Ec2iB2bI2PggbyjsqpaHsKF+rWi7KaKG8NpXORP8rVoPzc9EUgQvZ+kkE8mItu9
         dsesxRZ/iZyuNL2a7N0FFTBQpRNUUDCLU6RjKl4KLmjpqJgQn1yPYrjE4rELM8oQlkNc
         RWjw==
X-Gm-Message-State: AGRZ1gLVLxtzAi50P0S+4U8Uyyf+WOkNLFa5cwu0rP1SQOIUKezNoStQ
        Up9s3NE20nuuLUlsUBq9VMcvpA==
X-Google-Smtp-Source: AJdET5cpapxmmFzB5rM96+F+PJ3iepXHbjlGVKO4syw8YhT3acrQhXMRt4HQAttu5RUO/BSTpKLKZw==
X-Received: by 2002:adf:ef85:: with SMTP id d5-v6mr7209603wro.163.1541759661486;
        Fri, 09 Nov 2018 02:34:21 -0800 (PST)
Received: from localhost.localdomain ([151.15.207.85])
        by smtp.gmail.com with ESMTPSA id i7-v6sm1773298wmd.41.2018.11.09.02.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 02:34:20 -0800 (PST)
Date:   Fri, 9 Nov 2018 11:34:17 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        rostedt@goodmis.org
Subject: Re: [PATCH v5 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20181109103417.GB9471@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-4-juri.lelli@redhat.com>
 <20180925143416.GD25664@localhost.localdomain>
 <20181107155330.GA2509588@devbig004.ftw2.facebook.com>
 <20181107163841.GA18091@localhost.localdomain>
 <95aeb057-d63f-a6b8-cf0e-cdff80e79021@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95aeb057-d63f-a6b8-cf0e-cdff80e79021@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/18 14:11, Waiman Long wrote:
> On 11/07/2018 11:38 AM, Juri Lelli wrote:
> > Hi,
> >
> > On 07/11/18 07:53, Tejun Heo wrote:
> >> Hello,
> >>
> >> On Tue, Sep 25, 2018 at 04:34:16PM +0200, Juri Lelli wrote:
> >>> It would be great if you could please have a look at the proposed change
> >>> below (and the rest of the set of course :-).
> >> Yeah, looks good to me.  Please feel free to add
> >>
> >>  Acked-by: Tejun Heo <tj@kernel.org>
> > Thanks!
> >
> >>> Another bit that I'd be more comfortable after hearing your word on it
> >>> is this one (discussed over 5/5):
> >>>
> >>> https://lore.kernel.org/lkml/20180925130750.GA25664@localhost.localdomain/
> >> Can you please loop Waiman Long <longman@redhat.com> into discussion?
> >> He's working on cgroup2 cpuset support which might collide.
> > Sure, I've been originally working on this on top of his series, but
> > didn't try with latest version. Hopefully the two series don't generate
> > too much collisions. I'll try to find some time soon to check again.
> >
> > In the meantime, Waiman Long, how do you feel about it? :-)
> >
> > Thread starts at (you if missed it)
> >
> > https://lore.kernel.org/lkml/20180903142801.20046-1-juri.lelli@redhat.com/
> >
> > Best,
> >
> > - Juri
> 
> Your patches look good to me. There will be some minor conflicts, I
> think, but nothing big.

Thanks a lot for reviewing them.

Going to test and respin soon.

Best,

- Juri
