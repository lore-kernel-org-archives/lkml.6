Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/qLHxSobbRlO8x178ngAyOrZhTpexnMdId4HeOlVBX2EpUSOsFRa0z0hKLrXYD+RMpANuy
ARC-Seal: i=1; a=rsa-sha256; t=1523399521; cv=none;
        d=google.com; s=arc-20160816;
        b=oFiqDfI67cp+9vdCSYHdJy8WZeBX5MVRRbhmgDP1PAzRnxMpazwITNEnBNl6z4s7+F
         5BHwjyDAJ32VvUGLmRtNfMU7rAHrYLaK/rX8P0/MDC5JFf0KWMgLgDSrSemesofAlnFM
         tdUtN7gV0+IbO1PqXgAxsZ8jkb2UgjvFVJY2TsM+3hsV603IBFxyCkpTPQm8LKsBd7Hi
         iCXMnk5TQrZh4Ck7k4+JD9Jf5XCr8Xith7lvlutdZR9zolxMUcwv/tJkAS76Aa4EKXXS
         ScItUfB9sx4VQrG7UT5sciqKQj66Nv9OSSvJCJn9JXwEf0ZN2ASig3Zsv+lsCPlUvrOQ
         E+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PkY8W+jRy2pZbvXheFNLb1XzPj9JuNkSrXrDIq1aViU=;
        b=LvustHvxMjMgJmSe8AwoFmaz5BsbWyao3wqtZ41jWLklXvkF8Wfji1hb0X5ejO6vL2
         CJUw/5WF2nkHNbXT6VWQRJzsTiIKCG+BENeoH0NVut6WJWM7Dx8OercxYJgbn+/g+nOa
         qDLhHSCWEu1a1SQBDS/BbONy2Y2MChyyV/isRN7vjl88iMo55qHdu22Lpj571TGvnxzU
         46z2Hg1WIwwyjCLd/Gh8IC+XgV9nUvkfVc9/+T844UB6v7CJ3HPv1ED2S7D8luV0aPhJ
         XZwe2CdmCZZSdSjJv0Bw5MZC9eqTspbI0RDuQB8mE2phT3fb7YP1JzCESUuLxvjJX0Fa
         0Xbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emanuel Czirai <xftroxgpx@protonmail.com>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ashok Raj <ashok.raj@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 4.15 120/168] x86/microcode: Fix CPU synchronization routine
Date: Wed, 11 Apr 2018 00:24:22 +0200
Message-Id: <20180410212805.671434030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400176287333962?=
X-GMAIL-MSGID: =?utf-8?q?1597400176287333962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit bb8c13d61a629276a162c1d2b1a20a815cbcfbb7 upstream.

Emanuel reported an issue with a hang during microcode update because my
dumb idea to use one atomic synchronization variable for both rendezvous
- before and after update - was simply bollocks:

  microcode: microcode_reload_late: late_cpus: 4
  microcode: __reload_late: cpu 2 entered
  microcode: __reload_late: cpu 1 entered
  microcode: __reload_late: cpu 3 entered
  microcode: __reload_late: cpu 0 entered
  microcode: __reload_late: cpu 1 left
  microcode: Timeout while waiting for CPUs rendezvous, remaining: 1

CPU1 above would finish, leave and the others will still spin waiting for
it to join.

So do two synchronization atomics instead, which makes the code a lot more
straightforward.

Also, since the update is serialized and it also takes quite some time per
microcode engine, increase the exit timeout by the number of CPUs on the
system.

That's ok because the moment all CPUs are done, that timeout will be cut
short.

Furthermore, panic when some of the CPUs timeout when returning from a
microcode update: we can't allow a system with not all cores updated.

Also, as an optimization, do not do the exit sync if microcode wasn't
updated.

Reported-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Emanuel Czirai <xftroxgpx@protonmail.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20180314183615.17629-2-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   68 +++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 27 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -517,7 +517,29 @@ static int check_online_cpus(void)
 	return -EINVAL;
 }
 
-static atomic_t late_cpus;
+static atomic_t late_cpus_in;
+static atomic_t late_cpus_out;
+
+static int __wait_for_cpus(atomic_t *t, long long timeout)
+{
+	int all_cpus = num_online_cpus();
+
+	atomic_inc(t);
+
+	while (atomic_read(t) < all_cpus) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				all_cpus - atomic_read(t));
+			return 1;
+		}
+
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+
+		touch_nmi_watchdog();
+	}
+	return 0;
+}
 
 /*
  * Returns:
@@ -527,30 +549,16 @@ static atomic_t late_cpus;
  */
 static int __reload_late(void *info)
 {
-	unsigned int timeout = NSEC_PER_SEC;
-	int all_cpus = num_online_cpus();
 	int cpu = smp_processor_id();
 	enum ucode_state err;
 	int ret = 0;
 
-	atomic_dec(&late_cpus);
-
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
 	 * */
-	while (atomic_read(&late_cpus)) {
-		if (timeout < SPINUNIT) {
-			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
-				atomic_read(&late_cpus));
-			return -1;
-		}
-
-		ndelay(SPINUNIT);
-		timeout -= SPINUNIT;
-
-		touch_nmi_watchdog();
-	}
+	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
+		return -1;
 
 	spin_lock(&update_lock);
 	apply_microcode_local(&err);
@@ -558,15 +566,22 @@ static int __reload_late(void *info)
 
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		ret = -1;
-	} else if (err == UCODE_UPDATED) {
+		return -1;
+	/* siblings return UCODE_OK because their engine got updated already */
+	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
+	} else {
+		return ret;
 	}
 
-	atomic_inc(&late_cpus);
-
-	while (atomic_read(&late_cpus) != all_cpus)
-		cpu_relax();
+	/*
+	 * Increase the wait timeout to a safe value here since we're
+	 * serializing the microcode update and that could take a while on a
+	 * large number of CPUs. And that is fine as the *actual* timeout will
+	 * be determined by the last CPU finished updating and thus cut short.
+	 */
+	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC * num_online_cpus()))
+		panic("Timeout during microcode update!\n");
 
 	return ret;
 }
@@ -579,12 +594,11 @@ static int microcode_reload_late(void)
 {
 	int ret;
 
-	atomic_set(&late_cpus, num_online_cpus());
+	atomic_set(&late_cpus_in,  0);
+	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret < 0)
-		return ret;
-	else if (ret > 0)
+	if (ret > 0)
 		microcode_check();
 
 	return ret;
