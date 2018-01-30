Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeA3K61 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:58:27 -0500
Received: from www62.your-server.de ([213.133.104.62]:50859 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeA3K6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:58:25 -0500
Subject: Re: [PATCH bpf-next v7 3/5] libbpf: add error reporting in XDP
To: Eric Leblond <eric@regit.org>
Cc: alexei.starovoitov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <4dc597a1-5046-3805-eb81-03a23bf0acbb@iogearbox.net>
 <20180125000548.12320-1-eric@regit.org>
 <20180125000548.12320-4-eric@regit.org>
 <0291c0fe-d8c6-1072-3069-4b3000d290fe@iogearbox.net>
 <1517049126.24241.19.camel@regit.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a26f90e9-5028-f8a9-a1e6-83a6c46b4e0b@iogearbox.net>
Date: Tue, 30 Jan 2018 11:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1517049126.24241.19.camel@regit.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 01/27/2018 11:32 AM, Eric Leblond wrote:
> On Sat, 2018-01-27 at 02:28 +0100, Daniel Borkmann wrote:
>> On 01/25/2018 01:05 AM, Eric Leblond wrote:
>>> Parse netlink ext attribute to get the error message returned by
>>> the card. Code is partially take from libnl.
>>>
>>> We add netlink.h to the uapi include of tools. And we need to
>>> avoid include of userspace netlink header to have a successful
>>> build of sample so nlattr.h has a define to avoid
>>> the inclusion. Using a direct define could have been an issue
>>> as NLMSGERR_ATTR_MAX can change in the future.
>>>
>>> We also define SOL_NETLINK if not defined to avoid to have to
>>> copy socket.h for a fixed value.
>>>
>>> Signed-off-by: Eric Leblond <eric@regit.org>
>>> Acked-by: Alexei Starovoitov <ast@kernel.org>
>>>
>>> remote rtne
>>>
>>> Signed-off-by: Eric Leblond <eric@regit.org>
>>
>> Some leftover artifact from squashing commits?
> 
> Outch
> 
>>>  samples/bpf/Makefile   |   2 +-
>>>  tools/lib/bpf/Build    |   2 +-
>>>  tools/lib/bpf/bpf.c    |  13 +++-
>>>  tools/lib/bpf/nlattr.c | 187
>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>  tools/lib/bpf/nlattr.h |  72 +++++++++++++++++++
>>>  5 files changed, 273 insertions(+), 3 deletions(-)
>>>  create mode 100644 tools/lib/bpf/nlattr.c
>>>  create mode 100644 tools/lib/bpf/nlattr.h
>>>
>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>> index 7f61a3d57fa7..5c4cd3745282 100644
>>> --- a/samples/bpf/Makefile
>>> +++ b/samples/bpf/Makefile
>>> @@ -45,7 +45,7 @@ hostprogs-y += xdp_rxq_info
>>>  hostprogs-y += syscall_tp
>>>  
>>>  # Libbpf dependencies
>>> -LIBBPF := ../../tools/lib/bpf/bpf.o
>>> +LIBBPF := ../../tools/lib/bpf/bpf.o ../../tools/lib/bpf/nlattr.o
>>>  CGROUP_HELPERS :=
>>> ../../tools/testing/selftests/bpf/cgroup_helpers.o
>>>  
>>>  test_lru_dist-objs := test_lru_dist.o $(LIBBPF)
>>> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
>>> index d8749756352d..64c679d67109 100644
>>> --- a/tools/lib/bpf/Build
>>> +++ b/tools/lib/bpf/Build
>>> @@ -1 +1 @@
>>> -libbpf-y := libbpf.o bpf.o
>>> +libbpf-y := libbpf.o bpf.o nlattr.o
>>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>>> index 749a447ec9ed..765fd95b0657 100644
>>> --- a/tools/lib/bpf/bpf.c
>>> +++ b/tools/lib/bpf/bpf.c
>>> @@ -27,7 +27,7 @@
>>>  #include "bpf.h"
>>>  #include "libbpf.h"
>>>  #include "nlattr.h"
>>> -#include <uapi/linux/rtnetlink.h>
>>> +#include <linux/rtnetlink.h>
>>
>> Okay, so here it's put back from prior added uapi/linux/rtnetlink.h
>> into linux/rtnetlink.h. Could you add this properly in the first
>> commit rather than relative adjustment/fix within the same set?
> 
> Yes, sure.
> 
>>>  #include <sys/socket.h>
>>>  #include <errno.h>
>>>  
>>> @@ -37,6 +37,10 @@
>>>  #define IFLA_XDP_FLAGS	3
>>>  #endif
>>>  
>>> +#ifndef SOL_NETLINK
>>> +#define SOL_NETLINK 270
>>> +#endif
>>
>> This would need include/linux/socket.h into tools/ include infra
>> as well, no?
> 
> Yes, and I fear a lot of dependencies.

Sorry for the delay! So, once you pull these two headers in, are there more
follow-up dependencies with other headers required on your old test system?
I'd also be fine with keeping SOL_NETLINK here as is, but I would try to
have the if_link.h in the tools/ include infra, so we have all XDP definitions
available and up to date from the lib's pov. The dependency for if_link.h
seems minimal and probably enough to to only get in this single header. Could
you give that a try?

Thanks a lot,
Daniel
