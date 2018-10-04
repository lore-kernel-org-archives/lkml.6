Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F471C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B8D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjUb2mei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B8D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeJEB2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:28:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:28:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id 80-v6so3531710pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wkrOUO2JjC/9gOGj/z0K/4zLEufRFkYysJO1+x/Spag=;
        b=cjUb2meidMhOV5rtKIcGPwNvKuW2hSha49gy5i58MRsiFp2hT06G8cpmxoQ1mGsT9a
         dQkdkA4FuEeG42w9qlavHmLpwqnqEdqEWgqA1jF3KbVbiOhVm6d0YaEaLtCFNsl2h+CK
         bhNzTChmtM2f419eGnGzSx0mD9QDYOCD+KLBj6dfKoFRbf29b2/TW3ObqVjNvIhwZnGM
         Fm6v1/Pc4OlKkbMeyfibO4EuSP0NSu8coDGkxyRc65Ebzz95oPDKTpqWC22p3GnM8mne
         dduiw/OZra/3v1qCerLy47wuVDiRd1ff2Yl9p5u4G8TeflOG+Z5wALvwYKlNDJiWclug
         aOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wkrOUO2JjC/9gOGj/z0K/4zLEufRFkYysJO1+x/Spag=;
        b=Ig7N1/JuVk6Vuw/z1D4EzWLwFAn0ZgmU7g6k55noDG+Rt6pLIUcj5wYHI6Kwm7tjK5
         qDNir6H2r+7gKTiYUmBXMaFF1pM9xhXNlrZD5Y1NexyOAyfQfRibK9cvbHY1ymAgUCOJ
         fHABk4kHkcAylZY5hScJCZnLeRJ6q9jcCaprgEZ59ovtDF3yBHH6qMTC/Hef/rg5yE93
         RD4RWcMfHMNlG0rXTQ52bWBVQGMjyxBChy16PLpQOyhH+JAq5/l2dYxv6OKbfVoJ7ctv
         4qIQCpe7KBr6JJJYy8OGGmUUhIFPWeQMpGueX54OSIGAWL80BPlH77aaUS28OJjgukfq
         Ej8Q==
X-Gm-Message-State: ABuFfoh4muXPhs5IGesx1M3+X9GbH4nwxqZhHz83W713dwqzBvIP23u8
        daKW0z4u7maS/2OWx6L04pQnxQ==
X-Google-Smtp-Source: ACcGV60GxV8Fk/eOSZP0n3QNykVYTnod/zIU9jL0nNiRQuWx7+MKfu0FbIqZBcJUjHkjdIsvJVNV3A==
X-Received: by 2002:a63:9c3:: with SMTP id 186-v6mr6907024pgj.249.1538678052902;
        Thu, 04 Oct 2018 11:34:12 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w63-v6sm2261477pgd.66.2018.10.04.11.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 11:34:11 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:34:11 -0700 (PDT)
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
In-Reply-To: <20181004094637.GG22173@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810041130380.12951@chino.kir.corp.google.com>
References: <20180925202959.GY18685@dhcp22.suse.cz> <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com> <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org> <20180926060624.GA18685@dhcp22.suse.cz> <20181002112851.GP18290@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com> <20181003073640.GF18290@dhcp22.suse.cz> <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com> <20181004055842.GA22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com>
 <20181004094637.GG22173@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018, Michal Hocko wrote:

> > And prior to the offending commit, there were three ways to control thp 
> > but two ways to determine if a mapping was eligible for thp based on the 
> > implementation detail of one of those ways.
> 
> Yes, it is really unfortunate that we have ever allowed to leak such an
> internal stuff like VMA flags to userspace.
> 

Right, I don't like userspace dependencies on VmFlags in smaps myself, but 
it's the only way we have available that shows whether a single mapping is 
eligible to be backed by thp :/

> > If there are three ways to 
> > control thp, userspace is still in the dark wrt which takes precedence 
> > over the other: we have PR_SET_THP_DISABLE but globally sysfs has it set 
> > to "always", or we have MADV_HUGEPAGE set per smaps but PR_SET_THP_DISABLE 
> > shown in /proc/pid/status, etc.
> > 
> > Which one is the ultimate authority?
> 
> Isn't our documentation good enough? If not then we should document it
> properly.
> 

No, because the offending commit actually changed the precedence itself: 
PR_SET_THP_DISABLE used to be honored for future mappings and the commit 
changed that for all current mappings.  So as a result of the commit 
itself we would have had to change the documentation and userspace can't 
be expected to keep up with yet a fourth variable: kernel version.  It 
really needs to be simpler, just a per-mapping specifier.
