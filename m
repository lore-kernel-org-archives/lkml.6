Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4014C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B632086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqcMvKVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B632086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387967AbeKNBqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:46:48 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36820 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeKNBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:46:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so20157897qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LkMD2atEKCt1a++krARyhfiDLUess4x4VSkmuoPwz1c=;
        b=rqcMvKVCiLUCQpG62lc/LIKftMMSQTMgeItGXK8MJm/ewM5QuY3lc/4jEOKHftjhKR
         Xc0QwxKkN2h/JbStH4bbgAwzbQDJHz2ugtn6UwvIe71KbalGIb+Uti8Mfv/x3FVh5b4+
         0/pm4kc5blyCdmVB/kAYpZ0b8amUtDI00cWusUs6B37sLl4DQlILG7nk/8rAIbNhRNcp
         sRVf5g+qa1uS7FlHgEHFevxdwd/4X/MCpR2Kq51FnFnY6hXHNuJamzQr0SW71MG9o9AX
         ugVxAv5HoRbxehKPRFkUvlh9ttTaMoF0bB3FeCCnbcRQYTAcwkgjptajJfIGwL+aE2+E
         wgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LkMD2atEKCt1a++krARyhfiDLUess4x4VSkmuoPwz1c=;
        b=EabqAzK1zNHrfbfF2zOaBes6xABwnJsZUxKSHoVNF/YP+wjhIfM6HSwrYEJUbdHPU/
         K2shZHXYWHD5AWUEfqQDn+Cjt4Q1gBSnWF4wV8n01eq6UlBxTWcCkOk6R40uO4HUiiWn
         uFhLs2o6kDTGfWVS08HPSOjGPgonn8HCQqVDv6RNuVCaviyr2EirTlMFSX8m0IktRwDO
         DSQ7K0V6F1bKXU9yb68cU/i6Y9znJD2OOKnq6EMV1gaEebrEBRrWIvuTy0fgXfrWrZ26
         YKAczYcQxwMOfTyFAmaibdy1rPPb7JEHtjq/p0sWxrGegXCV3oBJ8UAKz+ZxeOaBw6rb
         bBxA==
X-Gm-Message-State: AGRZ1gLauLW6Wh0WElj1yWMyfmYIBQc8UKfIjiuCRJnHxsa0Zughfd9x
        iHm3cx7BHrEcgbNoK1J2FEAAlMXe
X-Google-Smtp-Source: AJdET5fFuzWem7QQfwGmnnQ7Z+rdaNgiADZCLa0NV5CsiwOMUijuoXnpNy5/aPYmIqd/p7Yqn/Ph1w==
X-Received: by 2002:a0c:95b5:: with SMTP id s50mr5767235qvs.64.1542124087898;
        Tue, 13 Nov 2018 07:48:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id w201sm12713172qkw.11.2018.11.13.07.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:48:06 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:48:03 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 25/41] workqueue: Replace call_rcu_sched()
 with call_rcu()
Message-ID: <20181113154803.GG2509588@devbig004.ftw2.facebook.com>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-25-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111194410.6368-25-paulmck@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:43:54AM -0800, Paul E. McKenney wrote:
> Now that call_rcu()'s callback is not invoked until after all
> preempt-disable regions of code have completed (in addition to explicitly
> marked RCU read-side critical sections), call_rcu() can be used in place
> of call_rcu_sched().  This commit therefore makes that change.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
