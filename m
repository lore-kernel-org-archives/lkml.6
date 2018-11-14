Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6131CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B32224E0
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="an2VW91M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B32224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeKOHqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:46:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:46:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id v68-v6so8573295pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 13:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wGu35BytE5MFLe3wiIaMa1iK3sSv0nEWLe5DbLqduK8=;
        b=an2VW91MA1T9qZ2PHtda93I5gBdaba8fxSwwidt89RBj0yqRH/ZvbG5vhC7NLtWq4t
         IXzBbHaUm58BT9OG9Bue9IZHcobudCjdObrL9udDFH+zfdG9U+iwfiQYf2c8/FKdag5Q
         YiuHvR0KyFI6tonkoxZZuBYE23lcBMJrJKCuEgkp4onE2VOGL8kS/KmhbbDs/pRXdfkR
         TiGFuXPwI/5FAJntYD99dipkSUH41TdqSqEnbV9uza7FZ+RuFUp6WrX+p7xCxncXfEOU
         vUDayA3qDJaUGwURusPJgo14VzrmCC3RrVQ/fymBYWUHNtOZt9I6JLhNgIN1qPEyQEA7
         igrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wGu35BytE5MFLe3wiIaMa1iK3sSv0nEWLe5DbLqduK8=;
        b=nP4tNun/Y8rqFoJtPWveqj4kAobWhW75Iy0fBz9qat/+5mZU36XyTXPTO9SGinb6Co
         jr4NpKovPns6HkYrmcsnJk1qQ0XO4SwAwebiymiujd61rw0ope2SVwb/oJaqKXXIqDHA
         9fKdIG2cbiuW9iZZ3s6xd+4xYakaOQil2sbNNUtP8ohELPv7ldawQvM6ajpRJ53qJATU
         12QdqJw0nqchiG55B9BmSEFbnH1buFe7HVcUykj9CJLsDPrYxPLwn7U9s0YRB0si08yy
         8Yzi1hy5+bvXm8QHwdAx4amkKO480xx7FEdtcgNMrViciCUDLjAg0Bx8rDp+ICmALucT
         eTew==
X-Gm-Message-State: AGRZ1gKU3DpkB/q6vLEfa7VZ/LrQDrxm/j32x6IOZmk1YtkwrgzAy1lp
        Muc9quhc7goeTEuojswjkuFB4A==
X-Google-Smtp-Source: AJdET5cW/2kRUHzRWL/gi31fdPLUVsnB8u8XGuQsqSrBFTRR8hPrq8/mIULXQKR3BEMtG8p4rqhk2A==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr3297389pgc.89.1542231674742;
        Wed, 14 Nov 2018 13:41:14 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x26sm689403pfn.50.2018.11.14.13.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 13:41:13 -0800 (PST)
Date:   Wed, 14 Nov 2018 13:41:12 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
In-Reply-To: <20181114132306.GX23419@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1811141336010.200345@chino.kir.corp.google.com>
References: <20181004094637.GG22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810041130380.12951@chino.kir.corp.google.com> <20181009083326.GG8528@dhcp22.suse.cz> <20181015150325.GN18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com>
 <20181016104855.GQ18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com> <20181017070531.GC18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810171256330.60837@chino.kir.corp.google.com> <20181018070031.GW18839@dhcp22.suse.cz>
 <20181114132306.GX23419@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Michal Hocko wrote:

> > > > Do you know of any other userspace except your usecase? Is there
> > > > anything fundamental that would prevent a proper API adoption for you?
> > > > 
> > > 
> > > Yes, it would require us to go back in time and build patched binaries. 
> > 
> > I read that as there is a fundamental problem to update existing
> > binaries. If that is the case then there surely is no way around it
> > and another sad page in the screwed up APIs book we provide.
> > 
> > But I was under impression that the SW stack which actually does the
> > monitoring is under your controll. Moreover I was under impression that
> > you do not use the current vanilla kernel so there is no need for an
> > immediate change on your end. It is trivial to come up with a backward
> > compatible way to check for the new flag (if it is not present then
> > fallback to vma flags).
> > 

The userspace had a single way to determine if thp had been disabled for a 
specific vma and that was broken with your commit.  We have since fixed 
it.  Modifying our software stack to start looking for some field 
somewhere else will not help anybody else that this has affected or will 
affect.  I'm interested in not breaking userspace, not trying a wait and 
see approach to see if anybody else complains once we start looking for 
some other field.  The risk outweighs the reward, it already broke us, and 
I'd prefer not to even open the possibility of breaking anybody else.
