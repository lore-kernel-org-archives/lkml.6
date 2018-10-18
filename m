Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC4ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0636F21470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0636F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeJRJqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:46:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbeJRJqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:46:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD094B060;
        Thu, 18 Oct 2018 01:47:59 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     peterz@infradead.org, dsafonov@virtuozzo.com, luto@kernel.org,
        hpa@zytor.com, dvlasenk@redhat.com, luto@amacapital.net,
        torvalds@linux-foundation.org, bp@alien8.de, mingo@kernel.org,
        brgerst@gmail.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-tip-commits@vger.kernel.org
Date:   Thu, 18 Oct 2018 12:47:50 +1100
Cc:     peterz@infradead.org, dsafonov@virtuozzo.com, luto@kernel.org,
        luto@amacapital.net, dvlasenk@redhat.com, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org, bp@alien8.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, brgerst@gmail.com
Cc:     James Simmons <jsimmons@infradead.org>
Subject: in_compat_syscall() returns from kernel thread for X86_32.
In-Reply-To: <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org>
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com> <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org>
Message-ID: <87h8hkc9fd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Was: Re: [tip:x86/asm] x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x=
32}_syscall()
On Tue, Apr 19 2016, tip-bot for Dmitry Safonov wrote:

> Commit-ID:  abfb9498ee1327f534df92a7ecaea81a85913bae
> Gitweb:     http://git.kernel.org/tip/abfb9498ee1327f534df92a7ecaea81a859=
13bae
> Author:     Dmitry Safonov <dsafonov@virtuozzo.com>
> AuthorDate: Mon, 18 Apr 2016 16:43:43 +0300
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 19 Apr 2016 10:44:52 +0200
>
> x86/entry: Rename is_{ia32,x32}_task() to in_{ia32,x32}_syscall()
>
...
> @@ -318,7 +318,7 @@ static inline bool is_x32_task(void)
>=20=20
>  static inline bool in_compat_syscall(void)
>  {
> -	return is_ia32_task() || is_x32_task();
> +	return in_ia32_syscall() || in_x32_syscall();
>  }

Hi,
 I'm reply to this patch largely to make sure I get the right people
 .....

This test is always true when CONFIG_X86_32 is set, as that forces
in_ia32_syscall() to true.
However we might not be in a syscall at all - we might be running a
kernel thread which is always in 64 mode.
Every other implementation of in_compat_syscall() that I found is
dependant on a thread flag or syscall register flag, and so returns
"false" in a kernel thread.

Might something like this be appropriate?

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thre=
ad_info.h
index 2ff2a30a264f..c265b40a78f2 100644
=2D-- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -219,7 +219,7 @@ static inline int arch_within_stack_frames(const void *=
 const stack,
 #ifndef __ASSEMBLY__
=20
 #ifdef CONFIG_X86_32
=2D#define in_ia32_syscall() true
+#define in_ia32_syscall() (!(current->flags & PF_KTHREAD))
 #else
 #define in_ia32_syscall() (IS_ENABLED(CONFIG_IA32_EMULATION) && \
 			   current_thread_info()->status & TS_COMPAT)

This came up in the (no out-of-tree) lustre filesystem where some code
needs to assume 32-bit mode in X86_32 syscalls, and 64-bit mode in kernel
threads.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvH5kYACgkQOeye3VZi
gblD5g/6A37QFjzG+7EwrKekFwAvVpffPH+qq9wtN9Q8TGVub6adyC4TsvvDATCf
zE7FFP/JRzCzUITd8KcnyzeYtIEmA+N/zxaoHWWDofC/EVJyWQ34pznV6Yu0e1vU
HhGIyEkTntAGkucZl60L+4poInTmStgBN3jkTarhqeavTKBIhtATkuKegc0tgq3k
AbLh4awH2VlmeD7/mVIUWYzhanf4/IlmpxkzKAmq3rw6zfUAbseLDe/ZJbFLVYoM
SYFYxWLadjk7YToo+AO9jVBPWOTI8nVGYVTRpQ6tbZ8CYgzABQ98crNu3AghD/C3
xHtX8FjlLC/I8oRPO25RUaYDx85cSXo70MYReI9MujMunbj0KkkS9SUsHNvabqdD
xtwDImMf8ZMKysPfAXpvLouDfjbOdcZMpMnZUdQuK7OuOfrK3F0HdBiUCUy45uaM
O4n3Raq1H/Yz/LWv3YqwGS/1YjXx5OVmwyqwQvatf2pN2AKmo+ZnELcltWK267Zw
NhlLDauCS2RkEi9e4wkJB5JsExEhhX0lvXiZXP2ErphXYiNQr+iVv+Plj4JO5OAI
hPSPgV94O/2p4oQtQodDdcfTi3Y1OHwSYLGNVSQRWvkHeRwJ4VndJNhyFM8nR5/P
2P8OJgG/vHBNIfoHyx5sV1/n+r8BFmewq+nyf9NXaqiIfLZ/ziI=
=Cmo3
-----END PGP SIGNATURE-----
--=-=-=--
