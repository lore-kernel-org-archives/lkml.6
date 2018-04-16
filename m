Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeDPPNT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:13:19 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:44938 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:13:17 -0400
X-Google-Smtp-Source: AIpwx4+QjzL2sEvJOzureoHvew2t690kofuTRocMNNQxTE34Xn37FeeRQpr0g2DHaDkxs3nZvpR75QfhWxph6w7jIAc=
MIME-Version: 1.0
In-Reply-To: <20180416134309.lt7mrxe5khcuhozl@redbean>
References: <7e17e3b1-25c3-cb61-ae94-dcbb1bf3473e@linux.ibm.com>
 <3836add7-8691-77c1-33d2-0fbee7051795@de.ibm.com> <2dc648ad-0a6b-ba79-5d6a-fb3e3029994f@de.ibm.com>
 <20180416134309.lt7mrxe5khcuhozl@redbean>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 08:13:16 -0700
X-Google-Sender-Auth: 9WJ4akl4UYvDbIXhmC3VRNKRCgY
Message-ID: <CA+55aFzDHR47yZXvpOGx22bjWBGExTi=5jWnYb5C+FijJdgOOA@mail.gmail.com>
Subject: Re: Wrong module .text address in 4.16.0
To: Jessica Yu <jeyu@kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Tobin C . Harding" <me@tobin.cc>, Kees Cook <keescook@chromium.org>
Content-Type: multipart/mixed; boundary="001a1141bc444cfc970569f8a9d6"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a1141bc444cfc970569f8a9d6
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 16, 2018 at 6:43 AM, Jessica Yu <jeyu@kernel.org> wrote:
>
> So for users of /sys/module/*/sections, we will need to work around
> this and possibly use %px for the real address. But perhaps we should
> base the usage of %px on kptr_restrict?

Maybe. I was hoping we would be able to get rid of it eventually.

The real problem is that those darn module_attribute things don't have
proper IO routines. They *only* have the show routine, and that
doesn't even get the 'struct file' pointer passed to it, just the
buffer to fill in (not even a _size_ of a buffer - we're talking the
bad bad old days of nasty /proc interfaces).

Why is that a problem? Without a 'struct file' we can't even do
permission checking right. %pK worked by doing disgusting wrong
things.

Now, in this case, at least the files are root-owned, and legible only
to root, so I guess we can say that permissions have been properly
checked at open time (not really true: the CAP_SYSLOG bit wasn't!, but
I doubt anybody really cares), and so we could just check
kptr_restrict.

Oh well.

Something like the attached, perhaps? Completely untested, and I don't
even want credit for this if it is used.

              Linus

--001a1141bc444cfc970569f8a9d6
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg2dol3o0

IGtlcm5lbC9tb2R1bGUuYyB8IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS5jIGIva2VybmVs
L21vZHVsZS5jCmluZGV4IGE2ZTQzYTU4MDZhMS4uZjhjZjBiYjM1YWI2IDEwMDY0NAotLS0gYS9r
ZXJuZWwvbW9kdWxlLmMKKysrIGIva2VybmVsL21vZHVsZS5jCkBAIC0xNDcyLDcgKzE0NzIsMTEg
QEAgc3RhdGljIHNzaXplX3QgbW9kdWxlX3NlY3Rfc2hvdyhzdHJ1Y3QgbW9kdWxlX2F0dHJpYnV0
ZSAqbWF0dHIsCiB7CiAJc3RydWN0IG1vZHVsZV9zZWN0X2F0dHIgKnNhdHRyID0KIAkJY29udGFp
bmVyX29mKG1hdHRyLCBzdHJ1Y3QgbW9kdWxlX3NlY3RfYXR0ciwgbWF0dHIpOwotCXJldHVybiBz
cHJpbnRmKGJ1ZiwgIjB4JXBLXG4iLCAodm9pZCAqKXNhdHRyLT5hZGRyZXNzKTsKKwl1bnNpZ25l
ZCBsb25nIGFkZHIgPSAwOworCisJLyogUGVybWlzc2lvbnMgd2VyZSBjaGVja2VkIGF0IG9wZW4g
Ki8KKwlhZGRyID0ga3B0cl9yZXN0cmljdCA8IDIgP3NhdHRyLT5hZGRyZXNzIDogMDsKKwlyZXR1
cm4gc3ByaW50ZihidWYsICIlI2x4XG4iLCBhZGRyKTsKIH0KIAogc3RhdGljIHZvaWQgZnJlZV9z
ZWN0X2F0dHJzKHN0cnVjdCBtb2R1bGVfc2VjdF9hdHRycyAqc2VjdF9hdHRycykK
--001a1141bc444cfc970569f8a9d6--
