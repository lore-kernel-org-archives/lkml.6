Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D25BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BF22086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeLONRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:17:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729192AbeLONRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:17:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 77A7A3D63F380;
        Sat, 15 Dec 2018 21:17:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Sat, 15 Dec 2018
 21:17:11 +0800
Subject: Re: [PATCH] jffs2: fix invocations of dbg_xattr() for dead
 jffs2_xattr_ref
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        <boris.brezillon@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181020110753.98407-1-houtao1@huawei.com>
 <20181209075256.43ca759f@bbrezillon>
 <CAFLxGvyfM4tKH8hVoWDuYcojcHOQABvvDKZd1Mwbc8TMC5R5Jw@mail.gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <39d00539-7845-4f1e-d95c-d6f14cde3905@huawei.com>
Date:   Sat, 15 Dec 2018 21:17:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyfM4tKH8hVoWDuYcojcHOQABvvDKZd1Mwbc8TMC5R5Jw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/14 5:53, Richard Weinberger wrote:
> On Sun, Dec 9, 2018 at 7:52 AM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
>>
>> On Sat, 20 Oct 2018 19:07:53 +0800
>> Hou Tao <houtao1@huawei.com> wrote:
>>
>>> When jffs2_xattr_ref is dead, xref->ic or xref->xd will be invalid
>>> because these fields will be reused as xref->ino or xref->xid,
>>> so access xref->ic->ino or xref->xd->xid will lead to Oops.
>>>
>>> Fix the problem by checking whether or not it is a dead xref.
>>>
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  fs/jffs2/xattr.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
>>> index 3d40fe02b003..0c4c7891556d 100644
>>> --- a/fs/jffs2/xattr.c
>>> +++ b/fs/jffs2/xattr.c
>>> @@ -550,7 +550,8 @@ static int save_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_ref *ref)
>>>       ref->xseqno = xseqno;
>>>       jffs2_add_physical_node_ref(c, phys_ofs | REF_PRISTINE, PAD(sizeof(rr)), (void *)ref);
>>>
>>> -     dbg_xattr("success on saving xref (ino=%u, xid=%u)\n", ref->ic->ino, ref->xd->xid);
>>> +     dbg_xattr("success on saving xref (ino=%u, xid=%u)\n",
>>> +                     je32_to_cpu(rr.ino), je32_to_cpu(rr.xid));
>>
>> Nit: align the second line on the open parens (same applies to the
>> other chunk).

Thanks for pointing it out, I will fix them.

>> Sorry, I can't comment on the actual change. I'll let Richard look
>> at it.
>>
>>>
>>>       return 0;
>>>  }
>>> @@ -1329,7 +1330,11 @@ int jffs2_garbage_collect_xattr_ref(struct jffs2_sb_info *c, struct jffs2_xattr_
>>>       rc = save_xattr_ref(c, ref);
>>>       if (!rc)
>>>               dbg_xattr("xref (ino=%u, xid=%u) GC'ed from %#08x to %08x\n",
>>> -                       ref->ic->ino, ref->xd->xid, old_ofs, ref_offset(ref->node));
>>> +                             is_xattr_ref_dead(ref) ?
>>> +                                     ref->ino : ref->ic->ino,
>>> +                             is_xattr_ref_dead(ref) ?
>>> +                                     ref->xid : ref->xd->xid,
>>> +                             old_ofs, ref_offset(ref->node));
>>>   out:
>>>       if (!rc)
>>>               jffs2_mark_node_obsolete(c, raw);
>>
> 
> Since is_xattr_ref_dead() is cheap, can you please add two macros.
> Something like:
> static inline uint32_t xattr_ref_ino(struct jffs2_xattr_ref *ref) {
>  if (is_xattr_ref_dead(ref))
>   return ref>ino;
>  else
>   return ref->ic->ino;
> }
> 
> Same for xid.
> 
Yes, there would be better, will do that.

Thanks,
Tao


