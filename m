Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0462821B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdL/fcvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405812AbfBNVi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:38:28 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:41648 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389588AbfBNVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:38:28 -0500
Received: by mail-vk1-f201.google.com with SMTP id q188so3047110vke.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XAFqFRHtufV1TyXpwD7i7TQuN1zCaRKMtzttQApxZxg=;
        b=BdL/fcvd1OIXVuElU90Wg/eAZ3CSR08SOA8jU3xROSAwWXWSNEUdFqg+28urkUA5zs
         Wd9uhNTWNt2O9PpXZ0yAFvIgffsO7kMf3v8H0xreL0BpMH3dYMolzIj9ZUIqFpK83nzI
         DAJEVFZDsizFILfcpq0ycEXv5oGec7lhZfgk0odFAIehmDp6Z5Cr1QlNCe9dcfe83szt
         jMtQEwDWLya8vyZ+Ohz2r+2f4KeofLhFlFq1tgYiLahFQI0HeBztNICk6ZPEbRSQ357B
         oCWRm0LHdkq2XH5heYuGvt/19hhK7jqCeiRQOPiL6P9S+wPd+fv96GmmoXjsTzkrtcQ1
         Rg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XAFqFRHtufV1TyXpwD7i7TQuN1zCaRKMtzttQApxZxg=;
        b=l7OYDdaquyOEuZsTVDcNH6JlqOza0P/F1RAiyTnQbbxabFwPH8/N94ISbrn0JRlRpG
         Xh1+WNeD1x5Tod5JAPkdApKW39iu4IMvHj7AJRvsRa0jRlBaUsN9e3lwKSIxjLaZIyma
         ATlb4QjGmkQOUT+LUtwulSkeR5DCrekAOU3rpPly9lL1mKx0ZGuYwE8MftLaOOEs7fKf
         DqwV9QhZVD/CE4i14P7ddldXn6nvVkJSNgyFJQ1GBmEDidyZ7880+0xHg3HhzgEvr/Lh
         Cb/kqyj99WHMlHaMvFs/Na/K3WiXxDxMFOeseocRbzQxz4S+BhsDFVNcfwbncDuad2zi
         yaLw==
X-Gm-Message-State: AHQUAuYooPf6ceUcFm2y2N9wVh22fx+p5kor8WwGAiS+8QGLxQTfFXCl
        tnuDl/FeKnxSRUA0zvIMH0sEqla9lCqo+B9nVaRiqA==
X-Google-Smtp-Source: AHgI3Iac77I1KLzcGAy9rCB+1iutLyogqRzi26kl9vJulzvV5ER8bLUDKX2cY1JjoWxkC59lkG8jeTSNquV0I5/Z3kfSuQ==
X-Received: by 2002:a67:ecc3:: with SMTP id i3mr3852765vsp.23.1550180306702;
 Thu, 14 Feb 2019 13:38:26 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:37:12 -0800
Message-Id: <20190214213729.21702-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        robh@kernel.org, kieran.bingham@ideasonboard.com,
        frowand.list@gmail.com
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set proposes KUnit, a lightweight unit testing and mocking
framework for the Linux kernel.

Unlike Autotest and kselftest, KUnit is a true unit testing framework;
it does not require installing the kernel on a test machine or in a VM
and does not require tests to be written in userspace running on a host
kernel. Additionally, KUnit is fast: From invocation to completion KUnit
can run several dozen tests in under a second. Currently, the entire
KUnit test suite for KUnit runs in under a second from the initial
invocation (build time excluded).

KUnit is heavily inspired by JUnit, Python's unittest.mock, and
Googletest/Googlemock for C++. KUnit provides facilities for defining
unit test cases, grouping related test cases into test suites, providing
common infrastructure for running tests, mocking, spying, and much more.

## What's so special about unit testing?

A unit test is supposed to test a single unit of code in isolation,
hence the name. There should be no dependencies outside the control of
the test; this means no external dependencies, which makes tests orders
of magnitudes faster. Likewise, since there are no external dependencies,
there are no hoops to jump through to run the tests. Additionally, this
makes unit tests deterministic: a failing unit test always indicates a
problem. Finally, because unit tests necessarily have finer granularity,
they are able to test all code paths easily solving the classic problem
of difficulty in exercising error handling code.

## Is KUnit trying to replace other testing frameworks for the kernel?

No. Most existing tests for the Linux kernel are end-to-end tests, which
have their place. A well tested system has lots of unit tests, a
reasonable number of integration tests, and some end-to-end tests. KUnit
is just trying to address the unit test space which is currently not
being addressed.

## More information on KUnit

There is a bunch of documentation near the end of this patch set that
describes how to use KUnit and best practices for writing unit tests.
For convenience I am hosting the compiled docs here:
https://google.github.io/kunit-docs/third_party/kernel/docs/
Additionally for convenience, I have applied these patches to a branch:
https://kunit.googlesource.com/linux/+/kunit/rfc/5.0-rc5/v4
The repo may be cloned with:
git clone https://kunit.googlesource.com/linux
This patchset is on the kunit/rfc/5.0-rc5/v4 branch.

## Changes Since Last Version

 - Got KUnit working on (hypothetically) all architectures (tested on
   x86), as per Rob's (and other's) request
 - Punting all KUnit features/patches depending on UML for now.
 - Broke out UML specific support into arch/um/* as per "[RFC v3 01/19]
   kunit: test: add KUnit test runner core", as requested by Luis.
 - Added support to kunit_tool to allow it to build kernels in external
   directories, as suggested by Kieran.
 - Added a UML defconfig, and a config fragment for KUnit as suggested
   by Kieran and Luis.
 - Cleaned up, and reformatted a bunch of stuff.

-- 
2.21.0.rc0.258.g878e2cd30e-goog

