Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80B42082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAW8uS2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80B42082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeKRFPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 00:15:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44821 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKRFO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 00:14:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3370539pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JmtMWaiD9FenKM3ns0kNxP2J4QR+RUeNI/5TJ/tQ45I=;
        b=KAW8uS2esdTjeBcDfFodpTuBiPuzrfOgpEvhmkdmizzqp7CMEjaFC2ORlF9MeL+yeA
         stdwlyxwK9cJAK+MAYm3DEfW4lRgMCiJRj3yewaXsrtQx5DmclC4R/K9qjVetVNcal+H
         pjN2zNK/65b6+lBFp6r24jInRxn3xDvrMAU8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JmtMWaiD9FenKM3ns0kNxP2J4QR+RUeNI/5TJ/tQ45I=;
        b=YEIsmFVSBYnhjdSigYWZNQspV57qmBZwZGm0A1P7RMFOTX/EzHn+vnRLnk3hQSf4C9
         HW75HkBjmyIRrmHV5JV9smK3DYd7gD31QnbiwodYoatjon+IqAd7xHqeJIIJF4FUd79G
         Hm7K0FiSdBwF5wLMMTQfbi+lMRvOMJRG5o5XUjGSi1z/WITnprL/WY7JIc64NLSV35Nf
         owyhysd9vIj/H4kpsJA/fi4qXXKGmIxG7Tw9tSz/SVPGzQSAhyiGT0v0SGopcu0DAPsg
         CQbQZNk9GOykhmHpDQEQCMaE8LLHcpVX2vrVp70zvJ+CusK/WwIMpf5nFpgVTcqqxZsV
         VL6w==
X-Gm-Message-State: AGRZ1gI27cUyl8d9HDg/ftqaMrjrQCuDqJP9U1N+sOjH1qRNJAf9DDv4
        gd6tNlALa/G/jUsCl+v0uvEEBWS2eWHOLQ==
X-Google-Smtp-Source: AJdET5epwL8opIfWAHhuSBY1hNn/GKz9erLG44ejL6V5gIz84eLRbi+P5B/LB3RozshYttdcdgtQpg==
X-Received: by 2002:a62:ed09:: with SMTP id u9-v6mr16036733pfh.188.1542481044594;
        Sat, 17 Nov 2018 10:57:24 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:23 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 4/4] arm64/bpf: don't allocate BPF JIT programs in module memory
Date:   Sat, 17 Nov 2018 10:57:15 -0800
Message-Id: <20181117185715.25198-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by simple vmalloc_exec()/vfree()
calls, which can be served from anywere. This also solves an
issue under KASAN, where shadow memory is needlessly allocated for
all BPF programs (which don't require KASAN shadow pages since
they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/net/bpf_jit_comp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..e0c702c2f682 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return vmalloc_exec(size);
+}
+
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
+{
+	bpf_jit_binary_unlock_ro(hdr);
+	vfree(hdr);
+}
-- 
2.17.1

