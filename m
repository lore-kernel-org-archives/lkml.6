Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D4C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0E92085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI8vBZUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0E92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeJLFfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:35:50 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35272 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeJLFfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:35:50 -0400
Received: by mail-wr1-f41.google.com with SMTP id w5-v6so11330915wrt.2;
        Thu, 11 Oct 2018 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0Hh7b2Lu1/pDyN98Jci6WGRTRZXC930AegybeA2rPM=;
        b=DI8vBZUOMy2WkufiXRoXXbQKKx4vauU3RDHimoopVEuY1+BeZzo3KEnF+5PniVle+d
         4GixUjORVHaEw/MyI/pEIY9x7Kg9IZ2XWo5HeeZXHoxMn3f1XyxKsSO1hpSGEB3vOR3g
         FkIBAsBv1ECvNZrV1TrzFsGhgL6RTESGq/kBjMwiiZ9nZyinAhrZhIIyaTCyU3WFo86K
         JCJf/Sihgvd6mUoJoGPKiIVTmS14ltYoXj8cvPpsQd/h4/2Q440H/HK/k0kdiLncJA6L
         080K0MzrQU/bnsmRAWMQ1sZeObUbH8nSwCpYK7MFKypaAVUxNgySxdQE7sCsmtffi+pk
         7WPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0Hh7b2Lu1/pDyN98Jci6WGRTRZXC930AegybeA2rPM=;
        b=N1jUd1WTNmN7dxfzt0tr3p0t+7gv76hyUK6E69O/drdqkVRE6xkXh6nbt6ZZWLEish
         w6RpznrFzl/HL9ORAFDaKUPVBudg+vFDTh+RZG3sX+PGyvp8SdNIY0GvEBDV7W0HYAdD
         /BM4cjiwMgSrHeQXVLP5fotJmpNXkQplEncp6vvGtg1niCn92n5a2r9jwIF3FHyhn7Xt
         2Bb3Zw4i3kSOL07PmCgD1/rSgFfIu2tuY4FIp2sqRYyVMCIww1RmEdgW9tUm+BW5aFRw
         hhijhGJcYxw3fNvTmRNJQEEWwxFdmFh6NNXpS/+w61PGyYeyOzh2nxwXsTLIo0/ZNGIm
         F6lw==
X-Gm-Message-State: ABuFfoj/eOGV6E21gsnljjasOR/KzsG75W5bBtBxx7tGhm2rW9nQz2Hx
        Q3pwqcDlKygIidk/v92PPLc=
X-Google-Smtp-Source: ACcGV62UbOQa4C2GcYeVoB8O/jBSMNiYe6RP8VmLZ8mvdTvatBtmpziOWGiwp6y2TrIg/T6/8WhJAw==
X-Received: by 2002:adf:f111:: with SMTP id r17-v6mr3214922wro.303.1539295594820;
        Thu, 11 Oct 2018 15:06:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j128-v6sm18676661wmb.43.2018.10.11.15.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:06:34 -0700 (PDT)
Date:   Fri, 12 Oct 2018 00:06:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     peterz@infradead.org, hofrat@osadl.org,
        torvalds@linux-foundation.org, john.garry@huawei.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/completions/Documentation: Clean up the
 document some more
Message-ID: <20181011220631.GB128397@gmail.com>
References: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
 <tip-0c373344b5c1eaa9e186368a32a169a2802be3ca@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-0c373344b5c1eaa9e186368a32a169a2802be3ca@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi Nicholas,

I was wondering about this paragraph:

> Using on-stack completions for code that calls any of the _timeout or
> _interruptible/_killable variants is not advisable as they will require
> additional synchronization to prevent the on-stack completion object in
> the timeout/signal cases from going out of scope. Consider using dynamically
> allocated completions when intending to use the _interruptible/_killable
> or _timeout variants of wait_for_completion().

What exact race related to _timeout()/_interruptible() waits and on-stack
completions were you trying to highlight here?

Is it the fact that if a signal is already pending for the current task,
that the _interruptible() variant might return prematurely, while any
kthread that has the completion pointer passed to it might still be using
it?

In that case the kthread should indeed be waited for.

How would a dynamically allocated completion object help in this case - or do
you mean a refcounted dynamic object?

A specific example might be useful here, instead of this rather vague,
generic description.

Thanks,

	Ingo
