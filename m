Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeFDSYt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:24:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34422 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeFDSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:24:47 -0400
Subject: Re: Slab out of bounds in setxattr
To: shankarapailoor <shankarapailoor@gmail.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <CAB+yDaZAwFny2NdOZfymdpdR3Sf7pdkxahgQ6v2zBzUvSwBWTA@mail.gmail.com>
 <CAB+yDaZFZhku34wp-t_i32Vy6cYB9fnS0iboPnQZ26sQeAZ+Uw@mail.gmail.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <2f2047ca-a96f-91da-c746-530c7b8d1bbf@oracle.com>
Date: Mon, 4 Jun 2018 13:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAB+yDaZFZhku34wp-t_i32Vy6cYB9fnS0iboPnQZ26sQeAZ+Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=697
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 11:06 PM, shankarapailoor wrote:
> Hi,
> 
> Looking at the crash some more, it seems that if value_len > PAGE_SIZE
> then e_buf->max_size is rounded up nearest page size [1]. If a new
> attribute is added with value_len < e_buf->max_size - EA_SIZE(ea) then
> no new space is allocated for the attiribute list [2] and this
> triggers the KASAN slab out of bounds error. This is the case in the C
> repro I provided.

I see the problem. It looks like we should be calculating max_size
earlier and using that to call kmalloc(). (xattr.c#496)

Shaggy
> 
> 
> 1. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L501
> 2. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L723
> 
> On Fri, Jun 1, 2018 at 1:52 PM, shankarapailoor
> <shankarapailoor@gmail.com> wrote:
>> Hi Dave et al,
>>
>> I have been fuzzing linux 4.17-rc4 with JFS using Syzkaller  KASAN:
>> slab-out-of-bounds in jfs_xattr.
>>
>> Attached are my kernel configs and a C reproducer. In the first
>> setxattr call it appears that length is much larger than the name. In
>> __jfs_setxattr, I don't see where the length is checked against the
>> actual value length.
>>
>> Regards,
>> Shankara Pailoor
> 
> 
> 
