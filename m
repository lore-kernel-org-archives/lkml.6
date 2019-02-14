Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E703921B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfBNXoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:44:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50740 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:44:05 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E90182C;
        Thu, 14 Feb 2019 23:44:03 +0000 (UTC)
Date:   Thu, 14 Feb 2019 15:44:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matej Kupljen <matej.kupljen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: tmpfs inode leakage when opening file with O_TMP_FILE
Message-Id: <20190214154402.5d204ef2aa109502761ab7a0@linux-foundation.org>
In-Reply-To: <CAHMF36F4JN44Y-yMnxw36A8cO0yVUQhAkvJDcj_gbWbsuUAA5A@mail.gmail.com>
References: <CAHMF36F4JN44Y-yMnxw36A8cO0yVUQhAkvJDcj_gbWbsuUAA5A@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc linux-fsdevel)

On Mon, 11 Feb 2019 15:18:11 +0100 Matej Kupljen <matej.kupljen@gmail.com> wrote:

> Hi,
> 
> it seems that when opening file on file system that is mounted on
> tmpfs with the O_TMPFILE flag and using linkat call after that, it
> uses 2 inodes instead of 1.
> 
> This is simple test case:
> 
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <string.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <linux/limits.h>
> #include <errno.h>
> 
> #define TEST_STRING     "Testing\n"
> 
> #define TMP_PATH        "/tmp/ping/"
> #define TMP_FILE        "file.txt"
> 
> 
> int main(int argc, char* argv[])
> {
>         char path[PATH_MAX];
>         int fd;
>         int rc;
> 
>         fd = open(TMP_PATH, __O_TMPFILE | O_RDWR,
>                         S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP |
> S_IROTH | S_IWOTH);
> 
>         rc = write(fd, TEST_STRING, strlen(TEST_STRING));
> 
>         snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
>         linkat(AT_FDCWD, path, AT_FDCWD, TMP_PATH TMP_FILE, AT_SYMLINK_FOLLOW);
>         close(fd);
> 
>         return 0;
> }
> 
> I have checked indoes with "df -i" tool. The first inode is used when
> the call to open is executed and the second one when the call to
> linkat is executed.
> It is not decreased when close is executed.
> 
> I have also tested this on an ext4 mounted fs and there only one inode is used.
> 
> I tested this on:
> $ cat /etc/lsb-release
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=18.04
> DISTRIB_CODENAME=bionic
> DISTRIB_DESCRIPTION="Ubuntu 18.04.1 LTS"
> 
> $ uname -a
> Linux Orion 4.15.0-43-generic #46-Ubuntu SMP Thu Dec 6 14:45:28 UTC
> 2018 x86_64 x86_64 x86_64 GNU/Linux
> 
> If you need any more information, please let me know.
> 
> And please CC me when replying, I am not subscribed to the list.
> 
> Thanks and BR,
> Matej
