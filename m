Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69037C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217D621765
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPmuwtZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217D621765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHURTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:19:00 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:35866 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:19:00 -0400
Received: by mail-pf1-f175.google.com with SMTP id b11-v6so8556827pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNLAlnzBQxiBRsR8v2zXtt5MtRWEZX994H1zPgR3UQ8=;
        b=IPmuwtZmEapXtpB/BYvBY0allvM/fWdAj/gf+z6cEdHHxyZ/dJ303XEcoS3Yd5z0Mj
         djuS2hHyn77COE9C7n1hXgE6ohTewF0ErwIrQGWbLfBTZHRdTUjrKvuhSrxuMnzNDCdD
         ijKv9FPY4ujVGY2YaDTI9hq7lSkralW7ONKenm+UiQInWeRDe6uF/JzIU2B6Sx4CXoZg
         /XHvIgIrQxv4npte+ArnvoeTi1iodUtGjoMFnPJW90AGQe/qzh5HkWEVYuXw0bWrEdFO
         zpO56fh1y3Ik94WAvsB/SxPKI31rLq0im+P8NDwlOg0EqVTznoaKKCqsXtNLrfbSNIAJ
         qozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNLAlnzBQxiBRsR8v2zXtt5MtRWEZX994H1zPgR3UQ8=;
        b=E1Re7T0Lb0B3lYg1ImABA9WH2PFyrZNHY6dzvqrwGy4AlaNWtmrJR1sQoGlQBdT8sk
         GkJVn1BOO8s6GtdJtq5YmIOdk7UIWutOxuoXsANlAUatDLvfK8YTIJeSxZIVlDixUW+v
         y5qUixOjK28FVISkcob7kJ8fgUZJE4CdcDu+MkcpjUz+mZX7u1SubVICjFQkvMyojiae
         r6yiJwqI2DzNagj+T/xkrFLZPzvY3yGq+e7oKiZT/APoK5XOs9m8QL4JH2NLusax96MU
         fqTm70+ur+MNL3SnvvigI9uMQBVgkzFL8pkrBopSrO1XktxQQb/AIMQckD9S4cMaIYkk
         mKYw==
X-Gm-Message-State: AOUpUlFXoyAmIXbrxoIqxX71ZiOrAiDJidesreeCaaMTuOKQL8fGj9fh
        NcDWxNlny/u43bENWgcmAEY=
X-Google-Smtp-Source: AA+uWPxIdQpCPjT8yt+PziRpQfRq7daZpmzMSM7PAN/i67M2hxhQjJ1X2F7osFBYUzNhYjEtp2yLfQ==
X-Received: by 2002:a63:4663:: with SMTP id v35-v6mr47096440pgk.178.1534859924453;
        Tue, 21 Aug 2018 06:58:44 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 22-v6sm22069017pfl.126.2018.08.21.06.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 06:58:43 -0700 (PDT)
Date:   Tue, 21 Aug 2018 06:58:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        dvyukov@google.com, hughd@google.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE
 enabled
Message-ID: <20180821135841.GA17160@roeck-us.net>
References: <20180817222733.GA18575@roeck-us.net>
 <20180820162938.GR29735@dhcp22.suse.cz>
 <20180820180353.GO12066@tassilo.jf.intel.com>
 <20180820201843.GA15008@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820201843.GA15008@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 01:18:43PM -0700, Andi Kleen wrote:
> On Mon, Aug 20, 2018 at 11:03:53AM -0700, Andi Kleen wrote:
> > On Mon, Aug 20, 2018 at 06:29:38PM +0200, Michal Hocko wrote:
> > > On Fri 17-08-18 15:27:33, Guenter Roeck wrote:
> > > > Hi,
> > > > 
> > > > the following crash is seen in v4.4.148, v4.4.149, v4.9.120, and v4.9.121
> > > > with CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y.
> > > 
> > > Could you try to apply fd7e315988b7 ("x86/mm: Simplify p[g4um]d_page()
> > > macros"). I do not see it in stable 4.4 tree and it has been introduced
> > > much later in 4.14. This one gave us quite some headache because it is
> > > soooo easy to overlook.
> > 
> > Good catch!
> > 
> > I tested that with 4.9 and backporting the patch indeed fixes the
> > syzcaller test case running in a KVM VM. Backported patch appended.
> 
> Tested on 4.4 too and it fixes the syzkaller test case there too.
> 

Confirmed that the problem is fixed in v4.4.151-rc1 and v4.9.123-rc1.

Thanks a lot for tracking this down and backporting the fix!

Guenter
