Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E958222B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOVYKPSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfBKOSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:18:23 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43627 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBKOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:18:23 -0500
Received: by mail-pf1-f173.google.com with SMTP id q17so1953818pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LqUzA0haoMVtFXo57c/1ju9sSjnsaaLY1RlWjjtLBYQ=;
        b=DOVYKPSSAjEuernO5KShulmYkGFuLI41zzMqN7AG7wO+OIRyQ2w08jbARNCJv8QkkJ
         Z8TEfULUmhNqcr8TiTIKXuSIzt0vJ6cZiWIvWOfPDzvdMdIhObL+EPYZEWuUJjlFy5Sq
         cAI2T1zbHxaFfDjAxRktkqOZg6y5Ltg0l3O79iIKfiBkWPWqBbRY7axlRPkInuHploPj
         rcjYGh1L6ybW2uAfGD/OWRYmvzMX10YUVzmt8gPhamBo0BTbj4+L886dhfv5J0Y35CE4
         HxsSnUriCiUMT1MrvJa+vrXbySkohnzVycpSOXDtMICBu2iwHlhF/2ZOVMa98rnxVShS
         MwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LqUzA0haoMVtFXo57c/1ju9sSjnsaaLY1RlWjjtLBYQ=;
        b=e+leRM859AVzuHlmqTRz7xe+Cbgn5fH2XcBpEUluu4MoRzqT9eBDLN4yFqRXf0fbSC
         e61bojqFSt3zIihdu05M1QA8Y1h1BJXyjfcy2fUI9KA8ow9dgUT5pVxWFDHL0wbi+dUd
         m00wrpb4p8Xuf8GIfWf+WKO8cAqRBVsJooz0qkPKZieAnk0od42LvFo5io4Ok3I+A9fD
         dvUGhKw8V8F1wNZGUffstiP7xw2yRsWsZGcneiZzdTaM1h+bsHkVSehH/lbUDjBoUHbf
         cIPGUwloWxsMitEPmNzo75N6MTzSiDn5YTPq9M10smi9zMU848KXV/eW60zyH8NlOcxz
         Rgcw==
X-Gm-Message-State: AHQUAuankKn1ruP9z/zCfFP8UhqF0s6FNZdOAjB3FhDdNnmdQCfLmEgf
        Y1H/v/22Dgt2hTo4eXJi3Oz34YINKHseN+gUjf0sppQT
X-Google-Smtp-Source: AHgI3IbVVKfq/qH5YvmyuB++t90myS7OOY4N4gm5VCDAmnaSRZNM5VUXxGBajJ1Nj1C7d+xVO88wDLY3ifG/couluHk=
X-Received: by 2002:a62:4188:: with SMTP id g8mr6897722pfd.205.1549894702035;
 Mon, 11 Feb 2019 06:18:22 -0800 (PST)
MIME-Version: 1.0
From:   Matej Kupljen <matej.kupljen@gmail.com>
Date:   Mon, 11 Feb 2019 15:18:11 +0100
Message-ID: <CAHMF36F4JN44Y-yMnxw36A8cO0yVUQhAkvJDcj_gbWbsuUAA5A@mail.gmail.com>
Subject: tmpfs inode leakage when opening file with O_TMP_FILE
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems that when opening file on file system that is mounted on
tmpfs with the O_TMPFILE flag and using linkat call after that, it
uses 2 inodes instead of 1.

This is simple test case:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <linux/limits.h>
#include <errno.h>

#define TEST_STRING     "Testing\n"

#define TMP_PATH        "/tmp/ping/"
#define TMP_FILE        "file.txt"


int main(int argc, char* argv[])
{
        char path[PATH_MAX];
        int fd;
        int rc;

        fd = open(TMP_PATH, __O_TMPFILE | O_RDWR,
                        S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP |
S_IROTH | S_IWOTH);

        rc = write(fd, TEST_STRING, strlen(TEST_STRING));

        snprintf(path, PATH_MAX,  "/proc/self/fd/%d", fd);
        linkat(AT_FDCWD, path, AT_FDCWD, TMP_PATH TMP_FILE, AT_SYMLINK_FOLLOW);
        close(fd);

        return 0;
}

I have checked indoes with "df -i" tool. The first inode is used when
the call to open is executed and the second one when the call to
linkat is executed.
It is not decreased when close is executed.

I have also tested this on an ext4 mounted fs and there only one inode is used.

I tested this on:
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.1 LTS"

$ uname -a
Linux Orion 4.15.0-43-generic #46-Ubuntu SMP Thu Dec 6 14:45:28 UTC
2018 x86_64 x86_64 x86_64 GNU/Linux

If you need any more information, please let me know.

And please CC me when replying, I am not subscribed to the list.

Thanks and BR,
Matej
