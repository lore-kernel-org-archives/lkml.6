Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD42C2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFnkRYgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD42C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbeKFXgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:36:43 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46469 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbeKFXgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:36:43 -0500
Received: by mail-yw1-f67.google.com with SMTP id v5-v6so704339ywa.13;
        Tue, 06 Nov 2018 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gdt1kJmntyurggHbrPSal7IcRdlpLMCs8QQ+tTT63wQ=;
        b=nFnkRYgCfWmZoENAc3hxQqb3oem6Dqi1Fzsjl34P34GjlCAWv2dUbLNpLZlJtN0A2R
         SPCHRYNCW4HUjQlkH29zJwyff0RK8VU3U9fYfmlhcNzy9HQZtinG8ov+ZwsGSXH72sKB
         blQQgIPRbLC3hp97L5UoehkD+SRiodlQoAdNN6SO8d5mwdvhfzjVlL5bKB4cSlIP7wa1
         xiBr6WH8NpVqZyyZY1Z97Cx2tw9An4K3aLgy6IF/Fky5cBqxmiORnf7T/wUajQVMAJRP
         qR6BiC4eJAGklw063yi1o6DY0YFcPFMNzi6jyLHBdFXUfMFy7FICkv314Ws6a5dp1n+N
         GFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdt1kJmntyurggHbrPSal7IcRdlpLMCs8QQ+tTT63wQ=;
        b=qF6B4GseOs3ijrwBJz0F7mG+1h76oDeGHtKokSnvWKly4dYaj9pwWTmHXVlXyb291G
         lkgNIQBppByZ3wZCkQT7D9xnTLMt0G1tm3gc/ucnYc/BcP31zA4AW0FOR5ZUxwkJEE8v
         dI/1mKAmdmU2lK+nvjAIWXyqXajQ1p+8vlqmR19vQjCuH6uGcXVO3E7UmL+AQUUw36+n
         Wvi1jeqccKUZgPoTbUsRqsLvh+DV19OpdoVXoX/aF8DoEdIR8Gimj5Qyeo2eMM5e0wUJ
         ed/PDrL1BO76d9jpzE6VW+aHg3T5vc67GHqFeO/1rXprgsSdU10KjwAnL9TI62GHUrk8
         f+ng==
X-Gm-Message-State: AGRZ1gK0YD3LBcwwmt3n7waFHqrCcecwi8ppXk5bI4HLKVsSGgi/Jsfc
        qPN/xaQhORTyNbgJ48ef2ztUrEyU
X-Google-Smtp-Source: AJdET5eEHnLn/nhqvJjdpeBCJzdX/QVYhi+nqTY2V4aXeaTAm93dlvBIlviN06RLacPy24CHqJrygA==
X-Received: by 2002:a0d:dd10:: with SMTP id g16-v6mr25189173ywe.59.1541513477826;
        Tue, 06 Nov 2018 06:11:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:9d2a])
        by smtp.gmail.com with ESMTPSA id j72-v6sm409510ywj.60.2018.11.06.06.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:11:16 -0800 (PST)
Date:   Tue, 6 Nov 2018 06:11:14 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 00/12] Enable cpuset controller in default hierarchy
Message-ID: <20181106141114.GA2351522@devbig004.ftw2.facebook.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <20181105163656.GK4182586@devbig004.ftw2.facebook.com>
 <20181106115335.GQ22431@hirez.programming.kicks-ass.net>
 <20181106115558.GB22485@hirez.programming.kicks-ass.net>
 <8c386375-b801-8adb-602e-40c73a7efedc@redhat.com>
 <CAOS58YPye=7Ga+y-ujFsgHqo6vdVnjykmON1z+UjNQLvvM_g4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOS58YPye=7Ga+y-ujFsgHqo6vdVnjykmON1z+UjNQLvvM_g4w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, again, guys.

On Tue, Nov 06, 2018 at 09:09:07AM -0500, Tejun Heo wrote:
> Hello, Waiman, Peter.
> 
> Let's skip this patch for now. I'll think more about the interface and
> adapt your patch later.

Sorry about the last message.  I thought I configured web interface
but obviously didn't and it went out with html subpart.

Thanks.

-- 
tejun
