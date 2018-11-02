Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C61C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935C02084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpfVtp1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935C02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbeKCDxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKCDxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:01 -0400
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1264E20854;
        Fri,  2 Nov 2018 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184288;
        bh=SM4Wpf2zBYd2WEx0/iln+4jyJvWCFLDbN2IDUHvNxh0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FpfVtp1Bd3578fIAWWRbMbv9zTJRPBU7e/3mMog6/9rkAw7EUNOcuzN4nvoivSRK5
         6JERz6wq6z/5Ns/UsuM/GsDz4ON7Df2/Q+pgXO+UtfTGhDzT84zpWBwztDlEnOEf0c
         pKz7e+EDXpN6Zxvy7deciH3vApc2m5WjPTkvsXm0=
Subject: Re: [RFC v2 01/14] kunit: test: add KUnit test runner core
To:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, Shuah Khan <shuah@kernel.org>
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <20181023235750.103146-2-brendanhiggins@google.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
Date:   Fri, 2 Nov 2018 12:44:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023235750.103146-2-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 05:57 PM, Brendan Higgins wrote:
> Add core facilities for defining unit tests; this provides a common way
> to define test cases, functions that execute code which is under test
> and determine whether the code under test behaves as expected; this also
> provides a way to group together related test cases in test suites (here
> we call them test_modules).
> 
> Just define test cases and how to execute them for now; setting
> expectations on code will be defined later.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  include/kunit/test.h | 165 ++++++++++++++++++++++++++++++++++++++++++
>  kunit/Kconfig        |  17 +++++
>  kunit/Makefile       |   1 +
>  kunit/test.c         | 168 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 351 insertions(+)
>  create mode 100644 include/kunit/test.h
>  create mode 100644 kunit/Kconfig
>  create mode 100644 kunit/Makefile
>  create mode 100644 kunit/test.c
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> new file mode 100644
> index 0000000000000..e0b14b227ac44
> --- /dev/null
> +++ b/include/kunit/test.h
> @@ -0,0 +1,165 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2018, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_TEST_H
> +#define _KUNIT_TEST_H
> +
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +
> +struct test;
> +
> +/**
> + * struct test_case - represents an individual test case.
> + * @run_case: the function representing the actual test case.
> + * @name: the name of the test case.
> + *
> + * A test case is a function with the signature, ``void (*)(struct test *)``
> + * that makes expectations (see TEST_EXPECT_TRUE()) about code under test. Each
> + * test case is associated with a &struct test_module and will be run after the
> + * module's init function and followed by the module's exit function.
> + *
> + * A test case should be static and should only be created with the TEST_CASE()
> + * macro; additionally, every array of test cases should be terminated with an
> + * empty test case.
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *
> + *	void add_test_basic(struct test *test)
> + *	{
> + *		TEST_EXPECT_EQ(test, 1, add(1, 0));
> + *		TEST_EXPECT_EQ(test, 2, add(1, 1));
> + *		TEST_EXPECT_EQ(test, 0, add(-1, 1));
> + *		TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
> + *		TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
> + *	}
> + *
> + *	static struct test_case example_test_cases[] = {
> + *		TEST_CASE(add_test_basic),
> + *		{},
> + *	};
> + *
> + */
> +struct test_case {
> +	void (*run_case)(struct test *test);
> +	const char name[256];
> +
> +	/* private: internal use only. */
> +	bool success;
> +};
> +

Introducing a prefix kunit_* might be a good idea for the API.
This comment applies to the rest of patches as well.

thanks,
-- Shuah
