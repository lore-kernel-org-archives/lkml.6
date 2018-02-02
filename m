Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2240rmPo5UtJTU0usMjHiMP4Hw2xSS5qUdu5vcNWUSyq00ayAHZf53QfvVbaMN+OMmzPsVEn
ARC-Seal: i=1; a=rsa-sha256; t=1517591056; cv=none;
        d=google.com; s=arc-20160816;
        b=OS9fa4tK3hDm3a9wxNVUpLYLMnmhyl8Rj+T/9aCio/12mdAFefKGmcEXgO3G1XyqrO
         QBcI2fZLQBU73gI67SG2C+wRCVQWFOVRC2dsDiIJ3faHMNZYmmmO3ktpK/PaHX53X9Q3
         FHyDYXwBH66PemXP/L3UISK2brs5dSjIRWTUzS9WSBQ/bOYWPpBhjjog2nYrhTP1oOaf
         8b/DzhXEDNtWm43xlVtf7U4+JR0abmr8Bj7Bn9VAvKCFQsY0dAD5b7ZsWuFpZd82ha/B
         GtC6olGZU1xzkE7QTruNdrIaIzXSsiNdSjjR8SbJHpZxBjSUqFfvtsCrJQmV014v0llr
         +gDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vpL7JnOJtZBvWhUMx+VZwcGUuBH8cRMQzhoqZyElQAE=;
        b=0W63/Syzne718QZ0f8Qr+y8hQWUFhs+G4fVCYBfwJ7ElyWFng1Qr8ssCrev6UvKe+Q
         LPmvq2qLPs45P2CpbUDEmZP9/Md1fcXGX5jlF1zOtu7guxPyyUidK8M/pN3R30CKhOBv
         /JFyfsnIkYWbqlsMMB/R1khRFgd/sDwV7+oQYzIXFmGl4yvElYmxLJWHgIpepeV8OBml
         4/pvKb18xNQ/pgTnfTYid2SZ27y+MayE2+dnt/5bIrdq5Lt7yisfVE0+5CO0+Ktn+MNJ
         eXjy2RC/i4c68mBhM/oQ51bNV61vOzhyGO336GJQT9S1O2kDqEotxl88IhB72kbn3UGS
         +bOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 36/86] KVM: X86: Fix softlockup when get the current kvmclock
Date: Fri,  2 Feb 2018 17:57:56 +0100
Message-Id: <20180202140825.835561072@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309559973496793?=
X-GMAIL-MSGID: =?utf-8?q?1591309559973496793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <kernellwp@gmail.com>


[ Upstream commit e70b57a6ce4e8b92a56a615ae79bdb2bd66035e7 ]

 watchdog: BUG: soft lockup - CPU#6 stuck for 22s! [qemu-system-x86:10185]
 CPU: 6 PID: 10185 Comm: qemu-system-x86 Tainted: G           OE   4.14.0-rc4+ #4
 RIP: 0010:kvm_get_time_scale+0x4e/0xa0 [kvm]
 Call Trace:
  get_time_ref_counter+0x5a/0x80 [kvm]
  kvm_hv_process_stimers+0x120/0x5f0 [kvm]
  kvm_arch_vcpu_ioctl_run+0x4b4/0x1690 [kvm]
  kvm_vcpu_ioctl+0x33a/0x620 [kvm]
  do_vfs_ioctl+0xa1/0x5d0
  SyS_ioctl+0x79/0x90
  entry_SYSCALL_64_fastpath+0x1e/0xa9

This can be reproduced when running kvm-unit-tests/hyperv_stimer.flat and
cpu-hotplug stress simultaneously. __this_cpu_read(cpu_tsc_khz) returns 0
(set in kvmclock_cpu_down_prep()) when the pCPU is unhotplug which results
in kvm_get_time_scale() gets into an infinite loop.

This patch fixes it by treating the unhotplug pCPU as not using master clock.

Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1751,10 +1751,13 @@ static u64 __get_kvmclock_ns(struct kvm
 	/* both __this_cpu_read() and rdtsc() should be on the same cpu */
 	get_cpu();
 
-	kvm_get_time_scale(NSEC_PER_SEC, __this_cpu_read(cpu_tsc_khz) * 1000LL,
-			   &hv_clock.tsc_shift,
-			   &hv_clock.tsc_to_system_mul);
-	ret = __pvclock_read_cycles(&hv_clock, rdtsc());
+	if (__this_cpu_read(cpu_tsc_khz)) {
+		kvm_get_time_scale(NSEC_PER_SEC, __this_cpu_read(cpu_tsc_khz) * 1000LL,
+				   &hv_clock.tsc_shift,
+				   &hv_clock.tsc_to_system_mul);
+		ret = __pvclock_read_cycles(&hv_clock, rdtsc());
+	} else
+		ret = ktime_get_boot_ns() + ka->kvmclock_offset;
 
 	put_cpu();
 
