Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757A8C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA54C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xrILrL0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA54C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeKUFKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:10:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44063 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:10:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so1569798plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BdQ7U60czxnAnC35iSzaUKOG78G8ek9b4ohFFkVj5E4=;
        b=xrILrL0NclaV8w1FN5oNlGlairbwQ0tkD51tfFVl1lciEkYsrbDuadmcWwfGR0R6B/
         azLea03KEndc2qwCPqaxg09bBhTTAijwkLdEbrnygZx5tKXMXsmUj5rE9M7ueHZLtjI2
         XqkHW9r8hiOGf/W+yM0Q2Rwaw8hgCvO3nUDJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BdQ7U60czxnAnC35iSzaUKOG78G8ek9b4ohFFkVj5E4=;
        b=Njoj7LncO0KxHXAwTvkxG4Yie9TQ+0anG0czOrWhpd4lQRmwlI2/7IQVkaT4Fb0jxA
         KPeqUpIKNwpM4TwK/AW/xOJsoCTUS/OPdaDTTGiYPrqWeWd8KSDv1P5kzb6hjxfPdRr5
         74igtBYpkFuHRWxM33riAMmDFgLKD2f5MydQ3GlwipzIPO07EHSy2vGo1MNjL++gHwZE
         h298qKwDC1d/c2nb0w8LRqD9F+111Lo7JydPoqfXIR61XC0L+b3kuUY2bFsW2CMR2vFj
         GW9ewiVyDhRmeFOpqwTA6TNKy8UrCayyjQLMFlA7LJynQ5rP6Cv4kcMOERqoyHkvaira
         b0iw==
X-Gm-Message-State: AA+aEWaJ9OEKn6WiT2qGrgdxJmkxlW4mVGMNwidBXembEOJPzB2QjaMB
        mkB1+gUvw3zD+cW1X61q2t+rXA==
X-Google-Smtp-Source: AFSGD/UVYEwy+jLljEOA2bg1stVeygo/7DzCq0xqdGQDbaHeNRvlKoJ7beFgciPCY8ZOsqWzPuoKGw==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr3253081plb.6.1542739168601;
        Tue, 20 Nov 2018 10:39:28 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p9-v6sm46190628pfa.22.2018.11.20.10.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 10:39:27 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:39:26 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more
 robust
Message-ID: <20181120183926.GA124387@google.com>
References: <20181120052137.74317-1-joel@joelfernandes.org>
 <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXgBENat=5=7EuU-ttQ-YSXT+ifjLGc=hpJ=unRgSsndw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:13:17AM -0800, Andy Lutomirski wrote:
> On Mon, Nov 19, 2018 at 9:21 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last week
> > where we don't need to modify core VFS structures to get the same
> > behavior of the seal. This solves several side-effects pointed out by
> > Andy [2].
> >
> > [1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
> > [2] https://lore.kernel.org/lkml/69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net/
> >
> > Suggested-by: Andy Lutomirski <luto@kernel.org>
> > Fixes: 5e653c2923fd ("mm: Add an F_SEAL_FUTURE_WRITE seal to memfd")
> 
> What tree is that commit in?  Can we not just fold this in?

It is in linux-next. Could we keep both commits so we have the history?

thanks,

 - Joel
