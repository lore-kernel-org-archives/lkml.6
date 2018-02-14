Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967513AbeBNLkz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:40:55 -0500
Received: from ozlabs.org ([103.22.144.67]:48249 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967355AbeBNLky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:40:54 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>
Cc: "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param xmon=off
In-Reply-To: <8737264c91.fsf@vajain21.in.ibm.com>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com> <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com> <8737264c91.fsf@vajain21.in.ibm.com>
Date: Wed, 14 Feb 2018 22:40:51 +1100
Message-ID: <87eflnre7w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> Thanks for reviewing this patch Balbir
>
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> Any specific issue you've run into without this patch? 
> Without this patch since xmon is still accessible via sysrq and there is
> no indication/warning on the xmon console mentioning that its is not
> fully functional. Specifically xmon-console would still allow user to
> set instruction/data breakpoint eventhough they wont work and will
> result in a kernel-oops.
>
> Below is command log illustrating this problem on one of my test system
> where I tried setting an instruction breakpoint on cmdline_proc_show()
> with xmon=off:

<snip>

But the same crash happens with XMON_DEFAULT=n and nothing on the
command line.

The problem is not xmon=off on the command line.

The problem is that when xmon_on = false and we enter xmon via sysrq and
then set breakpoints, we need to enable xmon_on before leaving xmon.

So this is a bug introduced by:

  3b5bf42b81d5 ("powerpc/xmon: Fix an unexpected xmon on/off state change")


How to fix it is not entirely clear. In general I like the behaviour we
have since the above commit, ie. quickly dropping into xmon and
inspecting something doesn't leave xmon enabled, which then causes the
system not to kdump/reboot later.

What would be nice is if we keep that behaviour, but any action you take
in xmon that requires xmon to remain resident, ie. setting a breakpoint,
calls a function which makes sure xmon_on = true and if it wasn't prints
a nice message saying "Turning xmon on due to breakpoint insertion" or
something.

cheers
