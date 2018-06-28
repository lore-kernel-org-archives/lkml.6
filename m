Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF9C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0D273E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dMOodLTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C0D273E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965978AbeF1NLC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:11:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42355 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965245AbeF1NK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:10:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id p1-v6so5472618wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czgCCwu5w8+Is78rh064XF2WOlg+3jlPMkGkQxjSbgI=;
        b=dMOodLTe7fotjawJjvny6HiMZLMx4DiUPptbG2rckHkpqbSKU+HECKwlv9SoW4MO+m
         4fyjdoALBvwfK5XCGclBc65BtlJWrpu5HOqI7gYGUYAumYCNGsj8pCFZmBRXibsxD7xp
         eXpx3R8yDWjQMu1U+9UiyQnVKJfnf/NfWqt6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=czgCCwu5w8+Is78rh064XF2WOlg+3jlPMkGkQxjSbgI=;
        b=WRbCwjB7n7mw+G7IvqcBa9Ow++nb5Dja8BJJbViZzP3+KQhousmJ7jagNJsZ6bZs8m
         6Lj3GCSQatuWBo8T+O+EVVMKbCvtI0aXRwrwUnp0vOxVYh1djrFhH9ELUzR9sN/al8Gj
         wEDImm7oxMrMRrxldRw7WGDwn96R7cNFOg9MNsxNwGSdCwseSCtu2JF3K0xjX4bGdVAU
         ap1OhTRDNDPdq5D92yjNcgFktcpopKnta2PVopFpPEUgCseqrhLLLGozbG987lZc6p7V
         bMp79qwsDWshDgAau3q9J4A/MJeTIelsFm5mwnaXn/oruosLl5+Nq9xEI+/NkzYKm6gm
         0TQg==
X-Gm-Message-State: APt69E2Wwnr0qABtqPfHAiDvH+nbU+8+2ezC3U6urvG4dMOFB9dr5avS
        X7DMWoainL/Kii/gMDjwGjaqPQ==
X-Google-Smtp-Source: AAOMgpeG8+9JesYsh3uEbQSS0ggC7Yrix2TkX/lm3mDonFiXduh7966jpS0HY3ZIevMELon9PUlBEA==
X-Received: by 2002:adf:f282:: with SMTP id k2-v6mr8259761wro.263.1530191456432;
        Thu, 28 Jun 2018 06:10:56 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id o17-v6sm6723397wrp.62.2018.06.28.06.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 06:10:55 -0700 (PDT)
Date:   Thu, 28 Jun 2018 15:10:49 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180628131049.GA14956@andrea>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
 <20180628130258.GF7646@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628130258.GF7646@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, Jun 28, 2018 at 06:02:58AM -0700, Matthew Wilcox wrote:
> On Thu, Jun 28, 2018 at 12:41:19PM +0200, Andrea Parri wrote:
> > + * smp_mb__after_spinlock() provides a full memory barrier between po-earlier
> > + * lock acquisitions and po-later memory accesses.
> 
> What does po-earlier mean?  Partial order?

"po" was intended as an abbreviation for "program order"; I should have
kept the whole form..., thank you for the feedback.

  Andrea
> 
