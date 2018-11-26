Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2300EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57552086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NuQn4G4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57552086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeK0A3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:29:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44443 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeK0A3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:29:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so6582113pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aTx3zTvJaBmU07f6U5v8PQPgrf2KN3pwhK5vuCBZ3HM=;
        b=NuQn4G4f5OA6V9NHaxYsXisRNYOH9LubQigPj61tZP9zIKj6+Y/DLvI8m3UTaZXC2L
         Y8yuapCEUvWG2LelXk6g3zU8bWT8zgLId9w9nHJc92QejOTMu3j+/uE4a/+bbJFHUgcw
         tIEz3r9deVW9sP4Ik0xoEYFJwChkGQQEg3WI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aTx3zTvJaBmU07f6U5v8PQPgrf2KN3pwhK5vuCBZ3HM=;
        b=UHb13dbc+PfYKOnPMRieB5DJAVAEicseNEBBzNGRA/lXy2UDkpjl6Kz+i+0Sn4XDgS
         5a6QWVO+HutKFsUd32trwnCTKK1v4447/dN3eJN7eei7lrs+tgo2DGvRxQpK+WXy2sdP
         so2ZAcu/VMBD5YB9o9RvEI95oK7ReASrlB+PJrd4TIKPjn5SCPpnpR1v/LspT9cA6/AE
         BcH+j9L+qxhUahzVpJ5HI6yqpq2+ghAJmwa7jQu7vzd/d8WHjEeC02BPnUI2Czh3BcJK
         eE5Aeyl9YvXMSvUBrd32NL1osL18lGuhzIIyFDGReoKP2FbQOlIxU7X1g4yv5CbiZYpO
         2/pA==
X-Gm-Message-State: AA+aEWYxSGPrMqt5aqCY1yQENF4t6t6+LZEjkDSMkOySKSAvekJgGHGx
        cb96mnIViGcUs1SrH58gFYKbPQ==
X-Google-Smtp-Source: AFSGD/WKlO4NxqiX1QEDSRM2cUe21kXkVBr7uLt8ue6bKGySIFPUBv0BDTlyKQKu23sBph+VqpUuww==
X-Received: by 2002:a63:790e:: with SMTP id u14mr24901140pgc.452.1543239339077;
        Mon, 26 Nov 2018 05:35:39 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id k24sm1268543pfj.13.2018.11.26.05.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 05:35:37 -0800 (PST)
Date:   Mon, 26 Nov 2018 05:35:36 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more
 robust
Message-ID: <20181126133536.GB242510@google.com>
References: <20181121070658.011d576d@canb.auug.org.au>
 <469B80CB-D982-4802-A81D-95AC493D7E87@amacapital.net>
 <20181120204710.GB22801@google.com>
 <F8E28229-C99E-4711-982B-5B5DE0F70F16@amacapital.net>
 <20181120211335.GC22801@google.com>
 <20181121182701.0d8a775fda6af1f8d2be8f25@linux-foundation.org>
 <CALCETrUGyhqi+M3cTdqJNNOPfTWn-R-ekM_R5heq2mbdVqPUAw@mail.gmail.com>
 <20181122230906.GA198127@google.com>
 <20181124164229.89c670b6e7a3530ef7b0a40c@linux-foundation.org>
 <20181125004736.GA3065@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125004736.GA3065@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 04:47:36PM -0800, Matthew Wilcox wrote:
> On Sat, Nov 24, 2018 at 04:42:29PM -0800, Andrew Morton wrote:
> > This changelog doesn't have the nifty test case code which was in
> > earlier versions?
> 
> Why do we put regression tests in the changelogs anyway?  We have
> tools/testing/selftests/vm/ already, perhaps they should go there?

The reason is I didn't add it was that test case went out of date and the
updated version of the test case went into the selftests in patch 2/2. I
thought that would suffice which covers all the cases. That's why I dropped
it.  Would that be Ok?

The changelog of the previous series had it because the selftest was added
only later.

Let me know, thanks,

 - Joel

