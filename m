Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A06C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE0320675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="H6ng2Jx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfAPWMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:12:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbfAPWMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:12:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so8833693wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5N6KpHR2dc17xPQXp/nlwnCS7l/ZYcyhqvBXytTiQD0=;
        b=H6ng2Jx7X1izvjyyHzZ4A5fnrs6N0UbH+Xmu/6Cz9b4mwb5WT8Bza/DRFBBga1Dgmj
         qCCRJo0oFrAVRMwSwfDp/sDIL0IkT035vgFLhJu2WblQGjWM6J63Rjc5SYp94ExtezOR
         xJUzGQ3z3rxbV6Bh/aLV/BXUX5V1dGeADXe4OfvQ4nqpEXL40Eh1KSnVJRoEbNhLloZU
         uZC720iqt0a7wIAcxc78pYCLsaml86/IO/Sq9X/PzckVFHfnNkFT3ugYaOIgAzgNQ2TZ
         8jjEZSgXBnqJ53FBu4MVEiJ00HHZxdbPNS/tnvtO3sSHaT+q4C3ZA42+0Yq1OUwsnPRq
         tCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5N6KpHR2dc17xPQXp/nlwnCS7l/ZYcyhqvBXytTiQD0=;
        b=gIb9r4QYgeqUyN3kYz2uXmbFQVeTSKGEvqAw9+3kofdEGN/47eC+VLuAKMdop7hHsl
         87uHqPxAgjr/mjLdegEsqIjZWvuyEqIrgqQ2G5A/LC22HQdoHeEOhchAJlkncLQS4HpO
         5U0N7sJAgQhp6LFcpNhU4FONjOSTUq64XbJ8VwzzHfjiESWCXzbMnaqGabve2eDG6cPH
         xTOCMAI1+mKVSSq8ucR0kTDMckIK2MteaO0wkEJt1lP5iYU2cwA9wiuh39s76mBg6x0e
         pRvEGs5y0WOYlGJFzO4G6yEkehY/BVuWnuzgA9nvFsI/QLi08U3cjZjGPMHSIuOoZhM0
         cF4g==
X-Gm-Message-State: AJcUukfs7Sohq4dKUc5OJlvv2H8tS2O3hddD/vnOzWV8mshqTP1NQB/0
        YcBPBUxFFMBad8DGUT4s+y3Y9g==
X-Google-Smtp-Source: ALg8bN5XXoK18EoqfmmZUVZYYnnpKCpuoglDTlcO6CE/FKRB5mFzWHjogxrf/7BVcr7J295vkC0QpQ==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr9592360wrn.187.1547676748884;
        Wed, 16 Jan 2019 14:12:28 -0800 (PST)
Received: from brauner.io ([154.119.55.246])
        by smtp.gmail.com with ESMTPSA id c14sm28620696wme.13.2019.01.16.14.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 14:12:28 -0800 (PST)
Date:   Wed, 16 Jan 2019 23:12:23 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com, tkjos@google.com
Subject: Re: [PATCH] selftests: add binderfs selftests
Message-ID: <20190116221221.m74xdxnzcjzfufny@brauner.io>
References: <20190116131903.8515-1-christian@brauner.io>
 <20190116155450.GA3508@kroah.com>
 <EB0D154D-A8CD-4CDB-B66F-C20945722AE2@brauner.io>
 <20190116164219.GD5446@kroah.com>
 <CA19B5F8-FEE9-4159-BA01-9C51B4DF97FA@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA19B5F8-FEE9-4159-BA01-9C51B4DF97FA@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:57:10PM +0200, Christian Brauner wrote:
> On January 16, 2019 6:42:20 PM GMT+02:00, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Wed, Jan 16, 2019 at 06:21:12PM +0200, Christian Brauner wrote:
> >> On January 16, 2019 5:54:50 PM GMT+02:00, Greg KH
> ><gregkh@linuxfoundation.org> wrote:
> >> >On Wed, Jan 16, 2019 at 02:19:03PM +0100, Christian Brauner wrote:
> >> >> This adds the promised selftest for binderfs. It will verify the
> >> >following
> >> >> things:
> >> >> - binderfs mounting works
> >> >> - binder device allocation works
> >> >> - performing a binder ioctl() request through a binderfs device
> >works
> >> >> - binder device removal works
> >> >> - binder-control removal fails
> >> >> - binderfs unmounting works
> >> >> 
> >> >> Cc: Todd Kjos <tkjos@google.com>
> >> >> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> >> >> ---
> >> >>  tools/testing/selftests/Makefile              |   1 +
> >> >>  .../selftests/filesystems/binderfs/.gitignore |   1 +
> >> >>  .../selftests/filesystems/binderfs/Makefile   |   6 +
> >> >>  .../filesystems/binderfs/binderfs_test.c      | 120
> >> >++++++++++++++++++
> >> >>  .../selftests/filesystems/binderfs/config     |   3 +
> >> >>  5 files changed, 131 insertions(+)
> >> >>  create mode 100644
> >> >tools/testing/selftests/filesystems/binderfs/.gitignore
> >> >>  create mode 100644
> >> >tools/testing/selftests/filesystems/binderfs/Makefile
> >> >>  create mode 100644
> >> >tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> >> >>  create mode 100644
> >> >tools/testing/selftests/filesystems/binderfs/config
> >> >> 
> >> >> diff --git a/tools/testing/selftests/Makefile
> >> >b/tools/testing/selftests/Makefile
> >> >> index 1a2bd15c5b6e..400ee81a3043 100644
> >> >> --- a/tools/testing/selftests/Makefile
> >> >> +++ b/tools/testing/selftests/Makefile
> >> >> @@ -10,6 +10,7 @@ TARGETS += drivers/dma-buf
> >> >>  TARGETS += efivarfs
> >> >>  TARGETS += exec
> >> >>  TARGETS += filesystems
> >> >> +TARGETS += filesystems/binderfs
> >> >>  TARGETS += firmware
> >> >>  TARGETS += ftrace
> >> >>  TARGETS += futex
> >> >> diff --git
> >a/tools/testing/selftests/filesystems/binderfs/.gitignore
> >> >b/tools/testing/selftests/filesystems/binderfs/.gitignore
> >> >> new file mode 100644
> >> >> index 000000000000..8a5d9bf63dd4
> >> >> --- /dev/null
> >> >> +++ b/tools/testing/selftests/filesystems/binderfs/.gitignore
> >> >> @@ -0,0 +1 @@
> >> >> +binderfs_test
> >> >> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile
> >> >b/tools/testing/selftests/filesystems/binderfs/Makefile
> >> >> new file mode 100644
> >> >> index 000000000000..58cb659b56b4
> >> >> --- /dev/null
> >> >> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
> >> >> @@ -0,0 +1,6 @@
> >> >> +# SPDX-License-Identifier: GPL-2.0
> >> >> +
> >> >> +CFLAGS += -I../../../../../usr/include/
> >> >> +TEST_GEN_PROGS := binderfs_test
> >> >> +
> >> >> +include ../../lib.mk
> >> >> diff --git
> >> >a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> >> >b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> >> >> new file mode 100644
> >> >> index 000000000000..ca4d9b616e84
> >> >> --- /dev/null
> >> >> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> >> >> @@ -0,0 +1,120 @@
> >> >> +// SPDX-License-Identifier: GPL-2.0
> >> >> +
> >> >> +#define _GNU_SOURCE
> >> >> +#include <errno.h>
> >> >> +#include <fcntl.h>
> >> >> +#include <sched.h>
> >> >> +#include <stdio.h>
> >> >> +#include <stdlib.h>
> >> >> +#include <string.h>
> >> >> +#include <sys/ioctl.h>
> >> >> +#include <sys/mount.h>
> >> >> +#include <sys/stat.h>
> >> >> +#include <sys/types.h>
> >> >> +#include <unistd.h>
> >> >> +#include <linux/android/binder.h>
> >> >> +#include <linux/android/binderfs.h>
> >> >> +#include "../../kselftest.h"
> >> >> +
> >> >> +int main(int argc, char *argv[])
> >> >> +{
> >> >> +	int fd, ret, saved_errno;
> >> >> +	size_t len;
> >> >> +	struct binderfs_device device = { 0 };
> >> >> +	struct binder_version version = { 0 };
> >> >> +
> >> >> +	ret = unshare(CLONE_NEWNS);
> >> >> +	if (ret < 0)
> >> >> +		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
> >> >> +				   strerror(errno));
> >> >> +
> >> >> +	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> >> >> +	if (ret < 0)
> >> >> +		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
> >> >> +				   strerror(errno));
> >> >> +
> >> >> +	ret = mkdir("/dev/binderfs", 0755);
> >> >> +	if (ret < 0 && errno != EEXIST)
> >> >> +		ksft_exit_fail_msg(
> >> >> +			"%s - Failed to create binderfs mountpoint\n",
> >> >> +			strerror(errno));
> >> >> +
> >> >> +	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
> >> >> +	if (ret < 0)
> >> >> +		ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
> >> >> +				   strerror(errno));
> >> >
> >> >Can you check first to see if the kernel under test really even has
> >> >binderfs in it?  If not, you need to just
> >> 
> >> Hm, I thought that's what the "config" file was for?
> >> E.g. a conditional compile or is this just a hint to the
> >> user what's needed to run the test?
> >
> >I do not know.  What happens if you try to run this test on a kernel
> >without that config option?  Does it not work as the framework
> >correctly
> >detects this?
> 
> I did test and it worked fine but let me check by setting up a clean vm and retry.

The compile always happens and always succeeds but the test will fail if
run on a kernel that does not have binderfs. So the mount() call should
check for ret == ENODEV and then exit with skip.

Thanks!
Christian
