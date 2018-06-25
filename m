Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E3A23D84
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/yG/MpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E3A23D84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754976AbeFYJOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:14:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55762 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754610AbeFYJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:14:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so8364910wmh.5;
        Mon, 25 Jun 2018 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cAbGG2RkwJum51bNmAL/qayaooOlDQ8XHQ4LlXfZomU=;
        b=q/yG/MpYle/UdgBn/6W3HGfbVzBxpkekJ4s3xVwKSLCwvB8SKi01yMUU3vNwEHc8Os
         QrbD/obflx5un4G1DGM95Yy+5Uq4dWRgcks/YJKHEAEr2FlPbV5PgKc9xYZlRNDie3Wy
         md50VWzBlj3Eogy+09lheWL3nm2qHMcoZR14QvQ115y8SAtGp5EW3l7I+e/Q2cuvD2Gt
         DkQ3iShuvIzwORn4RrdTElL1S2tUw/+Yluhrniu8IHNx/88w5myih3W8XaGbxS3TyxhD
         i/7tJCiaRAYegZDjn6R1SlaxBkGYsvsFH9k8+TK0Ov7oAR4kvHmlYz5jRWqF1tM6CGLz
         gGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cAbGG2RkwJum51bNmAL/qayaooOlDQ8XHQ4LlXfZomU=;
        b=K6BxSdtt3vclOU6OGwN7N3f8DqfU7+AeZIdUNaSrgXFBemLMeX+t+ynLFqsUWrayMl
         /r8L5VPCaxbLCUwFa7jdOplC4YwLDWG8fLxa1e5iXkcx+b66NQ7IXSs2f0ws1w7dU9qy
         c3DiXbKg1SiNCKq3/YJr12Lxwe4enl4/IkMJbngI1tq+WrtvHOKXeftDeTr0rqsDoGgE
         8FmBQAUoflWxQ0Rwxav9Gn/xF1/aJVGJzDHIhG0pE2a87vOmalsDrR1mr5/WnGfsdzme
         MLSmNHO9bibTm42eK32EOsllwcZlkG/Od7ToI63wOmhtvJh+gPGXY/89zv/9aJiOTE4p
         Xebg==
X-Gm-Message-State: APt69E1UJ13awsb1jY1FkAbWQY5W3S7ZinHNKH2ElgYo0G8DPbizYZkE
        omxLEAJedDugVI1Kv7uK8MA=
X-Google-Smtp-Source: AAOMgpfxOlYzfnkK2vKMvDex8erXfMw33WGQ1kC7ZNL3yfqoH6o2xuQf1zvRFTWWsO2sNkDx2VBUvA==
X-Received: by 2002:a1c:150d:: with SMTP id 13-v6mr350039wmv.100.1529918069256;
        Mon, 25 Jun 2018 02:14:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 127-v6sm11440806wmk.45.2018.06.25.02.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 02:14:28 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:14:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Message-ID: <20180625091426.GA18351@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
 <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com>
 <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com>
 <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
 <20180622021636.GA11266@gmail.com>
 <87a7rm3eb5.fsf@xmission.com>
 <20180624071258.GB29407@gmail.com>
 <87y3f31wsv.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3f31wsv.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Ingo Molnar <mingo@kernel.org> writes:
> 
> > * Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> >> The trouble with attributes is that means you can't filter your system
> >> call arguments with seccomp. [...]
> >
> > There's nothing keeping seccomp from securely fetching those arguments and 
> > extending filtering to them as well ...
> >
> > Allowing that would make sense for a lot of other system calls as
> > well.
> 
> Possibly.  The challenge is that if the fetch for the kernel to use
> those arguments is different from the fetch of seccomp to test those
> arguments you have a time of test vs time of use race.

Those fetched values should obviously then be used to call permitted system calls.

> Given the location of the seccomp hook at the kernel user space border
> there is no easy way for seccomp to share the fetch with the system
> call itself.
> 
> So I don't see how seccomp could perform the fetch securely.

Looks like more of a seccomp mis-design/mis-implementation than some fundamental 
problem.

Mis-designed security features should not hinder system call design.

Thanks,

	Ingo
