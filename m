Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1062DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBFC2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F6YtvnbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBFC2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeHUBpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:45:30 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:55310 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:45:30 -0400
Received: by mail-it0-f46.google.com with SMTP id d10-v6so1590776itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axRbtXcSw+cbCFzq2W3Tj97e06BaqDX69Epi2UuGI4c=;
        b=F6YtvnbYsrr6Rhlr2gu1bgmhIyyKgxlUye3DzsxzSFM3u7HFEvWY7QZSLb1bFaKpFH
         1Ns9XKiPsP9l6/+QB8sB6sn16NR/opqDminDQYyqPqS8MmzgOVh1O4g1FcNgsD0411c+
         wHY52jXsm8sif2Azf7/sf7sb31FKokaT3SK4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axRbtXcSw+cbCFzq2W3Tj97e06BaqDX69Epi2UuGI4c=;
        b=GD3dJsG1f7fnlY/I81qfhpTDT1V0bi/ldNNhpE8ZyNvQ3Kjx7i9K4fQfNOCEyzoJiF
         5IGB1UUQYAaXFp7Hyhv4S8bgwNnQGs4bry2V9sS4Qu0tfLY4sFPjPG3C4C5Oom5K2/XH
         kZ+nJHQ2lxYuTm3uPUDoIJ1pjfPu/VIYqLB7bM7Kyt9XTIr16np29aXoMFJSpnfetQTh
         YIEOwrI6+y/8ji46wsepuuCB3yZapvPFPvyrUjuZ+x4E6BCyLQnfdoXU0ptsjkm7/lfB
         IJheN7NhMt/FQTT9J6yEKYLt3XmT6YFbaVDgphqJfAAVD2Ajb7+mRcB+xOXajWR3iDFC
         244w==
X-Gm-Message-State: AOUpUlGQBu7PE36zKzURx6QA8jewW36szc1Rf0m0i0OhFXAXg2c3VX62
        IBEWubvJgc1k2pUfIykJrEG2UljcmqRTAn2mS2c=
X-Google-Smtp-Source: AA+uWPzgQwktuFZFD4rqPyGNKnf40/cGROujMVk6SCEbzNLAj2gNEXsDcjQ48Ca1w2dFaUw1aMk7ws/g58VDwLn6Frs=
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr35038165itb.123.1534804083298;
 Mon, 20 Aug 2018 15:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180820212556.GC2230@char.us.oracle.com> <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk>
In-Reply-To: <1534801939.10027.24.camel@amazon.co.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 15:27:52 -0700
Message-ID: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     David Woodhouse <dwmw@amazon.co.uk>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>, jsteckli@os.inf.tu-dresden.de,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 3:02 PM Woodhouse, David <dwmw@amazon.co.uk> wrote:
>
> It's the *kernel* we don't want being able to access those pages,
> because of the multitude of unfixable cache load gadgets.

Ahh.

I guess the proof is in the pudding. Did somebody try to forward-port
that patch set and see what the performance is like?

It used to be just 500 LOC. Was that because they took horrible
shortcuts? Are the performance numbers for the 32-bit case that
already had the kmap() overhead?

                  Linus
