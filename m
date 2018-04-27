Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758815AbeD0QhK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:37:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:16225 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758355AbeD0QhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:37:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,335,1520924400";
   d="scan'208";a="35147085"
Date: Fri, 27 Apr 2018 09:37:08 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86, mce: Fix stack out-of-bounds write in
 mce-inject.c:flags_read()
Message-ID: <20180427163707.ktaiysvbk3yhk4wm@agluck-desk>
References: <CACT4Y+Ys9bKFNaBm7YuCvk04jcZ2SnLiDSxgCojZMwtb2PKVBg@mail.gmail.com>
 <20180427154115.GF15229@pd.tnic>
 <CACT4Y+bptixoADW1cLtJzbJcHfmEAuLyBSnK9txb6u69fZ3n6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bptixoADW1cLtJzbJcHfmEAuLyBSnK9txb6u69fZ3n6w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each of the strings that we want to put into the buf[MAX_FLAG_OPT_SIZE]
in flags_read() is two characters. But the sprintf() adds a trailing newline
and will add a terminating NUL byte. So MAX_FLAG_OPT_SIZE needs to be 4.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index 475cb4f5f14f..c805a06e14c3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -48,7 +48,7 @@ static struct dentry *dfs_inj;
 
 static u8 n_banks;
 
-#define MAX_FLAG_OPT_SIZE	3
+#define MAX_FLAG_OPT_SIZE	4
 #define NBCFG			0x44
 
 enum injection_type {
