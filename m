Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6488C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF2420855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ceNtWdzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF2420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeIHOoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:44:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54118 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIHOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:44:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so16906557wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bFBAOxMrM35yrh7ri5v+LG8kkJ5SoJ6ayi0r6ggM1rU=;
        b=ceNtWdzbEoIryvZ9PX9C9+cpmXKEPSoXOGvcBdOMYx2I9s/dxygdgYvxmfiltmzx5+
         AZzkCLNxul0fAacOidCeNqg5NO8oEwDYY65549Mwo0HsNzyk4SYI7t9d8jueTuGyYL6d
         pWtCxy+s4OGHKJEgUp+HSJ7/MXBrzMM8H6gJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFBAOxMrM35yrh7ri5v+LG8kkJ5SoJ6ayi0r6ggM1rU=;
        b=bGv/uAHqK0xSiIJu+5uvI65CaAZ0eahExENkruaslpItyo/kzHE1jY1dnd1A+utOHl
         4pJnm5ulbISfAIBMKrTixFLq/9QELSLj3Kwuq8LWVE7Gpolvi0WvSeoUcrp496g2S8rO
         iqnSKVYjOHc849CqtTKftgGIQ3vtSsKOBScguN/c20V1sifTCAaeHNOQ7J1v8XU54DNI
         DSXZFVDYZdWEbskoxyKHOSnSK0yZwiYIijprYmKFaEP613KaCoifenHUu/zYOYdvpfOf
         JIPnMUjcvDympUtysaL0T8OE/x80tGqQlrYyku3wfcvVELo6Vp3vg9T3pd4OPhlHQ2NH
         9DCw==
X-Gm-Message-State: APzg51CmLLhvUIik/e5bVwdD/xzuVbXQPWEpUsAEoYgBzRen5PpBfr8W
        Xq4N5cGKn64sJZqvKDCPWsiPSg==
X-Google-Smtp-Source: ANB0VdYherFNvb0b0XIR7bnFQOI5iDvJDspElepM42f9XuUc7Mj9tyAGyrPZQoFzlI1yOfmPU0U6EA==
X-Received: by 2002:a1c:98cc:: with SMTP id a195-v6mr7550032wme.64.1536400741951;
        Sat, 08 Sep 2018 02:59:01 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id t69-v6sm7789069wmt.40.2018.09.08.02.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 02:59:01 -0700 (PDT)
Date:   Sat, 8 Sep 2018 11:58:48 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Daniel Lustig <dlustig@nvidia.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180908095848.GA6272@andrea>
References: <20990a3f-1507-c98b-f14e-2f5241319d8c@nvidia.com>
 <Pine.LNX.4.44L0.1809071256340.1547-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809071256340.1547-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Will feels strongly (and Linus agrees) that the LKMM should not require
> ordinary acquire and release to be any stronger than RCpc.
> 
> The issue that Andrea raised has to do with qspinlock, qrwlock, and
> mcs_spinlock, which are implemented using smp_cond_load_acquire()  
> instead of RMW-acquire.  This provides only the ordering properties of
> smp_load_acquire(), namely RCpc, which means that qspinlocks etc. might
> not be RCtso.
> 
> Since we do want locks to be RCtso, the question is how to resolve this 
> discrepancy.

[...]

> To tell the truth, I'm not aware of any code in the kernel that
> actually _needs_ RCtso ordering for locks, but Peter and Will are quite
> firm that it should be required.  Linus would actually like locks to be
> RCsc, but he recognizes that this would incur a noticeable performance
> penalty on Power so he'll settle for RCtso.

It does look like Will, Peter, Linus and me could help you put together
a satisfactory patch description! ;-)  I'm not sure I agree with all
you're claiming/concluding above..., but again: why don't you try to
collect what, in your opinion, are the relevant arguments/comments from
previous reviews of the patch (which, unfortunately, goes back to July)
and then send an updated version?  (I do have the impression that these
discussions would have been much more "easy to follow" if you only did
that time ago/with higher frequency...)

  Andrea
