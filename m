Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeBBTKa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:10:30 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:33619 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeBBTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:10:20 -0500
X-Google-Smtp-Source: AH8x225IoNEEqR9VRDuFo7Hj1J1v5FE5OMLXtnr4CBDY80J98q4eKBCdDdXLz0Y2V0OX1a0cGfxqMiAVlO01ZIMDm9g=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwg88mxuOiJSh+xLnAfqEwAC-ReB9rdNx+r8fy=FTSHJw@mail.gmail.com>
References: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk> <CA+55aFwg88mxuOiJSh+xLnAfqEwAC-ReB9rdNx+r8fy=FTSHJw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2018 11:10:19 -0800
X-Google-Sender-Auth: 6SK_2tR_S35z2EFi0xn5IwfesRs
Message-ID: <CA+55aFwqCc1UOkdBjEgiuL9fMkRj7RPrGFYQ376YhrqTUpLwrg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Reduce retpoline performance impact in slot_handle_level_range()
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Ahmed <karahmed@amazon.de>, sironi@amazon.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: multipart/mixed; boundary="001a1143ce48a9509a05643f7663"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a1143ce48a9509a05643f7663
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 2, 2018 at 10:50 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Will it make for bigger code? Yes. But probably not really all *that*
> much bigger, because of how it also will allow the compiler to
> simplify some things.

Actually, testing this with my fairly minimal config, it actually
makes for *smaller* code to inline those things.

That may be a quirk of my configuration, or maybe I screwed something
else up, but:

  [torvalds@i7 linux]$ size ~/mmu.o arch/x86/kvm/mmu.o
     text    data     bss     dec     hex filename
    85587    9310     120   95017   17329 /home/torvalds/mmu.o
    85531    9310     120   94961   172f1 arch/x86/kvm/mmu.o

so the attached patch actually shrank things down by about 50 bytes
because of the code simplification.

Of course, I have been known to screw up retpoline testing in the
past, so my numbers are suspect ;). Somebody should double-check me.

                    Linus

--001a1143ce48a9509a05643f7663
Content-Type: text/plain; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jd6b0z5x0

IGFyY2gveDg2L2t2bS9tbXUuYyB8IDEwICsrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21t
dS5jIGIvYXJjaC94ODYva3ZtL21tdS5jCmluZGV4IDJiOGViNGRhNGQwOC4uYjlmMGRlNmUzMDli
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vbW11LmMKKysrIGIvYXJjaC94ODYva3ZtL21tdS5j
CkBAIC01MDU4LDcgKzUwNTgsNyBAQCB2b2lkIGt2bV9tbXVfdW5pbml0X3ZtKHN0cnVjdCBrdm0g
Kmt2bSkKIHR5cGVkZWYgYm9vbCAoKnNsb3RfbGV2ZWxfaGFuZGxlcikgKHN0cnVjdCBrdm0gKmt2
bSwgc3RydWN0IGt2bV9ybWFwX2hlYWQgKnJtYXBfaGVhZCk7CiAKIC8qIFRoZSBjYWxsZXIgc2hv
dWxkIGhvbGQgbW11LWxvY2sgYmVmb3JlIGNhbGxpbmcgdGhpcyBmdW5jdGlvbi4gKi8KLXN0YXRp
YyBib29sCitzdGF0aWMgYm9vbCBfX2Fsd2F5c19pbmxpbmUKIHNsb3RfaGFuZGxlX2xldmVsX3Jh
bmdlKHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9tZW1vcnlfc2xvdCAqbWVtc2xvdCwKIAkJ
CXNsb3RfbGV2ZWxfaGFuZGxlciBmbiwgaW50IHN0YXJ0X2xldmVsLCBpbnQgZW5kX2xldmVsLAog
CQkJZ2ZuX3Qgc3RhcnRfZ2ZuLCBnZm5fdCBlbmRfZ2ZuLCBib29sIGxvY2tfZmx1c2hfdGxiKQpA
QCAtNTA4OCw3ICs1MDg4LDcgQEAgc2xvdF9oYW5kbGVfbGV2ZWxfcmFuZ2Uoc3RydWN0IGt2bSAq
a3ZtLCBzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICptZW1zbG90LAogCXJldHVybiBmbHVzaDsKIH0K
IAotc3RhdGljIGJvb2wKK3N0YXRpYyBib29sIF9fYWx3YXlzX2lubGluZQogc2xvdF9oYW5kbGVf
bGV2ZWwoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICptZW1zbG90LAog
CQkgIHNsb3RfbGV2ZWxfaGFuZGxlciBmbiwgaW50IHN0YXJ0X2xldmVsLCBpbnQgZW5kX2xldmVs
LAogCQkgIGJvb2wgbG9ja19mbHVzaF90bGIpCkBAIC01MDk5LDcgKzUwOTksNyBAQCBzbG90X2hh
bmRsZV9sZXZlbChzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKm1lbXNs
b3QsCiAJCQlsb2NrX2ZsdXNoX3RsYik7CiB9CiAKLXN0YXRpYyBib29sCitzdGF0aWMgYm9vbCBf
X2Fsd2F5c19pbmxpbmUKIHNsb3RfaGFuZGxlX2FsbF9sZXZlbChzdHJ1Y3Qga3ZtICprdm0sIHN0
cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKm1lbXNsb3QsCiAJCSAgICAgIHNsb3RfbGV2ZWxfaGFuZGxl
ciBmbiwgYm9vbCBsb2NrX2ZsdXNoX3RsYikKIHsKQEAgLTUxMDcsNyArNTEwNyw3IEBAIHNsb3Rf
aGFuZGxlX2FsbF9sZXZlbChzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3Qg
Km1lbXNsb3QsCiAJCQkJIFBUX01BWF9IVUdFUEFHRV9MRVZFTCwgbG9ja19mbHVzaF90bGIpOwog
fQogCi1zdGF0aWMgYm9vbAorc3RhdGljIGJvb2wgX19hbHdheXNfaW5saW5lCiBzbG90X2hhbmRs
ZV9sYXJnZV9sZXZlbChzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKm1l
bXNsb3QsCiAJCQlzbG90X2xldmVsX2hhbmRsZXIgZm4sIGJvb2wgbG9ja19mbHVzaF90bGIpCiB7
CkBAIC01MTE1LDcgKzUxMTUsNyBAQCBzbG90X2hhbmRsZV9sYXJnZV9sZXZlbChzdHJ1Y3Qga3Zt
ICprdm0sIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKm1lbXNsb3QsCiAJCQkJIFBUX01BWF9IVUdF
UEFHRV9MRVZFTCwgbG9ja19mbHVzaF90bGIpOwogfQogCi1zdGF0aWMgYm9vbAorc3RhdGljIGJv
b2wgX19hbHdheXNfaW5saW5lCiBzbG90X2hhbmRsZV9sZWFmKHN0cnVjdCBrdm0gKmt2bSwgc3Ry
dWN0IGt2bV9tZW1vcnlfc2xvdCAqbWVtc2xvdCwKIAkJIHNsb3RfbGV2ZWxfaGFuZGxlciBmbiwg
Ym9vbCBsb2NrX2ZsdXNoX3RsYikKIHsK
--001a1143ce48a9509a05643f7663--
