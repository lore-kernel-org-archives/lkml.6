Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B24C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B76121531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxtQg47D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B76121531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbeITXIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40155 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeITXIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8-v6so6562880wrh.7;
        Thu, 20 Sep 2018 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNvSaAuN8ua66sOY4or0/D1FlscDvCeOL0lZIZxxVVY=;
        b=ZxtQg47DfgTZWX+3aESPFzEFNa+YSp+x4lCfZoBf60il26qhOBGTWjiEsEbaF+xdr2
         4AywgAjMnBnuxTQ4s8ueVm2zxeVU7zZ11SUrIPpgpZde5kxpv0X39WZcSB4+/hVJS22Z
         0FYg7E/rODGjTnj8pgzvUhzQJN2J/xh4on32Q/YrfXHlFD2X+c4XdAS1A1/F+A8ejXgL
         6xcNAhMoVtWFnsQ2tOJvsMfFDEbgkwAXzv0GpihoXwwT8124GN3nSx+1G7HiUCMzA4Op
         oZoN5qPN8Z79TcktlU1IYXHQCH8JZ4Pt7Hchb3Uz3sKziqctX7W/IwfRoj2gxBe+Sse6
         21cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GNvSaAuN8ua66sOY4or0/D1FlscDvCeOL0lZIZxxVVY=;
        b=Aqw3cE/Gaw4vQM02plZEsqjU7doFbpnYsyWPeCyqI/h/R71iVkxN4LUWz2m8Coj5fP
         EVTaAOMz3Qn1unxazXNK7uUdNPjHf/hjdnAZEBJA4jl031xOFZTDRzPFjgftiDZOsbBV
         fWFNMHCMvNmfSQO/rvjoQHr876j6SVx7Taf3cx/i1S2NAtp9kQ9ivyyoNMXHkEJyVc9s
         piaQ1rk4TMW6in2f2zIbLehsPRvX+VUWgSJ9W2hqouNEQz7NCit9gt5R8Qz+4+JBWr3T
         DYSVQH6eqoG212UmpdfKbYRb4OrgzNrQUbtGKwvfUH/pxuu1AMPR7i6sGOukPX3is0gJ
         udKQ==
X-Gm-Message-State: ABuFfoisG8+8KNSDZxd+DYQ1W4smYTKwv7f2zEqX24Mg76lGsichYCAA
        qffCkND6PrQWfuaqfs/Xns4=
X-Google-Smtp-Source: ACcGV63BK/cnjGFvECOBoAjjxVvAO91wUVlT/95+RZ58uKyVECjaFS6PmXQCKhN/CJhtw1rlbHjUJg==
X-Received: by 2002:adf:f7c8:: with SMTP id a8-v6mr4418106wrq.86.1537464228572;
        Thu, 20 Sep 2018 10:23:48 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:48 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 11/15] Compiler Attributes: add MAINTAINERS entry
Date:   Thu, 20 Sep 2018 19:22:57 +0200
Message-Id: <20180920172301.21868-12-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e993064637ca..74419b8d00ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3722,6 +3722,11 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/compal-laptop.c
 
+COMPILER ATTRIBUTES
+M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
+S:	Maintained
+F:	include/linux/compiler_attributes.h
+
 CONEXANT ACCESSRUNNER USB DRIVER
 L:	accessrunner-general@lists.sourceforge.net
 W:	http://accessrunner.sourceforge.net/
-- 
2.17.1

