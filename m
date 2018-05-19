Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeESQpd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 12:45:33 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36460 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeESQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 12:45:32 -0400
X-Google-Smtp-Source: AB8JxZrIWV+vFNpzNz0/Mx1i347zZvnF/65mhAVRbXD/PHg5YGLY9oXcR4pqzH7T0haIYhqyBjmc0BevxRASP34skVQ=
MIME-Version: 1.0
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
 <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
 <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
 <CA+55aFwxEiiAC+dMMVqQ4igqb7rmn23Bq=BM8fqU=MFRWF1JSw@mail.gmail.com>
 <20180519034338.GV30522@ZenIV.linux.org.uk> <CA+55aFyHLFnGv8yFJs7-vGVe6tDeDAbSJ6=09iTqsegRZN_nGw@mail.gmail.com>
 <your-ad-here.call-01526729953-ext-6746@work.hours>
In-Reply-To: <your-ad-here.call-01526729953-ext-6746@work.hours>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 19 May 2018 09:45:20 -0700
Message-ID: <CA+55aFxw5VXKXVMiS6b0gdpRmrxXb+xHu6O3U=A_S5UzHvY2_A@mail.gmail.com>
Subject: Re: [PATCH] procfs: fix mmap() for /proc/vmcore
To: gor@linux.ibm.com
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: multipart/mixed; boundary="000000000000f7c2a5056c91cbcb"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f7c2a5056c91cbcb
Content-Type: text/plain; charset="UTF-8"

On Sat, May 19, 2018 at 4:39 AM Vasily Gorbik <gor@linux.ibm.com> wrote:

> Would work, but file_mmap_size_max first checks
>              if (S_ISREG(inode->i_mode))
>                      return inode->i_sb->s_maxbytes;
> before
>              if (file->f_mode & FMODE_UNSIGNED_OFFSET)
>                      return 0;
> so, as it is this patch does not fix the issue.

Right you are.

We could easily reverse the order of those two checks, but since clearly
the s_maxbytes case hadn't gotten as much coverage as I thought it had,
let's just simplify file_mmap_size_max() instead, and just make the limit
be MAX_LFS_FILESIZE for regular files too, the way we already do for block
devices (instead of trying to figure out the size of the block device).

That way we won't be introducing changes to s_maxbytes late in the rc
series, and we'll only affect the new logic.

Plus regular files was never what that logic really was introduced to
protect against anyway. It's the random ad-hoc mmap implementations in
drivers that it really aimed to protect.

So for now, I've committed the minimal fixlet that doesn't affect any
existing code (just the new max file size logic), and maybe this can be
revisited for 4.18.

                Linus

--000000000000f7c2a5056c91cbcb
Content-Type: application/x-patch;
	name="0001-mmap-relax-file-size-limit-for-regular-files.patch"
Content-Disposition: attachment;
	filename="0001-mmap-relax-file-size-limit-for-regular-files.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jhdmgx450>
X-Attachment-Id: f_jhdmgx450

RnJvbSA0MjM5MTNhZDRhZTViM2U4ZmI4OTgzZjcwOTY5ZmI1MjIyNjFiYTI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMTkgTWF5IDIwMTggMDk6Mjk6MTEgLTA3MDAKU3ViamVjdDog
W1BBVENIXSBtbWFwOiByZWxheCBmaWxlIHNpemUgbGltaXQgZm9yIHJlZ3VsYXIgZmlsZXMKCkNv
bW1pdCBiZTgzYmJmODA2ODIgKCJtbWFwOiBpbnRyb2R1Y2Ugc2FuZSBkZWZhdWx0IG1tYXAgbGlt
aXRzIikgd2FzCmludHJvZHVjZWQgdG8gY2F0Y2ggcHJvYmxlbXMgaW4gdmFyaW91cyBhZC1ob2Mg
Y2hhcmFjdGVyIGRldmljZSBkcml2ZXJzCmRvaW5nIG1tYXAgYW5kIGdldHRpbmcgdGhlIHNpemUg
bGltaXRzIHdyb25nLiAgSW4gdGhlIHByb2Nlc3MsIGl0IHVzZWQKImtub3duIGdvb2QiIGxpbWl0
cyBmb3IgdGhlIG5vcm1hbCBjYXNlcyBvZiBtYXBwaW5nIHJlZ3VsYXIgZmlsZXMgYW5kCmJsb2Nr
IGRldmljZSBkcml2ZXJzLgoKSXQgdHVybnMgb3V0IHRoYXQgdGhlICJzX21heGJ5dGVzIiBsaW1p
dCB3YXMgbGVzcyAia25vd24gZ29vZCIgdGhhbiBJCnRob3VnaHQuICBJbiBwYXJ0aWN1bGFyLCAv
cHJvYyBkb2Vzbid0IHNldCBpdCwgYnV0IGV4cG9zZXMgb25lIHJlZ3VsYXIKZmlsZSB0byBtbWFw
OiAvcHJvYy92bWNvcmUuICBBcyBhIHJlc3VsdCwgdGhhdCBmaWxlIGdvdCBsaW1pdGVkIHRvIHRo
ZQpkZWZhdWx0IE1BWF9JTlQgc19tYXhieXRlcyB2YWx1ZS4KClRoaXMgd2VudCB1bm5vdGljZWQg
Zm9yIGEgd2hpbGUsIGJlY2F1c2UgYXBwYXJlbnRseSB0aGUgb25seSB0aGluZyB0aGF0Cm5lZWRz
IGl0IGlzIHRoZSBzMzkwIGtlcm5lbCB6ZmNwZHVtcCwgYnV0IHRoZXJlIG1pZ2h0IGJlIG90aGVy
IHRvb2xzCnRoYXQgdXNlIHRoaXMgdG9vLgoKVmFzaWx5IHN1Z2dlc3RlZCBqdXN0IGNoYW5naW5n
IHNfbWF4Ynl0ZXMgZm9yIGFsbCBvZiAvcHJvYywgd2hpY2ggaXNuJ3QKd3JvbmcsIGJ1dCBtYWtl
cyBtZSBuZXJ2b3VzIGF0IHRoaXMgc3RhZ2UuICBTbyBpbnN0ZWFkLCBqdXN0IG1ha2UgdGhlCm5l
dyBtbWFwIGxpbWl0IGFsd2F5cyBiZSBNQVhfTEZTX0ZJTEVTSVpFIGZvciByZWd1bGFyIGZpbGVz
LCB3aGljaCB3b24ndAphZmZlY3QgYW55dGhpbmcgZWxzZS4gIEl0IHdhc24ndCB0aGUgcmVndWxh
ciBmaWxlIGNhc2UgSSB3YXMgd29ycmllZAphYm91dC4KCkknZCByZWFsbHkgcHJlZmVyIGZvciBt
YXhzaXplIHRvIGhhdmUgYmVlbiBwZXItaW5vZGUsIGJ1dCB0aGF0IGlzIG5vdApob3cgdGhpbmdz
IGFyZSB0b2RheS4KCkZpeGVzOiBiZTgzYmJmODA2ODIgKCJtbWFwOiBpbnRyb2R1Y2Ugc2FuZSBk
ZWZhdWx0IG1tYXAgbGltaXRzIikKUmVwb3J0ZWQtYnk6IFZhc2lseSBHb3JiaWsgPGdvckBsaW51
eC5pYm0uY29tPgpDYzogQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+ClNpZ25lZC1v
ZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0t
CiBtbS9tbWFwLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9tbS9tbWFwLmMKaW5kZXggNzhlMTRm
YWNkYjZlLi5mYzQxYzA1NDNkN2YgMTAwNjQ0Ci0tLSBhL21tL21tYXAuYworKysgYi9tbS9tbWFw
LmMKQEAgLTEzMjcsNyArMTMyNyw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1sb2NrX2Z1dHVyZV9j
aGVjayhzdHJ1Y3QgbW1fc3RydWN0ICptbSwKIHN0YXRpYyBpbmxpbmUgdTY0IGZpbGVfbW1hcF9z
aXplX21heChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGlub2RlICppbm9kZSkKIHsKIAlpZiAo
U19JU1JFRyhpbm9kZS0+aV9tb2RlKSkKLQkJcmV0dXJuIGlub2RlLT5pX3NiLT5zX21heGJ5dGVz
OworCQlyZXR1cm4gTUFYX0xGU19GSUxFU0laRTsKIAogCWlmIChTX0lTQkxLKGlub2RlLT5pX21v
ZGUpKQogCQlyZXR1cm4gTUFYX0xGU19GSUxFU0laRTsKLS0gCjIuMTcuMC4zOTIuZzQ0MTE3ZWY3
ZgoK
--000000000000f7c2a5056c91cbcb--
