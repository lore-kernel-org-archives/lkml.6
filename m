Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF0420874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeLSTiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:38:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:6688 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbeLSTiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:38:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 11:38:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,373,1539673200"; 
   d="scan'208";a="111900886"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 19 Dec 2018 11:38:22 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8E974300B49; Wed, 19 Dec 2018 11:38:22 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:38:22 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH] x86/speculation: Don't inherit TIF_SSBD on execve()
Message-ID: <20181219193822.GU25620@tassilo.jf.intel.com>
References: <1545246590-12704-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545246590-12704-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:09:50PM -0500, Waiman Long wrote:
> With the default SPEC_STORE_BYPASS_SECCOMP/SPEC_STORE_BYPASS_PRCTL mode,
> the TIF_SSBD bit will be inherited when a new task is fork'ed or cloned.
> 
> As only certain class of applications (like Java) requires disabling
> speculative store bypass for security purpose, it may not make sense to
> allow the TIF_SSBD bit to be inherited across execve() boundary where the
> new application may not need SSBD at all and is probably not aware that
> SSBD may have been turned on. This may cause an unnecessary performance
> loss of up to 20% in some cases.
> 
> The arch_setup_new_exec() function is updated to clear the TIF_SSBD
> bit unless it has been force-disabled.

This makes it impossible to write a wrapper that turns this mode
on for unmodified programs.

Do you have a real use case where this behavior is a problem?

-Andi
