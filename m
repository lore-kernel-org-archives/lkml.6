Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C379BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC7C20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bySd643V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC7C20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbeGKQW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:22:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42341 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733263AbeGKQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:22:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1-v6so18762583wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvxQwc8CGh8Y6dzq1i6hAVLrUPeugDRu3vUfcZIcsxw=;
        b=bySd643Vj/t54Z9kgKGQi5KgQEjh1/s3ENv7O5YaIcvhYqQh0dWlRghhlcfqZF6+GS
         AmGshn/cZhHS0sCEPH8cVTg5TPlevQtA2ibPa+6q7Y4PnVJSw+C1u/ixGz08z0Uw8HKv
         yhtBPgyImbGILy5K2VyTqRAbfEXSRKbld+tdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvxQwc8CGh8Y6dzq1i6hAVLrUPeugDRu3vUfcZIcsxw=;
        b=d1VXCI9Szbf5z33I/O/WVBOtphtMYsHY8IWGX30FwAqOITIGFMgslnMlC68X8eXlYA
         4C7bHWxcGWVFs7CS7xbgnydB71nLG/23o7DR+Vf+Wj09p7LOU2ZS6RrrPPXYHtfqHAx2
         uel9yK1XEY1TAkLBB3WnVYHHH9P0+bJnr7yGf87TTZFkxc3v7g6Ijy7/xRDC3jU79SPn
         PF3dzD3tGMWwJW4AwHFa9X+p/BSci4QZot1RtG06QKBQAjl60RKbMYKWVoHQXh5rHCLa
         hks7Dp6k/UIu1Vfj5A5bVd13mU48sExihdD9Vg79+RNg/abQEQkTPWgd7lu1BwCMvcWo
         Xelw==
X-Gm-Message-State: APt69E0dWcIMW1f1euiScB2csL+/77bUhzLNKg13aL9VezfYjyYEXrh1
        HhVHcwn3uUINx3PCpuAKQVE/WA==
X-Google-Smtp-Source: AAOMgpeYUPfXcwhebtSdEwfnQlA9wCRdkBeRlPyc06d58+ZdRJXduXZcth82fd1eFs7pYz0rGoCp3g==
X-Received: by 2002:adf:f50e:: with SMTP id q14-v6mr19814384wro.241.1531325844023;
        Wed, 11 Jul 2018 09:17:24 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id 6-v6sm3335106wmi.26.2018.07.11.09.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:17:23 -0700 (PDT)
Date:   Wed, 11 Jul 2018 18:17:17 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711161717.GA14635@andrea>
References: <20180710162555.GV3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807101416390.1449-100000@iolanthe.rowland.org>
 <20180711094344.GE13963@arm.com>
 <20180711154211.GT3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711154211.GT3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:42:11AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 11, 2018 at 10:43:45AM +0100, Will Deacon wrote:
> > Hi Alan,
> > 
> > On Tue, Jul 10, 2018 at 02:18:13PM -0400, Alan Stern wrote:
> > > More than one kernel developer has expressed the opinion that the LKMM
> > > should enforce ordering of writes by locking.  In other words, given
> > > the following code:
> > > 
> > > 	WRITE_ONCE(x, 1);
> > > 	spin_unlock(&s):
> > > 	spin_lock(&s);
> > > 	WRITE_ONCE(y, 1);
> > > 
> > > the stores to x and y should be propagated in order to all other CPUs,
> > > even though those other CPUs might not access the lock s.  In terms of
> > > the memory model, this means expanding the cumul-fence relation.
> > > 
> > > Locks should also provide read-read (and read-write) ordering in a
> > > similar way.  Given:
> > > 
> > > 	READ_ONCE(x);
> > > 	spin_unlock(&s);
> > > 	spin_lock(&s);
> > > 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> > > 
> > > the load of x should be executed before the load of (or store to) y.
> > > The LKMM already provides this ordering, but it provides it even in
> > > the case where the two accesses are separated by a release/acquire
> > > pair of fences rather than unlock/lock.  This would prevent
> > > architectures from using weakly ordered implementations of release and
> > > acquire, which seems like an unnecessary restriction.  The patch
> > > therefore removes the ordering requirement from the LKMM for that
> > > case.
> > > 
> > > All the architectures supported by the Linux kernel (including RISC-V)
> > > do provide this ordering for locks, albeit for varying reasons.
> > > Therefore this patch changes the model in accordance with the
> > > developers' wishes.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Thanks, I'm happy with this version of the patch:
> > 
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> 
> I have applied your Reviewed-by, and thank you both!
> 
> Given that this is a non-trivial change and given that I am posting
> for -tip acceptance in a few days, I intend to send this one not
> to the upcoming merge window, but to the one after that.
> 
> Please let me know if there is an urgent need for this to go into the
> v4.19 merge window.

I raised some concerns in my review to v2; AFAICT, these concerns have
not been resolved: so, until then, please feel free to add my NAK. ;-)

  Andrea


> 
> 							Thanx, Paul
> 
