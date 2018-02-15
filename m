Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226nmX4Wz0lgz7YyEGzQMi5q17fJR0xNikDzA6LAPHZeREVfUNtOXLagyEz91lWP3nfpTClR
ARC-Seal: i=1; a=rsa-sha256; t=1518708959; cv=none;
        d=google.com; s=arc-20160816;
        b=p81WhiK29HlWVPr2YmJ5SunxkQA8nfr08BLR+yIU8yzig3Tx9QEh/sEkT9LX1Aa6Et
         MWUUE0haUYnX0K8ZaxmOsQrHm5iEtOU9ayG5BuoB6SRNP6/Tfv0gpbYvlJLh0zpX3OAa
         udWjtU/vYteEsCs1UNDljeumVf0bowOi0RSu2XPrEmIPx2Q01iDdbGAomEVSwogeczCx
         tHrZ+YWFm24LrgILOJW9isrkv18F+kyzGWgxbCsSVP8O2l3A0y/mG9kxzeK452GDm2AC
         X78kJJWjfy8Er7SrLjVXb49+3wyAWCYpLl0S2gTEGNIuqFQj7O3vu2jbfXlCRCilFCZL
         qCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tck2rzMlICxbVssdbg527+duMBONC7JS4ZF1tRahKwA=;
        b=GJSkZ0pD48dFGf1hcgpJ/pkdg8ywMAbpWzSsLfK9/+lUU4CFY6sBqWExAjaNXbP0r5
         tH2Ir26vHwqIFB56iLv0yaBH7epj8zpnXKm0lNXpuJpwSoFIEQv1qa1HR8gyET6+nKvS
         f04w8jBZua3uylBhRNrnKQWmt6HIWSsIvRfKGOYtjyli5h8zTU4oK0s1L/Vfgi+9Vk6k
         xyGuShdeobdqDkio936TSzpp0Z1X0H7kinFZgq1XWMkbcR6Lx9vimdurrkFbqsCLes8v
         bL1+OujLN3YjW3Sc3hDgeXL/Y0G23wiXzm9ajV5F15RxBFspIfrN8TQXX2s5ZSrKGqcL
         zoTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	James Morse <james.morse@arm.com>
Subject: [PATCH 4.14 141/195] KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED
Date: Thu, 15 Feb 2018 16:17:12 +0100
Message-Id: <20180215151712.834917069@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481257354306127?=
X-GMAIL-MSGID: =?utf-8?q?1592481765863443291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 58d6b15e9da5042a99c9c30ad725792e4569150e upstream.

cpu_pm_enter() calls the pm notifier chain with CPU_PM_ENTER, then if
there is a failure: CPU_PM_ENTER_FAILED.

When KVM receives CPU_PM_ENTER it calls cpu_hyp_reset() which will
return us to the hyp-stub. If we subsequently get a CPU_PM_ENTER_FAILED,
KVM does nothing, leaving the CPU running with the hyp-stub, at odds
with kvm_arm_hardware_enabled.

Add CPU_PM_ENTER_FAILED as a fallthrough for CPU_PM_EXIT, this reloads
KVM based on kvm_arm_hardware_enabled. This is safe even if CPU_PM_ENTER
never gets as far as KVM, as cpu_hyp_reinit() calls cpu_hyp_reset()
to make sure the hyp-stub is loaded before reloading KVM.

Fixes: 67f691976662 ("arm64: kvm: allows kvm cpu hotplug")
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1220,6 +1220,7 @@ static int hyp_init_cpu_pm_notifier(stru
 			cpu_hyp_reset();
 
 		return NOTIFY_OK;
+	case CPU_PM_ENTER_FAILED:
 	case CPU_PM_EXIT:
 		if (__this_cpu_read(kvm_arm_hardware_enabled))
 			/* The hardware was enabled before suspend. */
