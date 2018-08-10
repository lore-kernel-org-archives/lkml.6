Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D336C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1356622454
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccgAz+/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1356622454
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeHJVSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:18:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37178 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeHJVSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:18:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so4796508pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3s1g1E8pEwR1f3AmZMpJiaiKBZlNWTUsvbDB+ejsKoQ=;
        b=ccgAz+/u0DgMN1d0+dwvYOVo3/+ITbvAWTYoqPoyv/SE7CnbMdxfkTtTwo3vBAVS+t
         la6zUzGsEyHfhpU4S7ola1M0MLSXK2jcuN56sioLIgrqHy090JO9oV0zmcQagzFYEMQR
         krosiItYYQN9XzErrrvJKoxtZDzZhYfKKCp7StW+jf4hOUAt5gtylgrR1Ep0HpZeFWcr
         G80HmCMpwZUPBugyNxkwvqIPIzMEUXJk23kfX9rplnd2EbkmyxZJ/ETJIKk09HJZK6D0
         Nfm/vleK9KGvb5FPhMZVrgxRztzmyfzK24Y9jGrhg7eL2e2ywwi+7NSlFvydaamgtKSn
         htzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3s1g1E8pEwR1f3AmZMpJiaiKBZlNWTUsvbDB+ejsKoQ=;
        b=fWAc5gIWz+dgMgJoY2P0WOCfVAzKCQphSnBcRET31001iWRmqjHaX7FsOXQphwKe3L
         Uim4c82oMHxAx2/yf/p7aIQJx8fqdsoGn60yjC38k7Xl0dC1bnoAjeBv/rlHWq12NTYw
         OSfkQaD9IP1AxwMuTYlGcI3UkFjfCuDzDqOQ3QgE2Ud35HzwccXK2x1fpzq5OZtO1o/r
         JO7FPstv3045lLG5mCPkHGUnzwAlRIwx49uDbtUHlOKsxZn9qzHhy0Zt4Adwj+aSmP9R
         8sZMJXP5FcvQVfLH/dEVIlhilprFhzbkRQu7VkHXY53aECrgkxIGNTFOxdTQoOrJuQ25
         4eHw==
X-Gm-Message-State: AOUpUlHgW+T/Omwh28rxTbPcBbMprEPPAUifiYCWgqJ0FqcctVJM7iTP
        g+JwpwvbjjuYQmAyCqtK7kA=
X-Google-Smtp-Source: AA+uWPyUniraWtusKCpLxeSYKo7bUT9LlKDuisREK0rXbYSnq/iNO/lVTCvoXAPR+5gOKnAGa6l32Q==
X-Received: by 2002:a62:d085:: with SMTP id p127-v6mr8228960pfg.119.1533926838346;
        Fri, 10 Aug 2018 11:47:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o10-v6sm19197262pfk.76.2018.08.10.11.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 11:47:17 -0700 (PDT)
Date:   Fri, 10 Aug 2018 11:47:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, dan.carpenter@oracle.com,
        tklauser@distanz.ch, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Message-ID: <20180810184715.GA11259@roeck-us.net>
References: <20180810083804.GA20415@infradead.org>
 <mhng-341b5b76-2cd6-41e3-859a-6b1d926ba770@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-341b5b76-2cd6-41e3-859a-6b1d926ba770@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:27:37AM -0700, Palmer Dabbelt wrote:
> On Fri, 10 Aug 2018 01:38:04 PDT (-0700), Christoph Hellwig wrote:
> >On Thu, Aug 09, 2018 at 03:19:51PM -0700, Palmer Dabbelt wrote:
> >>This would be necessary to make non-SMP builds work, but there is
> >>another error in the implementation of our syscall linkage that actually
> >>just causes sys_riscv_flush_icache to never build.  I've build tested
> >>this on allnoconfig and allnoconfig+SMP=y, as well as defconfig like
> >>normal.
> >
> >Would't it make sense to use COND_SYSCALL to stub out the syscall
> >for !SMP builds?
> 
> I'm not sure.  We can implement the syscall fine in !SMP, it's just that the
> vDSO is expected to always eat these calls because in non-SMP mode you can
> do a global fence.i by just doing a local fence.i (there's only one hart).
> 
> The original rationale behind not having the syscall in non-SMP mode was to
> limit the user ABI, but on looking again that seems like it's just a bit of
> extra complexity that doesn't help anything.  It's already been demonstrated

Doesn't this mean that some userspace code will only run if the kernel was
compiled for SMP ? I always thought that was unacceptable.

Guenter

> that nothing is checking the error because it's been silently slipping past
> userspace for six months, so the extra complexity seems like it'll just
> cause someone else to have to chase the bug in the future.
> 
> But I'm really OK either way.  Is there a precedent for what to do here?
