Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59062075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OsQAQrsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59062075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390166AbeKVJLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:11:24 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46449 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbeKVJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:11:24 -0500
Received: by mail-ed1-f47.google.com with SMTP id o10so6123332edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bMUASx2iq7y+Pbk5SYxh+6ADADLMrDOiQ+6EhXlgpAY=;
        b=OsQAQrsw/cw2JhADdaajXbyqC5orRuodCl5OGvwSPZaNn7GEHE7tVt/OIhgPRxXtYS
         EEkkmO1crYUyq1dMYsF5iPvxoSA6KTvy2xost1Aahs6nENLfrq39j1vxHl6gQjmuJFae
         v116/fMGUDpS3nFG8vTCxdFbNIK7J+sMS/30I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bMUASx2iq7y+Pbk5SYxh+6ADADLMrDOiQ+6EhXlgpAY=;
        b=cEMG/nN0gO2eMSHG1i6I+1puly7Xuv7gcOi97bowrUAS/iryjCufxA+1BS0c1yNyLE
         hYZKduK2RrT0GJ7V222KP8vabOLjQ2slu9htDjdwCi9LqQUpgq4cq5xLC8WIiNp+gkvK
         XPMmWhOnU0bb7jgBeQNAcnwBA9PpXPqxH/4LlHDJ5UVq+9B4NFyNthh3aUkrZgOLehD2
         ioAtviFvrrjodrqm6svZkSx1WlyBlcma+EQL+D9o/BuxkZEwW6RBRLftGEc+NHwYtLmw
         2G6+Ot5MmqeigClTc1wkfGTyGHC13bL4skXAQ5sGFWRR0EOJxQrEN+Bda8DgmgpbZb9m
         oRHQ==
X-Gm-Message-State: AGRZ1gJC96dZaGslFPn7UldCWWS2csa3wl5dm+VnWCUIJ7QBXM8766gO
        kAwlgb7bIb2UmZSaQwZb4uqRpA==
X-Google-Smtp-Source: AJdET5c0P8jA/pLRZPnjKgQ2ZKZNYM4016zYu/24s3N4RuTwJqmkOOegMAVEojetxwcUtIcOhZStdQ==
X-Received: by 2002:a17:906:4c94:: with SMTP id q20-v6mr6367952eju.26.1542839701689;
        Wed, 21 Nov 2018 14:35:01 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id d7-v6sm3448427ejx.68.2018.11.21.14.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 14:35:01 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:34:53 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [Question] atomic_fetch_andnot() in nohz_idle_balance()
Message-ID: <20181121223453.GA4016@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The comment for the atomic_fetch_andnot() in nohz_idle_balance() says:

  "barrier, pairs with nohz_balance_enter_idle(), ensures ..."

which, well, does sound a note of warning... ;-)

I see that nohz_balance_enter_idle() has an smp_mb__after_atomic() but
the comment for the latter suggests that this barrier is pairing with
the smp_mb() in _nohz_idle_balance().

So, what is the intended pairing barrier for the atomic_fetch_andnot()?
what (which memory accesses) do you want "to order" here?

Thanks,
  Andrea
