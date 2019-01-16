Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AC420840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547678456;
	bh=xWJGEpHFxQ1bFfbMYUaUcnCjVuUUIglN3OnrSVNFTkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z/x49S7E+VHwW2UNZtv9V7rZb2vk87Co+qmJtVOVF4fwMSiWbsAp17GjJvv1LI0lj
	 j2d1a8/av5ruiR6Q7f6nb07jCyrb0RUvfxi3TBA1nQM5+JsKuykZNdxZ75GfE+51HB
	 woHGDwfmGlua0GBGby+ICXiyhXX1lsAPULHTV8kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfAPWkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387475AbfAPWkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:40:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DD620652;
        Wed, 16 Jan 2019 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547678452;
        bh=xWJGEpHFxQ1bFfbMYUaUcnCjVuUUIglN3OnrSVNFTkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsJcuiJCV5YHogrmb+Ll3ErFaiFKzWDlqX//bkdpEsCDUCP3j6gAgPwaZIku6ZfSI
         6oe+cxmOP5pEtAHJ387V0D5bMlMXyV7NJ/KPcAsLkHA+fHkl0JWoQHbiJdGMiCanUp
         mtpzV+oa7D4xKdlyFnNOcycu63OVPCrr3+vkJxb0=
Date:   Wed, 16 Jan 2019 23:40:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        maco@android.com, arve@android.com, joel@joelfernandes.org,
        shuah@kernel.org, tkjos@google.com
Subject: Re: [PATCH v1] selftests: add binderfs selftests
Message-ID: <20190116224050.GA21920@kroah.com>
References: <20190116222745.26217-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116222745.26217-1-christian@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:27:45PM +0100, Christian Brauner wrote:
> This adds the promised selftest for binderfs. It will verify the following
> things:
> - binderfs mounting works
> - binder device allocation works
> - performing a binder ioctl() request through a binderfs device works
> - binder device removal works
> - binder-control removal fails
> - binderfs unmounting works
> 
> Cc: Todd Kjos <tkjos@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* Changelog */
> 
> v1:
> - check for ENODEV on mount failure to detect whether binderfs is
>   available
>   If it is not, skip the test and exit with success.
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/filesystems/binderfs/.gitignore |   1 +
>  .../selftests/filesystems/binderfs/Makefile   |   6 +
>  .../filesystems/binderfs/binderfs_test.c      | 126 ++++++++++++++++++
>  .../selftests/filesystems/binderfs/config     |   3 +
>  5 files changed, 137 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_test.c
>  create mode 100644 tools/testing/selftests/filesystems/binderfs/config
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 1a2bd15c5b6e..400ee81a3043 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -10,6 +10,7 @@ TARGETS += drivers/dma-buf
>  TARGETS += efivarfs
>  TARGETS += exec
>  TARGETS += filesystems
> +TARGETS += filesystems/binderfs
>  TARGETS += firmware
>  TARGETS += ftrace
>  TARGETS += futex
> diff --git a/tools/testing/selftests/filesystems/binderfs/.gitignore b/tools/testing/selftests/filesystems/binderfs/.gitignore
> new file mode 100644
> index 000000000000..8a5d9bf63dd4
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/.gitignore
> @@ -0,0 +1 @@
> +binderfs_test
> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
> new file mode 100644
> index 000000000000..58cb659b56b4
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -I../../../../../usr/include/
> +TEST_GEN_PROGS := binderfs_test
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> new file mode 100644
> index 000000000000..34361efcb9c8
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/android/binder.h>
> +#include <linux/android/binderfs.h>
> +#include "../../kselftest.h"
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd, ret, saved_errno;
> +	size_t len;
> +	struct binderfs_device device = { 0 };
> +	struct binder_version version = { 0 };
> +
> +	ret = unshare(CLONE_NEWNS);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
> +				   strerror(errno));
> +
> +	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
> +				   strerror(errno));
> +
> +	ret = mkdir("/dev/binderfs", 0755);
> +	if (ret < 0 && errno != EEXIST)
> +		ksft_exit_fail_msg(
> +			"%s - Failed to create binderfs mountpoint\n",
> +			strerror(errno));
> +
> +	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
> +	if (ret < 0) {
> +		if (errno != ENODEV)
> +			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
> +					   strerror(errno));
> +
> +		ksft_test_result_skip(
> +			"The Android binderfs filesystem is not available\n");
> +		ksft_exit_pass();

Do you have to clean up your new directory you created and the mount?
Or does exiting the code here somehow undo the unshare/mount/mkdir steps
above??

Same type of question for the failure paths of the mkdir and mount calls.

> +	}
> +
> +	/* binderfs mount test passed */
> +	ksft_inc_pass_cnt();
> +
> +	memcpy(device.name, "my-binder", strlen("my-binder"));
> +
> +	fd = open("/dev/binderfs/binder-control", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		ksft_exit_fail_msg(
> +			"%s - Failed to open binder-control device\n",
> +			strerror(errno));

No cleanup?  Same for other calls to ksft_exit_fail_msg() later in this
file.

thanks,

greg "error handling is hard!" k-h
