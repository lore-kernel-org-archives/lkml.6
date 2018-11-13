Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E471C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5F9223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLZWfjcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5F9223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeKNG6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:58:30 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37866 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeKNG63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:58:29 -0500
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so6003199yba.4;
        Tue, 13 Nov 2018 12:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S60uROdWn0WL7K7ecFcE3+FHfbw6BesWS23KZQCAEPE=;
        b=FLZWfjcsr1Gt3kuyzezxsRzj3iWOkeZzbXJIqDPo/+0ZtHx68ZPEyW0xbRT5/qIRI6
         TiuMMbEGmcrxOx3P7/z6n6jYNgBfk/jCV6XSMl6Pgg/ZLQYQgBWZlk4wJAlQCLZzramo
         eNT0CrG3P1/3nL6/EYg0EvvdD8GtNAL8P1pme8+9hFvGXzLyd83GJgJQv9lbXhPEod4E
         2WGgRw7RIaTw8S45D1FUr5KC9B7qmElhvXPIZh+R3rCfWAx1pb3ILp9/fQFhUSiuMB9R
         ed6qNoRHYCw8v/r9JcnIMjgDDk8CghN/k8nnWEwNnZxpqUJv118YUf8nrnomhAbPWh0R
         P6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S60uROdWn0WL7K7ecFcE3+FHfbw6BesWS23KZQCAEPE=;
        b=TaLJ8MJzOOArETKB8pQSk/6zAvCQrcAiGkFW+AZvUXUTsZjjZzJqgzmQGGtDEu8XWO
         pt6WAtX6xuef/Vpn/6sZJR5i+LcZ2FvfphfSrafSVyVujgedh8qIfCCJ2FhLVn59orO+
         wk2cDiFEW8B9Gq7Q6O/R5h5GzWiK3o78vt0ZapnV73Luz/YOgb7TKz3rMLvMYLpoVjRJ
         1kMFaNVDDduUdyEwBJoDUqhwVVTRWmD5NEY80w7CLQm/3KWQYvx17J3pXIS+yH+OEK6i
         2KJ36V6xtwZdEkppRViwwAnV/HEUcd6soIeJ1ojjGbnLiHNmehkPXYh2uySFR0FU/ygF
         Ddqg==
X-Gm-Message-State: AGRZ1gLG3clTSIOQeGTBKDJY6aHsfYDz7F9i4beEbQjIKI+ZVnGtE9RX
        OBflUzMx3uV9HDXfIHmL0qA=
X-Google-Smtp-Source: AJdET5feeNzahH4L8A+jwhba+JdaniS1Uagf2yOhTCwKhBsb3ft64WM5dSOXWPS/3uXhva9mKWasww==
X-Received: by 2002:a25:8311:: with SMTP id s17-v6mr6807075ybk.142.1542142714568;
        Tue, 13 Nov 2018 12:58:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id c6-v6sm15635059ywh.34.2018.11.13.12.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:58:33 -0800 (PST)
Date:   Tue, 13 Nov 2018 12:58:31 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Message-ID: <20181113205831.GP2509588@devbig004.ftw2.facebook.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com>
 <20181113020817.GE2509588@devbig004.ftw2.facebook.com>
 <20181113184751.GB21629@tower.DHCP.thefacebook.com>
 <20181113191541.GM2509588@devbig004.ftw2.facebook.com>
 <20181113205507.GB15590@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113205507.GB15590@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 08:55:11PM +0000, Roman Gushchin wrote:
> > > > > +	if (lock_task_sighand(task, &flags)) {
> > > > > +		if (test_bit(CGRP_FREEZE, &dst->flags))
> > > > > +			task->jobctl |= JOBCTL_TRAP_FREEZE;
> > > > > +		else
> > > > > +			task->jobctl &= ~JOBCTL_TRAP_FREEZE;
> > > > 
> > > > How are these flags synchronized?
> > > 
> > > Using the css_set_lock.
> > 
> > But other JOBCTL_TRAP bits aren't synchronized by css_set_lock, right?
> 
> But if we don't touch this bit anywhere else, should be fine, right?

But other JOBCTL_TRAP_ bits aren't synchronized with css_set_lock, so
they can be updated (read-modify-write) concurrently and clobber each
other, no?

Thanks.

-- 
tejun
