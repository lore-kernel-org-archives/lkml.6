Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0435C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B910206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ANOQJpvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfAPWts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:49:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55338 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfAPWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:49:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so3772134wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GQI34HYSDlcOKo2rNhdfwxoNvK4NkpQ1xY8ORCaanrM=;
        b=ANOQJpvRGOi1zzANwFuZM16MBFnumG/0JGD8+3gRvHh+iBEucpUjYYlrTjT4MnROvE
         cxD3zbT9BQgrLkKD2qCy+ENQUTldUUpExEy47/k2zffroElQBC2yNBEwRF55ntkTA0nM
         HrL6jmr7UQTqdJimK81VuG94qhy2N3UMrcngzAGh7/vX2lgQwU+tu7SlUzeNVc4716uU
         N70Lx111kEZI/zjxbfo/yzUVbZ/RF9JX70ZIgPXpZu3ZNZ51nj/Fo/fZZSYUpaXgWeV+
         JkbO+GvSZLWpILNf0mwFdchbT7HxW3YpaQ8nx91EaQnkZDf6lxE4LbRCcmVzqQCJ0s9+
         4XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GQI34HYSDlcOKo2rNhdfwxoNvK4NkpQ1xY8ORCaanrM=;
        b=d+TehVvxAKuG+To+Gu/6NfdwezVn5uRtHK1HtvNz13acxt1Bq6WUQTYxFm/P76OUXL
         Tmteac7l1rsQ8BFcmM8yGat86hn1ewmsoerF+x5xmXrdTeWAGy4dWpJej3LseekRoBgn
         dL4+6EtN+t+N3JTEqCb3V7TCzo9fVPLw12tBe2s2UHGxEaG9KXoFetFqXfdV1+zhFfQ/
         FOT0nUZ4FIs6fJ0u8my5TrdEeDHnnB+RE74NeHXwaeUr5KSPNXffOWLZ6VJSdB+ApKM8
         5rX5+VLhKvjbIEHa2OqJBFYF3jJK09HDfF56j/DuKFzTij60Zw0vISO/mccB6oXvu8yv
         YNgw==
X-Gm-Message-State: AJcUukfSYsv+YRVXLSvPmxbDlGav61Qfxwa5QY/aEouVrXxK2P+kcVUd
        soQWq6XTnzFcLlCwtlbTiqzuGg==
X-Google-Smtp-Source: ALg8bN4Lb3xjugZtbs+Edrh173zGOZ8UEb3vLuT5GFfKxxmbCBd100EwIWwpzblAAsr0UQW9l7EPvQ==
X-Received: by 2002:a1c:aad2:: with SMTP id t201mr9054492wme.148.1547678984557;
        Wed, 16 Jan 2019 14:49:44 -0800 (PST)
Received: from brauner.io ([154.119.55.246])
        by smtp.gmail.com with ESMTPSA id t5sm24291830wmg.43.2019.01.16.14.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 14:49:44 -0800 (PST)
Date:   Wed, 16 Jan 2019 23:49:38 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        maco@android.com, arve@android.com, joel@joelfernandes.org,
        shuah@kernel.org, tkjos@google.com
Subject: Re: [PATCH v1] selftests: add binderfs selftests
Message-ID: <20190116224936.xixnlqvhawtnvlio@brauner.io>
References: <20190116222745.26217-1-christian@brauner.io>
 <20190116224050.GA21920@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116224050.GA21920@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:40:50PM +0100, Greg KH wrote:
> On Wed, Jan 16, 2019 at 11:27:45PM +0100, Christian Brauner wrote:
> > This adds the promised selftest for binderfs. It will verify the following
> > things:
> > - binderfs mounting works
> > - binder device allocation works
> > - performing a binder ioctl() request through a binderfs device works
> > - binder device removal works
> > - binder-control removal fails
> > - binderfs unmounting works
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* Changelog */
> > 
> > v1:
> > - check for ENODEV on mount failure to detect whether binderfs is
> >   available
> >   If it is not, skip the test and exit with success.
> > ---
> >  tools/testing/selftests/Makefile              |   1 +
> >  .../selftests/filesystems/binderfs/.gitignore |   1 +
> >  .../selftests/filesystems/binderfs/Makefile   |   6 +
> >  .../filesystems/binderfs/binderfs_test.c      | 126 ++++++++++++++++++
> >  .../selftests/filesystems/binderfs/config     |   3 +
> >  5 files changed, 137 insertions(+)
> >  create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
> >  create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
> >  create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> >  create mode 100644 tools/testing/selftests/filesystems/binderfs/config
> > 
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 1a2bd15c5b6e..400ee81a3043 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -10,6 +10,7 @@ TARGETS += drivers/dma-buf
> >  TARGETS += efivarfs
> >  TARGETS += exec
> >  TARGETS += filesystems
> > +TARGETS += filesystems/binderfs
> >  TARGETS += firmware
> >  TARGETS += ftrace
> >  TARGETS += futex
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
> > +			"The Android binderfs filesystem is not available\n");
> > +		ksft_exit_pass();
> 
> Do you have to clean up your new directory you created and the mount?
> Or does exiting the code here somehow undo the unshare/mount/mkdir steps
> above??
> 
> Same type of question for the failure paths of the mkdir and mount calls.

All mounts performed after a new mount namespace without propagation is
setup for a process will die when all references to the mount namespace
are dropped which in this case happens when the process dies.

> 
> > +	}
> > +
> > +	/* binderfs mount test passed */
> > +	ksft_inc_pass_cnt();
> > +
> > +	memcpy(device.name, "my-binder", strlen("my-binder"));
> > +
> > +	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
> > +	if (fd < 0)
> > +		ksft_exit_fail_msg(
> > +			"%s - Failed to open binder-control device\n",
> > +			strerror(errno));
> 
> No cleanup?  Same for other calls to ksft_exit_fail_msg() later in this
> file.

Same comment as above. :)

The thing we might want to cleanup is the mountpoint itself
"/dev/binderfs".

> 
> thanks,
> 
> greg "error handling is hard!" k-h

That's fair. With patches purely for testing I always have to force
myself to pay close attention because I implicitly and very much
**falsely** keep thinking that the test is less important than the
actual code. And I'm always a little ashamed of that. :)

Thanks!
Christian
