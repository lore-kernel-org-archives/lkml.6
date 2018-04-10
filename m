Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rm/KZJ/CwnJMIlnl9dNRXTBRZffjAIwwl6Q9Bh56Jv/qW2jPc1W6B9K5w1YppXp+TCzQF
ARC-Seal: i=1; a=rsa-sha256; t=1523399513; cv=none;
        d=google.com; s=arc-20160816;
        b=ze0EKSqQvVNNlOSnkE74YhwQwBrvZ3waDHX+uczsP8VK3zDGZAa7xo69guFHG9Pqxp
         yTQpmC4fuzB2v/Xx3JA+n7syAFCa+ZL6MRKaj8PNvRcqYgNsBeCmYjg+xKfwIB1ybktR
         JyhvS++dsswjoVt76pxN+Y+1Sy30maWqPcIAN+ozWjnRjLxXRMLn3Bb9PmJqR9lSMQ8E
         cVx3Mw2Nc4BpwLaWOAiEYwWUPXefHEZSqiO2ql+2a8JNUedhKBdQjLLFRXJtPE2YwpQU
         rTGGSmacF9Kn2AppN59CiznQa6s4S5XsLXqwz3/XfpO1KRKDQekpg2/kSURFb1dndioY
         +ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qm37D2WnSLtTLp1HNU9LgtncwGt2P/smL95K8StWTzg=;
        b=kdCiYIK1irNr/SLHcv+s3/XZjNmaGC6c4j7jHmG0LeNYeJFA6W3dVoi2UL2maouEe4
         jdSpgFy5uaQCfofWex2Yk2MZSK8Qu9eg6xZE/3jFifd3VHSpLi64u83yl21KoVv6XfFX
         OnSwzoNrJyWfMDhnFOquk7i/coExhJ59IUdQ3DosDC/F6Z4hS5sTOkLvh8Guc9rjsNiA
         GnUvrcxeWfgDmxJZZTaqiStyhxtSO5J8TElhUWLTZpLSfnSfLrqwIXRFt5Xi2d3EOkC0
         NVY1oEP0G7X4LZ9UDqnxg2mfZzQDFxjIrlskoE6whpl85CMlL2Z8aXyao6vNbD/MoHw6
         3sCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 4.15 117/168] x86/microcode: Request microcode on the BSP
Date: Wed, 11 Apr 2018 00:24:19 +0200
Message-Id: <20180410212805.503854342@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400168193282695?=
X-GMAIL-MSGID: =?utf-8?q?1597400168193282695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit cfb52a5a09c8ae3a1dafb44ce549fde5b69e8117 upstream.

... so that any newer version can land in the cache and can later be
fished out by the application functions. Do that before grabbing the
hotplug lock.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: https://lkml.kernel.org/r/20180228102846.13447-7-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -499,15 +499,10 @@ static int check_online_cpus(void)
 static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	enum ucode_state ustate;
 
 	if (!uci->valid)
 		return UCODE_OK;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
-	if (ustate != UCODE_OK)
-		return ustate;
-
 	return apply_microcode_on_target(cpu);
 }
 
@@ -515,11 +510,11 @@ static ssize_t reload_store(struct devic
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
+	int cpu, bsp = boot_cpu_data.cpu_index;
 	enum ucode_state tmp_ret = UCODE_OK;
 	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
-	int cpu;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -528,6 +523,10 @@ static ssize_t reload_store(struct devic
 	if (val != 1)
 		return size;
 
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	if (tmp_ret != UCODE_OK)
+		return size;
+
 	get_online_cpus();
 
 	ret = check_online_cpus();
