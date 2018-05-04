Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEDTm3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:42:29 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34146 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeEDTm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:42:27 -0400
Subject: Re: [PATCH 1/2] selftests/filesystems: devpts_pts included wrong
 header
To: Christian Brauner <christian.brauner@canonical.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20180418075256.300-1-anders.roxell@linaro.org>
 <CAPP7u0XLS7sFM2cSY9ypziW3S1T8oouku=8u=9VLCO1qxuOOrQ@mail.gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <0631ea78-dc18-639c-8658-cdb810c6b4f3@kernel.org>
Date: Fri, 4 May 2018 13:42:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPP7u0XLS7sFM2cSY9ypziW3S1T8oouku=8u=9VLCO1qxuOOrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 08:05 AM, Christian Brauner wrote:
> On Wed, Apr 18, 2018 at 09:52:55AM +0200, Anders Roxell wrote:
>> We were picking up the wrong header should use asm/ioctls.h form the kernel
>> and not the header from the system (sys/ioctl.h). In the current code we
>> added the correct include and we added the kernel headers path to the CFLAGS.
>>
>> Fixes: ce290a19609d ("selftests: add devpts selftests")
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Patch looks good to me.
> 
> I'm going to look into the ioctl() error.
> 
> Thanks!
> Christian
> 
>>
>> Hi,
>>
>> I've been running devpts_pts on a mainline kernel (4.16+git0+60cc43fc88) and
> 
> 
> 
>> the verify_invalid_ptmx_bind_mount() test failes with this failure:
>>
>> root@intel-core2-32:~# ./devpts_pts
>> Failed to perform TIOCGPTPEER ioctl
>>
>> However, I'm still confused why I'm not able to get the test to pass.  Strace
>> showes that -ENOENT return in the TIOCGPTPEER implementation in the
>> kernel. I think the -ENOENT gets returned from this path
>> devpts_mntget()->devpts_ptmx_path->path_pts().
>>
>> See the strace issue below:
>> root@intel-core2-32:~# strace ./devpts_pts
>> execve("./devpts_pts", ["./devpts_pts"], [/* 17 vars */]) = 0
>> brk(NULL)                               = 0x5634e0092000
>> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f459d338000
>> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
>> open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
>> fstat(3, {st_mode=S_IFREG|0644, st_size=16726, ...}) = 0
>> mmap(NULL, 16726, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f459d333000
>> close(3)                                = 0
>> open("/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
>> read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\3\2\0\0\0\0\0"..., 832) = 832
>> fstat(3, {st_mode=S_IFREG|0755, st_size=1681056, ...}) = 0
>> mmap(NULL, 3787168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f459cd7b000
>> mprotect(0x7f459cf0f000, 2093056, PROT_NONE) = 0
>> mmap(0x7f459d10e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x193000) = 0x7f459d10e000
>> mmap(0x7f459d114000, 14752, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f459d114000
>> close(3)                                = 0
>> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f459d331000
>> arch_prctl(ARCH_SET_FS, 0x7f459d331700) = 0
>> mprotect(0x7f459d10e000, 16384, PROT_READ) = 0
>> mprotect(0x5634debe3000, 4096, PROT_READ) = 0
>> mprotect(0x7f459d33a000, 4096, PROT_READ) = 0
>> munmap(0x7f459d333000, 16726)           = 0
>> ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
>> unshare(CLONE_NEWNS)                    = 0
>> mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL) = 0
>> mount("/dev/pts/ptmx", "/dev/ptmx", NULL, MS_BIND, NULL) = 0
>> open("/dev/ptmx", O_RDWR|O_NOCTTY|O_CLOEXEC) = 3
>> ioctl(3, TIOCSPTLCK, [0])               = 0
>> ioctl(3, _IOC(0, 0x54, 0x41, 0x00), 0x80102) = 4
>> clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f459d3319d0) = 4377
>> wait4(4377, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 4377
>> --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=4377, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
>> close(3)                                = 0
>> close(4)                                = 0
>> getpid()                                = 4376
>> open("/tmp/devpts_ptmx_Z6aEvy", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
>> mount("/dev/pts/ptmx", "/tmp/devpts_ptmx_Z6aEvy", NULL, MS_BIND, NULL) = 0
>> close(3)                                = 0
>> open("/tmp/devpts_ptmx_Z6aEvy", O_RDWR|O_NOCTTY|O_CLOEXEC) = 3
>> ioctl(3, TIOCSPTLCK, [0])               = 0
>> ioctl(3, _IOC(0, 0x54, 0x41, 0x00), 0x80102) = -1 ENOENT (No such file or directory)
>> write(2, "Failed to perform TIOCGPTPEER io"..., 36Failed to perform TIOCGPTPEER ioctl
>> ) = 36
>> close(3)                                = 0
>> umount2("/dev/pts", 0)                  = 0
>> umount2("/dev/ptmx", 0)                 = 0
>> mkdir("/tmp/devpts_fs_w22bR6", 0700)    = 0
>> mount("devpts", "/tmp/devpts_fs_w22bR6", "devpts", MS_NOSUID|MS_NOEXEC, "newinstance,ptmxmode=0666,mode=0"...) = 0
>> open("/tmp/devpts_fs_w22bR6/ptmx", O_RDWR|O_NOCTTY|O_CLOEXEC) = 3
>> ioctl(3, TIOCSPTLCK, [0])               = 0
>> ioctl(3, _IOC(0, 0x54, 0x41, 0x00), 0x80102) = 4
>> clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f459d3319d0) = 4378
>> wait4(4378, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 4378
>> --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=4378, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
>> close(3)                                = 0
>> close(4)                                = 0
>> unlink("/tmp/devpts_fs_w22bR6")         = -1 EISDIR (Is a directory)
>> exit_group(0)                           = ?
>> +++ exited with 0 +++
>> root@intel-core2-32:~#
>>
>>  tools/testing/selftests/filesystems/Makefile     | 1 +
>>  tools/testing/selftests/filesystems/devpts_pts.c | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
>> index 4e6d09fb166f..427a401aae5c 100644
>> --- a/tools/testing/selftests/filesystems/Makefile
>> +++ b/tools/testing/selftests/filesystems/Makefile
>> @@ -1,5 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  TEST_PROGS := dnotify_test devpts_pts
>> +CFLAGS += -I../../../../usr/include/
>>  all: $(TEST_PROGS)
>>
>>  include ../lib.mk
>> diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
>> index b9055e974289..79420b9d00c7 100644
>> --- a/tools/testing/selftests/filesystems/devpts_pts.c
>> +++ b/tools/testing/selftests/filesystems/devpts_pts.c
>> @@ -8,7 +8,7 @@
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <unistd.h>
>> -#include <sys/ioctl.h>
>> +#include <asm/ioctls.h>
>>  #include <sys/mount.h>
>>  #include <sys/wait.h>
>>
>> --
>> 2.11.0
>>
> 

Thanks. I will queue this up for 4.18-rc1

-- Shuah
