Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227nu+Cg2L0xKZabDLGFyJ0iNS9LF6hmMoE746s+Ti9DXK3gFUv06+9dDpkk6BJmisU46pet
ARC-Seal: i=1; a=rsa-sha256; t=1519411001; cv=none;
        d=google.com; s=arc-20160816;
        b=ioEWhjpF+vontaozHKsvZaAmSnvjRyTN7D3UvNzAL2Tn2JUCtU7Sp7pNUPvUpWt+uf
         6X61YPM0r/UXQaV/fmn5FcHBZ8oX1k8KvcU4JHzCLfNz2dIFjxmDwG6SC5kFazPSYKzC
         Qk1O2KjplVliZrhmn5hbs9qrMC6czWa/X/jyYE6gZtB4RKbpk8DuG4kvYnGr1i23rsRO
         BQ/6lPQgQYAE4gLrSfAvP6PztUlyfSWn6YBrDfIIXL4xO9U3Rs/LZYBMC912PpVWsdaQ
         0zUVpJ3Y9gWfAty/Cfz2OfL9pfYzZNVuVBBa4Q8SpXkz+Q+yKUf8mlj0reGcZNmM2kYQ
         2vXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1N6gQ0pUSdTxgQ70856wEyg/nJjdm6Ov2LjjublG/jk=;
        b=pMSp5Jb0dF4p3MYnBQwaioHQ4mekXdlLjjxHJw5VOG/FNH6VBt4uSC3sJU0CA730Mp
         547lHngah8/M8pB1Yf++vGTGLWEgewWCBIqWYtb95UhMmv/MeLFOXQzx9P0PIu5MNjIG
         891gxu5wIpg4zURzBNV9noBIF4oDg/fynXeOgr53VgBTvvjUXCbyT1r48bMIe/6aQ7ie
         15m3bVFelV+5z9unCM6t+z7rAVxwd889sHm43Um62DDasAS/AqrljCHtAlL+6FH1cz5r
         m8UCCcVIY7wQcDkr3ilT0g7u44oc70XdlfqE9maXpQbGT/kOqH08Hb1itB2yxWCMPoCs
         5qCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Robin Holt <robinmholt@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Christoph Lameter <cl@linux.com>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 087/193] profile: hide unused functions when !CONFIG_PROC_FS
Date: Fri, 23 Feb 2018 19:25:20 +0100
Message-Id: <20180223170339.676998379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217910126071053?=
X-GMAIL-MSGID: =?utf-8?q?1593217910126071053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ade356b99a4187578609f2a91c4d2ed88e4e70dc upstream.

A couple of functions and variables in the profile implementation are
used only on SMP systems by the procfs code, but are unused if either
procfs is disabled or in uniprocessor kernels.  gcc prints a harmless
warning about the unused symbols:

  kernel/profile.c:243:13: error: 'profile_flip_buffers' defined but not used [-Werror=unused-function]
   static void profile_flip_buffers(void)
               ^
  kernel/profile.c:266:13: error: 'profile_discard_flip_buffers' defined but not used [-Werror=unused-function]
   static void profile_discard_flip_buffers(void)
               ^
  kernel/profile.c:330:12: error: 'profile_cpu_callback' defined but not used [-Werror=unused-function]
   static int profile_cpu_callback(struct notifier_block *info,
              ^

This adds further #ifdef to the file, to annotate exactly in which cases
they are used.  I have done several thousand ARM randconfig kernels with
this patch applied and no longer get any warnings in this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Robin Holt <robinmholt@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/profile.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -44,7 +44,7 @@ int prof_on __read_mostly;
 EXPORT_SYMBOL_GPL(prof_on);
 
 static cpumask_var_t prof_cpu_mask;
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PROC_FS)
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
 static DEFINE_MUTEX(profile_flip_mutex);
@@ -201,7 +201,7 @@ int profile_event_unregister(enum profil
 }
 EXPORT_SYMBOL_GPL(profile_event_unregister);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_PROC_FS)
 /*
  * Each cpu has a pair of open-addressed hashtables for pending
  * profile hits. read_profile() IPI's all cpus to request them
