Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226jdyxzCBNaDGAdPBA70nMvavtNZGz3bDDnrECtjCwZ7LUo3+btQaQzvdtTXPowPbUxM3zt
ARC-Seal: i=1; a=rsa-sha256; t=1518708474; cv=none;
        d=google.com; s=arc-20160816;
        b=qMT7c7P0tnF2MHskv8IAsTVxIu4wDChMc5A62bFQ0IsA2byUZ8wfXV8cqhtvK+odv1
         rAMtG63hc7O4XzZZ+WYFTNwGPcV8YOovLe9qaU8dj7CvIHeL/mxIONVSO2Yb9+rTcBAT
         ZUPlRRe4veP+tg/5NGPnAakJWWIG9R0m+MkXuxWOyiMdCiZdjF76tc7fF0goGh8PNqBo
         DlALBi2tEuYQ8jUiVYflzA+65N48Is3ul8cRMwc5kVR5RClFpN+4OQuerAb2QNSpMfa+
         LALUhp4rM0NKStB8q0MNVseqmSWOQXXL5Os3BCmaiUBkswV3JzMiGH5M+UAcCFwQdWJ1
         +y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HYWMdzSanIFsv7keTFA6r5XSDCWnRRxr0piC4Kx6dh4=;
        b=Pqdp7C7WEPfI6lJFY6F5XqDAhPZN/gLtTWb+qD4J7WWEO9ocefsR4/X/iwhNeC7MOv
         ctt0KZLWRdOjyrgad7mhKyBLU31nDsNVbo+x8MUX0s0SDqno0Utgj9O+aDcOXWMO/TJI
         a02Ddj4zFUekMdS1lhmKULAwW7Vzw3Ftg4yAWrirqR4EaXQYApqYxVZhTI5NHTKZ1nxT
         +JcQrq1UxPGZDptw+ytyms2vn7i8Vj5//zNWmqTsAPK076NDhx3aNKLFsyA8iPmS6SE/
         vKzV3c0cDJiu7fmNy31FSK/6CYSuad9R4TCjzrO1EL6Ifapd3IDKKoNWqqZfTAWyzOHQ
         F0yA==
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
Subject: [PATCH 4.9 54/88] KVM: arm/arm64: Handle CPU_PM_ENTER_FAILED
Date: Thu, 15 Feb 2018 16:17:21 +0100
Message-Id: <20180215151230.198638766@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481257354306127?=
X-GMAIL-MSGID: =?utf-8?q?1592481257354306127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arm/kvm/arm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1165,6 +1165,7 @@ static int hyp_init_cpu_pm_notifier(stru
 			cpu_hyp_reset();
 
 		return NOTIFY_OK;
+	case CPU_PM_ENTER_FAILED:
 	case CPU_PM_EXIT:
 		if (__this_cpu_read(kvm_arm_hardware_enabled))
 			/* The hardware was enabled before suspend. */
