Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+WwtZLbRSHLL6uCVJdm3ys8OWSW/TYus9k2pbB+zTF/l0aCyShBgUQ9JdGGNuttnsMRjKp
ARC-Seal: i=1; a=rsa-sha256; t=1523399507; cv=none;
        d=google.com; s=arc-20160816;
        b=QtjNbyIuh268pAai90J1fee59QuvQtYqHrgGlqXnH6A4UO2/7i40R4Zamx3RLyQlJW
         6+KixNnLt1dLSeTQ35qKkqF+BI3KiG2JNEriHTDiakxk+dRfOUPSA/P1pZkYYnnGvMHd
         Lf+yKSiwhKEmy7brfX8PUBJBWgk0WwGpgVCtNkndcNGatFFHC/ENTgmfTj1qspoIWa5/
         XtqQxoQt4/Lyqve0t3hoHjXpJbiItQzwaOeCJ4v99/FOReSXFbxOYo2rhU0CNGboPUal
         ntoPU8wG4aZ5zgVZYYqbNdQIS9QjvA2Aa5hYuspCSj0iyFO2wXNev25rgz9JncAGp/Q8
         GmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SUII8IWb0zhavL97uyfTXbnKwk2ffEezTCLesvTEC3o=;
        b=TBjjUXDqacbR7DsjECslXl2JzLV4UhA5WHZN9x507/GR69zlZU6g0cOQUm2ECkOW/t
         cyO2/98DorDB5FnqrWqL7zottNwc8dHq80aJDhsmMecxjqhxQsqP4twORe+YNsj+OVm2
         BKGZcliAU7pWtPdxbnmTDAOPmSLbWTn+0d3emrx3lI+4/nOHPg2/tyLHApJvhz+EnoaJ
         goDvr2kS5isn/5BvKlNFvC5C0N/rerF+APh9SxBzmN/+1rPerMjbGcwbPZQMBA2INqeg
         MJ667P/OzGXkR83e4fhY1DiGAxYFjJZWzrnemq3lJaGeccTt9SxZAoM/ogJRkt1yOUzJ
         RKtQ==
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
Subject: [PATCH 4.15 115/168] x86/microcode: Do not upload microcode if CPUs are offline
Date: Wed, 11 Apr 2018 00:24:17 +0200
Message-Id: <20180410212805.319101844@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400161395758639?=
X-GMAIL-MSGID: =?utf-8?q?1597400161395758639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
