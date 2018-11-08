Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79263C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C50220825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlfdqcS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C50220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeKHRVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:21:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52705 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeKHRVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:21:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so226982wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/lczE3XIDPd89Q1tErkJcRXSY9Rk0Iau9BXrGYyLGg=;
        b=VlfdqcS0tDgbBS8e/YbxynmQIN4DD+HUND0dkKgRzvA7CwpyJi0ZhIyGwNHMzAsshh
         TZdpeRWl3W5EsbzZ1MqVjE5PUckobNWZFy3sf2JwnOXGjTokO5xyYR+Z6fftqKw7vxXS
         Um28Nsgi4vr5ne4YGgHo27r3+rH+WNdQRA8EsgDgT+CAmaWru7YfHD9ThENmeHMTN5Zz
         A43BHQB4Ve8I369K/voE/MVaxGgvzFYsLnko59GtABde445pIqwUCVXrBPy3wHrHDR3m
         ak2xUMEMzUWPpKg92BJJAnFBvHMfZn0dD7AEOrruang2GSkfMNBQPBqnbncyzQabrosi
         hFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/lczE3XIDPd89Q1tErkJcRXSY9Rk0Iau9BXrGYyLGg=;
        b=VcNRHX4oUCoorucrDNDriH8M4UbJ3LbT/OlTFkN8kw0prqYkru449HTe9boSUgk/P+
         vwkDrKseCx+IcMK0/UJTl1QjKuvlWYfR+AK2Q+Etrk+oy7LQRADELGtD4MA9INsWfUiF
         SFPdyeYQmrtWdWaRnzZ0Fg3uQN0GOASM+6DVoLRTzJX0mQp1makD7kSBDGsuqpsYlB5m
         E/mg+7yLj9fRSy2ayr/328paPNg36xjCChDaEeNG/+iivJC9DCu61AbGbgRhmqFk4ZFm
         tUOk7cdomgRpN6dx0Opy5Cn40vbxlHaC44J7IAA/VRZ54ToC7JakHN1Efp4abJpZsphW
         Bi1g==
X-Gm-Message-State: AGRZ1gKA/uIInFfRHd59dT13COvffpw0qWgEIGsyI1tlX1lkNTBPfhzO
        mWX4+HHdSE8BuKc4WTwoNxHSjjbP
X-Google-Smtp-Source: AJdET5eOwq1SFZtvyvIywCesbnvHC8mxRTLH/jKpuUTNBVZbYF8GyH1hqCKIA40aHeQzbt1FWL9bSQ==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr195174wmb.145.1541663208628;
        Wed, 07 Nov 2018 23:46:48 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h18-v6sm2445050wro.0.2018.11.07.23.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 23:46:48 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:46:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108074645.GE20032@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107171149.165693799@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Lemme fill in the scheduler and locking/atomics bits as well:

> +The tip tree contains the following subsystems:
> +
> +   - **x86 architecture**
> +
> +     The x86 architecture development takes place in the tip tree except
> +     for the x86 KVM and XEN specific parts which are maintained in the
> +     corresponding subsystems and routed directly to mainline from
> +     there. It's still good practice to Cc the x86 maintainers on
> +     x86-specific KVM and XEN patches.
> +
> +     Some x86 subsystems have their own maintainers in addition to the
> +     overall x86 maintainers.  Please Cc the overall x86 maintainers on
> +     patches touching files in arch/x86 even when they are not called out
> +     by the MAINTAINER file.
> +
> +     Note, that ``x86@kernel.org`` is not a mailing list. It is merely a
> +     mail alias which distributes mails to the x86 top-level maintainer
> +     team. Please always Cc the Linux Kernel mailing list (LKML)
> +     ``linux-kernel@vger.kernel.org``, otherwise your mail ends up only in
> +     the private inboxes of the maintainers.
> +
> +   - **Scheduler**

        Scheduler development takes place in the -tip tree, in the 
        sched/core branch - with occasional sub-topic trees for 
        work-in-progress patch-sets.

> +
> +   - **Locking and atomics**

        Locking development (including atomics and other synchronization 
        primitives that are connected to locking) takes place in the -tip 
        tree, in the locking/core branch - with occasional sub-topic 
        trees for work-in-progress patch-sets.

Thanks,

	Ingo
