Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vCwAMnLfGLCgfQWdzEKUul+MIveDidUIaYy2rWUNNE1LK7crW+DWHCBOggGq/9c+7GB7G
ARC-Seal: i=1; a=rsa-sha256; t=1523981321; cv=none;
        d=google.com; s=arc-20160816;
        b=MK5cHB+nD4lsneGSDgc9vpsPC9OXBiM9VISmJwggTzXym2RdE2N+dMeGfzhAzxqE46
         cUmU0mCPW9oXSUCmTMzWncANr3Audmxom9D9lCCvlsnRLhtLOrGlBQt5qNzlwRcTqsYQ
         o+JacnoJa7ASbr7X2hrjK2OIwyimHqt5JnoamP0kxU9VLYj+1/6jo1kRgx19OiUDBWsA
         JHRVOGkTL/Nt2qQsw4LxBVKhzp5laf3VLyaf/EUrMYnH+5RdR2Vd8b0hJCLGrRYLE8Gr
         uU/kQx/tnXv0AKjb9GlGui8NjgU0RuLdrxyIBt6iL+vbucyfybHZL4je8wEPlX/Kivan
         5HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I86ycQ329ZLgFWXQb3o8+vEG5wmHWwngvOcUdSUb3HM=;
        b=KHfJuZomIsa/sWa4nVSaZ0W69KbA8anoGsBLNiogIoInH2MwWgePKq2C4G/piBJyxE
         db9mlh5/GihewjxojvY/OjLRzgv5K5cF1uWAYxGxquFa/MELRrRD31IdaZVQU1bj2iED
         t+obQhL3WwJKoslIzYi11ekpv5vi4e5EzzlYgawROvV9OGct3PtGrt6UNkTWid+/XboO
         RIndMJ4D+NQFGef9UtAX7upOfQawKC9CiBrHCuD4kMcfTJFtFS1vF1XHIA7pLxs0Wio5
         YZ+7aJLaCIvq6qjjK8EfPaN8gLZxNoycJTnD06EpIgrxV9tz+7jRuKy5b+Wz84O8SBfX
         9T5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 22/66] drivers/firmware: Expose psci_get_version through psci_ops structure
Date: Tue, 17 Apr 2018 17:58:55 +0200
Message-Id: <20180417155646.810533738@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010238567873822?=
X-GMAIL-MSGID: =?utf-8?q?1598010238567873822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit d68e3ba5303f7e1099f51fdcd155f5263da8569b upstream.

Entry into recent versions of ARM Trusted Firmware will invalidate the CPU
branch predictor state in order to protect against aliasing attacks.

This patch exposes the PSCI "VERSION" function via psci_ops, so that it
can be invoked outside of the PSCI driver where necessary.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/psci.c |    2 ++
 include/linux/psci.h    |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -496,6 +496,8 @@ static void __init psci_init_migrate(voi
 static void __init psci_0_2_set_functions(void)
 {
 	pr_info("Using standard PSCI v0.2 function IDs\n");
+	psci_ops.get_version = psci_get_version;
+
 	psci_function_id[PSCI_FN_CPU_SUSPEND] =
 					PSCI_FN_NATIVE(0_2, CPU_SUSPEND);
 	psci_ops.cpu_suspend = psci_cpu_suspend;
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -26,6 +26,7 @@ int psci_cpu_init_idle(unsigned int cpu)
 int psci_cpu_suspend_enter(unsigned long index);
 
 struct psci_operations {
+	u32 (*get_version)(void);
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
 	int (*cpu_off)(u32 state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
