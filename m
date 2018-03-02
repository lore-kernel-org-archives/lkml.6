Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbGDBQW7oki9J6+1aBIRhxB8IgDDNwFVXNaLs2mZj2ygUNEKDV/Zf0EGEsMsyZmduWjUo2
ARC-Seal: i=1; a=rsa-sha256; t=1519981176; cv=none;
        d=google.com; s=arc-20160816;
        b=DcZXhDVHKjaEUAIy50OTGlUo64xB8d9DWzZyTXzSOeCf+OXdaJetAJEFVlMsm//vyR
         XVnEDfKRwyNuK/GQU+hKdk6Lupij4ZnzXKkxsZax8xWBT6XsCpQVlEOPI3olFTJZC1xq
         TV9GDOE0gYJaF888n7KH0Be5sDNS4rs4gcf5tMFgcpJ37EOvY/5RS5upUSiC9Xz2MNvu
         0OpfOaN9lxwyhhgUKOEuaD6V9VDsPk1D5OLLYIkevk6gYjDI/tMzddCmn3A/k7vQdI95
         aUrBeqG+M1hD6GKd2GNw6JnawZH/87nWtpHmSNo6ik061YAB9Ff+CAh3+yqhqDpU+d5H
         rvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aANIZkMOdcoYJJN82brLk4DkPV+1pH6D46K0su/Xeu4=;
        b=wHu69waC2HiSPewLeTsL488dtN3WKNb+gg75FrENW8GJx/qrKBv9EMEi9rMoAD3UP3
         K3hJmBgbDo15B0PKCfpeS1h3WPXlOclPyETNPRIjaO8oqyTjEn6yAHo8/v4YevPHzjQW
         GhjdfySgNVuf/UjRFnzz9wkH5GbEs8i2pMO731bATAf3/JyBJZze+8GzhMRW0VcbC+X5
         YA1dcqRRCTo9wc2dDuHbBBWry2mSmOsV+umr9GUedyKkc4m137PXbn1p5oPHwusjSGe2
         f3Eu1ly1jk02Nq92aJIKAaBetk1vE66Jie0//yyYasGQKt3hBrhZmZAzbIrgKdxIwOI7
         /bFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 016/115] ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch
Date: Fri,  2 Mar 2018 09:50:19 +0100
Message-Id: <20180302084504.527618668@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815515532586116?=
X-GMAIL-MSGID: =?utf-8?q?1593815782397989493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunyan Zhang <zhang.lyra@gmail.com>


[ Upstream commit 36b0cb84ee858f02c256d26f0cb4229c78e3399e ]

An additional 'ip' will be pushed to the stack, for restoring the
DACR later, if CONFIG_CPU_SW_DOMAIN_PAN defined.

However, the fixup still get the err_ptr by add #8*4 to sp, which
results in the fact that the code area pointed by the LR will be
overwritten, or the kernel will crash if CONFIG_DEBUG_RODATA is enabled.

This patch fixes the stack mismatch.

Fixes: a5e090acbf54 ("ARM: software-based priviledged-no-access support")
Signed-off-by: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/lib/csumpartialcopyuser.S |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -85,7 +85,11 @@
 		.pushsection .text.fixup,"ax"
 		.align	4
 9001:		mov	r4, #-EFAULT
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+		ldr	r5, [sp, #9*4]		@ *err_ptr
+#else
 		ldr	r5, [sp, #8*4]		@ *err_ptr
+#endif
 		str	r4, [r5]
 		ldmia	sp, {r1, r2}		@ retrieve dst, len
 		add	r2, r2, r1
