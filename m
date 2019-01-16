Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EADFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F301020675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547680320;
	bh=2Dsey0qkU0vvhYJKjx3nXwShMbJ5YRSVJdVt6JPRQ5M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=nKDiKah4yQFovFu1Qmb5JhPZdaskyk7vFgZ81jzG68qgR6pbYvUxYnOj8P0xeqWTP
	 4jvMND+aNB4kVcr+TSbgtvjs9FBu1gCkb9+zsz7nL7xX99Dd7eZ9la6E1XiM/Giphh
	 SJelOCS16DNTfUL0F6AEHUsihOdL2wXWNQlXPtQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbfAPXL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:11:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbfAPXL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:11:58 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CA920675;
        Wed, 16 Jan 2019 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547680317;
        bh=2Dsey0qkU0vvhYJKjx3nXwShMbJ5YRSVJdVt6JPRQ5M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SSAppR7lZoV+AX1PGRJ0DkUkpXXb0eGL+5FZxpy94NFte+nfFiutq0dZuhCyhZZuF
         CN/FtzTXTSKyCEDHWtRaOhvSc9126u38yUbWipSmN8itgNMRVi0vLdEIpm6g9v/W5k
         z+1FLQKbFH1a6CM3XHADrgwvzYz5lpppvpdUHHTA=
Subject: Re: [PATCH v1] selftests: add binderfs selftests
To:     Christian Brauner <christian@brauner.io>,
        gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, shuah <shuah@kernel.org>
References: <20190116222745.26217-1-christian@brauner.io>
From:   shuah <shuah@kernel.org>
Message-ID: <e9f13d9b-69bf-bb01-d48a-52af77d76db4@kernel.org>
Date:   Wed, 16 Jan 2019 16:11:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116222745.26217-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 1/16/19 3:27 PM, Christian Brauner wrote:
> This adds the promised selftest for binderfs. It will verify the following
> things:
> - binderfs mounting works
> - binder device allocation works
> - performing a binder ioctl() request through a binderfs device works
> - binder device removal works
> - binder-control removal fails
> - binderfs unmounting works
> 

Thanks for the patch. A few comments below.

> Cc: Todd Kjos <tkjos@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* Changelog */
> 
> v1:
> - check for ENODEV on mount failure to detect whether binderfs is
>    available
>    If it is not, skip the test and exit with success.
> ---
>   tools/testing/selftests/Makefile              |   1 +
>   .../selftests/filesystems/binderfs/.gitignore |   1 +
>   .../selftests/filesystems/binderfs/Makefile   |   6 +
>   .../filesystems/binderfs/binderfs_test.c      | 126 ++++++++++++++++++
>   .../selftests/filesystems/binderfs/config     |   3 +
>   5 files changed, 137 insertions(+)
>   create mode 100644 tools/testing/selftests/filesystems/binderfs/.gitignore
>   create mode 100644 tools/testing/selftests/filesystems/binderfs/Makefile
>   create mode 100644 tools/testing/selftests/filesystems/binderfs/binderfs_test.c
>   create mode 100644 tools/testing/selftests/filesystems/binderfs/config
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 1a2bd15c5b6e..400ee81a3043 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -10,6 +10,7 @@ TARGETS += drivers/dma-buf
>   TARGETS += efivarfs
>   TARGETS += exec
>   TARGETS += filesystems
> +TARGETS += filesystems/binderfs
>   TARGETS += firmware
>   TARGETS += ftrace
>   TARGETS += futex
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

If this test requires user to be root, please add check for root uid and
do a skip the test with kselftest skip code.

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
> +			"The Android binderfs filesystem is not available\n")

Use ksft_exit_skip() instead of ksft_test_result_skip()

> +		ksft_exit_pass();

ksft_exit_pass() would result in false pass cases. Skip is the correct
exit code.

Think about other exit paths to see if skip is more appropriate.

thanks,
-- Shuah


