Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD2CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D0F2145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 03:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D0F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeLAONq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:13:46 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:37211 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLAONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:13:46 -0500
Received: by mail-pf1-f176.google.com with SMTP id y126so3715651pfb.4;
        Fri, 30 Nov 2018 19:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y8FFqlo+hs5jsQ9Y7l6rpCXKk9O09swMpG6+1RK/fCg=;
        b=TI+EkpGpCGpNq2mDJCgVTtVxLx2Q+7uaUr0yU0wd+rLfF8rxNnuIQDxdybPp3cQWzA
         ub0MvotVLTI4/OS3fxlmJjPXibXTlo5n5XvELptxJUXpmmBPimUcMq7YahuNAmejJtqQ
         hfH5jmXMsHukvwaj/Vho5XhubweDoJdtLUpwKYnQrMBTcH3YxLtWnskOpp8iHCwtRWy4
         jh9lNkVj/MAPGLueLuiSrhhOAuArfiwG2totPpG0wmeFgFNz7x7lI0Ma521LslO9CpzR
         fXvwPy7f4ChgprVLwtR4T69hV0WxLzi1BvLDyXMu9XjIuoMkPUvFsHsHkX+BdKaxxEYj
         AzkQ==
X-Gm-Message-State: AA+aEWbGrqlJekMZCsFrqpSsHYlrytItG0nj02C3eIe7iRfnpwVu8fUL
        NANQL+4ZaXVP1M+JrGpnU+4=
X-Google-Smtp-Source: AFSGD/UG09HxftfijPmsXT2rNLX7wlL/Vs1t3kQqLG9nVsFe3m4niFPnTyhorK0ItoofppSsekL9EA==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr3076526pfh.228.1543633339449;
        Fri, 30 Nov 2018 19:02:19 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id n68sm10221567pfb.62.2018.11.30.19.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 19:02:18 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 19:02:15 -0800
Date:   Fri, 30 Nov 2018 19:02:15 -0800
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
        knut.omang@oracle.com, Petr Mladek <pmladek@suse.com>,
        alexander.h.duyck@linux.intel.com
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181201030215.GJ28501@garbanzo.do-not-panic.com>
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
> +int kunit_run_tests(struct kunit_module *module)
> +{
> +	bool all_passed = true, success;
> +	struct kunit_case *test_case;
> +	struct kunit test;
> +	int ret;
> +
> +	ret = kunit_init_test(&test, module->name);
> +	if (ret)
> +		return ret;
> +
> +	for (test_case = module->test_cases; test_case->run_case; test_case++) {
> +		success = kunit_run_case(&test, module, test_case);

We are running test cases serially, why not address testing
asynchronously, this way tests can also be paralellized when possible,
therefore decreasing test time even further.

Would that mess up the printing/log stuff somehow?

  Luis
