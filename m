Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq5llDLCsWU6nmIeFteeLEVu/+I1xRlcRYVhT2PNrsxNvmrfX7gN68TvK5uuRvB+Ih4yknP
ARC-Seal: i=1; a=rsa-sha256; t=1525116463; cv=none;
        d=google.com; s=arc-20160816;
        b=anPEvp8d5qbtU3jgSG3ZP4riDP5y+cmvFtF7R6rg/0zJLOyRb5ARQjS1g+J1H1qKFm
         a1wt0Jsn3mXbt3mOHUE8+5xa3Wv2t3wa/n0S1e8aSfKhd8DWHQGf3CydxfAgBspHmXfu
         uIi6ihjlcrASrVRYwLqt9q1kXzVLVxCM45+XNhVRa5wpC0RbOe47y//7BRs4WwsXkXI6
         dhaE2iP4aZ7/LBKBtUBePdluZ0VsDBwoADUoPZLZxESsxe5e83zGpp2uaPY/a9oVNYUH
         laV+kQSfAWlR8znJKa3OiTgNPn9JEcHv8Rx9GZrZZRM7DOpL9VIOrq9Q9ET48eTTFW3q
         GEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=rf7qpNDg/j0fN97wxVSMA9Fl2LKzZRZImIkQOSl+opU=;
        b=aBuXaRhk+CRrs8TOrULhEj/w3YsKtKWiKok5IcPnBt/YVpc4zerI1Wxav7W4jIpwDU
         cBULB0YXYRoN1wKv9L1eKtgqeWdNMPVWBIIp0DlmB/TCfLCLYzJr9BJ8WdjHos2WUkNX
         9dsW8q6JcLPjaSsAE9sn4MPXo5SjM1vOeCcFUJbgAIk//DHZr2YcKFwSSyhZK8dOe1lS
         7ywUhDyy0n9n6Vh/pNHi7KnDKN9T1hX3QnoQvLRvZHmjBvTOvXNFkReVFBmHprjeB11j
         7tmu8OmP4UYRncJvOcNevl/Aghf2Q6DIsvzqh9+iwjS5/psqyNOm/1+6WdHRc9MDXtWA
         x32A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7706122E02
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
Subject: [PATCH 4.14 86/91] x86/microcode/intel: Save microcode patch unconditionally
Date: Mon, 30 Apr 2018 12:25:08 -0700
Message-Id: <20180430184008.779505767@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200597007916325?=
X-GMAIL-MSGID: =?utf-8?q?1599200521330244351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -485,7 +485,6 @@ static void show_saved_mc(void)
  */
 static void save_mc_for_early(u8 *mc, unsigned int size)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
@@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, un
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
-#endif
 }
 
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
