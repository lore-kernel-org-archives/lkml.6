Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B6D222DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550264514;
	bh=0d7/hARS75SzoprRrnLrfXPrT3UWHjpDyCJthpKQ1To=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=GNTQvnFS55LHvkvgMdqXe12KgfTTp7egeDnmQHMH7arMGOqPKOOCY9Zd/MAjPFgBh
	 WtTPh8tfwb3Sr0UN02cmXoMXF9ey0QVNQ6vEyIqkB+AP0rshLRRFB4Kcr3Z7Xfmk0u
	 oa4zVHkCGPUQqJAIK5+eZsjvYprgQSIya22N8Ui4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391818AbfBOVBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbfBOVBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:01:52 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B30D222A1;
        Fri, 15 Feb 2019 21:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550264511;
        bh=0d7/hARS75SzoprRrnLrfXPrT3UWHjpDyCJthpKQ1To=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=JWfILZbHsiVsxX9/tobHKR1dVqbYDSTDNnKaZAc7cPSwiEBoJ5iqz+8Pq0o65OSP5
         3u8Y1Te4ON7izdwItYq7jl4qYsAzP6Vx9u87v1tY7zRvJ7lA3C67MUOPvUSWhIaaCq
         aPQsYpq6k0EHKd/k2YhEAjHPPCfGVxi1k/x+TCj8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org
In-Reply-To: <20190214213729.21702-3-brendanhiggins@google.com>
User-Agent: alot/0.8
Subject: Re: [RFC v4 02/17] kunit: test: add test resource management API
Message-ID: <155026451067.115909.17082794837098610153@swboyd.mtv.corp.google.com>
References: <20190214213729.21702-1-brendanhiggins@google.com> <20190214213729.21702-3-brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 13:01:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-02-14 13:37:14)
> @@ -104,6 +167,7 @@ struct kunit {
>         const char *name; /* Read only after initialization! */
>         spinlock_t lock; /* Gaurds all mutable test state. */
>         bool success; /* Protected by lock. */
> +       struct list_head resources; /* Protected by lock. */
>         void (*vprintk)(const struct kunit *test,
>                         const char *level,
>                         struct va_format *vaf);
> @@ -127,6 +191,51 @@ int kunit_run_tests(struct kunit_module *module);
>                 } \
>                 late_initcall(module_kunit_init##module)
> =20
> +/**
> + * kunit_alloc_resource() - Allocates a *test managed resource*.
> + * @test: The test context object.
> + * @init: a user supplied function to initialize the resource.
> + * @free: a user supplied function to free the resource.
> + * @context: for the user to pass in arbitrary data.

Nitpick: "pass in arbitrary data to the init function"? Maybe that
provides some more clarity.

> + *
> + * Allocates a *test managed resource*, a resource which will automatica=
lly be
> + * cleaned up at the end of a test case. See &struct kunit_resource for =
an
> + * example.
> + */
