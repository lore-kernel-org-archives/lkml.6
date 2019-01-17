Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174B4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF04020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="IquU4xIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfAQKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:25:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37385 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfAQKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:25:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so458707wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sOndgwxfkTWsggmQJz6AVLa+wexIa94JDFt48CAAOJo=;
        b=IquU4xIvKvo68D8euQ2dGj6z8l6qzTFJJu1o6e/+E+GqwFU2mRsS3YG3PAoT4ZAR7a
         IJUv2CklKZZyx+Z26GXx2dtUlgpofKkKYCdn0tF02yqz0BYdZ3S7nQ5ueyveqKpNz3mm
         kGTkghFkjT467TyPk1H4Asob+oAj8l5gZgTmrezZxpNFNfmm35683vGIBJLbtvMu0wzl
         dnCwfcTZ1BWMJ3F//56PsLh/pVU9Ma3Hg5ySWkooqhW4tSOpT+zru8IWDzOIM8QNtjsy
         OgE76aEaWTU0uTFjRxYRZeyVrEu0IVQhR0nQ4XSkcaHc0BUcLIpPq4GlukGqwcH6omqK
         dyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sOndgwxfkTWsggmQJz6AVLa+wexIa94JDFt48CAAOJo=;
        b=XckH2/nczlmYDBrizzzVIjCuKt9zDmRhKYgdXvkLyfiFfuPUEJoXfEsNvXMigmP6tW
         YOkVPShMWkxvemrUlFbcwifacovcO5nARrSxbX4JrXMfOUzo5aQoVULBwAjpc1rTR4Eb
         c3pIe7vlrGAp+PNiDXYqwCI+yrPbBW0KOKGvNun1aZpa8VO1w6csinvPmLVOiI5DRjg7
         LDXqQ2HyonMffGpGd2LhSlc/l2JETRZI34cRggu/ziPIg7Enes4oKji/1fa1Sc4IGwu7
         UpmZToUbH+Zjz9el6Zj4eWi9ojO4iZXRr6z8GXxhbYEBqL5t1EQuwIGWeTGE+QCQEHUD
         eZag==
X-Gm-Message-State: AJcUukcpaIjhr+Z9dYVAJaTP6LaJmU4pEvmB9VRMAmSQ56lzwDsKcZE2
        WrSkXfF1iroUG4rIDpFLUdB/xQ==
X-Google-Smtp-Source: ALg8bN50SNhQxwqC29moprFoHP1wiFe9GFW+h4S/jHBbO2v8oEj8ecdrAucUyWEFDzfqSsvshe6keg==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr11141150wmi.140.1547720722567;
        Thu, 17 Jan 2019 02:25:22 -0800 (PST)
Received: from brauner.io ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id a8sm17325164wme.23.2019.01.17.02.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 02:25:21 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:25:16 +0100
From:   Christian Brauner <christian@brauner.io>
To:     shuah <shuah@kernel.org>
Cc:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, arve@android.com,
        maco@android.com, joel@joelfernandes.org, tkjos@google.com
Subject: Re: [PATCH v1] selftests: add binderfs selftests
Message-ID: <20190117102515.lnzjohxwk3bms5gr@brauner.io>
References: <20190116222745.26217-1-christian@brauner.io>
 <e9f13d9b-69bf-bb01-d48a-52af77d76db4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9f13d9b-69bf-bb01-d48a-52af77d76db4@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:11:55PM -0700, shuah wrote:
> Hi Christian,
> 
> On 1/16/19 3:27 PM, Christian Brauner wrote:
> > This adds the promised selftest for binderfs. It will verify the following
> > things:
> > - binderfs mounting works
> > - binder device allocation works
> > - performing a binder ioctl() request through a binderfs device works
> > - binder device removal works
> > - binder-control removal fails
> > - binderfs unmounting works
> > 
> 
> Thanks for the patch. A few comments below.

Thanks for the review!

> 
> > Cc: Todd Kjos <tkjos@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* Changelog */
> > 
> > v1:
> > - check for ENODEV on mount failure to detect whether binderfs is
> >    available
> >    If it is not, skip the test and exit with success.
> > ---
> >   tools/testing/selftests/Makefile              |   1 +
> >   .../selftests/filesystems/binderfs/.gitignore |   1 +
> >   .../selftests/filesystems/binderfs/Makefile   |   6 +
> >   .../filesystems/binderfs/binderfs_test.c      | 126 ++++++++++++++++++
> >   .../selftests/filesystems/binderfs/config     |   3 +
> >   5 files changed, 137 insertions(+)
> >   create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
> >   create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
> >   create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> >   create mode 100644 tools/testing/selftests/filesystems/binderfs/config
> > 
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 1a2bd15c5b6e..400ee81a3043 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -10,6 +10,7 @@ TARGETS += drivers/dma-buf
> >   TARGETS += efivarfs
> >   TARGETS += exec
> >   TARGETS += filesystems
> > +TARGETS += filesystems/binderfs
> >   TARGETS += firmware
> >   TARGETS += ftrace
> >   TARGETS += futex
> > diff --git a/tools/testing/selftests/filesystems/binderfs/.gitignore b/tools/testing/selftests/filesystems/binderfs/.gitignore
> > new file mode 100644
> > index 000000000000..8a5d9bf63dd4
> > --- /dev/null
> > +++ b/tools/testing/selftests/filesystems/binderfs/.gitignore
> > @@ -0,0 +1 @@
> > +binderfs_test
> > diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
> > new file mode 100644
> > index 000000000000..58cb659b56b4
> > --- /dev/null
> > +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +CFLAGS += -I../../../../../usr/include/
> > +TEST_GEN_PROGS := binderfs_test
> > +
> > +include ../../lib.mk
> > diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> > new file mode 100644
> > index 000000000000..34361efcb9c8
> > --- /dev/null
> > +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <sched.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/ioctl.h>
> > +#include <sys/mount.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > +#include <linux/android/binder.h>
> > +#include <linux/android/binderfs.h>
> > +#include "../../kselftest.h"
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int fd, ret, saved_errno;
> > +	size_t len;
> > +	struct binderfs_device device = { 0 };
> > +	struct binder_version version = { 0 };
> > +
> > +	ret = unshare(CLONE_NEWNS);
> > +	if (ret < 0)
> > +		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
> > +				   strerror(errno));
> > +
> > +	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> > +	if (ret < 0)
> > +		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
> > +				   strerror(errno));
> > +
> 
> If this test requires user to be root, please add check for root uid and
> do a skip the test with kselftest skip code.

I think in addition to privileged tests I'll also add unprivileged tests
when mounting binderfs inside a user namespace so that we a) can run
this test as an unprivileged user and b) test that binderfs is mountable
in user namespaces.

> 
> > +	ret = mkdir("/dev/binderfs", 0755);
> > +	if (ret < 0 && errno != EEXIST)
> > +		ksft_exit_fail_msg(
> > +			"%s - Failed to create binderfs mountpoint\n",
> > +			strerror(errno));
> > +
> > +	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
> > +	if (ret < 0) {
> > +		if (errno != ENODEV)
> > +			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
> > +					   strerror(errno));
> > +
> > +		ksft_test_result_skip(
> > +			"The Android binderfs filesystem is not available\n")
> 
> Use ksft_exit_skip() instead of ksft_test_result_skip()
> 
> > +		ksft_exit_pass();
> 
> ksft_exit_pass() would result in false pass cases. Skip is the correct
> exit code.

Thanks, fixed now.

Christian
