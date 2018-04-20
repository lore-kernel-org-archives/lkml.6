Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx4+a48N+nrUpZTTf0wND32XtSRjyvHalDull1qX2h2L9Mgt4KIzKXBvUQVlPUx/paH/3hkGB
ARC-Seal: i=1; a=rsa-sha256; t=1524220471; cv=none;
        d=google.com; s=arc-20160816;
        b=kC++C7up9H9RozhPk+tTEUHeaEjn34PKH+dBwPtOPOcvAFG4nNaX+6qroVqrxIX75m
         +VpF48L887oSGiUF8vWMvlCaSnYy5TB+4qPCMaby1U7qiSnLmAo7V+rnbLRCqMNvxd+l
         ScSYMl5BUSKsnL1SBa5LnLS/yoqImir2BhASRRc9CXmd16KmYPL/tqL4A1LBICJPhKp0
         2OJwryy0UIG0Wr1TnHlbIQUa2pAqZssBvS5X/FmpCWBQtT5jLc9bMUE1qISA0lBMIU1M
         L0mahpRRR0dQ9i4Cl3uksU12DN86eyAaPZWlQJKvsFZdjUstuNGvl7CvQEeq8vX7iuHb
         agmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=MQDB3twHUV+r6yKkqCSWfDdOeat5jhgGwYk2XKOS6Gc=;
        b=ejAMPXwkvYipqZljsQWFca4G6aovetaISFuMClEfJXe6fX+K5KFDiOqygXRgu6KBfU
         GHRQnkSN41q/m0gBFFbNIHSGFTlZAG4u1XjZ5nm83lwr/FvRl4RY1Dwhf5sdJp6vwp8z
         sY0g8uEFaPNgZG8uzTqDi8DkvCQ02484LknYy61C+j16Et4oA2Nw27YJ9JORtZihv2+S
         4QakOZ6vBF2gkWCVTDRQMNW3OaRX+S2cw4VBcpx3dsG66C+mm11M+5rRooakdY4WIPAx
         g0oP/AY6ik/HN3B7l8afBbf7T3MKa/X25WZUQ2qQQk9VRVLNf7u0um1DPM8a6k5X52Mt
         mE+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Fri, 20 Apr 2018 12:34:28 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>,
	"Raj, Ashok" <ashok.raj@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: [PATCH 1/2] x86/microcode/intel: Save microcode patch unconditionally
Message-ID: <20180420103428.GD13977@pd.tnic>
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
X-GMAIL-THRID: =?utf-8?q?1598261005085608238?=
X-GMAIL-MSGID: =?utf-8?q?1598261005085608238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

save_mc_for_early() was a no-op on !CONFIG_HOTPLUG_CPU but the
generic_load_microcode() path saves the microcode patches it has found
into our cache of patches which is used for late loading too. Regardless
of whether we do CPU hotplug or not.

So make the saving unconditional so that late loading can find the
proper patch.

Reported-by: Vitezslav Samel <vitezslav@samel.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: <stable@vger.kernel.org> # if it has backported d8c3b52c00a05036e0a6b315b4b17921a7b67997
Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
---
 arch/x86/kernel/cpu/microcode/intel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 32b8e5724f96..1c2cfa0644aa 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -485,7 +485,6 @@ static void show_saved_mc(void)
  */
 static void save_mc_for_early(u8 *mc, unsigned int size)
 {
-#ifdef CONFIG_HOTPLUG_CPU
 	/* Synchronization during CPU hotplug. */
 	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
 
@@ -495,7 +494,6 @@ static void save_mc_for_early(u8 *mc, unsigned int size)
 	show_saved_mc();
 
 	mutex_unlock(&x86_cpu_microcode_mutex);
-#endif
 }
 
 static bool load_builtin_intel_microcode(struct cpio_data *cp)
-- 
2.13.0

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
