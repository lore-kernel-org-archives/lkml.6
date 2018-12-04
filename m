Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B91C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567CF2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSHBn+3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567CF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLDBnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:43:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32864 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLDBnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:43:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so7432866plo.0;
        Mon, 03 Dec 2018 17:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Th0v2UT5RVhPgXbxBsglycGhp+RqO4OKzX8UkhGpqp8=;
        b=JSHBn+3uR4u1ek2VtKdIOtwqbIpsPAjLCdulzxtZsMV27b9uEBrLNgBHSiL9ZhOa+/
         WSu5FTgeJTjjRI4tOjLG5RjDIXLVjsiNTqd6gWXTWPrYUcEjkU5YvW1ms4syHYDfKUWy
         s1cZ1aBeEQRzfDlBhVfuprrOlWyqxQIFbvY/E9JeArVsnFhiI37k6AuA+gNgPq92HUT7
         D3WGR0lxS+EbtD0+eW5ZIyL2peZWqZXKm+YDWa/SUZmj7Wjgjzz/l65oUM+IxfCXtgwo
         hn1jbmlPSUpp1NLqqPrxsOTGRM3VfghyJcSywoMQl6PCCK+KFak+FfX0QSS+qFnIopVJ
         4wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Th0v2UT5RVhPgXbxBsglycGhp+RqO4OKzX8UkhGpqp8=;
        b=F8MC5T6Q52DQ+hRkgI+bJBuBEHmMpKLMGCiJyi3OQNhY/WaNHoukWaZpTEOkBS0I3U
         4J5oGl6I0ItGdSqkTItYpxVkAgVdaISwZgs1XJyS774WCzcwn94jZiBApQQ5xLka08aj
         gXnddmYjHzW3PountGJUrIvmNVZj8jcCHo9XU+qkDCEBWhbmaRYrgTMibuWuDEZ22hCn
         3SmHSi84If20r7NNXi2FI5YLgKQvbTaj7lhG73pW9xE1CHcR+s2F+B3v03wBvTYGDUrF
         L9qlFKWdIX+XNHAvq/GDezFXetjK8YxYXlxLXvSDZnXXxLxyHi80wfgci8PX3qy0I+wT
         yn1g==
X-Gm-Message-State: AA+aEWZd0O+1DCz9jgSO7ksdJLmjkm2zKYUrvjPUSBO+quuhO2kgfo4q
        TQOaZsFP56lepDAaI1jb5w0=
X-Google-Smtp-Source: AFSGD/XcD7IKlkrNaYYS/wvP8i7Fd77/uwZyjxBJfhA69WKv6hB/aQ0fjuuVchNFj9+7btK1KDKKCQ==
X-Received: by 2002:a17:902:4324:: with SMTP id i33mr11593800pld.227.1543887794180;
        Mon, 03 Dec 2018 17:43:14 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id a4sm16092640pgv.70.2018.12.03.17.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:43:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181128000754.18056-2-rick.p.edgecombe@intel.com>
Date:   Mon, 3 Dec 2018 17:43:11 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        netdev@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, kristen@linux.intel.com,
        Dave Hansen <dave.hansen@intel.com>, deneen.t.dock@intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe =
<rick.p.edgecombe@intel.com> wrote:
>=20
> Since vfree will lazily flush the TLB, but not lazily free the =
underlying pages,
> it often leaves stale TLB entries to freed pages that could get =
re-used. This is
> undesirable for cases where the memory being freed has special =
permissions such
> as executable.

So I am trying to finish my patch-set for preventing transient W+X =
mappings
from taking space, by handling kprobes & ftrace that I missed (thanks =
again for
pointing it out).

But all of the sudden, I don=E2=80=99t understand why we have the =
problem that this
(your) patch-set deals with at all. We already change the mappings to =
make
the memory writable before freeing the memory, so why can=E2=80=99t we =
make it
non-executable at the same time? Actually, why do we make the module =
memory,
including its data executable before freeing it???

In other words: disable_ro_nx() is called by free_module() before =
freeing
the memory. Wouldn=E2=80=99t inverting the logic makes much more sense? =
I am
confused.

-- >8 --

From: Nadav Amit <namit@vmware.com>
Subject: [PATCH] modules: disable_ro_nx() should enable nx=20

---
 kernel/module.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 7cb207249437..e12d760ea3b0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2029,14 +2029,13 @@ void set_all_modules_text_ro(void)
=20
 static void disable_ro_nx(const struct module_layout *layout)
 {
+	frob_text(layout, set_memory_nx);
+
 	if (rodata_enabled) {
 		frob_text(layout, set_memory_rw);
 		frob_rodata(layout, set_memory_rw);
 		frob_ro_after_init(layout, set_memory_rw);
 	}
-	frob_rodata(layout, set_memory_x);
-	frob_ro_after_init(layout, set_memory_x);
-	frob_writable_data(layout, set_memory_x);
 }
=20
 #else
--=20
2.17.1

