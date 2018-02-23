Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224qDs4824jTRoYmSb5wC2JdQyPsho0Pkni1V+z2LWLqzgzrfqTZV6ppdRFZ6jkyk/ma1qja
ARC-Seal: i=1; a=rsa-sha256; t=1519412168; cv=none;
        d=google.com; s=arc-20160816;
        b=QVod/+nENWFCiV43c/6gC4rCP6Bj31LW7gwhQcBjaaRJu4ZrMESvis7DobEgvDlBbj
         eQhW8LJmUWojM4KYhYaIxbXM0SLpMlJb1jKf3NPv5CXLtnVDnfi0F8NKpkCA0KQdKXMd
         fyUEGTwatK6ciL16UmxOrU5edwbBaEVwBTL1YfWCMzyqotP4QkNy80SMNqS6fylzkm/t
         xWzWaUX+wHg1Q0uOvxor53xWa80krjlyMzUKMbFbe1l8Q9AMvMtKCSf9I19g43L8kFnb
         sA2CAa9H3o9T5r4Ut03FroUDq3Yi6TEOaHreVBmFkEEJvjZ+7WyOCWltYgqhglmspvT0
         veNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Hwz+g3+1u+hvI50z7GMWr3EISSfJ6qoQJKD6liAR0lY=;
        b=y+2Sc0tmK99c9Pdss1WtBP/Y0DoiieUdIKIM3Jt/Z+OPuuyP2tVnD1KuouISjO3cgJ
         4+a3XVdIgUzifbGtIKMT+IaUVWiXFxnFzttDM6nUC9x1iKlqKjxpakqLE716e+q4SO2j
         oJ3EHu8FSc4ubRtkSqxmcxJqg0ybjAd2ycozc3eNtrYORW3bFYhhiNXk0LJ+tWjt2tJ1
         0hcMiAsa/IyI84kZdb6kLaCUJaPLebnDQX2m30A3SfpH77LLBsf72C9EkWWpW7wZOLFe
         NMMAhyo0LUJczBUEBO9C8R+QJ6UWt9ruKRXfkr5hcGZrOZ4Tyo9vRSp5xPsZIy2H9rSH
         VjJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Young <dyoung@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bp@suse.de,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 147/159] mm/early_ioremap: Fix boot hang with earlyprintk=efi,keep
Date: Fri, 23 Feb 2018 19:27:35 +0100
Message-Id: <20180223170800.766416022@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217624910234583?=
X-GMAIL-MSGID: =?utf-8?q?1593219133834834974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Young <dyoung@redhat.com>


[ Upstream commit 7f6f60a1ba52538c16f26930bfbcfe193d9d746a ]

earlyprintk=efi,keep does not work any more with a warning
in mm/early_ioremap.c: WARN_ON(system_state != SYSTEM_BOOTING):
Boot just hangs because of the earlyprintk within the earlyprintk
implementation code itself.

This is caused by a new introduced middle state in:

  69a78ff226fe ("init: Introduce SYSTEM_SCHEDULING state")

early_ioremap() is fine in both SYSTEM_BOOTING and SYSTEM_SCHEDULING
states, original condition should be updated accordingly.

Signed-off-by: Dave Young <dyoung@redhat.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bp@suse.de
Cc: linux-efi@vger.kernel.org
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20171209041610.GA3249@dhcp-128-65.nay.redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/early_ioremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -111,7 +111,7 @@ __early_ioremap(resource_size_t phys_add
 	enum fixed_addresses idx;
 	int i, slot;
 
-	WARN_ON(system_state != SYSTEM_BOOTING);
+	WARN_ON(system_state >= SYSTEM_RUNNING);
 
 	slot = -1;
 	for (i = 0; i < FIX_BTMAPS_SLOTS; i++) {
