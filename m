Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031303AbeEZHmJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 03:42:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38851 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031131AbeEZHmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 03:42:07 -0400
X-Google-Smtp-Source: ADUXVKKzPfvX4VmPhe8RDFHBZlWln9u2Qy/s9YYbFudFQJTCIBnT6QlPQDa28sM9fY8dDC3foc8aPJ54ujla4jMwnbo=
MIME-Version: 1.0
In-Reply-To: <176ee190-ecda-9b3e-5066-ecf3fbaf32bb@huawei.com>
References: <20180525101757.13756-1-yuehaibing@huawei.com> <20180525161925.crdamzqjgs5wg77e@ast-mbp>
 <176ee190-ecda-9b3e-5066-ecf3fbaf32bb@huawei.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 26 May 2018 15:41:26 +0800
Message-ID: <CALOAHbD1h+3SrV6LAEGgSS8sAytiGFMnSp=a9ieq4QwY2PFXqQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bpfilter: fix a build err
To: YueHaibing <yuehaibing@huawei.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Miller <davem@davemloft.net>, ast@kernel.org,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 10:25 AM, YueHaibing <yuehaibing@huawei.com> wrote:
> On 2018/5/26 0:19, Alexei Starovoitov wrote:
>> On Fri, May 25, 2018 at 06:17:57PM +0800, YueHaibing wrote:
>>> gcc-7.3.0 report following err:
>>>
>>>   HOSTCC  net/bpfilter/main.o
>>> In file included from net/bpfilter/main.c:9:0:
>>> ./include/uapi/linux/bpf.h:12:10: fatal error: linux/bpf_common.h: No such file or directory
>>>  #include <linux/bpf_common.h>
>>>
>>> remove it by adding a include path.
>>> Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  net/bpfilter/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
>>> index 2af752c..3f3cb87 100644
>>> --- a/net/bpfilter/Makefile
>>> +++ b/net/bpfilter/Makefile
>>> @@ -5,7 +5,7 @@
>>>
>>>  hostprogs-y := bpfilter_umh
>>>  bpfilter_umh-objs := main.o
>>> -HOSTCFLAGS += -I. -Itools/include/
>>> +HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
>>
>> Strangely I don't see this error with gcc 7.3
>> I've tried this patch and it doesn't hurt,
>> but before it gets applied could you please try
>> the top two patches from this tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/?h=ipt_bpf
>> in your environment?
>> These two patches add the actual meat of bpfilter and I'd like
>> to make sure the build setup is good for everyone before
>> we proceed too far.
>
> after applied these two patches on net-next, the err still here:
>  bpfilter: rough bpfilter codegen example hack
>  bpfilter: add iptable get/set parsing
>
>   HOSTCC  net/bpfilter/main.o
> In file included from net/bpfilter/main.c:13:0:
> ./include/uapi/linux/bpf.h:12:10: fatal error: linux/bpf_common.h: No such file or directory
>  #include <linux/bpf_common.h>
>           ^~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [net/bpfilter/main.o] Error 1
> make[1]: *** [net/bpfilter] Error 2
> make: *** [net] Error 2
>
> Also I compile your tree, error is same
>
> my gcc version info as follow:
> [root@localhost net-next]# gcc -v
> Using built-in specs.
> COLLECT_GCC=gcc
> COLLECT_LTO_WRAPPER=/home/yuehb/gcc-7.3.0-tools/libexec/gcc/x86_64-pc-linux-gnu/7.3.0/lto-wrapper
> Target: x86_64-pc-linux-gnu
> Configured with: ../gcc-7.3.0/configure --enable-checking=release --enable-languages=c,c++
> --disable-multilib --prefix=/home/yuehb/gcc-7.3.0-tools
> Thread model: posix
> gcc version 7.3.0 (GCC)
>
>>


This error also occurs on gcc-4.8.5.
After applied Haibin's patch, this build error disapears.

Thanks
Yafang
