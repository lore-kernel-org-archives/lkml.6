Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE9C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7173020671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FMPJZlWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7173020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeJWWgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:36:19 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41860 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:36:19 -0400
Received: by mail-lj1-f169.google.com with SMTP id u21-v6so1518757lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bq7AIYDkDFku49TgH+UsRGqvL0JuSt96vBIwTG3vbJc=;
        b=FMPJZlWa8zxWBpkU7Li2ydjXLulm8kjoUtS2s9cfdow4qZSPUKev9jBTvgfS+vEsSg
         eOUEHr7NrJ5i+oPM67rMD6qYQUeVWDJYcmkGWPeNFZ+VPV7Qx5NSyIxdpSHz0yDblYuY
         thQDp0bw06bd1I5hzKeQwffZh1duYpgMsZPQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bq7AIYDkDFku49TgH+UsRGqvL0JuSt96vBIwTG3vbJc=;
        b=AgEmSdOeVS3QP6+Kl0xwHlEqrS4WC7dyE/tzOwJL512VuCunrVjtLSzm3fMFdk+8cE
         reTE4kXR9W0RFTk1Jjkw7gVdpuV7pxTsharZOonrwOwQjV2gCeIEXQ0fCI80wqJBnku0
         SYswBkVqsXo/2WOkIX7xafYL0TPLDU9bUD++NuceOvnBVldiEmGVmKJA28SavSKVF5AT
         Acw2DPjkwKKYyX4TkglOMJhgUZSG5d6lbpAEydlvZUl1F/FSyfjV+wjgsO7eGWzK49wK
         OFFG6vExKVTVkaIPzllPxdBpiPjMPAtsLjeMBexPu9dXjkCutzi7DE5hEfEehZzPjg8i
         ASUw==
X-Gm-Message-State: AGRZ1gL2YUAlw2GXh0ddmnYEUfKCpji9px/H1z4AXSUiHnHqG4YT5+uu
        GCFhox7lfrVjMwmlcU4mn9Q4VaekTeHehnjJ
X-Google-Smtp-Source: AJdET5c6h6pmLC6EzGQMMfmciWZ97eK+NWobxOjeKjQyQ1kOuDCu+t3mXVqBLcD7hgp/LtvxaSsn/A==
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr9660885lja.38.1540303959698;
        Tue, 23 Oct 2018 07:12:39 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n16-v6sm222257lji.28.2018.10.23.07.12.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 07:12:38 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id c4-v6so1531958lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 07:12:38 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr12254867ljj.80.1540303958235;
 Tue, 23 Oct 2018 07:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181023110600.GA43785@gmail.com>
In-Reply-To: <20181023110600.GA43785@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 15:12:22 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgAA7jjZRm1nixAWDYgcRf6rkR9X-xMEwhU8+T1F-+XMg@mail.gmail.com>
Message-ID: <CAHk-=wgAA7jjZRm1nixAWDYgcRf6rkR9X-xMEwhU8+T1F-+XMg@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler updates for v4.20
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, tglx@linutronix.de,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 12:06 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest sched-core-for-linus git tree from:

Hmm. I've pulled, but this message was odd and mis-formed.

First off, it didn't have a diffstat (I did verify the shortlog instead).

Secondly, can you please check how you send emails. I get a DMARC
failure on that email, looking like this:

  ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iFVXLHcJ;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com
designates 209.85.220.65 as permitted sender)
smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

so it seems something is unhappy with how you had that

   Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
   From: Ingo Molnar <mingo@kernel.org>

set up. It looks like you went directly through gmail rather than
going through kernel.org and getting a proper kernel.org dkim hash.

Thirdly (and least importantly), you should probably check your MUA
(which seems to be Mutt), because this came in with

  Content-Type: text/plain; charset=iso-8859-1
  Content-Disposition: inline
  Content-Transfer-Encoding: 8bit

and using iso-8859-1 instead of utf-8 in this day and age is just all
kinds of odd.  It looks like it was all fine, but if Mutt has an
option to just send as utf-8, I encourae everybody to just use that
and try to just have utf-8 everywhere. We've had too many silly issues
when people mix locales etc and some point in the chain gets it
wrong..

                Linus
