Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeBXAN7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:13:59 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43959 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeBXAN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:13:58 -0500
X-Google-Smtp-Source: AH8x224jYAypMyRrGewSFNOxIJc0tdbls+05eQiD4NFLAsmQcW1qdyuF52EtxlHM+OtOlOPCtkEaZkY3dQ3Z+BfQYA0=
MIME-Version: 1.0
In-Reply-To: <CAM_iQpUveA5T6-y7bguaPUok-LphJrLYxw6kNgaMorsxm4z9NA@mail.gmail.com>
References: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
 <b926a569-c05e-dd49-a25d-555e88e9ff8e@infradead.org> <CAM_iQpUveA5T6-y7bguaPUok-LphJrLYxw6kNgaMorsxm4z9NA@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 23 Feb 2018 16:13:36 -0800
Message-ID: <CAM_iQpWSRe0t1Dr=7o+1ejULV=F+_Wx1v7yyw=NRBUTYttMxog@mail.gmail.com>
Subject: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running selftest
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Khalid Aziz <khalid.aziz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 3:27 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Fri, Feb 23, 2018 at 11:00 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> [adding netdev]
>>
>> On 02/23/2018 08:05 AM, Khalid Aziz wrote:
>>> I am seeing a kernel panic with 4.16-rc1 and 4.16-rc2 kernels when running selftests
>>> from tools/testing/selftests. Last messages from selftest before kernel panic are:
>>>
> ...
>>> Same selftest does not cause panic on 4.15. git bisect pointed to commit 6ce711f2750031d12cec91384ac5cfa0a485b60a ("idr: Make 1-based IDRs more efficient").
>>> Kernel config is attached.
>
> Looks like something horribly wrong with u32 key id idr...

Adding a few printk's, I got:

[   31.231560] requested handle = ffe00000
[   31.232426] allocated handle = 0
...
[   31.246475] requested handle = ffd00000
[   31.247555] allocated handle = 1


So the bug is here where we can't allocate a specific handle:

                        err = idr_alloc_u32(&tp_c->handle_idr, ht, &handle,
                                            handle, GFP_KERNEL);
                        if (err) {
                                kfree(ht);
                                return err;
                        }
