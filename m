Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23E9206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5FaZP5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23E9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439240AbeKWLvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 06:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392716AbeKWLvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 06:51:06 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9073820838
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542935342;
        bh=jZszkvFR3ApXve2Jwb5IbBwsSVmr21WdWYmIWulelN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o5FaZP5cbKmClFNSjSGxqg3bEFY28aqDfAXeReVqWG35it6YdDfFrUbtZ7x3hnLD9
         mE1I8zJFxb+hzF9dO68oLOnnLZEZLle62vJ4PF0TbQfro/wcxIcq36kfX3Ydv6hl5c
         1twtQyyg6qFLHwa9ZB7hqRFw+jvqs8jZZwjjA/9Q=
Received: by mail-wm1-f43.google.com with SMTP id j207so3337645wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 17:09:02 -0800 (PST)
X-Gm-Message-State: AGRZ1gLsH5t9wPsFPs7PxvWmcNxQT5nl51I/CFParv58efZtT4Wjyc9Y
        +kU5ciHiTkIRiI/tYF7BznmkKH//EosFPz2A1NsIMA==
X-Google-Smtp-Source: AJdET5dUfi1BGriSv/koGum5Y2CfCap8el/zhJD9sU/y3aukuxu+o4vrmPyAb2ZkO7UXTKpOatRyS+pcyz+Aj8NfiCY=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr11186312wmh.83.1542935340997;
 Thu, 22 Nov 2018 17:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20181116232728.23538-1-chang.seok.bae@intel.com>
 <CALCETrVtnkrr+t7-oXXrGDsei1Q0nudh8JstkuaE+dka4FHPEA@mail.gmail.com>
 <20181122205645.GA36550@gmail.com> <CALCETrVHtjXFskx5VesHnzv=BnUx=t3qC_RRWsp96RgT5CN2VQ@mail.gmail.com>
In-Reply-To: <CALCETrVHtjXFskx5VesHnzv=BnUx=t3qC_RRWsp96RgT5CN2VQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 17:08:48 -0800
X-Gmail-Original-Message-ID: <CALCETrUGJBme-xA1_=GgnJWDN6rkQ79g_insKfNJwuo_wO0FSQ@mail.gmail.com>
Message-ID: <CALCETrUGJBme-xA1_=GgnJWDN6rkQ79g_insKfNJwuo_wO0FSQ@mail.gmail.com>
Subject: Re: [PATCH v5] x86/fsgsbase/64: Fix the base write helper functions
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e9a186057b4aa0d3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e9a186057b4aa0d3
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 22, 2018 at 4:42 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Nov 22, 2018 at 12:56 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Andy Lutomirski <luto@kernel.org> wrote:
> >
> > > On Fri, Nov 16, 2018 at 3:27 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> > > >
> > > > The helper functions that purport to write the base should just write it
> > > > only. It shouldn't have magic optimizations to change the index.
> > > >
> > > > Make the index explicitly changed from the caller, instead of including
> > > > the code in the helpers.
> > > >
> > > > Subsequently, the task write helpers do not handle for the current task
> > > > anymore. The range check for a base value is also factored out, to
> > > > minimize code redundancy from the caller.
> > > >
> > > > v2: Fix further on the task write functions. Revert the changes on the
> > > > task read helpers.
> > > >
> > > > v3: Fix putreg(). Edit the changelog.
> > > >
> > > > v4: Update the task write helper functions and do_arch_prctl_64(). Fix
> > > > the comment in putreg().
> > > >
> > > > v5: Fix preempt_disable() calls in do_arch_prctl_64()
> > >
> > > Reviewed-by: Andy Lutomirski <luto@kernel.org>
> > >
> > > Ingo, Thomas: can we get this in x86/urgent, please?
> >
> > Sadly this commit introduced a boot failure on both an Intel and an AMD
> > 64-bit testbox.
> >
> > Symptoms range from silent bootup hang in early userspace to segfaults
> > like this:
> >
> > [   21.885741] random: systemd: uninitialized urandom read (16 bytes read)
> > [   21.964778] systemd[1]: segfault at 28 ip 00005584d8d8247d sp 00007ffc7a05aed0 error 4 in systemd[5584d8d0d000+137000]
> > [   21.977664] Code: c3 4c 89 ff e8 94 78 fa ff eb bb 48 89 c3 eb f1 00 00 00 00 00 00 00 00 00 00 00 00 00 41 55 41 54 55 53 48 89 fd 48 83 ec 28 <64> 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 48 85 ff 74 6e 48
> > [   22.000004] systemd[1]: segfault at 28 ip 00005584d8db0a3d sp 00007ffc7a05a7e0 error 4 in systemd[5584d8d0d000+137000]
> > [   22.012869] Code: 49 89 e9 ba 67 01 00 00 bf 04 00 00 00 31 c0 e8 c9 1c 03 00 59 31 c0 5e e9 ff fa ff ff 41 54 55 53 89 fb 48 81 ec 40 01 00 00 <64> 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00 00 31 c0 e8 fb 92
> >
> > I've zapped the commit from x86/urgent because it's clearly not ready
> > yet.
> >
> > I used a fairly regular distro .config and a fairly regular distro -
> > nothing fancy.
> >
>
> I can reproduce it.  Off the top of my head, maybe 0day is using a
> different, weird glibc configuration?  I think it runs some ancient
> version of Yocto.
>
> And I think I've almost root-caused the problem, and I think it's a
> preexisting bug exposed by this patch.  Lemme double-check and I'll
> send a fix.

Nope, I'm wrong.  Delta fix attached.  Want to just fold this in?

--000000000000e9a186057b4aa0d3
Content-Type: text/x-patch; charset="US-ASCII"; name="fix.diff"
Content-Disposition: attachment; filename="fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jotbd2ff0>
X-Attachment-Id: f_jotbd2ff0

Y29tbWl0IGE1Zjk5YmM4MGM5YmRhY2YzYTE5MDJmODkyMmNhOWI5MzlkNTI3MjMKQXV0aG9yOiBB
bmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4KRGF0ZTogICBUaHUgTm92IDIyIDE2OjUz
OjU3IDIwMTggLTA4MDAKCiAgICB4ODYvZnNnc2Jhc2UvNjQ6IEZpeCBkb19hcmNoX3ByY3RsXzY0
KCkgdG8gd29yayBjb3JyZWN0bHkgd3J0IHNhdmVfYmFzZV9sZWdhY3koKQogICAgCiAgICBTaWdu
ZWQtb2ZmLWJ5OiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4KCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3Nf
NjQuYwppbmRleCA3NDAzNWMyYTg1YjMuLmZjZjUyOGRmNWI4ZCAxMDA2NDQKLS0tIGEvYXJjaC94
ODYva2VybmVsL3Byb2Nlc3NfNjQuYworKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5j
CkBAIC03MzMsNiArNzMzLDEzIEBAIGxvbmcgZG9fYXJjaF9wcmN0bF82NChzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnRhc2ssIGludCBvcHRpb24sIHVuc2lnbmVkIGxvbmcgYXJnMikKIAkJaWYgKHRhc2sg
PT0gY3VycmVudCkgewogCQkJbG9hZHNlZyhHUywgMCk7CiAJCQl4ODZfZ3NiYXNlX3dyaXRlX2Nw
dV9pbmFjdGl2ZShhcmcyKTsKKworCQkJLyoKKwkJCSAqIE9uIG5vbi1GU0dTQkFTRSBzeXN0ZW1z
LCBzYXZlX2Jhc2VfbGVnYWN5KCkgZXhwZWN0cworCQkJICogdGhhdCB3ZSBhbHNvIGZpbGwgaW4g
dGhyZWFkLmdzYmFzZS4KKwkJCSAqLworCQkJdGFzay0+dGhyZWFkLmdzYmFzZSA9IGFyZzI7CisK
IAkJfSBlbHNlIHsKIAkJCXRhc2stPnRocmVhZC5nc2luZGV4ID0gMDsKIAkJCXg4Nl9nc2Jhc2Vf
d3JpdGVfdGFzayh0YXNrLCBhcmcyKTsKQEAgLTc1Niw2ICs3NjMsMTIgQEAgbG9uZyBkb19hcmNo
X3ByY3RsXzY0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgaW50IG9wdGlvbiwgdW5zaWduZWQg
bG9uZyBhcmcyKQogCQlpZiAodGFzayA9PSBjdXJyZW50KSB7CiAJCQlsb2Fkc2VnKEZTLCAwKTsK
IAkJCXg4Nl9mc2Jhc2Vfd3JpdGVfY3B1KGFyZzIpOworCisJCQkvKgorCQkJICogT24gbm9uLUZT
R1NCQVNFIHN5c3RlbXMsIHNhdmVfYmFzZV9sZWdhY3koKSBleHBlY3RzCisJCQkgKiB0aGF0IHdl
IGFsc28gZmlsbCBpbiB0aHJlYWQuZnNiYXNlLgorCQkJICovCisJCQl0YXNrLT50aHJlYWQuZnNi
YXNlID0gYXJnMjsKIAkJfSBlbHNlIHsKIAkJCXRhc2stPnRocmVhZC5mc2luZGV4ID0gMDsKIAkJ
CXg4Nl9mc2Jhc2Vfd3JpdGVfdGFzayh0YXNrLCBhcmcyKTsK
--000000000000e9a186057b4aa0d3--
