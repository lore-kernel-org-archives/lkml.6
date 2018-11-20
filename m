Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9105C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7265E2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HUvEt6l7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7265E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeKUHSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:18:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39506 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeKUHSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:18:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so2015220pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 12:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t0XJn4BkWlFoPkgggIK5gqWzE8c0ylZ8sdGW0a2MCuc=;
        b=HUvEt6l7Wycvm0rNnZTJ0fXxAkgWRDkahlrOP6l3V2uwGbM5AYXJ+vO0JKUOG3Iin2
         9efyqrsXtZ80aQ67TlIKKxpB9YVm89YsFrC9oGkNrfrcMHnVKYauGyhJd7ZxTnXjMTEc
         enXqlm3Mn61oVInEaGV/+VtV520IJsD3TU3Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t0XJn4BkWlFoPkgggIK5gqWzE8c0ylZ8sdGW0a2MCuc=;
        b=s4wZBj7vnZY4xGrCDoRMn9cOOEdEAWAawqYtZa3XvLCzQxEwimKG10sbkL9N0ESHW8
         AGctqMt7oCPQfq0gHSQoRu0sXyM8/RBLH7AnktnDA0cr76cn0nkyn1l065KwxobHT4pM
         NwvVfZNXolc2iH7Y83LLPbXSzyJhK0/DuNlf36LDxVkYwPRb+ItRESHBV6Ff22Ez9u/n
         xerL08yXu4G3zKZCySoxNExlyniNzH1Rh7aoD48mGS+/87ElT9MftV+sTK7cRg8FzfsL
         c13GnpQdMXmEvkyH8QFb25wwArkabytfxF70eNaT1CiPHwhz/2epiB0mC/Y0bR2HTigf
         Lupg==
X-Gm-Message-State: AGRZ1gInWhyKYD3GIIvbZ+eYbmqhQpgbzaAYeXdnb1s/yHv3IJASt1nJ
        EiSoHF3GMKkw39RiU8ksJCbO3Q==
X-Google-Smtp-Source: AJdET5dgCexKSqUNRwxNpu0U+GfAubRtiajC39zFKvUPznXpUknZgMOPBgnliiqbT1dK3KaNmBbHJA==
X-Received: by 2002:a62:dec3:: with SMTP id h186mr3897625pfg.158.1542746832170;
        Tue, 20 Nov 2018 12:47:12 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id f64sm94576467pfh.0.2018.11.20.12.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 12:47:11 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:47:10 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more
 robust
Message-ID: <20181120204710.GB22801@google.com>
References: <20181120052137.74317-1-joel@joelfernandes.org>
 <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com>
 <20181120183926.GA124387@google.com>
 <20181121070658.011d576d@canb.auug.org.au>
 <469B80CB-D982-4802-A81D-95AC493D7E87@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469B80CB-D982-4802-A81D-95AC493D7E87@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 01:33:18PM -0700, Andy Lutomirski wrote:
> 
> > On Nov 20, 2018, at 1:07 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Hi Joel,
> > 
> >> On Tue, 20 Nov 2018 10:39:26 -0800 Joel Fernandes <joel@joelfernandes.org> wrote:
> >> 
> >>> On Tue, Nov 20, 2018 at 07:13:17AM -0800, Andy Lutomirski wrote:
> >>> On Mon, Nov 19, 2018 at 9:21 PM Joel Fernandes (Google)
> >>> <joel@joelfernandes.org> wrote:  
> >>>> 
> >>>> A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last week
> >>>> where we don't need to modify core VFS structures to get the same
> >>>> behavior of the seal. This solves several side-effects pointed out by
> >>>> Andy [2].
> >>>> 
> >>>> [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
> >>>> [2] https://lore.kernel.org/lkml/69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net/
> >>>> 
> >>>> Suggested-by: Andy Lutomirski <luto@kernel.org>
> >>>> Fixes: 5e653c2923fd ("mm: Add an F_SEAL_FUTURE_WRITE seal to memfd")  
> >>> 
> >>> What tree is that commit in?  Can we not just fold this in?  
> >> 
> >> It is in linux-next. Could we keep both commits so we have the history?
> > 
> > Well, its in Andrew's mmotm, so its up to him.
> > 
> > 
> 
> Unless mmotm is more magical than I think, the commit hash in your fixed
> tag is already nonsense. mmotm gets rebased all the time, and is only
> barely a git tree.

I wouldn't go so far to call it nonsense. It was a working patch, it just did
things differently. Your help with improving the patch is much appreciated.

I am Ok with whatever Andrew wants to do, if it is better to squash it with
the original, then I can do that and send another patch.

- Joel
