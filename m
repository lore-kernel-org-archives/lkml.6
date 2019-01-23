Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD69620861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Svfzx6XI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfAWKzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:55:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36187 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfAWKzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:55:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so1335808edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uI4jrGcUisdNvwYZp8caNnVXcLIvIT7PToY0EiRg6ys=;
        b=Svfzx6XIj/bVghMsSGKdjoldUIPB9ahR3wwn90hW6ypjMJAj+C1Cm4N431VVsYB5ZS
         8LdkjAWNso7XzTisEQAm7QjzNCeE3dsZAg1vSNPFAv166CXKA+B2mrqpbwm2OgXiy+ol
         h73ceteytcKklmxcNgmvSiyI5jwX+By3uGS2DXbA0dlDBhO3i8k0KhZsg1yMSAK9wzEv
         7/+MCbvb8iHMNp3ORfuJ+Urs6PmFi+N21/d7xaKgTWfetmdDM/rjJzLsSXK4Nr+L2LDa
         1JCviU/070l+zed1UCQYyINkdgAuG7FaH9qI4iFgOLQHwZz52L//ksGPbBRKukCRQiOm
         DHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uI4jrGcUisdNvwYZp8caNnVXcLIvIT7PToY0EiRg6ys=;
        b=AXrZWgtO1pL8RvHulqrLCPd2D3cPJGN0yMYKIgtTqKzYPXKv80CfkoTFSgaFFfV+De
         ROv67+eHi6YZjysjqi+D0FLGNhhUF9MU4+m4o0bSkXR4olIdAh2VeJM6vpY55lkeyxV3
         olWj0spiYicitsaiQ6bV9jE+FRgT6ON5JY2Lmvvh07XLRFH8OzYVBIlcXf475w1oo0NE
         TVtknPOqNi8nVVjoUfC54rUyqog4n6eHvP1mp9i7peqi0ReIwaQgmPJI4igWeDKzPFvu
         tp83nCE8kvTZf8xQIRQu1PgJAnVeM0OcIrD73Rp+5mPO0pxzUG/CKJvwqjq2Sz3Jw8mp
         5aNg==
X-Gm-Message-State: AJcUukecNfck8XHbtP5sCLkmV89r/7q1pp+ZK9RqrwrcppU68hDoHs0u
        9OGQAEHcvbi9pYUBydF7lOBcZw==
X-Google-Smtp-Source: ALg8bN6QRREPZbR6Glk3lZI19jHhRAkb1UDB+kcX/hBru3O65pClon5c0YZrMVWSZ4eMs55u3JpMLQ==
X-Received: by 2002:a05:6402:1286:: with SMTP id w6mr2288268edv.53.1548240900546;
        Wed, 23 Jan 2019 02:55:00 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id w56sm10468626edb.72.2019.01.23.02.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 02:54:59 -0800 (PST)
Date:   Wed, 23 Jan 2019 11:54:58 +0100
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, shuah@kernel.org
Subject: Re: [PATCH v3] selftests: add binderfs selftests
Message-ID: <20190123105457.k7oobylgq6rwka55@brauner.io>
References: <20190117114854.15132-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117114854.15132-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:48:54PM +0100, Christian Brauner wrote:
> This adds the promised selftest for binderfs. It will verify the following
> things:
> - binderfs mounting works
> - binder device allocation works
> - performing a binder ioctl() request through a binderfs device works
> - binder device removal works
> - binder-control removal fails
> - binderfs unmounting works
> 
> The tests are performed both privileged and unprivileged. The latter
> verifies that binderfs behaves correctly in user namespaces.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Hey Shuah,

If you're ok with the patch in its current form, can you please make
sure that this still lands in 5.0? If at all possible I'd like to have
all ducks in a row and release binderfs with selftests and everything.
:)

Thanks!
Christian

> ---
> /* Changelog */
> v3:
> - s/printf/ksft_print_msg/g
> - do not report misleading errno on short write
> 
> v2:
> - make failure to create /dev/binderfs directory fatal in all circumstances
> - make tests run in user namespace to test whether binderfs can be mounted
>   in user namespaces and so that unprivileged users can run the tests
> - use ksft_exit_skip()
> 
> v1:
> - check for ENODEV on mount failure to detect whether binderfs is
>   available
>   If it is not, skip the test and exit with success.
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/filesystems/binderfs/.gitignore |   1 +
>  .../selftests/filesystems/binderfs/Makefile   |   6 +
>  .../filesystems/binderfs/binderfs_test.c      | 275 ++++++++++++++++++
>  .../selftests/filesystems/binderfs/config     |   3 +
>  5 files changed, 286 insertions(+)
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
> index 000000000000..8c2ed962e1c7
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <stdbool.h>
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
> +static ssize_t write_nointr(int fd, const void *buf, size_t count)
> +{
> +	ssize_t ret;
> +again:
> +	ret = write(fd, buf, count);
> +	if (ret < 0 && errno == EINTR)
> +		goto again;
> +
> +	return ret;
> +}
> +
> +static void write_to_file(const char *filename, const void *buf, size_t count,
> +			  int allowed_errno)
> +{
> +	int fd, saved_errno;
> +	ssize_t ret;
> +
> +	fd = open(filename, O_WRONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		ksft_exit_fail_msg("%s - Failed to open file %s\n",
> +				   strerror(errno), filename);
> +
> +	ret = write_nointr(fd, buf, count);
> +	if (ret < 0) {
> +		if (allowed_errno && (errno == allowed_errno)) {
> +			close(fd);
> +			return;
> +		}
> +
> +		goto on_error;
> +	}
> +
> +	if ((size_t)ret != count)
> +		goto on_error;
> +
> +	close(fd);
> +	return;
> +
> +on_error:
> +	saved_errno = errno;
> +	close(fd);
> +	errno = saved_errno;
> +
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to write to file %s\n",
> +				   strerror(errno), filename);
> +
> +	ksft_exit_fail_msg("Failed to write to file %s\n", filename);
> +}
> +
> +static void change_to_userns(void)
> +{
> +	int ret;
> +	uid_t uid;
> +	gid_t gid;
> +	/* {g,u}id_map files only allow a max of 4096 bytes written to them */
> +	char idmap[4096];
> +
> +	uid = getuid();
> +	gid = getgid();
> +
> +	ret = unshare(CLONE_NEWUSER);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to unshare user namespace\n",
> +				   strerror(errno));
> +
> +	write_to_file("/proc/self/setgroups", "deny", strlen("deny"), ENOENT);
> +
> +	ret = snprintf(idmap, sizeof(idmap), "0 %d 1", uid);
> +	if (ret < 0 || (size_t)ret >= sizeof(idmap))
> +		ksft_exit_fail_msg("%s - Failed to prepare uid mapping\n",
> +				   strerror(errno));
> +
> +	write_to_file("/proc/self/uid_map", idmap, strlen(idmap), 0);
> +
> +	ret = snprintf(idmap, sizeof(idmap), "0 %d 1", gid);
> +	if (ret < 0 || (size_t)ret >= sizeof(idmap))
> +		ksft_exit_fail_msg("%s - Failed to prepare uid mapping\n",
> +				   strerror(errno));
> +
> +	write_to_file("/proc/self/gid_map", idmap, strlen(idmap), 0);
> +
> +	ret = setgid(0);
> +	if (ret)
> +		ksft_exit_fail_msg("%s - Failed to setgid(0)\n",
> +				   strerror(errno));
> +
> +	ret = setuid(0);
> +	if (ret)
> +		ksft_exit_fail_msg("%s - Failed to setgid(0)\n",
> +				   strerror(errno));
> +}
> +
> +static void change_to_mountns(void)
> +{
> +	int ret;
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
> +}
> +
> +static void rmdir_protect_errno(const char *dir)
> +{
> +	int saved_errno = errno;
> +	(void)rmdir(dir);
> +	errno = saved_errno;
> +}
> +
> +static void __do_binderfs_test(void)
> +{
> +	int fd, ret, saved_errno;
> +	size_t len;
> +	ssize_t wret;
> +	bool keep = false;
> +	struct binderfs_device device = { 0 };
> +	struct binder_version version = { 0 };
> +
> +	change_to_mountns();
> +
> +	ret = mkdir("/dev/binderfs", 0755);
> +	if (ret < 0) {
> +		if (errno != EEXIST)
> +			ksft_exit_fail_msg(
> +				"%s - Failed to create binderfs mountpoint\n",
> +				strerror(errno));
> +
> +		keep = true;
> +	}
> +
> +	ret = mount(NULL, "/dev/binderfs", "binder", 0, 0);
> +	if (ret < 0) {
> +		if (errno != ENODEV)
> +			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
> +					   strerror(errno));
> +
> +		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		ksft_exit_skip(
> +			"The Android binderfs filesystem is not available\n");
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
> +
> +	ret = ioctl(fd, BINDER_CTL_ADD, &device);
> +	saved_errno = errno;
> +	close(fd);
> +	errno = saved_errno;
> +	if (ret < 0) {
> +		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		ksft_exit_fail_msg(
> +			"%s - Failed to allocate new binder device\n",
> +			strerror(errno));
> +	}
> +
> +	ksft_print_msg(
> +		"Allocated new binder device with major %d, minor %d, and name %s\n",
> +		device.major, device.minor, device.name);
> +
> +	/* binder device allocation test passed */
> +	ksft_inc_pass_cnt();
> +
> +	fd = open("/dev/binderfs/my-binder", O_CLOEXEC | O_RDONLY);
> +	if (fd < 0) {
> +		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
> +				   strerror(errno));
> +	}
> +
> +	ret = ioctl(fd, BINDER_VERSION, &version);
> +	saved_errno = errno;
> +	close(fd);
> +	errno = saved_errno;
> +	if (ret < 0) {
> +		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		ksft_exit_fail_msg(
> +			"%s - Failed to open perform BINDER_VERSION request\n",
> +			strerror(errno));
> +	}
> +
> +	ksft_print_msg("Detected binder version: %d\n",
> +		       version.protocol_version);
> +
> +	/* binder transaction with binderfs binder device passed */
> +	ksft_inc_pass_cnt();
> +
> +	ret = unlink("/dev/binderfs/my-binder");
> +	if (ret < 0) {
> +		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
> +				   strerror(errno));
> +	}
> +
> +	/* binder device removal passed */
> +	ksft_inc_pass_cnt();
> +
> +	ret = unlink("/dev/binderfs/binder-control");
> +	if (!ret) {
> +		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		ksft_exit_fail_msg("Managed to delete binder-control device\n");
> +	} else if (errno != EPERM) {
> +		keep ? : rmdir_protect_errno("/dev/binderfs");
> +		ksft_exit_fail_msg(
> +			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
> +			strerror(errno));
> +	}
> +
> +	/* binder-control device removal failed as expected */
> +	ksft_inc_xfail_cnt();
> +
> +on_error:
> +	ret = umount2("/dev/binderfs", MNT_DETACH);
> +	keep ?: rmdir_protect_errno("/dev/binderfs");
> +	if (ret < 0)
> +		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
> +				   strerror(errno));
> +
> +	/* binderfs unmount test passed */
> +	ksft_inc_pass_cnt();
> +}
> +
> +static void binderfs_test_privileged()
> +{
> +	if (geteuid() != 0)
> +		ksft_print_msg(
> +			"Tests are not run as root. Skipping privileged tests\n");
> +	else
> +		__do_binderfs_test();
> +}
> +
> +static void binderfs_test_unprivileged()
> +{
> +	change_to_userns();
> +	__do_binderfs_test();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	binderfs_test_privileged();
> +	binderfs_test_unprivileged();
> +	ksft_exit_pass();
> +}
> diff --git a/tools/testing/selftests/filesystems/binderfs/config b/tools/testing/selftests/filesystems/binderfs/config
> new file mode 100644
> index 000000000000..02dd6cc9cf99
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/binderfs/config
> @@ -0,0 +1,3 @@
> +CONFIG_ANDROID=y
> +CONFIG_ANDROID_BINDERFS=y
> +CONFIG_ANDROID_BINDER_IPC=y
> -- 
> 2.19.1
> 
