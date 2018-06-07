Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3h9rLdR3GVslLQAAmS7hNA
	; Thu, 07 Jun 2018 18:22:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9BDB26074D; Thu,  7 Jun 2018 18:22:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgYT53Bo"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2973C605A2;
	Thu,  7 Jun 2018 18:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2973C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935723AbeFGSWJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933152AbeFGSWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:22:06 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53182208B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 18:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528395725;
        bh=87KrFrL2yob3soM7BqH5pKZFRV5AMt3+eqpsu7DlzDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BgYT53BoDnbqFh64eh3IkOS2jor5WmSJe2V+MRYuPccpvEs4yvb8e2aUodAq5ru1/
         kh7MAIAF+e+jcw6/MUzu5zmjqbWjVx9HtdqM3vRRcV33sQsNrK5S3gBtVrlLZPgCBX
         REc83hyVBOE5kU2byaJ8Eb7ANw2mmbBRMCRiG/6c=
Received: by mail-wm0-f44.google.com with SMTP id x6-v6so19628123wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:22:05 -0700 (PDT)
X-Gm-Message-State: APt69E0kFjAz5fkUOqP59c+/zmFSE1/hcEuBxQ7qWLJj3/mObevFuSEa
        XBJfLlFjeA0R0J1hn8A4Y4GIhM0ohVIiyX0AKdDrfQ==
X-Google-Smtp-Source: ADUXVKKuvnewK/zoGK5MPBYH3F/Cluw/zCNI1KVCAHM7HXIJtm1Mxs272C3IbRYRjaoFZwUWyQzAlmU8AVnJEKqaZH8=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr2478788wma.21.1528395723668;
 Thu, 07 Jun 2018 11:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-5-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-5-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:21:51 -0700
X-Gmail-Original-Message-ID: <CALCETrUqXvh2FDXe6bveP10TFpzptEyQe2=mdfZFGKU0T+NXsA@mail.gmail.com>
Message-ID: <CALCETrUqXvh2FDXe6bveP10TFpzptEyQe2=mdfZFGKU0T+NXsA@mail.gmail.com>
Subject: Re: [PATCH 04/10] x86/cet: Handle thread shadow stack
To: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>
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
> When fork() specifies CLONE_VM but not CLONE_VFORK, the child
> needs a separate program stack and a separate shadow stack.
> This patch handles allocation and freeing of the thread shadow
> stack.

Aha -- you're trying to make this automatic.  I'm not convinced this
is a good idea.  The Linux kernel has a long and storied history of
enabling new hardware features in ways that are almost entirely
useless for userspace.

Florian, do you have any thoughts on how the user/kernel interaction
for the shadow stack should work?  My intuition would be that all
shadow stack management should be entirely controlled by userspace --
newly cloned threads (with CLONE_VM) should have no shadow stack
initially, and newly started processes should have no shadow stack
until they ask for one.  If it would be needed for optimization, there
could some indication in an ELF binary that it is requesting an
initial shadow stack.

But maybe some kind of automation like this patch does is actually reasonable.

--Andy
