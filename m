Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7687BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9121874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551213349;
	bh=AIx3XufD+dPEwB4nsVqiYidGa9V0OHwI0Gg79OXQryo=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=SWjbJBnXQKw6A6AdKPDkvTvp7CEerZdceKvw0SQYEmstyEqNNjANCpdUvknHTXQ14
	 pP2q8MbA9PKef2vpjkQjTEagpaI+jlgUJJWQrE6Xn3BWpHb3BYa4kKd6ZS1PUM1cN1
	 jhdiD8sjo0RhdCV85hQrCrFfgN5iiOw6X5a+vOa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfBZUfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbfBZUfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:35:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0971F21852;
        Tue, 26 Feb 2019 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551213346;
        bh=AIx3XufD+dPEwB4nsVqiYidGa9V0OHwI0Gg79OXQryo=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=YUHFuSudRSU6jgi9XFOrumYafgoHojlSVe6wKmEjxBocWNg7Ni1cr2z2p2K2WHgKd
         6O2vT6QzQPbfPiJvhtxLTuwNzHMvpvJdnlfjkp6kd+1QomHABOo+Ady1PrLFKWawRc
         jbrgj4gCIgdvZiBQxO7qggcNoUSOaDaccWhPuAUM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org
References: <20190214213729.21702-1-brendanhiggins@google.com> <20190214213729.21702-9-brendanhiggins@google.com>
Message-ID: <155121334527.260864.5324117081460979741@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
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
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190214213729.21702-9-brendanhiggins@google.com>
Date:   Tue, 26 Feb 2019 12:35:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2019-02-14 13:37:20)
> Add support for aborting/bailing out of test cases. Needed for
> implementing assertions.

Can you add some more text here with the motivating reasons for
implementing assertions and bailing out of test cases?

For example, I wonder why unit tests can't just return with a failure
when they need to abort and then the test runner would detect that error
via the return value from the 'run test' function. That would be a more
direct approach, but also more verbose than a single KUNIT_ASSERT()
line. It would be more kernel idiomatic too because the control flow
isn't hidden inside a macro and it isn't intimately connected with
kthreads and completions.

>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
[...]
> diff --git a/kunit/test-test.c b/kunit/test-test.c
> new file mode 100644
> index 0000000000000..a936c041f1c8f

Could this whole file be another patch? It seems to be a test for the
try catch mechanism.

> diff --git a/kunit/test.c b/kunit/test.c
> index d18c50d5ed671..6e5244642ab07 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
[...]
> +
> +static void kunit_generic_throw(struct kunit_try_catch *try_catch)
> +{
> +       try_catch->context.try_result =3D -EFAULT;
> +       complete_and_exit(try_catch->context.try_completion, -EFAULT);
> +}
> +
> +static int kunit_generic_run_threadfn_adapter(void *data)
> +{
> +       struct kunit_try_catch *try_catch =3D data;
> =20
> +       try_catch->try(&try_catch->context);
> +
> +       complete_and_exit(try_catch->context.try_completion, 0);

The exit code doesn't matter, right? If so, it might be clearer to just
return 0 from this function because kthreads exit themselves as far as I
recall.

> +}
> +
> +static void kunit_generic_run_try_catch(struct kunit_try_catch *try_catc=
h)
> +{
> +       struct task_struct *task_struct;
> +       struct kunit *test =3D try_catch->context.test;
> +       int exit_code, wake_result;
> +       DECLARE_COMPLETION(test_case_completion);

DECLARE_COMPLETION_ONSTACK()?

> +
> +       try_catch->context.try_completion =3D &test_case_completion;
> +       try_catch->context.try_result =3D 0;
> +       task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter,
> +                                            try_catch,
> +                                            "kunit_try_catch_thread");
> +       if (IS_ERR_OR_NULL(task_struct)) {

It looks like NULL is never returned from kthread_create(), so don't
check for it here.

> +               try_catch->catch(&try_catch->context);
> +               return;
> +       }
> +
> +       wake_result =3D wake_up_process(task_struct);
> +       if (wake_result !=3D 0 && wake_result !=3D 1) {

These are the only two possible return values of wake_up_process(), so
why not just use kthread_run() and check for an error on the process
creation?

> +               kunit_err(test, "task was not woken properly: %d", wake_r=
esult);
> +               try_catch->catch(&try_catch->context);
> +       }
> +
> +       /*
> +        * TODO(brendanhiggins@google.com): We should probably have some =
type of
> +        * timeout here. The only question is what that timeout value sho=
uld be.
> +        *
> +        * The intention has always been, at some point, to be able to la=
bel
> +        * tests with some type of size bucket (unit/small, integration/m=
edium,
> +        * large/system/end-to-end, etc), where each size bucket would ge=
t a
> +        * default timeout value kind of like what Bazel does:
> +        * https://docs.bazel.build/versions/master/be/common-definitions=
.html#test.size
> +        * There is still some debate to be had on exactly how we do this=
. (For
> +        * one, we probably want to have some sort of test runner level
> +        * timeout.)
> +        *
> +        * For more background on this topic, see:
> +        * https://mike-bland.com/2011/11/01/small-medium-large.html
> +        */
> +       wait_for_completion(&test_case_completion);

It doesn't seem like a bad idea to make this have some arbitrarily large
timeout value to start with. Just to make sure the whole thing doesn't
get wedged. It's a timeout, so in theory it should never trigger if it's
large enough.

> +
> +       exit_code =3D try_catch->context.try_result;
> +       if (exit_code =3D=3D -EFAULT)
> +               try_catch->catch(&try_catch->context);
> +       else if (exit_code =3D=3D -EINTR)
> +               kunit_err(test, "wake_up_process() was never called.");

Does kunit_err() add newlines? It would be good to stick to the rest of
kernel style (printk, tracing, etc.) and rely on the callers to have the
newlines they want. Also, remove the full-stop because it isn't really
necessary to have those in error logs.

> +       else if (exit_code)
> +               kunit_err(test, "Unknown error: %d", exit_code);
> +}
> +
> +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
> +{
> +       try_catch->run =3D kunit_generic_run_try_catch;

Is the idea that 'run' would be anything besides
'kunit_generic_run_try_catch'? If it isn't going to be different, then
maybe it's simpler to just have a function like
kunit_generic_run_try_catch() that is called by the unit tests instead
of having to write 'try_catch->run(try_catch)' and indirect for the
basic case. Maybe I've missed the point entirely though and this is all
scaffolding for more complicated exception handling later on.

> +       try_catch->throw =3D kunit_generic_throw;
> +}
> +
> +void __weak kunit_try_catch_init(struct kunit_try_catch *try_catch)
> +{
> +       kunit_generic_try_catch_init(try_catch);
> +}
> +
> +static void kunit_try_run_case(struct kunit_try_catch_context *context)
> +{
> +       struct kunit_try_catch_context *ctx =3D context;
> +       struct kunit *test =3D ctx->test;
> +       struct kunit_module *module =3D ctx->module;
> +       struct kunit_case *test_case =3D ctx->test_case;
> +
> +       /*
> +        * kunit_run_case_internal may encounter a fatal error; if it doe=
s, we
> +        * will jump to ENTER_HANDLER above instead of continuing normal =
control

Where is 'ENTER_HANDLER' above?

> +        * flow.
> +        */
>         kunit_run_case_internal(test, module, test_case);
> +       /* This line may never be reached. */
>         kunit_run_case_cleanup(test, module, test_case);
> +}
