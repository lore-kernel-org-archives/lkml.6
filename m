Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8E621564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Za6vrniA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8E621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeI0HDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:03:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46158 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeI0HDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:03:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id h22-v6so934290qtr.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f/EAkGtAefVaQBgPZAGOkdZhmJzeqi0Qe1D/uQ3y5o4=;
        b=Za6vrniAldGFa10n74Ejh1qkLtpScETCKd7ahwjXgBbX8LQmrEzb8xG4f2poL7PduZ
         hyJMqqdARoh63u1t+URyAWkJOrqIirhXBIVsbRH+rxtt1+ko8mejEtLk2iz5Ic/Sc98J
         SJgl3Q8LBwmqFgXGAJKbPf0Cpa+OEJfOqYTHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/EAkGtAefVaQBgPZAGOkdZhmJzeqi0Qe1D/uQ3y5o4=;
        b=ofZFlSLreiuunWNuoqlcMY2PjxNHIR6BnAXv2IcoTH4PQoi6SOWRUtZVz1OLVtsW1s
         KkvK7vfIVm4HJ2QluBKi0YHa6mfp0m9MZKl03n/570lW7WuZuTgzHdc2dFbSoRHGG/bJ
         rTHBcnfy4rqd5SvL3xnmKaw9muaX7jmKaPDQrt8NbAnDfGav9WCU4CLAtQXBuH5VPV3j
         IWHxf/7+KRQ16wFZy5BLYXnGL05ZGyueDZXyXX8MqUQhsXqKEsuK/VyKJ0IXX24b+sQb
         G/Nd89lbLtqsjeYR5yYYPGy5VR1dE8b6mIHJ11x7t0UgAPRw8CKnKH5U4Aa3OhUZ03ic
         r37w==
X-Gm-Message-State: ABuFfog4HPDV7DA2TMlwqGBrL1Qmi0MRjbJaqQBMg7P33fc5OQimFE20
        7RRzpKuDYGLTICiiwoCMuq2u7Q==
X-Google-Smtp-Source: ACcGV63lwo8VAWt3YgOCQXRCZMdzGf+QFMDhv7SWP8ydSnF6+IPFz7lCuimE5DefhJpipres38JQzA==
X-Received: by 2002:aed:3539:: with SMTP id a54-v6mr6474024qte.153.1538009256729;
        Wed, 26 Sep 2018 17:47:36 -0700 (PDT)
Received: from puremoods ([185.232.22.59])
        by smtp.gmail.com with ESMTPSA id f90-v6sm597214qkf.49.2018.09.26.17.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 17:47:35 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:47:33 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-mm@ archive on lore.kernel.org (Was: [PATCH 0/2] thp
 nodereclaim fixes)
Message-ID: <20180927004733.GA4013@puremoods>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180926130850.vk6y6zxppn7bkovk@kshutemo-mobl1>
 <20180926131445.GW6278@dhcp22.suse.cz>
 <20180926152200.8a3bfb1845de21937914feeb@linux-foundation.org>
 <20180926230838.GK1750@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926230838.GK1750@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:08:38AM +0100, Mel Gorman wrote:
> > fwiw, I have everything going back to 2001.   For some reason.
> 
> This is far better than mine and the only person I think could potentially
> improve upon the archives is Rik. 2001 would cover the most interesting
> periods when things like rmap was introduced. Back then the VM was relatively
> simple and the concepts were generally covered by academic textbooks AFAIK.

Now you just need to have a point person who would do the requesting and
archive-providing, per the procedure described on
https://korg.wiki.kernel.org/userdoc/lore.

-K
