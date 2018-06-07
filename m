Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HCTcCSx+GVvSXAAAmS7hNA
	; Thu, 07 Jun 2018 18:49:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3B3B56089E; Thu,  7 Jun 2018 18:49:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtrF+tr9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B3DC8606DD;
	Thu,  7 Jun 2018 18:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3DC8606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932416AbeFGStQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932373AbeFGStN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:49:13 -0400
Received: from mail-wr0-f181.google.com (mail-wr0-f181.google.com [209.85.128.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37AF3208B1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528397353;
        bh=crbJkwTStLUzTuNVU01tdjm1kf88uyd/+FByIXqhZu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gtrF+tr9mtgO+zr88VaZ6BT8kt3AaVa7gphT4iuEFeJp00TBxtk6D44BsMuImftsc
         d1soH5MA1tI1EaR5/mg8HyeTT9TS0d4lHoXhc9Y3QBw4sF4Zk5LFARZ1wJe3/FAf6S
         EcixHyvokfTTSW5PfaN7I14raG8S12jVMfs3418M=
Received: by mail-wr0-f181.google.com with SMTP id w10-v6so10869592wrk.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:49:13 -0700 (PDT)
X-Gm-Message-State: APt69E2g84mT/K8fbVHAI76W8J2ntx9I65fW57IzjyfhRtWgguT5hzIb
        I9vSFtxB4PeuwqyOE52DVCas9stBl6i0aCC/gdhSLA==
X-Google-Smtp-Source: ADUXVKKcssBNw43uWQR7fRpxR81LkXSciyBwdGCavGt63/lG6zvaBnoj20T0EOMxRFF51K3ukLayBjPH27QnF7fYMx4=
X-Received: by 2002:adf:e084:: with SMTP id c4-v6mr2563276wri.199.1528397351735;
 Thu, 07 Jun 2018 11:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-9-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-9-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:48:59 -0700
X-Gmail-Original-Message-ID: <CALCETrVX8nE6oFnJH7yZCydxtnC-VAhhnYs=ekJELc07a2UKiQ@mail.gmail.com>
Message-ID: <CALCETrVX8nE6oFnJH7yZCydxtnC-VAhhnYs=ekJELc07a2UKiQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] mm: Prevent mremap of shadow stack
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Please justify.  This seems actively harmful to me.
