Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAA0C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD22081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFD22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeK3OWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:22:31 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:45798 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeK3OWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:22:30 -0500
Received: by mail-pf1-f182.google.com with SMTP id g62so2048205pfd.12;
        Thu, 29 Nov 2018 19:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfsE2y5uyGQ+xDaWwbYRWfame/GiD1QyJljdjs1QLr0=;
        b=QKb+2WR/DIVi9vquR3W3bUBe6OI2WmQAUnUr293gSoYrnvp+SWmGy8ozh4Yct+yCv3
         dAS2PW2AsHNksE5ynlPtySNPRs1oTTMJdNVFhzX3k6i8xMrFgQiF0CW6kmOSZWTauZ8u
         1X04V1PZClZ1aa4bsuSDxhJNrtdYH9WBDmHnVf7dMR9Dw8D1a5wv70Q/srxlYDAVqPaJ
         tPDUHIk3sJeRLpEItl/qppjEs9GS1Smou5XQdR89E4h9ZAauIphto75LE+2r7H508bOZ
         mRzzNXtjd4pYJyk0YFqYCXc7PmFVf6GAaAFias8cq4We41uyo5QjqQ5LJohyYPMLsEyk
         JnHg==
X-Gm-Message-State: AA+aEWadW8aBwyuXeBYSe61m7ypaGygPDf06/AV0M99YMN+4cBAfAQRy
        n1RYGW+Sce3tTCjQhhxvKbY=
X-Google-Smtp-Source: AFSGD/VcsOoRaNZL9I8RiIn16yTR0owFi8RuqlMbiG6rdapRT9fEV5ZKDcuBfC4zYMRNlTB1dSRfIQ==
X-Received: by 2002:a63:ba19:: with SMTP id k25mr3412439pgf.194.1543547683131;
        Thu, 29 Nov 2018 19:14:43 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id e16sm4936370pfn.46.2018.11.29.19.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:14:41 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:14:38 -0800
Date:   Thu, 29 Nov 2018 19:14:38 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, mcgrof@kernel.org,
        Alexander.Levin@microsoft.com, levinsasha928@gmail.com
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181130031438.GQ4922@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-2-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:36:18AM -0800, Brendan Higgins wrote:
> +#define module_test(module) \
> +		static int module_kunit_init##module(void) \
> +		{ \
> +			return kunit_run_tests(&module); \
> +		} \
> +		late_initcall(module_kunit_init##module)

Here in lies an assumption that suffices. I'm inclined to believe we
need new initcall level here so to ensure we *do* run after all the
respective kernels iniut calls. Otherwise we're left at the whims of
link order for kunit. For instance if a kunit test relies on frameworks
which are also late_initcall() we'd have complete incompatibility with
anything linked *after* kunit.

> diff --git a/kunit/Kconfig b/kunit/Kconfig
> new file mode 100644
> index 0000000000000..49b44c4f6630a
> --- /dev/null
> +++ b/kunit/Kconfig
> @@ -0,0 +1,17 @@
> +#
> +# KUnit base configuration
> +#
> +
> +menu "KUnit support"
> +
> +config KUNIT
> +	bool "Enable support for unit tests (KUnit)"
> +	depends on UML

Consider using:

if UML
   ...
endif

That allows the depends to be done once.

> +	help
> +	  Enables support for kernel unit tests (KUnit), a lightweight unit
> +	  testing and mocking framework for the Linux kernel. These tests are
> +	  able to be run locally on a developer's workstation without a VM or
> +	  special hardware.


Some mention of UML may be good here?

> For more information, please see
> +	  Documentation/kunit/
> +
> +endmenu

I'm a bit conflicted here. This currently depends on UML but yet you
noted on RFC v2 that your intention is to liberate kunit from UML and
ideally allow unit tests to depend only on userspace. I've addressed
tests using both selftests kernels drivers and also re-written kernel
APIs to userspace to test there. I think we may need to live with both.

Then for the UML stuff, I think if we *really* accept that UML will
always be a viable option we should probably consider now throwing these
things under drivers/platform/uml/. This follows the pattern of arch
specific drivers. Whether or not we end up with a complete userspace
component independent of UML may implicate having a shared component
somewhere else.

Likewise, I realize the goal is to *avoid* using a virtual machine for
these tests, but would it in any way make sense to share kunit to be
supported for other architectures to allow easier-to-write tests as
well?

  Luis
