Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/iFDIHXXEb9p+hRkApnItmsYrrsuyqh23yBCWDxWp/JeVIQesA/3pl4lGu2K29IgjBX+KE
ARC-Seal: i=1; a=rsa-sha256; t=1523399914; cv=none;
        d=google.com; s=arc-20160816;
        b=piTk0YV+fCsTh5AmqtUlOJABkCf0/pnvOWX42REx1kmSdasqLc0c+j6eAdgBYtrk2u
         xSRGw2cTBFlY5SxuY5EcX8IEPS3OpvTsDaOVhA1xwAqZKM4VhHq+zvdqyPQ99AJNpbpR
         6TrSNao0b437JdEs7THRIT2tCC5n0mUG4oEi7pPziOn6ckOKSjZpsdVu+d7uunutXSvN
         zfkzyE9vj6VMbKlpVnhUSvHUnoVho1O0RCQ9Nby6zqDTGWeT8LCEh74s0aeWbnQCtIBv
         xkLLHKJSAvXrWYs/SnbM8O1CO7MLd0RJFo9iMGZxO2BXkmCwE9TN3uksJUrfy9sLh7/x
         Lepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cMPCguNW1ekNPpHgLXfdFRwyu8bLDN/NWXpOz8b23h4=;
        b=TxNopymoMHHBZDf5pmHAWqnXTlXkYUYDlhrqA+w0UTPSBYgEK21PTtbOv1h5ow8mmO
         dEvjWC1na/Bcr4ZxLlxJ6tGNr64i9j0KZf+IgxzRMFzgSPM/xKi83DGTUUeymH87OjA5
         8loSyqW7VlfLfiuG1iCn0RlfsKhgEBZRtQWwVf7VVTlTGtqXguWN84zdUiomzzD3dwje
         j7Xdx7l/ixe+b/vE8JAjNeit2PQ6mZgK20JFHXOerhC2BoARyLwqJDTzmUKOhOFTl8Qa
         JlTJshqwBrSFWZWqHNpeY9arKTbL8LIVbvtVglTPsIDbRsKWbnJSduAn689GXmKm6hN2
         yGpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 4.14 091/138] x86/microcode: Do not upload microcode if CPUs are offline
Date: Wed, 11 Apr 2018 00:24:41 +0200
Message-Id: <20180410212912.759185934@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400161395758639?=
X-GMAIL-MSGID: =?utf-8?q?1597400588810382434?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashok Raj <ashok.raj@intel.com>

commit 30ec26da9967d0d785abc24073129a34c3211777 upstream.

Avoid loading microcode if any of the CPUs are offline, and issue a
warning. Having different microcode revisions on the system at any time
is outright dangerous.

[ Borislav: Massage changelog. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-4-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-5-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -486,6 +486,16 @@ static void __exit microcode_dev_exit(vo
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
+static int check_online_cpus(void)
+{
+	if (num_online_cpus() == num_present_cpus())
+		return 0;
+
+	pr_err("Not all CPUs online, aborting microcode update.\n");
+
+	return -EINVAL;
+}
+
 static enum ucode_state reload_for_cpu(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
@@ -519,7 +529,13 @@ static ssize_t reload_store(struct devic
 		return size;
 
 	get_online_cpus();
+
+	ret = check_online_cpus();
+	if (ret)
+		goto put;
+
 	mutex_lock(&microcode_mutex);
+
 	for_each_online_cpu(cpu) {
 		tmp_ret = reload_for_cpu(cpu);
 		if (tmp_ret > UCODE_NFOUND) {
@@ -538,6 +554,8 @@ static ssize_t reload_store(struct devic
 		microcode_check();
 
 	mutex_unlock(&microcode_mutex);
+
+put:
 	put_online_cpus();
 
 	if (!ret)
