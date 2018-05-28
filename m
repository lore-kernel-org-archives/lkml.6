Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbeE1UK2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 16:10:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36483 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeE1UK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 16:10:26 -0400
X-Google-Smtp-Source: AB8JxZrTisVCGeHKRvCKbSkFlAs+eGqAxtUH9ls1YRqSmO3ZQ9wPA5k06TQ0BKmBiqvxHTmAKd0tAmglGLN8OjGnAqk=
MIME-Version: 1.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 May 2018 01:40:23 +0530
Message-ID: <CA+G9fYsS50-auAAe79hSGAQ8b1jzkfdcUvuHq0WpAJk17JQkEA@mail.gmail.com>
Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, dave@stgolabs.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 May 2018 at 15:30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.16.13 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed May 30 10:01:02 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> Davidlohr Bueso <dave@stgolabs.net>
>     ipc/shm: fix shmat() nil address after round-down when remapping
>
> Davidlohr Bueso <dave@stgolabs.net>
>     Revert "ipc/shm: Fix shmat mmap nil-page protection"

Regression on 4.16, 4,14, 4.9 and 4.4 and all devices.

Regressions (compared to build v4.16.12)
------------------------------------------------------------------------

On all devices,
  ltp-syscalls-tests:
    * cve-2017-5669

  ltp-cve-tests:
    * cve-2017-5669

Test log:
------------
cve-2017-5669.c:62: INFO: Attempting to attach shared memory to null page
cve-2017-5669.c:74: INFO: Mapped shared memory to (nil)
cve-2017-5669.c:78: FAIL: We have mapped a VM address within the first 64Kb
cve-2017-5669.c:84: INFO: Touching shared memory to see if anything
strange happens
Summary:
passed   0
failed   1
skipped  0
warnings 0


The root cause is,
"Revert "ipc/shm: Fix shmat mmap nil-page protection"",
which explicitly rolls back the original change and mentions that
the LTP test case needs to be updated accordingly.

This regression initially detected on 4.17.0-rc5-next-20180516
Need more investigation on this issue.

Ref:
LKFT: next: LTS-4.16,4.14 and 4.9: LTP test case cve-2017-5669 failed on
all devices
https://bugs.linaro.org/show_bug.cgi?id=3835
https://bugzilla.kernel.org/show_bug.cgi?id=192931
https://patchwork.kernel.org/patch/9552307/

Best regards
Naresh Kamboju
