Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsujXZAu6ZK4r3b4FuOzJbhXW2lFfPRAd8DYrBezEHsaO0P3BulfPMmdOtPCHE+wd4ta0Yr
ARC-Seal: i=1; a=rsa-sha256; t=1521800295; cv=none;
        d=google.com; s=arc-20160816;
        b=vBcleIy6pI75Ch7gATQ+F3fo59RrrPiLqwX5Iw6BjKCnVoxHj40PwNnL2hy4cbW79W
         0l7CRS7Xq/uaGC08RVCya6ADMsP+D/9XJ6xqzFOLbPXRY3MnoxI7YLwYtCkaXL50cH+p
         Ipk29CfaslsT/ae34x1ywfhnAyy/rkYvjN3nfrJbdUVTwkyWBd3jm1zUJAoq2GtdIeeF
         a5XsxGJBAeTGoK8nVgyItXVVRH9f2peDXHpQwgpaKpuBGQNOuDrTrmqqZ5KXuKkZW8pP
         wZlS477ERGKCmZ2u18hqGLBaVrrP8lpIt3w+ykdGkQGOsAv1eRjdXPlMs8Pas3OfRtyU
         2DAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aqrJQMr12s/5aApJs+W1ugPgTLhNnHIdrH5OsLHqPwE=;
        b=VoAJT0wTRVErxuoZX+sM9QeJGea7aBjG21mwusicMEmvqcEWxLapIY5un3zWl6alWr
         I/GNCkNlcX7kfiW1Ki3sSEMlPicbO4JWGfteapaQcJapTV65c2YrQ7Kvyt0DOnXGhg1E
         CzSd7zakSgvQgLXIsihyTdXL3zyzwlpr+fAkHKf/jNx59m7EPby288tXOMgdrqWIVJt+
         t3yqNbpJXlQDlGiaH8PieJlkNR2XWA9P8WxFhEuSpVy2lHd6rIogO9S9D3VQiaE15Cng
         Vv3Owt1xxtRD1RItCwI+kb55yKHZK+tIu/n12hU/1P6WKJ68tEazenhNX9e34lke3MdJ
         y1ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-acpi@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Tejun Heo <tj@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Len Brown <lenb@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 04/47] ACPI/processor: Replace racy task affinity logic
Date: Fri, 23 Mar 2018 10:54:55 +0100
Message-Id: <20180323094248.309975152@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722442451561427?=
X-GMAIL-MSGID: =?utf-8?q?1595723266691620537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>


[ Upstream commit 8153f9ac43897f9f4786b30badc134fcc1a4fb11 ]

acpi_processor_get_throttling() requires to invoke the getter function on
the target CPU. This is achieved by temporarily setting the affinity of the
calling user space thread to the requested CPU and reset it to the original
affinity afterwards.

That's racy vs. CPU hotplug and concurrent affinity settings for that
thread resulting in code executing on the wrong CPU and overwriting the
new affinity setting.

acpi_processor_get_throttling() is invoked in two ways:

1) The CPU online callback, which is already running on the target CPU and
   obviously protected against hotplug and not affected by affinity
   settings.

2) The ACPI driver probe function, which is not protected against hotplug
   during modprobe.

Switch it over to work_on_cpu() and protect the probe function against CPU
hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-acpi@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.785920903@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_driver.c     |    7 +++-
 drivers/acpi/processor_throttling.c |   62 ++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 27 deletions(-)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -231,11 +231,16 @@ static int __acpi_processor_start(struct
 static int acpi_processor_start(struct device *dev)
 {
 	struct acpi_device *device = ACPI_COMPANION(dev);
+	int ret;
 
 	if (!device)
 		return -ENODEV;
 
-	return __acpi_processor_start(device);
+	/* Protect against concurrent CPU hotplug operations */
+	get_online_cpus();
+	ret = __acpi_processor_start(device);
+	put_online_cpus();
+	return ret;
 }
 
 static int acpi_processor_stop(struct device *dev)
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -66,8 +66,8 @@ struct acpi_processor_throttling_arg {
 #define THROTTLING_POSTCHANGE      (2)
 
 static int acpi_processor_get_throttling(struct acpi_processor *pr);
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force);
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct);
 
 static int acpi_processor_update_tsd_coord(void)
 {
@@ -886,7 +886,8 @@ static int acpi_processor_get_throttling
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"Invalid throttling state, reset\n"));
 			state = 0;
-			ret = acpi_processor_set_throttling(pr, state, true);
+			ret = __acpi_processor_set_throttling(pr, state, true,
+							      true);
 			if (ret)
 				return ret;
 		}
@@ -896,36 +897,31 @@ static int acpi_processor_get_throttling
 	return 0;
 }
 
-static int acpi_processor_get_throttling(struct acpi_processor *pr)
+static long __acpi_processor_get_throttling(void *data)
 {
-	cpumask_var_t saved_mask;
-	int ret;
+	struct acpi_processor *pr = data;
+
+	return pr->throttling.acpi_processor_get_throttling(pr);
+}
 
+static int acpi_processor_get_throttling(struct acpi_processor *pr)
+{
 	if (!pr)
 		return -EINVAL;
 
 	if (!pr->flags.throttling)
 		return -ENODEV;
 
-	if (!alloc_cpumask_var(&saved_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	/*
-	 * Migrate task to the cpu pointed by pr.
+	 * This is either called from the CPU hotplug callback of
+	 * processor_driver or via the ACPI probe function. In the latter
+	 * case the CPU is not guaranteed to be online. Both call sites are
+	 * protected against CPU hotplug.
 	 */
-	cpumask_copy(saved_mask, &current->cpus_allowed);
-	/* FIXME: use work_on_cpu() */
-	if (set_cpus_allowed_ptr(current, cpumask_of(pr->id))) {
-		/* Can't migrate to the target pr->id CPU. Exit */
-		free_cpumask_var(saved_mask);
+	if (!cpu_online(pr->id))
 		return -ENODEV;
-	}
-	ret = pr->throttling.acpi_processor_get_throttling(pr);
-	/* restore the previous state */
-	set_cpus_allowed_ptr(current, saved_mask);
-	free_cpumask_var(saved_mask);
 
-	return ret;
+	return work_on_cpu(pr->id, __acpi_processor_get_throttling, pr);
 }
 
 static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
@@ -1075,8 +1071,15 @@ static long acpi_processor_throttling_fn
 			arg->target_state, arg->force);
 }
 
-int acpi_processor_set_throttling(struct acpi_processor *pr,
-						int state, bool force)
+static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct)
+{
+	if (direct)
+		return fn(arg);
+	return work_on_cpu(cpu, fn, arg);
+}
+
+static int __acpi_processor_set_throttling(struct acpi_processor *pr,
+					   int state, bool force, bool direct)
 {
 	int ret = 0;
 	unsigned int i;
@@ -1125,7 +1128,8 @@ int acpi_processor_set_throttling(struct
 		arg.pr = pr;
 		arg.target_state = state;
 		arg.force = force;
-		ret = work_on_cpu(pr->id, acpi_processor_throttling_fn, &arg);
+		ret = call_on_cpu(pr->id, acpi_processor_throttling_fn, &arg,
+				  direct);
 	} else {
 		/*
 		 * When the T-state coordination is SW_ALL or HW_ALL,
@@ -1158,8 +1162,8 @@ int acpi_processor_set_throttling(struct
 			arg.pr = match_pr;
 			arg.target_state = state;
 			arg.force = force;
-			ret = work_on_cpu(pr->id, acpi_processor_throttling_fn,
-				&arg);
+			ret = call_on_cpu(pr->id, acpi_processor_throttling_fn,
+					  &arg, direct);
 		}
 	}
 	/*
@@ -1177,6 +1181,12 @@ int acpi_processor_set_throttling(struct
 	return ret;
 }
 
+int acpi_processor_set_throttling(struct acpi_processor *pr, int state,
+				  bool force)
+{
+	return __acpi_processor_set_throttling(pr, state, force, false);
+}
+
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
