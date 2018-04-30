Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr3OkOrL6yab741zLXRiNgbPaf1D30YTGRlMpAViOP6R+u77BaNuRQfpPi8RZCXkbZ+BcWn
ARC-Seal: i=1; a=rsa-sha256; t=1525116536; cv=none;
        d=google.com; s=arc-20160816;
        b=W39HPsUdyrJAkVF6/N6IU6GqI7zfkcrw5SCJLhP2uQRaAfjUzsGx6wWeLLvNakEWZM
         DOq5PVpovHqQSF9nUm85Ko/KjQ7bFXblhaHoycnN/7FDytu68ozpRubCkXkJaXdShMjE
         6TTtb4SY3rEQRlKOboYE41UmPXoPP//7efUd4WBaSG94p0YFkd4y5yicd9+KhPJ1/jG4
         LI3NmRee0UZAPmzjACDXgbBFu1H7sTMjX8pjczbk3qLikwiTIgxNBAjUluezo+MbhA5p
         13sdYBvnb+4xAjqoCje+h5opV5mP60upqJsEZjCdb5OURjIj4058oQHAl3S9JdyLzZgi
         OxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4zQ7Gpvh9pBx+jFkm43dcP2Ggl8OFrzc6xB0MEwX7CI=;
        b=JovEnyHrPxeNpLFMNpYaJJeSRy0SUZ4RE191suwtL/76up87ZmHIGY7+MDz0ZjqARF
         CB10HmYwY0aP7ejf32NML1N1tJOcMRKpR1+vD6PY6BAADJDqO1G2rEJJAXcC1nI08c9R
         rDeqJemOHB3H411Kl5YFsYItwstwFPqtvbmXpfhbwqCDiXoHCPtDwb+I5M5NU5QXmEpG
         p2GtcJ7CweBMwb7hm/roKvOAvEftIbehgmJkkGbAXF4l60HsbFvAQVrEMlova+a1dTVX
         ba9RBCSGhkpobi0K/SWn4wD5sNlRePi77FZB/Zwm0T4UApcBWU/kd/IrwuWD9dOaP7Wr
         pCKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C46235E5
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
Subject: [PATCH 4.16 110/113] x86/microcode: Do not exit early from __reload_late()
Date: Mon, 30 Apr 2018 12:25:21 -0700
Message-Id: <20180430184019.843643264@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200597625375020?=
X-GMAIL-MSGID: =?utf-8?q?1599200597625375020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 09e182d17e8891dd73baba961a0f5a82e9274c97 upstream.

Vitezslav reported a case where the

  "Timeout during microcode update!"

panic would hit. After a deeper look, it turned out that his .config had
CONFIG_HOTPLUG_CPU disabled which practically made save_mc_for_early() a
no-op.

When that happened, the discovered microcode patch wasn't saved into the
cache and the late loading path wouldn't find any.

This, then, lead to early exit from __reload_late() and thus CPUs waiting
until the timeout is reached, leading to the panic.

In hindsight, that function should have been written so it does not return
before the post-synchronization. Oh well, I know better now...

Fixes: bb8c13d61a62 ("x86/microcode: Fix CPU synchronization routine")
Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vitezslav Samel <vitezslav@samel.cz>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
Link: https://lkml.kernel.org/r/20180421081930.15741-2-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -564,14 +564,12 @@ static int __reload_late(void *info)
 	apply_microcode_local(&err);
 	spin_unlock(&update_lock);
 
+	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		return -1;
-	/* siblings return UCODE_OK because their engine got updated already */
+		ret = -1;
 	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
-	} else {
-		return ret;
 	}
 
 	/*
