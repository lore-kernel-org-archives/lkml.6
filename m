Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gXW8+wcft0oMGO9iR42BZC4mM32kcjEsq7m3lB506srPY2soJl2a039KAQG7Vmr0HdAM1
ARC-Seal: i=1; a=rsa-sha256; t=1524406246; cv=none;
        d=google.com; s=arc-20160816;
        b=0If9utLS8dThnOe7aC/CY5PHcdaenWrg/LKuFe0tH3KgqPLvzzAUS+9wCcLSoNDpG4
         6BHK1mg9h8SJ8JOkDM+Ft+PVc0ZZ0Ad3xQoMhKsCvmGWgRGa5eWw95O2G0Dn0dAxedO8
         nEHjzPUogUTrXLt5xDJPIDZ3TcHTol7mfjnBfD6CRuXWHjBA9oIbtQdTnn73sGUUhylW
         7gahN1LRoOUiLayhTg+mRiuyF67qcnP5J03FQL+fmfWsPPEVNDJkf9cX2CDfIVySMt1A
         pZ7K7tKeCf0AeWDHvhvxv8PUma46f3mfLNsuZE4zOjOt6ATXxlyQe7Bqu32One0H+bMv
         1ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4hqxf9NU8k+HtLvzwSxMFBaxxZQRW16hz+brkVyPJCI=;
        b=drdOBi+0SWkuhP9y6gcHeo+fsev3saY0Kh7/GugM/GgTREJA7sMpWL1tTCkCQAzzSh
         wIlMfV4u5CLa4tq7Az2rpD4n/nCatolKSMRmiO2t4ZWlh/VLjy/dgYFnPkHqDeD+V2nY
         tq2kxTgRTVbbje11Eks9N2AjWChxNhsK+uUgSRez7A/FF2Bt9TbgesAAvR4Mujj1vQef
         wE9/zzUiBOAV+CGpW0D5XKGLwv+ypDC74KzE81EgAYpRChxd7//T6II6FhNYzXfa06lk
         QspnjN4dT08lFdbqPHzeGzBDDcgJ2THJnlIsZmtil2qv0s+GWAr0omxfb2TXtbOk6yAe
         rRyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 146/164] powerpc/xive: Fix trying to "push" an already active pool VP
Date: Sun, 22 Apr 2018 15:53:33 +0200
Message-Id: <20180422135141.466082140@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455276312388961?=
X-GMAIL-MSGID: =?utf-8?q?1598455803998725327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit b32e56e5a87a1f9243db92bc7a5df0ffb4627cfb upstream.

When setting up a CPU, we "push" (activate) a pool VP for it.

However it's an error to do so if it already has an active
pool VP.

This happens when doing soft CPU hotplug on powernv since we
don't tear down the CPU on unplug. The HW flags the error which
gets captured by the diagnostics.

Fix this by making sure to "pull" out any already active pool
first.

Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/sysdev/xive/native.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -388,6 +388,10 @@ static void xive_native_setup_cpu(unsign
 	if (xive_pool_vps == XIVE_INVALID_VP)
 		return;
 
+	/* Check if pool VP already active, if it is, pull it */
+	if (in_be32(xive_tima + TM_QW2_HV_POOL + TM_WORD2) & TM_QW2W2_VP)
+		in_be64(xive_tima + TM_SPC_PULL_POOL_CTX);
+
 	/* Enable the pool VP */
 	vp = xive_pool_vps + cpu;
 	pr_debug("CPU %d setting up pool VP 0x%x\n", cpu, vp);
