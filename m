Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELshs/rgeJUtLc+s6qSudeMj4yKRI3OZvRTC7a+x4lA9JWfPt5xImN455tuYbr/iCleo/dwL
ARC-Seal: i=1; a=rsa-sha256; t=1519980922; cv=none;
        d=google.com; s=arc-20160816;
        b=qzizlozgAZDhMVBIGrwv9emnWvgBMZUT4Kqzsd5iSEIKiwM0hS5q3ehtH+BIOuilWL
         6ILjDxds2xQqp+2o1lWx8oMmv2/PIq/s+At3BZttsPMG//aCp/eBT2p0yalBNWZjRJjr
         huzq/5g9l0RTQeASrsldifJfGURVwJ+tj44z6yS/fUCXdB9mWjxvVhXL2z5vWaROECDl
         PMpWmN6SNTKUfLP1rgCfDJ7glP6cDX90C8vJQHxXEAc5fPh5kMLZQ64r/RaZsKcy8Z1y
         FtYiLDt4JmacZBUKc8YfO9A3JUYCFrwuXJbKdLTl5pqavLYq4luN5tu7q/ez1layfJGB
         CnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ft8r5qEG190OYAEhxT4yEOWuWcU+eZj9EBonQKx5JVY=;
        b=v7VQoKh6U0TIeRCa4Vd1JWAbVX3DJh9yXxxUfZGJz1BV5bwXuJLdCaS/oXvzOv2Inr
         9XTMpwXiXeR4SOWs1+EJaLGpD43gA7SEyRbJkMEfqK7lKCygF+OI0f7aZAJpVzdYKu3n
         8HF9Z0O+xXWURHUF6PpR9Zcacdzb16f2/3aI+7PTepQnZFcyZIsM/uFca0XuOw5evyw9
         JfQq+YJLHoTBihAoZSYuVdVxLpoLLx5bD9xp1QXT1GSUu7F7w1gPvpgItgfaNmdR8kEv
         icEM/iE0Fr06SGJDLPOB7M181i4wGeUX7eoXmM18i9NNxMsRDXBrWW4Zjp5HzB8sLwBm
         rKtQ==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 05/34] ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch
Date: Fri,  2 Mar 2018 09:51:01 +0100
Message-Id: <20180302084436.333276338@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815515532586116?=
X-GMAIL-MSGID: =?utf-8?q?1593815515532586116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
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
