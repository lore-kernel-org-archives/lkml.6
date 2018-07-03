Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A0C24658
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqMcSEYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A0C24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbeGCIau (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:30:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36640 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeGCIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:30:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so1304588wmc.1;
        Tue, 03 Jul 2018 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U58CqrJwDfqEUqLyIEoQYFtpNT9vhJIqcTkegBF36hE=;
        b=EqMcSEYHva8e3zKR9OLDVAiirn9CXE+7wKqiJZz5yji1xjnLlrhKkA9drKiWQEbVLX
         HqcL0S/5PX6p7xt8w413Qj/88caUJgR5xFP6k+qLORJ6ycHHt5fEhahWggnnAm3vO//X
         FAiIupZ23lLhp/T0q6PR34OZnKZNucbnW2ml0P2QBEkpSIX9F0Mb2K/J0I89rNI7633F
         ARYc7ATYndMu0ohm5pciWOqFLVmGa9g0SZTrD2Q4q3FfffL1h5yHEZkAb/l1lt6e3r8n
         D+ku4kvaETv9+r+RzTltsNwEEQtUnKCavk/p/5z9IHODlEe7TksOxknb/182ZEofuLcP
         GdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U58CqrJwDfqEUqLyIEoQYFtpNT9vhJIqcTkegBF36hE=;
        b=JGEYO8UWwDXEdFkv17QJvvi+/O41PZrmMpz4X8JZ9KQt8F2d5K9mf+ufmCbac6059p
         1lW9Xs8KDZ7pjpXweqvhuqp7jixcNezFCyYBkCLinofzRjz/EKYDI28oJcmDOyfiz631
         HMdIgN58rdav6wXf2AsGlJwkA2mdekT6bC33D1DJSTYXDzH2IA7Di+ovJtiqfoYeXhxL
         NdImMU14mFwwKltMh5CjettaTTr+9BZiGfFikNd0gXdIh4qRLrGJhRI5IAF3lqh0r7O7
         WNPqWfVTHMdYBJ9Nlmvs1HeIEKYJfcxOH3g15dFNnl8WhXZ3YGOZEBV8SbeDzOps1Bsy
         2JGw==
X-Gm-Message-State: APt69E37ReP7plyRR1o4E/jNec1poDceUqoK83xV1GJYTnR+S3w8e4Ay
        tGUtVxlE8q8wEs5Knoa6tG0=
X-Google-Smtp-Source: AAOMgpci8BHkKTlOt3BkbMXrTFDn71zyAsKksLPFam7QBKfb8keywFBkt138QXTV31exIdLRKAoqDQ==
X-Received: by 2002:a1c:7908:: with SMTP id l8-v6mr7136193wme.80.1530606643667;
        Tue, 03 Jul 2018 01:30:43 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t9-v6sm693788wmh.41.2018.07.03.01.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 01:30:43 -0700 (PDT)
Date:   Tue, 3 Jul 2018 10:30:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe()
 exception handling
Message-ID: <20180703083040.GB971@gmail.com>
References: <20180702165803.GB19488@linux.intel.com>
 <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153056565378.3420.295180898468362039.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> Hi Ingo,
> 
> Here is an additional copy_to_iter_mcsafe() fix to address the crash
> reported by Ross. This now passes xfstests:generic/323 on my system.

The lib/iov_iter fix would need an Acked-by from Al.

Thanks,

	Ingo
