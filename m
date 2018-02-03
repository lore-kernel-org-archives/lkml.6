Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517618657; cv=none;
        d=google.com; s=arc-20160816;
        b=WRXDMv3S0tjnifH71kANR8hcmentGy+4AwMTdP/JhSNcdKBtZlCdMSj1k3hIwEiOKG
         qBcxPCI//cX8sid0UtQqd/2I1orQ8WGNES/ljEbGUwjJJsTJBX1tFkc6t5+/Df+2viyT
         3yMj7T0W0hZrm7Pbb/BBPTMfLG4hJPcp7DedibWH39DvARb+HgM7CvwU2oVXwBzu6m4x
         tjkjolAViLQUZXRBJg+OK0EpD4A6AH5NqEV/fQelo2EbNTj9NzWuPSoGTuHZ7OtkxUha
         MOXax7qY29HGsqgkFFQSwFD2BDY0wp+8SW4gNzhKmdTTAXrGCZ1QhxszKy/298KIrjPf
         tUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=jEAoCuCN3uzhyDSReuz547fvyd4YmSqrz/LEYwx7aFQ=;
        b=YYGepV7hS+SPZXn1ofq6f+XcQ/dEPu1JWpl21oMTcgckYRE2dol6DPJEnBhlt1hJRK
         9IoWlRc0B5G0zLmFJ+q8EwIXNu0mHKEyGDeLiC9by/fye4YNi4AsRab9cdyDb8QTLa6m
         /Yf96YiWV7HNojM5zoj6R71m3hud7KAoQklDN0KbmDr8uVdlZraueLkSdTSDIJF5do7O
         bSGQiYNJgdUVPczXYWKi8sn1jEpBO+rHFEaQTW2FW34w6yoYp9O8imowXRVSPduZhFSi
         25ai5Jr0OGcX2obD/V9sME3dMFzdj0Vw19hl8OicdiFBOIrT6iFt+7kgU4Ytp+FPEpuG
         Yqyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b24wY1gX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b24wY1gX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224KfKChaX1dr1C+ibdBOL4MbM6oABI4YbNmVFFq/iSsPxUyn34JwyrN1KK2PLuFwZacnT6rf1/UQxRZkta0W0k=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2018 16:44:14 -0800
X-Google-Sender-Auth: WMvMcVsc4D6w-jt2hjse6OW-U1E
Message-ID: <CA+55aFztiKehjo7OQQFboAEfe_BrxJQG_5wxak2a_GdNBEFiMw@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
To: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
Content-Type: multipart/mixed; boundary="94eb2c1fd3acef0154056444200f"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591338500863694793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1fd3acef0154056444200f
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 2, 2018 at 2:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> so I would really prefer to speed up recompiles and just generally try
> to avoid horrible header file inclusion by doing the same thing in
> <linux/device.h>, adding just that
>
>     struct dev_pin_info;
>
> declaration, and removing the <linux/pinctrl/devinfo.h> include.

It turns out that some pinctl users seem to depend on this broken
situation., with at least

  drivers/pinctrl/core.c
  drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
  drivers/pinctrl/pinctrl-ocelot.c
  drivers/pinctrl/bcm/pinctrl-iproc-gpio.c

expecting to magically get some of the pinctrl function declarations
not through some pinctrl header file, but just from <linux/device.h>.

Adding that include to <linux/pinctrl/pinctrl.h> would seem to make
those happy and make 'allmodconfig' build for me.

But I'm only testing x86-64. Can somebody test at least arm too?

Stupid patch attached. I don't know how much this helps the insane
dependency hell for <linux/pinctrl/devinfo.h>, but it's bound to help
_some_.

Comments?

             Linus

--94eb2c1fd3acef0154056444200f
Content-Type: text/plain; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jd6msgxc0

IGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgICAgfCAyICstCiBpbmNsdWRlL2xpbnV4L3Bp
bmN0cmwvcGluY3RybC5oIHwgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZGV2aWNlLmggYi9pbmNs
dWRlL2xpbnV4L2RldmljZS5oCmluZGV4IGY2NDlmYzBjMjU3MS4uYjA5MzQwNWVkNTI1IDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L2RldmljZS5oCisrKyBiL2luY2x1ZGUvbGludXgvZGV2aWNl
LmgKQEAgLTIwLDcgKzIwLDYgQEAKICNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPgogI2luY2x1
ZGUgPGxpbnV4L3R5cGVzLmg+CiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4KLSNpbmNsdWRlIDxs
aW51eC9waW5jdHJsL2RldmluZm8uaD4KICNpbmNsdWRlIDxsaW51eC9wbS5oPgogI2luY2x1ZGUg
PGxpbnV4L2F0b21pYy5oPgogI2luY2x1ZGUgPGxpbnV4L3JhdGVsaW1pdC5oPgpAQCAtNDEsNiAr
NDAsNyBAQCBzdHJ1Y3QgZndub2RlX2hhbmRsZTsKIHN0cnVjdCBpb21tdV9vcHM7CiBzdHJ1Y3Qg
aW9tbXVfZ3JvdXA7CiBzdHJ1Y3QgaW9tbXVfZndzcGVjOworc3RydWN0IGRldl9waW5faW5mbzsK
IAogc3RydWN0IGJ1c19hdHRyaWJ1dGUgewogCXN0cnVjdCBhdHRyaWJ1dGUJYXR0cjsKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvcGluY3RybC9waW5jdHJsLmggYi9pbmNsdWRlL2xpbnV4L3Bp
bmN0cmwvcGluY3RybC5oCmluZGV4IDVlNDUzODVjNWJkYy4uOGY1ZGJiODQ1NDdhIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L3BpbmN0cmwvcGluY3RybC5oCisrKyBiL2luY2x1ZGUvbGludXgv
cGluY3RybC9waW5jdHJsLmgKQEAgLTE4LDYgKzE4LDcgQEAKICNpbmNsdWRlIDxsaW51eC9saXN0
Lmg+CiAjaW5jbHVkZSA8bGludXgvc2VxX2ZpbGUuaD4KICNpbmNsdWRlIDxsaW51eC9waW5jdHJs
L3BpbmN0cmwtc3RhdGUuaD4KKyNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2RldmluZm8uaD4KIAog
c3RydWN0IGRldmljZTsKIHN0cnVjdCBwaW5jdHJsX2RldjsK
--94eb2c1fd3acef0154056444200f--
