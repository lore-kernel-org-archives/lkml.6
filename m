Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753475AbeBKOvt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 09:51:49 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:45936 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 09:51:47 -0500
X-Google-Smtp-Source: AH8x225PV7dP+Y3GKXDlWsmK49ouokl5WZuH68CpAtqRn3gWvs3AuzQEhIyAYyVD40htsVcNcZ2Ty7TLWE9xAUB64v0=
MIME-Version: 1.0
In-Reply-To: <CA+55aFz34O6dA6fYy36yYA0w==dwkLX6UOCnTrioCO6__+rajQ@mail.gmail.com>
References: <1517851938-5892-1-git-send-email-amir73il@gmail.com> <CA+55aFz34O6dA6fYy36yYA0w==dwkLX6UOCnTrioCO6__+rajQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 11 Feb 2018 16:51:45 +0200
Message-ID: <CAOQ4uxi=u-KKvULgEHPc2XFnfZ0EWd8R9AcJNCSCMwo3M0iFPw@mail.gmail.com>
Subject: Re: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="f403045e5a5a87c59a0564f0e6c4"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f403045e5a5a87c59a0564f0e6c4
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 9, 2018 at 8:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

>
> I *would* love to get some kind of estimate on how this changes the
> hash distribution. Do you have anything like that? The way this
> function is designed to be used, the upper bits should be used for the
> hash bucket information, so doing some bucket size distribution on
> (say) the upper ~12 bits or something with some real string input
> would be really good.
>

I've added bucket counters and tracing number of entries / number of non
empty buckets and largest bucket to dcache (patch attached).
Increased d_hash_shift to take only 12 bits for hash table offset.
The results vary a bit per run, but below are some outputs from sample runs
of find / of 55K entries right after boot.

The bottom line is that, at least w.r.t this simplistic bucket analysis and this
specific workload, the patch does not seem to move the needle. The bucket
distribution of before and after patch are similar and also similar to the
word-at-a-time results.
Just for comparison, I added a run with noop end_name_hash() which shows
a worse bucket distribution.

Perhaps it would take a different workload, or different analysis to demonstrate
the alleged deficiencies of the current implementation? Not sure which evidence
will be required to justify the change, even if, the patch is correct in theory?
I wonder if we should just let this old code be... maybe add something to the
comment or remove the part about "try to avoid losing bits..."?

Thanks,
Amir.


----------------------------------------------------

x86_64, word-at-a-time, 12 bits:

[    0.008583] dcache: d_hash_shift = 20, nentries = 1, nbuckets = 1,
maxcount = 1
[    0.783683] dcache: d_hash_shift = 20, nentries = 130, nbuckets =
129, maxcount = 2
[    0.785336] dcache: d_hash_shift = 20, nentries = 314, nbuckets =
303, maxcount = 3
[    0.789104] dcache: d_hash_shift = 20, nentries = 818, nbuckets =
736, maxcount = 4
[    0.795435] dcache: d_hash_shift = 20, nentries = 1738, nbuckets =
1406, maxcount = 5
[    0.804935] dcache: d_hash_shift = 20, nentries = 3056, nbuckets =
2134, maxcount = 6
[    0.814014] dcache: d_hash_shift = 20, nentries = 4158, nbuckets =
2595, maxcount = 7
[    0.824848] dcache: d_hash_shift = 20, nentries = 5635, nbuckets =
3051, maxcount = 8
[    0.844848] dcache: d_hash_shift = 20, nentries = 8523, nbuckets =
3584, maxcount = 9
[    0.852072] dcache: d_hash_shift = 20, nentries = 9571, nbuckets =
3708, maxcount = 10
[    0.855598] dcache: d_hash_shift = 20, nentries = 10098, nbuckets =
3745, maxcount = 11
[    2.793453] dcache: d_hash_shift = 20, nentries = 13547, nbuckets =
3937, maxcount = 12
[    3.097325] dcache: d_hash_shift = 20, nentries = 14394, nbuckets =
3965, maxcount = 13
[    3.559967] dcache: d_hash_shift = 20, nentries = 16783, nbuckets =
4017, maxcount = 14
[   10.259225] dcache: d_hash_shift = 20, nentries = 22166, nbuckets =
4070, maxcount = 15
[   10.326126] dcache: d_hash_shift = 20, nentries = 24960, nbuckets =
4083, maxcount = 16
[   10.338824] dcache: d_hash_shift = 20, nentries = 25348, nbuckets =
4084, maxcount = 17
[   10.423085] dcache: d_hash_shift = 20, nentries = 29715, nbuckets =
4095, maxcount = 18
[   10.746374] dcache: d_hash_shift = 20, nentries = 30771, nbuckets =
4095, maxcount = 19

x86_64, byte at a time, before patch:

[    0.008624] dcache: d_hash_shift = 20, nentries = 1, nbuckets = 1,
maxcount = 1
[    0.797948] dcache: d_hash_shift = 20, nentries = 168, nbuckets =
167, maxcount = 2
[    0.803184] dcache: d_hash_shift = 20, nentries = 953, nbuckets =
858, maxcount = 3
[    0.809085] dcache: d_hash_shift = 20, nentries = 1690, nbuckets =
1390, maxcount = 4
[    0.818364] dcache: d_hash_shift = 20, nentries = 2868, nbuckets =
2082, maxcount = 5
[    0.826448] dcache: d_hash_shift = 20, nentries = 4016, nbuckets =
2609, maxcount = 6
[    0.844307] dcache: d_hash_shift = 20, nentries = 6525, nbuckets =
3357, maxcount = 7
[    0.848492] dcache: d_hash_shift = 20, nentries = 7121, nbuckets =
3473, maxcount = 8
[    0.850470] dcache: d_hash_shift = 20, nentries = 7419, nbuckets =
3514, maxcount = 9
[    2.781536] dcache: d_hash_shift = 20, nentries = 13484, nbuckets =
3984, maxcount = 10
[    3.082709] dcache: d_hash_shift = 20, nentries = 14329, nbuckets =
4012, maxcount = 11
[    3.116017] dcache: d_hash_shift = 20, nentries = 14411, nbuckets =
4011, maxcount = 12
[    3.736935] dcache: d_hash_shift = 20, nentries = 17509, nbuckets =
4054, maxcount = 13
[   17.557370] dcache: d_hash_shift = 20, nentries = 19928, nbuckets =
4073, maxcount = 14
[   17.587867] dcache: d_hash_shift = 20, nentries = 21488, nbuckets =
4083, maxcount = 15
[   17.622295] dcache: d_hash_shift = 20, nentries = 22798, nbuckets =
4085, maxcount = 16
[   17.642227] dcache: d_hash_shift = 20, nentries = 23505, nbuckets =
4086, maxcount = 17
[   17.722103] dcache: d_hash_shift = 20, nentries = 27107, nbuckets =
4092, maxcount = 18
[   17.749791] dcache: d_hash_shift = 20, nentries = 28353, nbuckets =
4093, maxcount = 19
[   17.958165] dcache: d_hash_shift = 20, nentries = 30687, nbuckets =
4095, maxcount = 20

x86_64, byte at a time, after patch:

[    0.008648] dcache: d_hash_shift = 20, nentries = 1, nbuckets = 1,
maxcount = 1
[    0.795676] dcache: d_hash_shift = 20, nentries = 157, nbuckets =
156, maxcount = 2
[    0.799493] dcache: d_hash_shift = 20, nentries = 619, nbuckets =
563, maxcount = 3
[    0.803741] dcache: d_hash_shift = 20, nentries = 1115, nbuckets =
928, maxcount = 4
[    0.814418] dcache: d_hash_shift = 20, nentries = 2619, nbuckets =
1894, maxcount = 5
[    0.817449] dcache: d_hash_shift = 20, nentries = 3053, nbuckets =
2095, maxcount = 6
[    0.838418] dcache: d_hash_shift = 20, nentries = 5981, nbuckets =
3159, maxcount = 7
[    0.843916] dcache: d_hash_shift = 20, nentries = 6790, nbuckets =
3340, maxcount = 8
[    0.854101] dcache: d_hash_shift = 20, nentries = 8263, nbuckets =
3565, maxcount = 9
[    0.864520] dcache: d_hash_shift = 20, nentries = 9745, nbuckets =
3760, maxcount = 10
[    2.799091] dcache: d_hash_shift = 20, nentries = 13273, nbuckets =
3954, maxcount = 11
[    3.201936] dcache: d_hash_shift = 20, nentries = 14576, nbuckets =
3988, maxcount = 12
[    3.996005] dcache: d_hash_shift = 20, nentries = 17902, nbuckets =
4051, maxcount = 13
[    9.847851] dcache: d_hash_shift = 20, nentries = 19322, nbuckets =
4068, maxcount = 14
[    9.858100] dcache: d_hash_shift = 20, nentries = 19891, nbuckets =
4074, maxcount = 15
[    9.889944] dcache: d_hash_shift = 20, nentries = 21424, nbuckets =
4082, maxcount = 16
[    9.912863] dcache: d_hash_shift = 20, nentries = 22145, nbuckets =
4087, maxcount = 17
[    9.940020] dcache: d_hash_shift = 20, nentries = 23126, nbuckets =
4089, maxcount = 18
[   10.016343] dcache: d_hash_shift = 20, nentries = 26093, nbuckets =
4094, maxcount = 19
[   10.072039] dcache: d_hash_shift = 20, nentries = 28712, nbuckets =
4094, maxcount = 20

x86_64, byte at a time, with NOOP end_name_hash() (i.e. take 32 LSB):

[    0.008609] dcache: d_hash_shift = 20, nentries = 1, nbuckets = 1,
maxcount = 1
[    0.081990] dcache: d_hash_shift = 20, nentries = 5, nbuckets = 4,
maxcount = 2
[    0.802145] dcache: d_hash_shift = 20, nentries = 31, nbuckets =
28, maxcount = 3
[    0.813503] dcache: d_hash_shift = 20, nentries = 554, nbuckets =
482, maxcount = 4
[    0.817755] dcache: d_hash_shift = 20, nentries = 1151, nbuckets =
932, maxcount = 5
[    0.817910] dcache: d_hash_shift = 20, nentries = 1175, nbuckets =
947, maxcount = 6
[    0.817987] dcache: d_hash_shift = 20, nentries = 1187, nbuckets =
952, maxcount = 7
[    0.838691] dcache: d_hash_shift = 20, nentries = 4152, nbuckets =
2502, maxcount = 8
[    0.848732] dcache: d_hash_shift = 20, nentries = 5564, nbuckets =
2959, maxcount = 9
[    0.848774] dcache: d_hash_shift = 20, nentries = 5570, nbuckets =
2960, maxcount = 10
[    0.872152] dcache: d_hash_shift = 20, nentries = 8949, nbuckets =
3548, maxcount = 11
[    0.879572] dcache: d_hash_shift = 20, nentries = 10020, nbuckets =
3647, maxcount = 12
[    0.893884] dcache: d_hash_shift = 20, nentries = 12009, nbuckets =
3803, maxcount = 13
[    0.897821] dcache: d_hash_shift = 20, nentries = 12570, nbuckets =
3827, maxcount = 14
[    0.898154] dcache: d_hash_shift = 20, nentries = 12615, nbuckets =
3827, maxcount = 15
[    0.898432] dcache: d_hash_shift = 20, nentries = 12654, nbuckets =
3829, maxcount = 16
[    0.898877] dcache: d_hash_shift = 20, nentries = 12717, nbuckets =
3830, maxcount = 17
[    0.906711] dcache: d_hash_shift = 20, nentries = 12821, nbuckets =
3838, maxcount = 18
[    0.906822] dcache: d_hash_shift = 20, nentries = 12822, nbuckets =
3838, maxcount = 19
[    0.906920] dcache: d_hash_shift = 20, nentries = 12823, nbuckets =
3838, maxcount = 20
[...]
[    3.743889] dcache: d_hash_shift = 20, nentries = 17112, nbuckets =
3992, maxcount = 91
[    4.113855] dcache: d_hash_shift = 20, nentries = 17927, nbuckets =
4000, maxcount = 92
[   11.915833] dcache: d_hash_shift = 20, nentries = 27988, nbuckets =
4084, maxcount = 93

--f403045e5a5a87c59a0564f0e6c4
Content-Type: text/x-patch; charset="US-ASCII"; name="dcache_buckets.patch"
Content-Disposition: attachment; filename="dcache_buckets.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jdiw66610

ZGlmZiAtLWdpdCBhL2ZzL2RjYWNoZS5jIGIvZnMvZGNhY2hlLmMKaW5kZXggN2MzOGYzOTk1OGJj
Li5iYTExZDIwNDdlNzMgMTAwNjQ0Ci0tLSBhL2ZzL2RjYWNoZS5jCisrKyBiL2ZzL2RjYWNoZS5j
CkBAIC0xMDMsMTMgKzEwMywyNSBAQCBFWFBPUlRfU1lNQk9MKHNsYXNoX25hbWUpOwogCiBzdGF0
aWMgdW5zaWduZWQgaW50IGRfaGFzaF9zaGlmdCBfX3JlYWRfbW9zdGx5OwogCi1zdGF0aWMgc3Ry
dWN0IGhsaXN0X2JsX2hlYWQgKmRlbnRyeV9oYXNodGFibGUgX19yZWFkX21vc3RseTsKK3N0cnVj
dCBfaGxpc3RfYmxfaGVhZCB7CisJc3RydWN0IGhsaXN0X2JsX2hlYWQgaGVhZDsKKwlpbnQgY291
bnQ7Cit9OwogCi1zdGF0aWMgaW5saW5lIHN0cnVjdCBobGlzdF9ibF9oZWFkICpkX2hhc2godW5z
aWduZWQgaW50IGhhc2gpCitzdGF0aWMgaW50IG5lbnRyaWVzLCBuYnVja2V0cywgbWF4Y291bnQ7
CisKK3N0YXRpYyBzdHJ1Y3QgX2hsaXN0X2JsX2hlYWQgKmRlbnRyeV9oYXNodGFibGUgX19yZWFk
X21vc3RseTsKKworc3RhdGljIGlubGluZSBzdHJ1Y3QgX2hsaXN0X2JsX2hlYWQgKl9kX2hhc2go
dW5zaWduZWQgaW50IGhhc2gpCiB7CiAJcmV0dXJuIGRlbnRyeV9oYXNodGFibGUgKyAoaGFzaCA+
PiBkX2hhc2hfc2hpZnQpOwogfQogCitzdGF0aWMgaW5saW5lIHN0cnVjdCBobGlzdF9ibF9oZWFk
ICpkX2hhc2godW5zaWduZWQgaW50IGhhc2gpCit7CisJcmV0dXJuICZfZF9oYXNoKGhhc2gpLT5o
ZWFkOworfQorCiAjZGVmaW5lIElOX0xPT0tVUF9TSElGVCAxMAogc3RhdGljIHN0cnVjdCBobGlz
dF9ibF9oZWFkIGluX2xvb2t1cF9oYXNodGFibGVbMSA8PCBJTl9MT09LVVBfU0hJRlRdOwogCkBA
IC0xNzQsNyArMTg2LDcgQEAgaW50IHByb2NfbnJfZGVudHJ5KHN0cnVjdCBjdGxfdGFibGUgKnRh
YmxlLCBpbnQgd3JpdGUsIHZvaWQgX191c2VyICpidWZmZXIsCiAgKiBDb21wYXJlIDIgbmFtZSBz
dHJpbmdzLCByZXR1cm4gMCBpZiB0aGV5IG1hdGNoLCBvdGhlcndpc2Ugbm9uLXplcm8uCiAgKiBU
aGUgc3RyaW5ncyBhcmUgYm90aCBjb3VudCBieXRlcyBsb25nLCBhbmQgY291bnQgaXMgbm9uLXpl
cm8uCiAgKi8KLSNpZmRlZiBDT05GSUdfRENBQ0hFX1dPUkRfQUNDRVNTCisjaWYgMC8vZGVmIENP
TkZJR19EQ0FDSEVfV09SRF9BQ0NFU1MKIAogI2luY2x1ZGUgPGFzbS93b3JkLWF0LWEtdGltZS5o
PgogLyoKQEAgLTQ3MSwxOSArNDgzLDI4IEBAIHN0YXRpYyB2b2lkIGRlbnRyeV9scnVfYWRkKHN0
cnVjdCBkZW50cnkgKmRlbnRyeSkKIHN0YXRpYyB2b2lkIF9fX2RfZHJvcChzdHJ1Y3QgZGVudHJ5
ICpkZW50cnkpCiB7CiAJaWYgKCFkX3VuaGFzaGVkKGRlbnRyeSkpIHsKKwkJc3RydWN0IF9obGlz
dF9ibF9oZWFkICpfYjsKIAkJc3RydWN0IGhsaXN0X2JsX2hlYWQgKmI7CiAJCS8qCiAJCSAqIEhh
c2hlZCBkZW50cmllcyBhcmUgbm9ybWFsbHkgb24gdGhlIGRlbnRyeSBoYXNodGFibGUsCiAJCSAq
IHdpdGggdGhlIGV4Y2VwdGlvbiBvZiB0aG9zZSBuZXdseSBhbGxvY2F0ZWQgYnkKIAkJICogZF9v
YnRhaW5fcm9vdCwgd2hpY2ggYXJlIGFsd2F5cyBJU19ST09UOgogCQkgKi8KLQkJaWYgKHVubGlr
ZWx5KElTX1JPT1QoZGVudHJ5KSkpCisJCWlmICh1bmxpa2VseShJU19ST09UKGRlbnRyeSkpKSB7
CisJCQlfYiA9IE5VTEw7CiAJCQliID0gJmRlbnRyeS0+ZF9zYi0+c19yb290czsKLQkJZWxzZQot
CQkJYiA9IGRfaGFzaChkZW50cnktPmRfbmFtZS5oYXNoKTsKLQorCQl9IGVsc2UgeworCQkJX2Ig
PSBfZF9oYXNoKGRlbnRyeS0+ZF9uYW1lLmhhc2gpOworCQkJYiA9ICZfYi0+aGVhZDsKKwkJfQog
CQlobGlzdF9ibF9sb2NrKGIpOwogCQlfX2hsaXN0X2JsX2RlbCgmZGVudHJ5LT5kX2hhc2gpOwor
CQlpZiAoX2IpIHsKKwkJCV9iLT5jb3VudC0tOworCQkJaWYgKCFfYi0+Y291bnQpCisJCQkJbmJ1
Y2tldHMtLTsKKwkJCW5lbnRyaWVzLS07CisJCX0KIAkJaGxpc3RfYmxfdW5sb2NrKGIpOwogCQkv
KiBBZnRlciB0aGlzIGNhbGwsIGluLXByb2dyZXNzIHJjdS13YWxrIHBhdGggbG9va3VwIHdpbGwg
ZmFpbC4gKi8KIAkJd3JpdGVfc2VxY291bnRfaW52YWxpZGF0ZSgmZGVudHJ5LT5kX3NlcSk7CkBA
IC0yNDA2LDEwICsyNDI3LDIwIEBAIEVYUE9SVF9TWU1CT0woZF9kZWxldGUpOwogCiBzdGF0aWMg
dm9pZCBfX2RfcmVoYXNoKHN0cnVjdCBkZW50cnkgKmVudHJ5KQogewotCXN0cnVjdCBobGlzdF9i
bF9oZWFkICpiID0gZF9oYXNoKGVudHJ5LT5kX25hbWUuaGFzaCk7CisJc3RydWN0IF9obGlzdF9i
bF9oZWFkICpfYiA9IF9kX2hhc2goZW50cnktPmRfbmFtZS5oYXNoKTsKKwlzdHJ1Y3QgaGxpc3Rf
YmxfaGVhZCAqYiA9ICZfYi0+aGVhZDsKIAogCWhsaXN0X2JsX2xvY2soYik7CiAJaGxpc3RfYmxf
YWRkX2hlYWRfcmN1KCZlbnRyeS0+ZF9oYXNoLCBiKTsKKwlpZiAoIV9iLT5jb3VudCkKKwkJbmJ1
Y2tldHMrKzsKKwlfYi0+Y291bnQrKzsKKwluZW50cmllcysrOworCWlmIChfYi0+Y291bnQgPiBt
YXhjb3VudCkgeworCQltYXhjb3VudCA9IF9iLT5jb3VudDsKKwkJcHJfaW5mbygiZGNhY2hlOiBk
X2hhc2hfc2hpZnQgPSAlZCwgbmVudHJpZXMgPSAlZCwgbmJ1Y2tldHMgPSAlZCwgbWF4Y291bnQg
PSAlZFxuIiwKKwkJCQlkX2hhc2hfc2hpZnQsIG5lbnRyaWVzLCBuYnVja2V0cywgbWF4Y291bnQp
OworCX0KIAlobGlzdF9ibF91bmxvY2soYik7CiB9CiAKQEAgLTM2MTAsNyArMzY0MSw3IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBkY2FjaGVfaW5pdF9lYXJseSh2b2lkKQogCiAJZGVudHJ5X2hhc2h0
YWJsZSA9CiAJCWFsbG9jX2xhcmdlX3N5c3RlbV9oYXNoKCJEZW50cnkgY2FjaGUiLAotCQkJCQlz
aXplb2Yoc3RydWN0IGhsaXN0X2JsX2hlYWQpLAorCQkJCQlzaXplb2Yoc3RydWN0IF9obGlzdF9i
bF9oZWFkKSwKIAkJCQkJZGhhc2hfZW50cmllcywKIAkJCQkJMTMsCiAJCQkJCUhBU0hfRUFSTFkg
fCBIQVNIX1pFUk8sCkBAIC0zNjE4LDcgKzM2NDksNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgZGNh
Y2hlX2luaXRfZWFybHkodm9pZCkKIAkJCQkJTlVMTCwKIAkJCQkJMCwKIAkJCQkJMCk7Ci0JZF9o
YXNoX3NoaWZ0ID0gMzIgLSBkX2hhc2hfc2hpZnQ7CisJZF9oYXNoX3NoaWZ0ID0gMzIgLSAxMjsv
L2RfaGFzaF9zaGlmdDsKIH0KIAogc3RhdGljIHZvaWQgX19pbml0IGRjYWNoZV9pbml0KHZvaWQp
CkBAIC0zNjM4LDcgKzM2NjksNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgZGNhY2hlX2luaXQodm9p
ZCkKIAogCWRlbnRyeV9oYXNodGFibGUgPQogCQlhbGxvY19sYXJnZV9zeXN0ZW1faGFzaCgiRGVu
dHJ5IGNhY2hlIiwKLQkJCQkJc2l6ZW9mKHN0cnVjdCBobGlzdF9ibF9oZWFkKSwKKwkJCQkJc2l6
ZW9mKHN0cnVjdCBfaGxpc3RfYmxfaGVhZCksCiAJCQkJCWRoYXNoX2VudHJpZXMsCiAJCQkJCTEz
LAogCQkJCQlIQVNIX1pFUk8sCkBAIC0zNjQ2LDcgKzM2NzcsNyBAQCBzdGF0aWMgdm9pZCBfX2lu
aXQgZGNhY2hlX2luaXQodm9pZCkKIAkJCQkJTlVMTCwKIAkJCQkJMCwKIAkJCQkJMCk7Ci0JZF9o
YXNoX3NoaWZ0ID0gMzIgLSBkX2hhc2hfc2hpZnQ7CisJZF9oYXNoX3NoaWZ0ID0gMzIgLSAxMjsv
L2RfaGFzaF9zaGlmdDsKIH0KIAogLyogU0xBQiBjYWNoZSBmb3IgX19nZXRuYW1lKCkgY29uc3Vt
ZXJzICovCmRpZmYgLS1naXQgYS9mcy9uYW1laS5jIGIvZnMvbmFtZWkuYwppbmRleCBhZmUyYThh
ZjljZTQuLmUxMTIwMGMxMjM1MSAxMDA2NDQKLS0tIGEvZnMvbmFtZWkuYworKysgYi9mcy9uYW1l
aS5jCkBAIC0xNzk4LDcgKzE3OTgsNyBAQCBzdGF0aWMgaW50IHdhbGtfY29tcG9uZW50KHN0cnVj
dCBuYW1laWRhdGEgKm5kLCBpbnQgZmxhZ3MpCiAgKiAgIHRoZSBmaW5hbCBtYXNrIi4gQWdhaW4s
IHRoYXQgY291bGQgYmUgcmVwbGFjZWQgd2l0aCBhCiAgKiAgIGVmZmljaWVudCBwb3B1bGF0aW9u
IGNvdW50IGluc3RydWN0aW9uIG9yIHNpbWlsYXIuCiAgKi8KLSNpZmRlZiBDT05GSUdfRENBQ0hF
X1dPUkRfQUNDRVNTCisjaWYgMC8vZGVmIENPTkZJR19EQ0FDSEVfV09SRF9BQ0NFU1MKIAogI2lu
Y2x1ZGUgPGFzbS93b3JkLWF0LWEtdGltZS5oPgogCkBAIC0xOTg1LDYgKzE5ODUsOSBAQCB1bnNp
Z25lZCBsb25nIGZ1bGxfbmFtZV9sb25nX2hhc2goY29uc3Qgdm9pZCAqc2FsdCwgY29uc3QgY2hh
ciAqbmFtZSwKIH0KIEVYUE9SVF9TWU1CT0woZnVsbF9uYW1lX2xvbmdfaGFzaCk7CiAKKy8vIGRl
ZmluZSBlbmRfbmFtZV9oYXNoIHRvIE5PT1AKKy8vI2RlZmluZSBlbmRfbmFtZV9oYXNoICh1bnNp
Z25lZCBpbnQpCisKIHVuc2lnbmVkIGludCBmdWxsX25hbWVfaGFzaChjb25zdCB2b2lkICpzYWx0
LCBjb25zdCBjaGFyICpuYW1lLAogCQkJICAgIHVuc2lnbmVkIGludCBsZW4pCiB7Cg==
--f403045e5a5a87c59a0564f0e6c4--
