Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A2C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF4F2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MG65AbsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfBFANA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:13:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33374 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfBFALf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so4518312eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/xv33RBnM953+vpssFfbq1v4eTcaYbTCiCX8dfIKHs=;
        b=MG65AbsSryj1/mrIzNQ4GblWCu76hTamCLwUYhWRqHeTbLI9Za3gwc4RhDW+yazSjX
         tnSwroyktoewNFQSPbSjKfpIm9lTKvCjN7/HQvTdaibt4YAgOyw1PWFnS6wIYZXXJNhz
         Bkz+NKPzAa2EVof6HUkpC4pQQKP9g2cLPGS+XDyS4UqYsrWQi+r2/4Z2QNYhQTD4KaTT
         UbEO3hB5DQCcCKuhB8k2a8vObONeoMtFoOUIMNwj5PKLkihEPResnvczApY1q87Reyv7
         vsp8VUft5kiRMndq3z1wDZ9199r8j+aoTQosa+/lIrc2m7K0FB2LCQ/atg2P8R8PvaB8
         72aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/xv33RBnM953+vpssFfbq1v4eTcaYbTCiCX8dfIKHs=;
        b=aiU/vhH6oqBMhX6Dd5iZ1DhhE+Ny0QGrm+zphsOL6cbzagbquf0W/98xH8RkvOOkFA
         KFMRzFtVdRTUFmXO/hNbRYlBPIyR1+cygKi/Bu5lezpwa1UYxoNyZRvhWQCh4DJGrUKJ
         ViT3YnXeCY3tsbnvLVS5CqALs/Bcl09L/uLLNe0muFUpjyIwaucE2zU3+55vPteMEfFK
         WAIirQmgpJTcipv8Oxayqi0oGyec54hREV+HV6wZMbpLcidpPDf0ApFC7psqgndcoAzD
         TZoPyAN69IT7xDgkW5wGFRY9ioAFPRCBtTQH2oAeD9f6EqX2S6sWe9Kus0Y4zkUqiZS4
         Sulw==
X-Gm-Message-State: AHQUAuaPBvrluEnyKU7ndmk2pF/fRUj0lXR1c1s6umqObWCjVhxhkylu
        k3nWiBj4suyJ3LMXtLhWC9wrKeX672E=
X-Google-Smtp-Source: AHgI3IavdBQ2u5XWzAtAc5QZZUq3GNh0TPpcGeSiD8C0SLHOtNbJR4ujcudGd2J4je5XfuuxdifFxQ==
X-Received: by 2002:a50:ed8a:: with SMTP id h10mr201199edr.30.1549411894010;
        Tue, 05 Feb 2019 16:11:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:33 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 18/32] x86/vdso.lds: Align !timens (host's) vdso.so entries
Date:   Wed,  6 Feb 2019 00:10:52 +0000
Message-Id: <20190206001107.16488-19-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Unfortunately, to allow changing VDSO VMA on a running process,
the entry points to VDSO should have the same offsets (addresses).
That's needed as i.e. application that calls setns() may have already
resolved VDSO symbols in GOT/PLT.

Align VDSO entries for host with addresses generated from timens VDSO
(which is bigger as it has code for adding offsets).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index ba216527e59f..e529ee3ec9e8 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -70,7 +70,17 @@ SECTIONS
 	 * stuff that isn't used at runtime in between.
 	 */
 
-	.text		: { *(.text*) }			:text	=0x90909090,
+	.text		: {
+#if defined(CONFIG_TIME_NS) && !defined(UNALIGNED_ENTRIES)
+#ifdef BUILD_VDSO32
+# include "vdso32.entries"
+#endif
+#ifdef BUILD_VDSO64
+# include "vdso64.entries"
+#endif
+#endif
+		*(.text*)
+	}						:text	=0x90909090,
 
 	.altinstructions	: { *(.altinstructions) }	:text
 	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
-- 
2.20.1

