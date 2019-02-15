Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5673C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1A3222DB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550264091;
	bh=ZV7cv8ytdewnvDsiXyMJqgaj14HKjDUV+zxpmQSk08E=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=yezdqdyA+XsoJqlKq0PxSkHM5rsYW2Uy4HA6/Ll/gMxJpxy7NdQQSfNJsSCraKMej
	 938JRRkODnkqLvRN9ktD1Fs0OH8AzHa8ejAAR+APjpiAzsZL9194G4jNyESbBj4NxD
	 HilFJutw6uodX+ECzF7mJdvo22sViC73DvymicYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390649AbfBOUyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfBOUyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:54:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6387C222D7;
        Fri, 15 Feb 2019 20:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550264088;
        bh=ZV7cv8ytdewnvDsiXyMJqgaj14HKjDUV+zxpmQSk08E=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=oekEGZiPI6h1EZRxpe/+q+Pv7onQc6BxBQO/Fca0rrCf42EhUgKsHBrol7aZUe8D4
         K6YiWpMsJmtcB2hAxWqNmEHz1ZJNlxBiKQt+l1wA7lj6m206fesCbTROND5y6woVBa
         G9M4thInXQmCV7fe6e+OCZxdLij8aM2AsfX5HhCc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org
In-Reply-To: <20190214213729.21702-11-brendanhiggins@google.com>
User-Agent: alot/0.8
Subject: Re: [RFC v4 10/17] kunit: test: add test managed resource tests
Message-ID: <155026408761.115909.17855438744578437385@swboyd.mtv.corp.google.com>
References: <20190214213729.21702-1-brendanhiggins@google.com> <20190214213729.21702-11-brendanhiggins@google.com>
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
        Brendan Higgins <brendanhiggins@google.com>,
        Avinash Kondareddy <avikr@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 12:54:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-02-14 13:37:22)
> diff --git a/kunit/test-test.c b/kunit/test-test.c
> index 0b4ad6690310d..bb34431398526 100644
> --- a/kunit/test-test.c
> +++ b/kunit/test-test.c
[...]
> +
> +#define KUNIT_RESOURCE_NUM 5
> +static void kunit_resource_test_cleanup_resources(struct kunit *test)
> +{
> +       int i;
> +       struct kunit_test_resource_context *ctx =3D test->priv;
> +       struct kunit_resource *resources[KUNIT_RESOURCE_NUM];
> +
> +       for (i =3D 0; i < KUNIT_RESOURCE_NUM; i++) {

Nitpick: This could use ARRAY_SIZE(resources) and then the #define could
be dropped.

> +               resources[i] =3D kunit_alloc_resource(&ctx->test,
> +                                                   fake_resource_init,
> +                                                   fake_resource_free,
> +                                                   ctx);
> +       }
> +
> +       kunit_cleanup(&ctx->test);
> +
> +       KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
> +}
> +
[...]
> +
> +static struct kunit_case kunit_resource_test_cases[] =3D {

Can these arrays be const?

> +       KUNIT_CASE(kunit_resource_test_init_resources),
> +       KUNIT_CASE(kunit_resource_test_alloc_resource),
> +       KUNIT_CASE(kunit_resource_test_free_resource),
> +       KUNIT_CASE(kunit_resource_test_cleanup_resources),
> +       {},
> +};
