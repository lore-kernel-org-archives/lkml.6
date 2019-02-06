Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75766C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42579217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549482731;
	bh=w+DGFDTLkP77xayNW0w9JiSIyI48OufI8Y2ZmervkNo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yWdfKZ3drlJvFvKXn2TGDZpTtda3/bLQId5TqVoprVfJc4FbjA3OBcOY4619AW81Q
	 mu7t9Nxkn6+ZhILimhk68FNI1Z4vZ0Elg9dhf+/Kx9KODmuHP2Xdjk3pV3azBHUCUG
	 hUOX6xQM+gzzY/s/8ofqp8gaZqSlmt/dZIHzwOug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBFTwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:52:09 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43063 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFTwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:52:09 -0500
Received: by mail-yw1-f65.google.com with SMTP id u200so3632272ywu.10;
        Wed, 06 Feb 2019 11:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MSVhCOK7rMXrMnBSLKltiXtG9QzJqhjoir0Y7Ntls3c=;
        b=FKUKxUoasMRjF57OKehoZon53ZPx1HG813SjdHT+f3mRavOKEvvk4d1PMufjjKhkl7
         IbUKhenmXA7gNeE9QuPFX/vJmnYwLVhQ/ZJMDNpM6v0EjCVYoAWeLdd24u14xrtROnfP
         2W0POEDa8IW8hKwMy5pdZopsrgCZQhpwIosWBS6l/TrKTPDxH3BluLkrXZ+lLvPKWkB0
         /FI+zDeiXgZVQ4a2cp3urHpewQKG/6dRHJYcN+Tb2+M8UYV4siPEqc/9LM9DMLhAONqF
         babm2lccBSH9/Z/KASR1hT6oGLbBx6CGIzgUGjnk41Ybb2WW65p/GRoOg7dTy3g1K490
         sl6A==
X-Gm-Message-State: AHQUAub9OFLsCUGvQ9NlFzb+ILcqi6Nd3v7GDvZod6qjvAEWy4JhLAOk
        rcZATUZR3LQLVZ0jNdaVmzs=
X-Google-Smtp-Source: AHgI3IYgS5fB6kOCNQjl03Mf1yuO+8Z1DoiVZcLE9r6Xftfdoc3AsbgaRnWRQqlIHzuvrbFKbDnfpg==
X-Received: by 2002:a0d:e8c9:: with SMTP id r192mr3641239ywe.321.1549482727690;
        Wed, 06 Feb 2019 11:52:07 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id e194sm5777996ywa.85.2019.02.06.11.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:52:06 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Wed, 06 Feb 2019 11:52:02 -0800
Date:   Wed, 6 Feb 2019 11:52:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
        yzaikin@google.com, brendanhiggins@google.com
Subject: Re: [PATCH 1/2] test_sysctl: add tests for >32-bit values written to
 32-bit integers
Message-ID: <20190206195202.GF11489@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patches, please include akpm@linux-foundation.org in the
future, as we can merge the changes through Andrew as well.

Also please Cc yzaikin@google.com, brendanhiggins@google.com in follow
ups for now.  They are looking at the sysctl testing code as well.

Some feedback below:

In-Reply-To: <20181227111231.12912-2-zev@bewilderbeest.net>

On Thu, Dec 27, 2018 at 05:12:29AM -0600, Zev Weiss wrote:
> +run_wideint_tests()
> +{
> +	# check negative and positive 64-bit values, with and without
> +	# bits set in the lower 31, and with and without bit 31 (sign
> +	# bit of a 32-bit int) set.  None of these are representable
> +	# in 32 bits, and hence all should fail.
> +	check_failure 0x0000010000000000
> +	check_failure 0x0000010080000000
> +	check_failure 0x000001ff7fffffff
> +	check_failure 0x000001ffffffffff
> +	check_failure 0xffffffff7fffffff


> +	check_failure 0xffffffffffffffff

This s64 version of -1

> +	check_failure 0xffffff0000000000
> +	check_failure 0xffffff0080000000
> +}

It was still unclear from the comments and manually looking at the
values why they are clear candidates to always test from all respective
64-bit values. A comment per each would be useful.

  Luis
