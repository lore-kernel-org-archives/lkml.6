Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B33DC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255F206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLP5xQeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E255F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeJCEif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:38:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41912 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeJCEie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:38:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id q17-v6so2386292plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BUCLlfgISqsV1J401/wn/uLiurLdWscU/s3NC09HQpo=;
        b=rLP5xQeRH+0GsulGyt94Qs0dk8teutsbOFguR3n+wYj7vp24TYjujLuHVAhJXRwP4r
         66DIihEib7ZRT5Jp248zEH1s0n8mmpeZBwOThZ3yh8Ms4KaxpnwbJjAuEuRYMwM3Ngy5
         /MAtTbgdavPeO+c5Yfb3pLow/OiIOAcKu5vAwcRYoGcBUurzLjbs3jffDly1zSjNxFoS
         xLMp7zZWnDUOsrQziqDtOzOM+PTzIoDzerv/csarrzBbc2qaadgKVNZ1on/eKmBEAnoO
         xpvLNTPYP5un3/VTCwnU5JE60m8VrPXGvYvtEYUX59f5qO8F/7lv4NbaVQh8yRNhMZZa
         srmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BUCLlfgISqsV1J401/wn/uLiurLdWscU/s3NC09HQpo=;
        b=iJso4yxaSf9OIdThhUIoQ9ZpdHEjBSgSKmH61TgSBVYAkoz7LwV5J3g9402zTH53vH
         uvpSAq7KQD01pe05QyIIbfqCBKedoXCtz+BGQRNjokw7sQeAtMhS4JaSmGD3jyu1+PwK
         9SikO4CoaDdQdWFb1OOPDsPsdMlUtG0++M2Kb5zn2yqVipXxP9peHO/u5ITMs25PTs1h
         FXzYsw5VWw7TG8de8rS237VV8CZGNqAtLZfdOu5jQLtqHIfd6grMvYtI+S3EE9jX2AFY
         sbrvHbnvcJIAXlkG62ktQmOJ4dnQI31/VVvnvq/NOwqTjwVxw8Mii7CqqxTTkeQh0/Ns
         J7mA==
X-Gm-Message-State: ABuFfojyRkCMDVwHU//O8c8p1SIXEnzdbcvvuqEQPg7N/PCHjjJ9qrCV
        pn19BwzyjD3hfAYf+xqLgV8=
X-Google-Smtp-Source: ACcGV62LZaopxah8/J54uY8YKMwsB5IurRUMfVCg7KQZ/OUlQTS+1J0zxFArgZuRTMOSDKMqJdw8vw==
X-Received: by 2002:a17:902:28a8:: with SMTP id f37-v6mr18564418plb.264.1538517186899;
        Tue, 02 Oct 2018 14:53:06 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g3-v6sm23539254pgn.37.2018.10.02.14.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:53:06 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:53:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: Traceback in ww_mutex test (test_cycle_work) on arm64/x86_64
Message-ID: <20181002215305.GA9322@roeck-us.net>
References: <20180923195706.GA1538@roeck-us.net>
 <20180924105133.GA12461@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924105133.GA12461@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Sep 24, 2018 at 11:51:33AM +0100, Will Deacon wrote:
> Hi Guenter,
> 
> On Sun, Sep 23, 2018 at 12:57:06PM -0700, Guenter Roeck wrote:
> > when enabling CONFIG_WW_MUTEX_SELFTEST on arm64 or x86_64,
> > I get the following traceback.
> > 
> > [    3.111852] ------------[ cut here ]------------
> > [    3.112100] DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
> > [    3.112753] WARNING: CPU: 1 PID: 771 at kernel/locking/mutex.c:1211 __mutex_unlock_slowpath+0x1a8/0x2e0
> > [    3.113238] Modules linked in:
> > [    3.113774] CPU: 1 PID: 771 Comm: kworker/u16:8 Not tainted 4.19.0-rc5-dirty #1
> > [    3.114025] Hardware name: linux,dummy-virt (DT)
> > [    3.114587] Workqueue: test-ww_mutex test_cycle_work
> > [    3.114950] pstate: 40000005 (nZcv daif -PAN -UAO)
> > [    3.115144] pc : __mutex_unlock_slowpath+0x1a8/0x2e0
> > [    3.115327] lr : __mutex_unlock_slowpath+0x1a8/0x2e0
> > [    3.115500] sp : ffff00000b7cbc40
> > [    3.115647] x29: ffff00000b7cbc40 x28: 0000000000000000 
> > [    3.115921] x27: ffff00000942f000 x26: ffff00000a204da0 
> > [    3.116155] x25: ffff00000a1c93d0 x24: ffff000009103cd8 
> > [    3.116376] x23: ffff00000a1c9000 x22: ffff00000942f000 
> > [    3.116596] x21: ffff00000b7cbca8 x20: ffff80001c05f8c8 
> > [    3.116817] x19: 0000000000000000 x18: ffffffffffffffff 
> > [    3.117036] x17: 0000000000000000 x16: 0000000000000000 
> > [    3.117256] x15: ffff00000942f808 x14: ffff00008a1c8bb7 
> > [    3.117476] x13: ffff00000a1c8bc5 x12: ffff00000944f000 
> > [    3.117695] x11: 0000000005f5e0ff x10: ffff0000094b3000 
> > [    3.117947] x9 : 0000000000000000 x8 : ffff00000942f808 
> > [    3.118172] x7 : ffff00000816153c x6 : 0000000000000000 
> > [    3.118392] x5 : 0000000000000000 x4 : ffff00000b7cc000 
> > [    3.118612] x3 : 6172e063a21fe200 x2 : ffff00000944fd80 
> > [    3.118830] x1 : 6172e063a21fe200 x0 : 0000000000000000 
> > [    3.119169] Call trace:
> > [    3.119348]  __mutex_unlock_slowpath+0x1a8/0x2e0
> > [    3.119540]  ww_mutex_unlock+0x48/0xa0
> > [    3.119709]  test_cycle_work+0x10c/0x220
> > [    3.119864]  process_one_work+0x29c/0x708
> > [    3.120016]  worker_thread+0x40/0x458
> > [    3.120179]  kthread+0x12c/0x130
> > [    3.120317]  ret_from_fork+0x10/0x18
> 
> Fun: I can reproduce this all the way back to 4.11, when the selftests
> were merged!
> 
Yes, I know. Sorry, I should have mentioned it.

> > Debugging shows that the traceback occurs in the following code
> > in test_cycle_work().
> > 
> > +       err = ww_mutex_lock(cycle->b_mutex, &ctx);
> > +       if (err == -EDEADLK) {
> > 				# true
> > +               ww_mutex_unlock(&cycle->a_mutex);
> > +               ww_mutex_lock_slow(cycle->b_mutex, &ctx);
> > +               err = ww_mutex_lock(&cycle->a_mutex, &ctx);
> > 				# returns with err == -EDEADLK
> > +       }
> > +
> > +       if (!err)
> > +               ww_mutex_unlock(cycle->b_mutex);
> > +       ww_mutex_unlock(&cycle->a_mutex);
> > 				# traceback seen here:
> > 				# unlocks a_mutex even though it was not
> > 				# acquired by this thread
> > 
> > Details don't really matter as long as the number of CPUs is at least 8
> > (I have not seen the problem with 1, 2, 4, or 6 CPUs). My test system
> > has 8 CPU cores (times 2 for hyperthreading), so that may be related.
> > 
> > The test case above is clearly wrong if both calls to ww_mutex_lock()
> > fail with -EDEADLK. Unfortunately I don't know the expected behavior
> > in this case, so I'll have to pass this on without a proposed fix.
> 
> Yeah, I think the test code isn't robust in the face of
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH, which can spuriously return -EDEADLK
> from mutex_lock(). It looks like it's assuming that err will always be
> reset to 0 when it takes a_mutex the second time. Chris?
> 

I just sent a patch to fix the kernel warning message. That doesn't fix
the test failure, but then I have no idea if this is a real test failure
or a bad test program.

Thanks,
Guenter
