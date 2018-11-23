Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E4620C01
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BIWL6o70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E4620C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440988AbeKXE2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:28:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36741 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbeKXE2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:28:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so9221051lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRLaDoqDQyDzybsiVG52hhNs3y8bOzLOSLe2iT/iqao=;
        b=BIWL6o70yxUhnN8RqTGNNy2LI1uo3Qq3WOowxayOXyG/BC7Pv3Om1q04TSNZHXwrRa
         aQ6sq4Qiow8mnfjQGjdTASx/ZuQo48SAUnt9zUrXAbuGFmU8u40WEURBlDRC7mzCYgZF
         pRf/FlVhArGoSo1VQ8ac9Uszf+SJp5KeNhbV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRLaDoqDQyDzybsiVG52hhNs3y8bOzLOSLe2iT/iqao=;
        b=P3HXnwKAzYWsDiuIdg14PJwIRLtlegSJUSHSA4roXwjhyA/aBLC3suWqNbrDheTgNC
         QwgQILFfAJ+dBWu/sO+J01/1v9bHz8TNEfs7xPnXHVR96huzcjrl3I/7NTTfUiHbNm8w
         bw6I3QUky2SXRdf9OttAqz35Qe4SxRfAQ4YijvweP07RkB5ehYUPfHPWTViJs8tODDd9
         3qOO6tusvpYKTArK2Q+LMkW9qCP1OGclFj81YfJma9TDku9U8MxLuyPpuRjmJwjA22EW
         moPyJhI0pZCD3Zy6gVMD17dX9vNAaba1OMVXPmk3mFmwmPh9YNOw/xI6KHQI1uLDgWg/
         1NAQ==
X-Gm-Message-State: AGRZ1gJkoGX0x8e6rAo23EYayBmH22pMo+UXha1ww33Ake67MbZiZpBC
        PXZuGOZMk2HBZu8B0V0KEPDb7dDjV8Ge+w==
X-Google-Smtp-Source: AJdET5cQyGzjg5abcEZ4DArXBnY3Tsn7vUnc7fhhI+vNNZNQ1J5QO6lRRbEzsqLF/4NF7T3xaRAwqw==
X-Received: by 2002:a19:5510:: with SMTP id n16mr9678380lfe.68.1542994980647;
        Fri, 23 Nov 2018 09:43:00 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b25-v6sm7829635lji.94.2018.11.23.09.42.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 09:42:57 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id c19-v6so11303099lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:42:57 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr11794449ljk.80.1542994976708;
 Fri, 23 Nov 2018 09:42:56 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com>
 <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
 <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
 <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com>
 <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Nov 2018 09:42:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrdrZW5VgnKXqdayafYmQC2HBEA4kzMWYTyaj5jgURdA@mail.gmail.com>
Message-ID: <CAHk-=wjrdrZW5VgnKXqdayafYmQC2HBEA4kzMWYTyaj5jgURdA@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     David.Laight@aculab.com
Cc:     Andrew Lutomirski <luto@kernel.org>, dvlasenk@redhat.com,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        pabeni@redhat.com
Content-Type: multipart/mixed; boundary="0000000000007a8721057b5883b2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007a8721057b5883b2
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 23, 2018 at 8:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me write a generic routine in lib/iomap_copy.c (which already does
> the "user specifies chunk size" cases), and hook it up for x86.

Something like this?

ENTIRELY UNTESTED! It might not compile. Seriously. And if it does
compile, it might not work.

And this doesn't actually do the memset_io() function at all, just the
memcpy ones.

Finally, it's worth noting that on x86, we have this:

  /*
   * override generic version in lib/iomap_copy.c
   */
  ENTRY(__iowrite32_copy)
          movl %edx,%ecx
          rep movsd
          ret
  ENDPROC(__iowrite32_copy)

because back in 2006, we did this:

    [PATCH] Add faster __iowrite32_copy routine for x86_64

    This assembly version is measurably faster than the generic version in
    lib/iomap_copy.c.

which actually implies that "rep movsd" is faster than doing
__raw_writel() by hand.

So it is possible that this should all be arch-specific code rather
than that butt-ugly "generic" code I wrote in this patch.

End result: I'm not really all that  happy about this patch, but it's
perhaps worth testing, and it's definitely worth discussing. Because
our current memcpy_{to,from}io() is truly broken garbage.

                   Linus

--0000000000007a8721057b5883b2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_joubcpp90>
X-Attachment-Id: f_joubcpp90

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2lvLmggfCAgIDYgKysKIGluY2x1ZGUvbGludXgvaW8uaCAg
ICAgICAgfCAgIDIgKwogbGliL2lvbWFwX2NvcHkuYyAgICAgICAgICB8IDE1MyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDE2
MSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vaW8uaCBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2lvLmgKaW5kZXggODMyZGE4MjI5Y2M3Li4zYjkyMDZlZTI1
YjggMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lvLmgKKysrIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20vaW8uaApAQCAtOTIsNiArOTIsMTIgQEAgYnVpbGRfbW1pb193cml0ZShfX3dy
aXRlbCwgImwiLCB1bnNpZ25lZCBpbnQsICJyIiwgKQogCiAjZGVmaW5lIG1taW93YigpIGJhcnJp
ZXIoKQogCit2b2lkIF9faW93cml0ZV9jb3B5KHZvaWQgX19pb21lbSAqdG8sIGNvbnN0IHZvaWQg
KmZyb20sIHNpemVfdCBjb3VudCk7Cit2b2lkIF9faW9yZWFkX2NvcHkodm9pZCAqdG8sIGNvbnN0
IHZvaWQgX19pb21lbSAqZnJvbSwgc2l6ZV90IGNvdW50KTsKKworI2RlZmluZSBtZW1jcHlfdG9p
byBfX2lvd3JpdGVfY29weQorI2RlZmluZSBtZW1jcHlfZnJvbWlvIF9faW9yZWFkX2NvcHkKKwog
I2lmZGVmIENPTkZJR19YODZfNjQKIAogYnVpbGRfbW1pb19yZWFkKHJlYWRxLCAicSIsIHU2NCwg
Ij1yIiwgOiJtZW1vcnkiKQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pby5oIGIvaW5jbHVk
ZS9saW51eC9pby5oCmluZGV4IDMyZTMwZThmYjlkYi4uNjQyZjc4OTcwMDE4IDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L2lvLmgKKysrIGIvaW5jbHVkZS9saW51eC9pby5oCkBAIC0yOCw2ICsy
OCw4IEBACiBzdHJ1Y3QgZGV2aWNlOwogc3RydWN0IHJlc291cmNlOwogCit2b2lkIF9faW9yZWFk
X2NvcHkodm9pZCAqdG8sIGNvbnN0IHZvaWQgX19pb21lbSAqZnJvbSwgc2l6ZV90IGNvdW50KTsK
K3ZvaWQgX19pb3dyaXRlX2NvcHkodm9pZCBfX2lvbWVtICp0bywgY29uc3Qgdm9pZCAqZnJvbSwg
c2l6ZV90IGNvdW50KTsKIF9fdmlzaWJsZSB2b2lkIF9faW93cml0ZTMyX2NvcHkodm9pZCBfX2lv
bWVtICp0bywgY29uc3Qgdm9pZCAqZnJvbSwgc2l6ZV90IGNvdW50KTsKIHZvaWQgX19pb3JlYWQz
Ml9jb3B5KHZvaWQgKnRvLCBjb25zdCB2b2lkIF9faW9tZW0gKmZyb20sIHNpemVfdCBjb3VudCk7
CiB2b2lkIF9faW93cml0ZTY0X2NvcHkodm9pZCBfX2lvbWVtICp0bywgY29uc3Qgdm9pZCAqZnJv
bSwgc2l6ZV90IGNvdW50KTsKZGlmZiAtLWdpdCBhL2xpYi9pb21hcF9jb3B5LmMgYi9saWIvaW9t
YXBfY29weS5jCmluZGV4IGI4ZjFkNmNiYjIwMC4uOGVkYzM1OWRkYTYyIDEwMDY0NAotLS0gYS9s
aWIvaW9tYXBfY29weS5jCisrKyBiL2xpYi9pb21hcF9jb3B5LmMKQEAgLTE3LDYgKzE3LDE1OSBA
QAogCiAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+CiAjaW5jbHVkZSA8bGludXgvaW8uaD4KKyNp
bmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+CisKK3N0YXRpYyBpbmxpbmUgYm9vbCBpb21lbV9hbGln
bihjb25zdCB2b2lkIF9faW9tZW0gKnB0ciwgaW50IHNpemUsIGludCBjb3VudCkKK3sKKwlyZXR1
cm4gY291bnQgPj0gc2l6ZSAmJiAoX19mb3JjZSB1bnNpZ25lZCBsb25nKXB0ciAmIHNpemU7Cit9
CisKKworLyoqCisgKiBfX2lvd3JpdGVfY29weSAtIGNvcHkgZGF0YSB0byBNTUlPIHNwYWNlCisg
KiBAdG86IGRlc3RpbmF0aW9uLCBpbiBNTUlPIHNwYWNlCisgKiBAZnJvbTogc291cmNlCisgKiBA
Y291bnQ6IG51bWJlciBvZiBieXRlcyB0byBjb3B5LgorICoKKyAqIENvcHkgYXJiaXRyYXJpbHkg
YWxpZ25lZCBkYXRhIGZyb20ga2VybmVsIHNwYWNlIHRvIE1NSU8gc3BhY2UsCisgKiB1c2luZyBy
ZWFzb25hYmxlIGNodW5raW5nLgorICovCit2b2lkIF9fYXR0cmlidXRlX18oKHdlYWspKSBfX2lv
d3JpdGVfY29weSh2b2lkIF9faW9tZW0gKnRvLAorCQkJCQkgIGNvbnN0IHZvaWQgKmZyb20sCisJ
CQkJCSAgc2l6ZV90IGNvdW50KQoreworCWlmIChpb21lbV9hbGlnbih0bywgMSwgY291bnQpKSB7
CisJCXVuc2lnbmVkIGNoYXIgZGF0YSA9ICoodW5zaWduZWQgY2hhciAqKWZyb207CisJCV9fcmF3
X3dyaXRlYihkYXRhLCB0byk7CisJCWZyb20rKzsKKwkJdG8rKzsKKwkJY291bnQtLTsKKwl9CisJ
aWYgKGlvbWVtX2FsaWduKHRvLCAyLCBjb3VudCkpIHsKKwkJdW5zaWduZWQgc2hvcnQgZGF0YSA9
IGdldF91bmFsaWduZWQoKHVuc2lnbmVkIHNob3J0ICopZnJvbSk7CisJCV9fcmF3X3dyaXRldyhk
YXRhLCB0byk7CisJCWZyb20gKz0gMjsKKwkJdG8gKz0gMjsKKwkJY291bnQgLT0gMjsKKwl9Cisj
aWZkZWYgQ09ORklHXzY0QklUCisJaWYgKGlvbWVtX2FsaWduKHRvLCA0LCBjb3VudCkpIHsKKwkJ
dW5zaWduZWQgaW50IGRhdGEgPSBnZXRfdW5hbGlnbmVkKCh1bnNpZ25lZCBpbnQgKilmcm9tKTsK
KwkJX19yYXdfd3JpdGVsKGRhdGEsIHRvKTsKKwkJZnJvbSArPSA0OworCQl0byArPSA0OworCQlj
b3VudCAtPSA0OworCX0KKyNlbmRpZgorCXdoaWxlIChjb3VudCA+PSBzaXplb2YodW5zaWduZWQg
bG9uZykpIHsKKwkJdW5zaWduZWQgbG9uZyBkYXRhID0gZ2V0X3VuYWxpZ25lZCgodW5zaWduZWQg
bG9uZyAqKWZyb20pOworI2lmZGVmIENPTkZJR182NEJJVAorCQlfX3Jhd193cml0ZXEoZGF0YSwg
dG8pOworI2Vsc2UKKwkJX19yYXdfd3JpdGVsKGRhdGEsIHRvKTsKKyNlbmRpZgorCQlmcm9tICs9
IHNpemVvZih1bnNpZ25lZCBsb25nKTsKKwkJdG8gKz0gc2l6ZW9mKHVuc2lnbmVkIGxvbmcpOwor
CQljb3VudCAtPSBzaXplb2YodW5zaWduZWQgbG9uZyk7CisJfQorCisjaWZkZWYgQ09ORklHXzY0
QklUCisJaWYgKGNvdW50ID49IDQpIHsKKwkJdW5zaWduZWQgaW50IGRhdGEgPSBnZXRfdW5hbGln
bmVkKCh1bnNpZ25lZCBpbnQgKilmcm9tKTsKKwkJX19yYXdfd3JpdGVsKGRhdGEsIHRvKTsKKwkJ
ZnJvbSArPSA0OworCQl0byArPSA0OworCQljb3VudCAtPSA0OworCX0KKyNlbmRpZgorCisJaWYg
KGNvdW50ID49IDIpIHsKKwkJdW5zaWduZWQgc2hvcnQgZGF0YSA9IGdldF91bmFsaWduZWQoKHVu
c2lnbmVkIHNob3J0ICopZnJvbSk7CisJCV9fcmF3X3dyaXRldyhkYXRhLCB0byk7CisJCWZyb20g
Kz0gMjsKKwkJdG8gKz0gMjsKKwkJY291bnQgLT0gMjsKKwl9CisKKwlpZiAoY291bnQpIHsKKwkJ
dW5zaWduZWQgY2hhciBkYXRhID0gKih1bnNpZ25lZCBjaGFyICopZnJvbTsKKwkJX19yYXdfd3Jp
dGViKGRhdGEsIHRvKTsKKwl9Cit9CitFWFBPUlRfU1lNQk9MX0dQTChfX2lvd3JpdGVfY29weSk7
CisKKy8qKgorICogX19pb3JlYWRfY29weSAtIGNvcHkgZGF0YSBmcm9tIE1NSU8gc3BhY2UKKyAq
IEB0bzogZGVzdGluYXRpb24KKyAqIEBmcm9tOiBzb3VyY2UsIGluIE1NSU8gc3BhY2UKKyAqIEBj
b3VudDogbnVtYmVyIG9mIGJ5dGVzIHRvIGNvcHkuCisgKgorICogQ29weSBhcmJpdHJhcmlseSBh
bGlnbmVkIGRhdGEgZnJvbSBNTUlPIHNwYWNlIHRvIGtlcm5lbCBzcGFjZSwKKyAqIHVzaW5nIHJl
YXNvbmFibGUgY2h1bmtpbmcuCisgKi8KK3ZvaWQgX19hdHRyaWJ1dGVfXygod2VhaykpIF9faW9y
ZWFkX2NvcHkodm9pZCAqdG8sCisJCQkJCSBjb25zdCB2b2lkIF9faW9tZW0gKmZyb20sCisJCQkJ
CSBzaXplX3QgY291bnQpCit7CisJaWYgKGlvbWVtX2FsaWduKGZyb20sIDEsIGNvdW50KSkgewor
CQl1bnNpZ25lZCBjaGFyIGRhdGEgPSBfX3Jhd19yZWFkYihmcm9tKTsKKwkJcHV0X3VuYWxpZ25l
ZChkYXRhLCAodW5zaWduZWQgY2hhciAqKSB0byk7CisJCWZyb20rKzsKKwkJdG8rKzsKKwkJY291
bnQtLTsKKwl9CisJaWYgKGlvbWVtX2FsaWduKHRvLCAyLCBjb3VudCkpIHsKKwkJdW5zaWduZWQg
c2hvcnQgZGF0YSA9IF9fcmF3X3JlYWR3KGZyb20pOworCQlwdXRfdW5hbGlnbmVkKGRhdGEsICh1
bnNpZ25lZCBzaG9ydCAqKSB0byk7CisJCWZyb20gKz0gMjsKKwkJdG8gKz0gMjsKKwkJY291bnQg
LT0gMjsKKwl9CisjaWZkZWYgQ09ORklHXzY0QklUCisJaWYgKGlvbWVtX2FsaWduKHRvLCA0LCBj
b3VudCkpIHsKKwkJdW5zaWduZWQgaW50IGRhdGEgPSBfX3Jhd19yZWFkbChmcm9tKTsKKwkJcHV0
X3VuYWxpZ25lZChkYXRhLCAodW5zaWduZWQgaW50ICopIHRvKTsKKwkJZnJvbSArPSA0OworCQl0
byArPSA0OworCQljb3VudCAtPSA0OworCX0KKyNlbmRpZgorCXdoaWxlIChjb3VudCA+PSBzaXpl
b2YodW5zaWduZWQgbG9uZykpIHsKKyNpZmRlZiBDT05GSUdfNjRCSVQKKwkJdW5zaWduZWQgbG9u
ZyBkYXRhID0gX19yYXdfcmVhZHEoZnJvbSk7CisjZWxzZQorCQl1bnNpZ25lZCBsb25nIGRhdGEg
PSBfX3Jhd19yZWFkbChmcm9tKTsKKyNlbmRpZgorCQlwdXRfdW5hbGlnbmVkKGRhdGEsICh1bnNp
Z25lZCBsb25nICopIHRvKTsKKwkJZnJvbSArPSBzaXplb2YodW5zaWduZWQgbG9uZyk7CisJCXRv
ICs9IHNpemVvZih1bnNpZ25lZCBsb25nKTsKKwkJY291bnQgLT0gc2l6ZW9mKHVuc2lnbmVkIGxv
bmcpOworCX0KKworI2lmZGVmIENPTkZJR182NEJJVAorCWlmIChjb3VudCA+PSA0KSB7CisJCXVu
c2lnbmVkIGludCBkYXRhID0gX19yYXdfcmVhZGwoZnJvbSk7CisJCXB1dF91bmFsaWduZWQoZGF0
YSwgKHVuc2lnbmVkIGludCAqKSB0byk7CisJCWZyb20gKz0gNDsKKwkJdG8gKz0gNDsKKwkJY291
bnQgLT0gNDsKKwl9CisjZW5kaWYKKworCWlmIChjb3VudCA+PSAyKSB7CisJCXVuc2lnbmVkIHNo
b3J0IGRhdGEgPSBfX3Jhd19yZWFkdyhmcm9tKTsKKwkJcHV0X3VuYWxpZ25lZChkYXRhLCAodW5z
aWduZWQgc2hvcnQgKikgdG8pOworCQlmcm9tICs9IDI7CisJCXRvICs9IDI7CisJCWNvdW50IC09
IDI7CisJfQorCisJaWYgKGNvdW50KSB7CisJCXVuc2lnbmVkIGNoYXIgZGF0YSA9IF9fcmF3X3Jl
YWRiKGZyb20pOworCQlwdXRfdW5hbGlnbmVkKGRhdGEsICh1bnNpZ25lZCBjaGFyICopIHRvKTsK
Kwl9Cit9CitFWFBPUlRfU1lNQk9MX0dQTChfX2lvcmVhZF9jb3B5KTsKIAogLyoqCiAgKiBfX2lv
d3JpdGUzMl9jb3B5IC0gY29weSBkYXRhIHRvIE1NSU8gc3BhY2UsIGluIDMyLWJpdCB1bml0cwo=
--0000000000007a8721057b5883b2--
