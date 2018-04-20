Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx48c6UjBNUg18eW5mYxSBGQbicxhNNlueQD0QnkaEOjxLb/hgYGulEfySmyGBIBShDZsYFs3
ARC-Seal: i=1; a=rsa-sha256; t=1524220632; cv=none;
        d=google.com; s=arc-20160816;
        b=Rurnxm5WheepXCGtrrwqENxSUj3vFNNFEUhgnKx433j4nKcR+QuXPFxhklCUM2H6+C
         Z2qYi+jmM3f/tt4hgejGtNXVoCHF1vgn9IgODB+ORQzB8LSsY/dzh9p5HRdvHiX5U2Vs
         chG/rlw/9XbgF5CMcqeRdQ2h3WLNrvRQfxwM4jRHXQFPaoKX2ZfViP3drrZl3zBxzPDi
         TMEMUfATi9zY1+plgNJm/FKrWr15JHqG1SlQX5uImPVNHr19o0O0PbRDZX7NiFi08qtA
         TCctJExBe3M7TYHDZaE4WvAWX/gPKmlt723an6ayNfmzLgWKUVPW1NTtp4PLQH5bQHvu
         7iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=uVPH4+lYR2umKpWCLNQJ3hySNnXFciHJ5UnposFjOWs=;
        b=hwWrV/uRHDMT4kLn7/Iw9EFVRILcAFsd+/ZVeorI0hMVJUMWQ84rQ0SgGnoEg/XfnX
         hN3FsB0Wxz0HAYK/ug4nng67hRnPvJPk1N3i68gN0tofSFI0DvQ1CmGWrX6Ca6Bw088J
         2E/AbVb2uJ+x0bzcqlorR5In2hWbrxBOiw9RL/JGV42+uSIowZ8huU+DouEnMjbhzQp9
         wpd03SklJcTxtGQXze8pcql/ANKy90VVqelosIFRM2PscDArGVM8mnQrrJXHwN+IJe3K
         9HCTTJnlblndt6RWygydBLzYKD1L0TOPOWoAiZsqWQASZvkam1XqmgFy32zbj+n6wlv+
         Uyog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Fri, 20 Apr 2018 12:37:08 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>,
	"Raj, Ashok" <ashok.raj@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: [PATCH 2/2] x86/microcode: Do not exit early from __reload_late()
Message-ID: <20180420103708.GE13977@pd.tnic>
References: <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
 <20180420095220.GA13977@pd.tnic>
 <20180420100131.GA14217@pc11.op.pod.cz>
 <20180420103242.GB13977@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420103242.GB13977@pd.tnic>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598261173668216348?=
X-GMAIL-MSGID: =?utf-8?q?1598261173668216348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Vitezslav reported a case where the

  "Timeout during microcode update!"

panic would hit. After a deeper look, it turned out that his .config had
CONFIG_HOTPLUG_CPU disabled which practically made save_mc_for_early() a
no-op.

When that happened, the discovered microcode patch wasn't saved into our
cache and the late loading path wouldn't find any.

This, then, lead to early exit from __reload_late() and thus CPUs
waiting until the timeout is reached, leading to the panic.

In hindsight, I should've made that function not return before the
post-synchronization. Oh well, I know better now...

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: <stable@vger.kernel.org>
Fixes: bb8c13d61a62 ("x86/microcode: Fix CPU synchronization routine")
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
---
 arch/x86/kernel/cpu/microcode/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 10c4fc2c91f8..77e201301528 100644
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
-- 
2.13.0

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
