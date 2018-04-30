Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqU+Pf4UxF+OrVsHTAIj/wGos10vJLcJnTFOrEYyZuHkXe7kgmhvIFgIBWR6uZf5u/EowAT
ARC-Seal: i=1; a=rsa-sha256; t=1525116408; cv=none;
        d=google.com; s=arc-20160816;
        b=1Igzp/z83+11TLi0j3lKe2RVaCqyoN9LIzcNfE/sOf4nHUU5ayWgIKUxAFunNzRwQ4
         H10E6eEgGV8RqaNsFD0QT3pgvTbxQ9FhPIkJ/pj/vLA5R3jjsOoGSEKPV4FP/6Y6D2Kj
         QSAC7HhKSPozxbt2sF4SfweZMHrNrqkT6rzV0dJtiWns8iweEj44pklgax2ulKhntTxA
         UXczuN/SCbb/gB6G3eJt9+OLiOHNIjbqOxXvYAFCUm7nwRo/cp6mWojn5OPTVUDkFh8N
         lqRQgbEI3a5v4Pi9Qf2s2GyrNsavVEjc/L1dBaTzR1HCYUyXUjzmh1HEGKbJDP+JmyAF
         3rfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=51eZmsvATuoyjpw0adnjoJEneWguze2HdlEJjo8xvjk=;
        b=DNYG6pGT0kOHBsKTM2JmpuvkgpSCic+1hqScCZ8QTOC2ZX8YvS/03MVUGCYJOYgOY6
         G0L3iGYzY0zj9BX98M81gI1+/7kqO5Hrx7mXgNF0jBHDr0t/3KilgjcA+4Gd56Te7X/q
         V+JxEgsPu2/kUAXGnnN7HLfWwNuAHh4xswwJKIe+byPjl50KxFCnBCLq8dbtNL1iEBRF
         1IqVRdMMbJcMeGAZ/HQmXq+M72BGVjdRhl3fB9N5U5aC6YQKSDwLLRZUQTYQa5AYLBJx
         gHP0G8eXG7SVC6K02jEZBsEdXBNtFZOZ9NVEs+snylOpX7LKI621/oL19Zj1yQ+0rbZz
         8oiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF79522DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vitezslav Samel <vitezslav@samel.cz>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 4.9 60/61] x86/microcode/intel: Save microcode patch unconditionally
Date: Mon, 30 Apr 2018 12:25:03 -0700
Message-Id: <20180430183956.327516089@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200597007916325?=
X-GMAIL-MSGID: =?utf-8?q?1599200463115385547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 84749d83758af6576552046b215b9b7f37f9556b upstream.

save_mc_for_early() was a no-op on !CONFIG_HOTPLUG_CPU but the
generic_load_microcode() path saves the microcode patches it has found into
the cache of patches which is used for late loading too. Regardless of
whether CPU hotplug is used or not.

Make the saving unconditional so that late loading can find the proper
patch.

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
Link: https://lkml.kernel.org/r/20180421081930.15741-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/intel.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -474,7 +474,6 @@ static void show_saved_mc(void)
  */
 static void save_mc_for_early(u8 *mc)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
@@ -521,7 +520,6 @@ static void save_mc_for_early(u8 *mc)
 
 out:
 	mutex_unlock(&x86_cpu_microcode_mutex);
-#endif
 }
 
 static bool __init load_builtin_intel_microcode(struct cpio_data *cp)
