Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZozNXgjucwaq1UrrCQ4vSZ2I2d+kiYL5iM8G4vhytmDUrDovjA12tWbZw1xdpMXcF/js006
ARC-Seal: i=1; a=rsa-sha256; t=1526937248; cv=none;
        d=google.com; s=arc-20160816;
        b=FozvMo/ISrh/pc2t4soNUA1+EL20FZW8KchWs+C45Kro5JzIs4G8u6e8FuoxPZS/+t
         bUAWUjCY9GP4vHkAdmsWGF1IxVB+kQxqOutkDvgYj5MT+nLzODKXU0950fP3DBnWEmMY
         CKRMYkV/J/UXsoJXdZUKIVtEP7hJIOrzuoSELlGrpU0rbTSe0oI4qop/G0UqgVC1Zdu2
         t1Tv7soyzUdU2Tr7Ci502MkhU7MOvWWWEYNyAb+JF2yTBRGyYUeqB5cbjANBrMI9TMT5
         vlzUx7vRue5hVBYJFzcUBj6OQGZ61BKdJ4pgsIHX/Ufpv9g/0G4s8//NtUKgC4dtRHco
         gYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qzzHeMv0RpHgg3RurN4HaiO7FzqTyH8jlEewURgujNU=;
        b=K1M+lGKMvmrxIPL/7uWhwnq0dgl8SsbwIbMz/673qhfBKtwNMtuzUDNClv6TuNlnbl
         yaX24Xt+86n551v3UsznLa6mWoUU26P1DYsoz/ajzhrd3EnSGJ2lpfB2vffnuNzwu8EL
         qAowcL6C07XHPXdfmc6PcvH7ety11Ac0/DRhepAJ580IYWSPFwaklJMTWhnN90cjZsCf
         ns5MjEezFvItXl1T4aVX5TcbOXaphPrkiEjeRgAJVyeXko2y8TRtS+ABSoPDWFRgVADN
         zMwBx/VpO9qJwI1uRjKqibnWkQotosmO8y/TscOXeA6m9gzKvbWe5+KxExL8Ijah79Mu
         yJuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=STah/RUm;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=STah/RUm;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 4.9 13/87] powerpc: Dont preempt_disable() in show_cpuinfo()
Date: Mon, 21 May 2018 23:10:49 +0200
Message-Id: <20180521210421.462653316@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109752390685238?=
X-GMAIL-MSGID: =?utf-8?q?1601109752390685238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 349524bc0da698ec77f2057cf4a4948eb6349265 upstream.

This causes warnings from cpufreq mutex code. This is also rather
unnecessary and ineffective. If we really want to prevent concurrent
unplug, we could take the unplug read lock but I don't see this being
critical.

Fixes: cd77b5ce208c ("powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo")
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/setup-common.c |   11 -----------
 1 file changed, 11 deletions(-)

--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -228,14 +228,6 @@ static int show_cpuinfo(struct seq_file
 	unsigned short maj;
 	unsigned short min;
 
-	/* We only show online cpus: disable preempt (overzealous, I
-	 * knew) to prevent cpu going down. */
-	preempt_disable();
-	if (!cpu_online(cpu_id)) {
-		preempt_enable();
-		return 0;
-	}
-
 #ifdef CONFIG_SMP
 	pvr = per_cpu(cpu_pvr, cpu_id);
 #else
@@ -340,9 +332,6 @@ static int show_cpuinfo(struct seq_file
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
 #endif
-
-	preempt_enable();
-
 	/* If this is the last cpu, print the summary */
 	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
 		show_cpuinfo_summary(m);
