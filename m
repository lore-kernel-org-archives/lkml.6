Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45378C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEC820989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClDBJbGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEC820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeKTUVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:21:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKTUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:21:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so1508025wmh.0;
        Tue, 20 Nov 2018 01:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r1Gaqae/pJv/yHYiqxnaEvj6zIGb7jvtUr4qFjNV/Ac=;
        b=ClDBJbGSJpT6DbZyegpyU1qht4WD0TwwhjG6cb2NLS8gFQNoGR4qMCCCB1czNGMKWb
         Ntxrls6vf79WlHlMJbges2NXlt3Sl1H5bHT1U1MXmDDyeeIuxGbgp9c3AToBNlNn4lNj
         NaM3g2KiWalthOqIQflD9P50RZXZ1caIZE7PKq4pBEszNuveJOihU6OtTlHjGLwBnW6I
         /PswOuZemuJJckM3RjTDq+P6KQNh6mdlgzoWQuWh5ZAgcMD0ik8uIKHscaLophalsOgG
         jnswGJgXHNP1x7Q4M7gpEHilVQnjxoM+mW+EskI3Y7Fi+493YM5dUwP4Qu1DjV2wAI33
         z1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1Gaqae/pJv/yHYiqxnaEvj6zIGb7jvtUr4qFjNV/Ac=;
        b=Wk3DYZNo1Q/MTTWulZ8LxiB6FtTvpByI9DOD2QC0UhTJ0zZVmboWi5CeGxLk+LtUp1
         6PyE1emS8QlsSqMVQpXgSsLLuovYZNSQw8GCbbKEinEB5MIe1vm3g0Aox3S4Ov10P9y2
         Rd5SQ57qK/yFxfa5MhF7JoPyuOxx5chDXxzBOA8v7Nq6Go5cvAA8GcOG45xbrnmXj6g2
         0WiCMBoD+dr8jJk9IVipmWKRN+TeSZnv7hIPaaltWVUJX0YHg0RNuK9ueAC+YCFTicK/
         a3GrVmkI/gsxh5k163E5PTYE1WPyGzKPDm8gvvg2SMEXa8UIYE9RfsFHW4JetTOcXWhV
         reXA==
X-Gm-Message-State: AA+aEWYmeZ2xa0pvVPEYj+N947VKZPujNYwqexy4+tvDtCEo8QVmNCky
        giyeUqv4j87+aW0jUA/XEbM=
X-Google-Smtp-Source: AJdET5dSjSij58XZUpdJld5dyMB1FlhS3lj1eWNL7qgCa5AoG1owvTs51Ns7Xzb+wQXV+pWNfbrnHg==
X-Received: by 2002:a1c:c44c:: with SMTP id u73mr1571159wmf.45.1542707577016;
        Tue, 20 Nov 2018 01:52:57 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a11sm1877783wmh.26.2018.11.20.01.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 01:52:56 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:52:53 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v6 01/26] Documentation/x86: Add CET description
Message-ID: <20181120095253.GA119911@gmail.com>
References: <20181119214809.6086-1-yu-cheng.yu@intel.com>
 <20181119214809.6086-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119214809.6086-2-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> +X86 Documentation
> +=======================
> +
> +Control-flow Enforcement
> +========================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   intel_cet
> diff --git a/Documentation/x86/intel_cet.rst b/Documentation/x86/intel_cet.rst
> new file mode 100644
> index 000000000000..dac83bbf8a24
> --- /dev/null
> +++ b/Documentation/x86/intel_cet.rst
> @@ -0,0 +1,268 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================
> +Control-flow Enforcement Technology (CET)
> +=========================================
> +
> +[1] Overview
> +============
> +
> +Control-flow Enforcement Technology (CET) provides protection against
> +return/jump-oriented programming (ROP) attacks.  It can be setup to
> +protect both the kernel and applications.  In the first phase,
> +only the user-mode protection is implemented in 64-bit mode; 32-bit
> +applications are supported in compatibility mode.
> +
> +CET introduces shadow stack (SHSTK) and indirect branch tracking
> +(IBT).  SHSTK is a secondary stack allocated from memory and cannot
> +be directly modified by applications.  When executing a CALL, the
> +processor pushes a copy of the return address to SHSTK.  Upon
> +function return, the processor pops the SHSTK copy and compares it
> +to the one from the program stack.  If the two copies differ, the
> +processor raises a control-protection exception.  IBT verifies all
> +indirect CALL/JMP targets are intended as marked by the compiler
> +with 'ENDBR' opcodes (see CET instructions below).
> +
> +There are two kernel configuration options:
> +
> +    INTEL_X86_SHADOW_STACK_USER, and
> +    INTEL_X86_BRANCH_TRACKING_USER.
> +
> +To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or later
> +are required.  To build a CET-enabled application, GLIBC v2.28 or
> +later is also required.
> +
> +There are two command-line options for disabling CET features:
> +
> +    no_cet_shstk - disables SHSTK, and
> +    no_cet_ibt - disables IBT.
> +
> +At run time, /proc/cpuinfo shows the availability of SHSTK and IBT.

What is the rough expected performance impact of CET on average function 
call frequency user applications and the kernel itself?

Thanks,

	Ingo
