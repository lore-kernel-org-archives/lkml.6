Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsVQfTncbhA+xak5U9nSDYMewM8/0YLKKoVWRlleFS8rUClAS31fuUZF4hqIBwiNhA3Nm0D
ARC-Seal: i=1; a=rsa-sha256; t=1521484241; cv=none;
        d=google.com; s=arc-20160816;
        b=zmBiaepkHQQqLr6v3eq0GCKRGSCB+AZ72Axa1uZQD6e96qcla/j8z1dtcjd70RnRIN
         WKIKJ/rijmqABQAoVW/xBwzj5v77Po0D4xsXXUma6dk0e+tmHQb1f4CIxSkdlLfpbSpP
         s7TJfZtrqeYomuEAD5O1tsgm6XP7RH9ORw1juxk+4SpP/qtN2sNekiLNRI7fYPLwxndm
         VXrP4f6m2b8f/1fm4WbvudpmKNKLAWx7cqb7tyBTIOhyYknRwfxH3ay3SsvWDYuDQCsu
         0o7TkgypqMbPEfDf/s6ZZS2r9Jf1D38lggdM4qLChqMOV0zD+bBd3JGzK/RSTtjBvdQ8
         nNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3lxF/794OiCt2nhz7ujEhXCy5gmJcBbCFHLxZou1OLU=;
        b=jchtqtL018LKZzSs9UiWDLmyMwW/YZTDb254PMIDIHHy+2mEyKvZ4fAR/suCCNKHxL
         8cN8fZsf5wzhg3Mybo8xnHdthhT71QPrqMpFZTelEl8h5E3uPLw1+7Dtp+SBqLrxfKSH
         CQh67GOdc9mwLrUxURSb43XI6Fq/Dt2dh+ChmFScg4iyGgnJX5y4NoIGosjoosClw3ZL
         egawXDQ6xa4Fw++PCiHiqhrl1j92hP2hMgbqC+lVbjoc5PADaenBF6wkchOTtN1DRJzE
         edq4s/64t2NqPdBjURS2kRYio6/XjXsZZ5uNnCrm9HlmKSI054VSmldjMt78ji2aYCyh
         fkLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoffer Dall <cdall@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 23/41] kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3
Date: Mon, 19 Mar 2018 19:08:23 +0100
Message-Id: <20180319180733.751463832@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391859857089694?=
X-GMAIL-MSGID: =?utf-8?q?1595391859857089694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 27e91ad1e746e341ca2312f29bccb9736be7b476 upstream.

On guest exit, and when using GICv2 on GICv3, we use a dsb(st) to
force synchronization between the memory-mapped guest view and
the system-register view that the hypervisor uses.

This is incorrect, as the spec calls out the need for "a DSB whose
required access type is both loads and stores with any Shareability
attribute", while we're only synchronizing stores.

We also lack an isb after the dsb to ensure that the latter has
actually been executed before we start reading stuff from the sysregs.

The fix is pretty easy: turn dsb(st) into dsb(sy), and slap an isb()
just after.

Cc: stable@vger.kernel.org
Fixes: f68d2b1b73cc ("arm64: KVM: Implement vgic-v3 save/restore")
Acked-by: Christoffer Dall <cdall@kernel.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/hyp/vgic-v3-sr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -215,7 +215,8 @@ void __hyp_text __vgic_v3_save_state(str
 	 * are now visible to the system register interface.
 	 */
 	if (!cpu_if->vgic_sre) {
-		dsb(st);
+		dsb(sy);
+		isb();
 		cpu_if->vgic_vmcr = read_gicreg(ICH_VMCR_EL2);
 	}
 
