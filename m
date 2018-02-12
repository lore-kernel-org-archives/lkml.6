Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbeBLPTi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:19:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751279AbeBLPTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:19:37 -0500
Date: Mon, 12 Feb 2018 16:19:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        ananth@linux.vnet.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Uprobe: Bug(?) when probing small binaries
Message-ID: <20180212151935.GA12577@redhat.com>
References: <e74318e0-0cdf-e55d-bf06-b481541e2697@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e74318e0-0cdf-e55d-bf06-b481541e2697@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 02/12, Ravi Bangoria wrote:
>
> I'm observing a bug in the uprobe infrastructure.

I am not sure,

> When target binary
> is quite small, uprobe replaces 'trap' instruction at two different
> places. Ex,

but this is actually "the same place" (in the file), just 2 virtual addrs differ,

>   (gdb) x/w 0x1001069c
>     0x1001069c:    2080899750
>
> Now enable the probe:
>
>   # echo 1 > events/probe_a/main/enable
>
> Check probed instruction:
>
>   (gdb) disassemble main
>        0x000000001000069c <+8>:    trap
>
> *Bug*:
>
>   (gdb) x/w 0x1001069c
>     0x1001069c:  2145386504
>
> In short, when it replaces the probe instruction, it does some corruption
> in the readonly vma. This seems to be a bug.
>
> How did I get the other address 0x1001069c?I found build_map_info()
> returns these two vmas for the single probe:
>
>   10000000-10010000 r-xp 00000000 08:05 67325595   /home/ravi/a.out
>   10010000-10020000 r--p 00000000 08:05 67325595   /home/ravi/a.out

please note that these 2 vma's mmap the same region in a.out, so
*0x1001069c and *0x1000069c point to the same insn.

Oleg.
