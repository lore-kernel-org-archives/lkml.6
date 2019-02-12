Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48932C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F1C217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549976952;
	bh=fNGrO4Z9cUqKFFi3SgEvqFc8Qs3lIpeumSpYFWUZoIY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=bkCrc6pO58IXFgjUdShXnHfKpTXEgmrr/G4ZTdzcolkoKjAXm/OoXmG0my/iTTfCP
	 ciUGn+ifpv5EWoLP1Gn28adanH+mXuVRIIA1NxrY+n2Ya5C6+cO5vI//82+3WpAPnQ
	 VuOwAq7GJQ/iIyeCo1rLRzxyldq2ooKG8pk6uOgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfBLNJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfBLNJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:09:09 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DFB6214DA;
        Tue, 12 Feb 2019 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549976948;
        bh=fNGrO4Z9cUqKFFi3SgEvqFc8Qs3lIpeumSpYFWUZoIY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hUf05cJMYzkJpBgq5qfmfo09arTbQIEkVyuFLVQ8M0QgIbGCHBr6TokNUO4hoXelk
         +p5q/ABQDWYsymzOLraWRV19VheHRzEYxIXfcO3RbAKyYIqol3EzEbT/Ja7jtb6zKU
         FdBPL/RflncvjMXlCLW9EvaMtiGzhayA7RIVCcnQ=
Date:   Tue, 12 Feb 2019 14:09:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, Josh Snyder <joshs@netflix.com>
Subject: Re: [PATCH 3/3] mm/mincore: provide mapped status when cached status
 is not allowed
In-Reply-To: <20190212063643.GL15609@dhcp22.suse.cz>
Message-ID: <nycvar.YFH.7.76.1902121405440.11598@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-4-vbabka@suse.cz> <20190131100907.GS18811@dhcp22.suse.cz> <99ee4d3e-aeb2-0104-22be-b028938e7f88@suse.cz> <nycvar.YFH.7.76.1902120440430.11598@cbobk.fhfr.pm>
 <20190212063643.GL15609@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Michal Hocko wrote:

> I would go with patch 1 for 5.1. Patches 2 still sounds controversial or
> incomplete to me. 

Is it because of the disagreement what 'non-blocking' really means, or do 
you see something else missing?

Merging patch just patch 1 withouth patch 2 is probably sort of useless 
excercise, unfortunately.

Thanks,

-- 
Jiri Kosina
SUSE Labs

