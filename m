Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeCFTEF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:04:05 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:33315 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbeCFTED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:04:03 -0500
X-Google-Smtp-Source: AG47ELskT4UIBy+5E1LoEJqdjz9zAlszMaNnWyCq8ZTw036qO7aeRY3eBVlQ0KFDXodjndqBS60lCtVkEQn506N+5rY=
MIME-Version: 1.0
In-Reply-To: <20180306175320.GE25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com> <CAM_iQpUfRMW4aGfaTdFqCRwuuLXFX69Aewg+k-aa6BMUKSrhTA@mail.gmail.com>
 <20180306175320.GE25017@tassilo.jf.intel.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 6 Mar 2018 11:03:42 -0800
Message-ID: <CAM_iQpVQs0YTckbo9F0zjPsSL+=ksVZvdcLO-QHTONcZc84eKg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
To: Andi Kleen <ak@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ilya Pronin <ipronin@twitter.com>
Content-Type: multipart/mixed; boundary="0000000000001df2a00566c31b33"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001df2a00566c31b33
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 6, 2018 at 9:53 AM, Andi Kleen <ak@linux.intel.com> wrote:
>> Here is the output from your own commit:
>>
>>       423470,,stalled-cycles-frontend,509102,100.00,65.69,frontend cycles idle
>>       <not supported>,,stalled-cycles-backend,0,100.00,,,,
>>
>> so line 1 has 7 fields, line 2 has 9 fields, and this is expected?
>
> If you had metrics on line 1 it would be correct.
>
> So you just shifted it to break that case.
>
> If you always want to have the same number of fields
> you need to add two empty fields to the normal output
> when there are no metrics.

The number of separators is the only way to learn the number
of fields, therefore it must be a fixed number.

Yeah, it could be the other way that supported ones have less
separators than it should. If we look at print_metric_csv() alone,
it should produce a same number of separators for all cases,
otherwise hard to count.

So I believe we need an additional patch, like the one attached,
to make it complete? Note, I only spot the cgroup field here.

--0000000000001df2a00566c31b33
Content-Type: text/plain; charset="US-ASCII"; name="perf-stat.diff"
Content-Disposition: attachment; filename="perf-stat.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jefzqynr0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMgYi90b29scy9wZXJmL2J1aWx0
aW4tc3RhdC5jCmluZGV4IDU0YTRjMTUyZWRiMy4uNjg5NmU3MzlhZTRlIDEwMDY0NAotLS0gYS90
b29scy9wZXJmL2J1aWx0aW4tc3RhdC5jCisrKyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMK
QEAgLTEwNDQsOCArMTA0NCw3IEBAIHN0YXRpYyB2b2lkIG5zZWNfcHJpbnRvdXQoaW50IGlkLCBp
bnQgbnIsIHN0cnVjdCBwZXJmX2V2c2VsICpldnNlbCwgZG91YmxlIGF2ZykKIAogCWZwcmludGYo
b3V0cHV0LCBmbXRfbiwgbmFtZSk7CiAKLQlpZiAoZXZzZWwtPmNncnApCi0JCWZwcmludGYob3V0
cHV0LCAiJXMlcyIsIGNzdl9zZXAsIGV2c2VsLT5jZ3JwLT5uYW1lKTsKKwlmcHJpbnRmKG91dHB1
dCwgIiVzJXMiLCBjc3Zfc2VwLCBldnNlbC0+Y2dycCA/IGV2c2VsLT5jZ3JwLT5uYW1lIDogIiIp
OwogfQogCiBzdGF0aWMgaW50IGZpcnN0X3NoYWRvd19jcHUoc3RydWN0IHBlcmZfZXZzZWwgKmV2
c2VsLCBpbnQgaWQpCkBAIC0xMDkyLDEyICsxMDkxLDEzIEBAIHN0YXRpYyB2b2lkIGFic19wcmlu
dG91dChpbnQgaWQsIGludCBuciwgc3RydWN0IHBlcmZfZXZzZWwgKmV2c2VsLCBkb3VibGUgYXZn
KQogCWlmIChldnNlbC0+dW5pdCkKIAkJZnByaW50ZihvdXRwdXQsICIlLSpzJXMiLAogCQkJY3N2
X291dHB1dCA/IDAgOiB1bml0X3dpZHRoLAotCQkJZXZzZWwtPnVuaXQsIGNzdl9zZXApOworCQkJ
ZXZzZWwtPnVuaXQgPyBldnNlbC0+dW5pdCA6ICIiLCBjc3Zfc2VwKTsKKwllbHNlCisJCWZwcmlu
dGYob3V0cHV0LCAiJXMiLCBjc3Zfc2VwKTsKIAogCWZwcmludGYob3V0cHV0LCAiJS0qcyIsIGNz
dl9vdXRwdXQgPyAwIDogMjUsIHBlcmZfZXZzZWxfX25hbWUoZXZzZWwpKTsKIAotCWlmIChldnNl
bC0+Y2dycCkKLQkJZnByaW50ZihvdXRwdXQsICIlcyVzIiwgY3N2X3NlcCwgZXZzZWwtPmNncnAt
Pm5hbWUpOworCWZwcmludGYob3V0cHV0LCAiJXMlcyIsIGNzdl9zZXAsIGV2c2VsLT5jZ3JwID8g
ZXZzZWwtPmNncnAtPm5hbWUgOiAiIik7CiB9CiAKIHN0YXRpYyB2b2lkIHByaW50b3V0KGludCBp
ZCwgaW50IG5yLCBzdHJ1Y3QgcGVyZl9ldnNlbCAqY291bnRlciwgZG91YmxlIHV2YWwsCkBAIC0x
MTYzLDkgKzExNjMsOCBAQCBzdGF0aWMgdm9pZCBwcmludG91dChpbnQgaWQsIGludCBuciwgc3Ry
dWN0IHBlcmZfZXZzZWwgKmNvdW50ZXIsIGRvdWJsZSB1dmFsLAogCQkJY3N2X291dHB1dCA/IDAg
OiAtMjUsCiAJCQlwZXJmX2V2c2VsX19uYW1lKGNvdW50ZXIpKTsKIAotCQlpZiAoY291bnRlci0+
Y2dycCkKLQkJCWZwcmludGYoc3RhdF9jb25maWcub3V0cHV0LCAiJXMlcyIsCi0JCQkJY3N2X3Nl
cCwgY291bnRlci0+Y2dycC0+bmFtZSk7CisJCWZwcmludGYoc3RhdF9jb25maWcub3V0cHV0LCAi
JXMlcyIsIGNzdl9zZXAsCisJCQljb3VudGVyLT5jZ3JwID8gY291bnRlci0+Y2dycC0+bmFtZSA6
ICIiKTsKIAogCQlpZiAoIWNzdl9vdXRwdXQpCiAJCQlwbSgmb3MsIE5VTEwsIE5VTEwsICIiLCAw
KTsK
--0000000000001df2a00566c31b33--
