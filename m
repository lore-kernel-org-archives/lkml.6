Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeFDSaj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:30:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45777 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeFDSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:30:38 -0400
X-Google-Smtp-Source: ADUXVKKyIEMGKZFplfJY35/oluYo+2gYZnQnhRoPKfPR6Fh+TVDHfFEixSeaKtIA3T1ZzRPSCDxPAExirLuAsplSI0A=
MIME-Version: 1.0
In-Reply-To: <2f2047ca-a96f-91da-c746-530c7b8d1bbf@oracle.com>
References: <CAB+yDaZAwFny2NdOZfymdpdR3Sf7pdkxahgQ6v2zBzUvSwBWTA@mail.gmail.com>
 <CAB+yDaZFZhku34wp-t_i32Vy6cYB9fnS0iboPnQZ26sQeAZ+Uw@mail.gmail.com> <2f2047ca-a96f-91da-c746-530c7b8d1bbf@oracle.com>
From: shankarapailoor <shankarapailoor@gmail.com>
Date: Mon, 4 Jun 2018 11:30:36 -0700
Message-ID: <CAB+yDaZFVpRGW8X_eN=0pEeujn6VX13kxRZSf-Sse_GrjcCQKA@mail.gmail.com>
Subject: Re: Slab out of bounds in setxattr
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000435523056dd52163"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000435523056dd52163
Content-Type: text/plain; charset="UTF-8"

Hi Dave,

Attached is my proposed patch. It solves the problem as you suggest
and I don't see the KASAN complaint.

Regards,
Shankara

On Mon, Jun 4, 2018 at 11:24 AM, Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
> On 06/01/2018 11:06 PM, shankarapailoor wrote:
>> Hi,
>>
>> Looking at the crash some more, it seems that if value_len > PAGE_SIZE
>> then e_buf->max_size is rounded up nearest page size [1]. If a new
>> attribute is added with value_len < e_buf->max_size - EA_SIZE(ea) then
>> no new space is allocated for the attiribute list [2] and this
>> triggers the KASAN slab out of bounds error. This is the case in the C
>> repro I provided.
>
> I see the problem. It looks like we should be calculating max_size
> earlier and using that to call kmalloc(). (xattr.c#496)
>
> Shaggy
>>
>>
>> 1. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L501
>> 2. https://elixir.bootlin.com/linux/v4.17-rc7/source/fs/jfs/xattr.c#L723
>>
>> On Fri, Jun 1, 2018 at 1:52 PM, shankarapailoor
>> <shankarapailoor@gmail.com> wrote:
>>> Hi Dave et al,
>>>
>>> I have been fuzzing linux 4.17-rc4 with JFS using Syzkaller  KASAN:
>>> slab-out-of-bounds in jfs_xattr.
>>>
>>> Attached are my kernel configs and a C reproducer. In the first
>>> setxattr call it appears that length is much larger than the name. In
>>> __jfs_setxattr, I don't see where the length is checked against the
>>> actual value length.
>>>
>>> Regards,
>>> Shankara Pailoor
>>
>>
>>



-- 
Regards,
Shankara Pailoor

--000000000000435523056dd52163
Content-Type: application/octet-stream; name=jfspatch
Content-Disposition: attachment; filename=jfspatch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ji0lbf6q0

ZGlmZiAtLWdpdCBhL2ZzL2pmcy94YXR0ci5jIGIvZnMvamZzL3hhdHRyLmMKaW5kZXggYzYwZjNk
My4uYTA5YzUyNiAxMDA2NDQKLS0tIGEvZnMvamZzL3hhdHRyLmMKKysrIGIvZnMvamZzL3hhdHRy
LmMKQEAgLTQ5MywxNCArNDkzLDE0IEBAIHN0YXRpYyBpbnQgZWFfZ2V0KHN0cnVjdCBpbm9kZSAq
aW5vZGUsIHN0cnVjdCBlYV9idWZmZXIgKmVhX2J1ZiwgaW50IG1pbl9zaXplKQogICAgICAgICAg
ICAgICAgICogVG8ga2VlcCB0aGUgcmVzdCBvZiB0aGUgY29kZSBzaW1wbGUuICBBbGxvY2F0ZSBh
CiAgICAgICAgICAgICAgICAgKiBjb250aWd1b3VzIGJ1ZmZlciB0byB3b3JrIHdpdGgKICAgICAg
ICAgICAgICAgICAqLwotICAgICAgICAgICAgICAgZWFfYnVmLT54YXR0ciA9IGttYWxsb2Moc2l6
ZSwgR0ZQX0tFUk5FTCk7CisgICAgICAgICAgICAgICBlYV9idWYtPm1heF9zaXplID0gKHNpemUg
KyBzYi0+c19ibG9ja3NpemUgLSAxKSAmCisgICAgICAgICAgICAgICAgICAgfihzYi0+c19ibG9j
a3NpemUgLSAxKTsKKworICAgICAgICAgICAgICAgZWFfYnVmLT54YXR0ciA9IGttYWxsb2MoZWFf
YnVmLT5tYXhfc2l6ZSwgR0ZQX0tFUk5FTCk7CiAgICAgICAgICAgICAgICBpZiAoZWFfYnVmLT54
YXR0ciA9PSBOVUxMKQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKIAog
ICAgICAgICAgICAgICAgZWFfYnVmLT5mbGFnID0gRUFfTUFMTE9DOwotICAgICAgICAgICAgICAg
ZWFfYnVmLT5tYXhfc2l6ZSA9IChzaXplICsgc2ItPnNfYmxvY2tzaXplIC0gMSkgJgotICAgICAg
ICAgICAgICAgICAgIH4oc2ItPnNfYmxvY2tzaXplIC0gMSk7Ci0KICAgICAgICAgICAgICAgIGlm
IChlYV9zaXplID09IDApCiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOwo=
--000000000000435523056dd52163--
