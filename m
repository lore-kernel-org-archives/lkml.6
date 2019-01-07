Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B19C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFA72089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfAGVxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:53:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37440 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfAGVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:53:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id g125so1209013qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XscXXsUqMIUZrTmARrC5SmhRBALRJ2JqQUFxn6IIhQM=;
        b=m96Bmp1GVIgJOo6oH2ZA/SP4v4JVOtuFgAmfA25TrcX9mVtWQ48WUYUV9ZAzegfVfV
         1djf6t4TTMRWBo7VTY0+nwibnMF7BQOcgmjRuk168xISgplW/qtgiSxdFLbtTWFtDKfg
         bbUlPfVI3DplCCLdEClYe8Lgk5uhUSoiMQASD4g8LQZzS79ApY45FqksOyVWGQcKiCxn
         h4C9ra+9T5mDqu6MU6JD8uQlKmufG/6tRUC2TUgz+TRMiqCUGdjyNzzgLrJ/wPNnmuTA
         Dx9Yc77+R6iZCVT5zdHIZKTDgCBg6lqqSs+nFMa9gUlZ/kUoHNLpdhoarjeWKhwj/lpb
         QE5w==
X-Gm-Message-State: AJcUukdZLbbP2PzD/2i61IBGQDaaDLdxK+8aKVHpseARtsQxe0MMVc2v
        UT8MB1qUgAPenCBH5i17R0Yvmw==
X-Google-Smtp-Source: ALg8bN6/GEK0em4Dh5XroXwGuSDYTw865EVky9OyUaJcRwPM62t8IVGhBAX5zQpwQkS+CbRDH3K2yA==
X-Received: by 2002:a37:8006:: with SMTP id b6mr20686649qkd.19.1546898001920;
        Mon, 07 Jan 2019 13:53:21 -0800 (PST)
Received: from trogon.sfo.coreos.systems ([2604:2000:80c5:4400:140c:73de:b623:c90])
        by smtp.gmail.com with ESMTPSA id w52sm38537702qtc.51.2019.01.07.13.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 13:53:21 -0800 (PST)
Date:   Mon, 7 Jan 2019 16:53:18 -0500
From:   Benjamin Gilbert <bgilbert@redhat.com>
To:     Wei Huang <wei@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-x86_64@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/boot/compressed/64: Set EFER.LME=1 in 32-bit
 trampoline code before returning to long mode
Message-ID: <20190107215318.GA22396@trogon.sfo.coreos.systems>
References: <20190104054411.12489-1-wei@redhat.com>
 <20190107082512.w5gkbebsypionyey@black.fi.intel.com>
 <6899e645-9579-f599-922a-eb26fc56e8ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6899e645-9579-f599-922a-eb26fc56e8ab@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:03:15PM -0600, Wei Huang wrote:
> On 1/7/19 2:25 AM, Kirill A. Shutemov wrote:
> > On Fri, Jan 04, 2019 at 05:44:11AM +0000, Wei Huang wrote:
> >> In some old AMD KVM implementation, guest's EFER.LME bit is cleared by KVM
> >> when the hypervsior detects guest sets CR0.PG to 0. This causes guest OS
> >> to reboot when it tries to return from 32-bit trampoline code because CPU
> >> is in incorrect state: CR4.PAE=1, CR0.PG=1, CS.L=1, but EFER.LME=0.
> >> As a precaution, this patch sets EFER.LME=1 as part of long mode
> >> activation procedure. This extra step won't cause any harm when Linux is
> >> booting on bare-metal machine.
> >>
> >> Signed-off-by: Wei Huang <wei@redhat.com>
> > 
> > Thanks for tracking this down.
> 
> BTW I think this patch _might_ be related the recent reboot issue
> reported in https://lkml.org/lkml/2018/7/1/836 since the symptoms are
> exactly the same.

The problem in that case turned out to be https://lkml.org/lkml/2018/7/4/723
which was fixed by d503ac531a.

--Benjamin Gilbert
