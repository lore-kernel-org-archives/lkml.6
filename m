Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoq7c4fPuJ6vdNWIJKgWFIgX3cXC3XsiI6Cuk0WmwfvGHp4LjxyqbypYwIM58VgxPsYBujV
ARC-Seal: i=1; a=rsa-sha256; t=1525116464; cv=none;
        d=google.com; s=arc-20160816;
        b=axNCZuvVJCp280Yn+3fmo2pd4OKZfIIgC8obcwXDDhPlkrHoJEH68CXgZw9LyAUxbm
         3Er9W8jBF8tIk3JICYxgwPS7+XrXq+iGrIjPeoO4ICLEJ0QtIsMGShf9Yx/Nf66nmr/Y
         8jrKo4saj93LCxRIQETkcmkvCmQfEZjB7zwv7k3F0y9HMP5GyiN39QVhQK3ppgBG3VoK
         cwR8GpbBD3zjhPYfsfrYGQBUDDMA8GvOL8LWFeDE7YTjiEnBe4/RIuonHKB8Vv0fFEh7
         RarqNG/2b3p7Thp2ABNQBrzso1ryMAQ1Y9cELSLnbcDIrFRS/mKkn3SyPLpH+mCv4ufq
         E//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=28MZFdm1qA+j6Wpqwy7nzJCtLrXPN7Ec1gD+eoQGmoY=;
        b=Dv04ybklQDs4MhWf8WqkrXUwsTCP+7jwnODpT9ruesvkCHoo7Tq5nHN2KXPi6jvs09
         Ds2P0EMCjUGZ0Ddm4VnhxoOFo7Iw1kyE89FS7eMnolott/QaM0pHIvSXfHgbmAeo53BF
         TY8W8Ld5BXx00vt0HU6RvbOtSCfF4TSc8ecslyoPLiiOzSl8wsxciKCOWl4C61wF73aQ
         zdFKBis9llQ0Qc23B7Q5MJX5EW7PVSj37634HBndR9HD3Y7diJXmFrNFFFFRWBCV/vOU
         DNIYa3UkaEmf3+5z/KLa+mlDPzEHltvNmbmo8/WaTHZMEi1BRjQfe6ToA4ACBNkMUiak
         25Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256C322E01
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
Subject: [PATCH 4.14 87/91] x86/microcode: Do not exit early from __reload_late()
Date: Mon, 30 Apr 2018 12:25:09 -0700
Message-Id: <20180430184008.830295165@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200597625375020?=
X-GMAIL-MSGID: =?utf-8?q?1599200522518138144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
