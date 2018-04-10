Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48YcimKKsK48D63HduAI9Dy6Usk0PYRtBmklnj3++zutzAEVDoLiICs0Si3ZuuV+O6tQWsW
ARC-Seal: i=1; a=rsa-sha256; t=1523399919; cv=none;
        d=google.com; s=arc-20160816;
        b=zKwL9J+mttS8Ysr0Fslp2yWG1/ieB4d1yx/1PX6M58r5Xx0sITA0Byab47GE5oXVfT
         TA5A63z0wM3umLGQcRJ8qGkwfuS55aald1pZZDHlljrPtqa7mAHyxKAdaShayIzZC/f0
         Fx4F0IarJLHhhGHno6PL+hCEJNfKp4d42W3r941bmoBfl+II1s/D6v8R5eMvns6/U2rD
         0WzwTSwtA7tO4XzWRi++0C6xzOHc1c4XMejMcTsgWnGyHsVZwtLLz8DgfyDwlT0ErIjy
         uRweV8Kf3Vk+zirh7OPqBO0rpG07kWFs34teRn6lChf9anKq1KCZnGE9S85g90+rAh59
         1bJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WrIppQyD2xKIFLR0yx6eSDzRhU3soszZQXfUsN/1WCk=;
        b=Ss0e9N/PfkDvo5+/CAC7wjRmgkfGqcnzxP8qlnN6EvUGF/8AOCqW4M2yNB9f1lXVbE
         RSjIIWKp0PWK2lgHOUrX814vGS3yGrmb5GUyy7RhpnqchVkYDzOYy3/od5rmMwHyYilz
         oLUYBRbxLxDOAr9am4mrbUqRMIPVwwt9pfBVtAUXW7zPuS7SgXQUvEJbgUJBILaiNeRZ
         PsnYYcflQjsLiw/F+o2TIqyTwjajVenJxEJHLKjw5uVzBHg9nb9njxVRUoYyW/DL+WFH
         24WHRJ9wPQVDD3RgnHVH+333BIilG/7jOIKO22NfZdWpBDlQLftC1r9bNsFhFZizbODb
         CGPQ==
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
Subject: [PATCH 4.14 093/138] x86/microcode: Request microcode on the BSP
Date: Wed, 11 Apr 2018 00:24:43 +0200
Message-Id: <20180410212913.001412711@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400168193282695?=
X-GMAIL-MSGID: =?utf-8?q?1597400594228460414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
