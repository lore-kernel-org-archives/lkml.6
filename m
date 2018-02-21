Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2267i/AEcUjEwPmW3Mfa6n7VZopPzjOO7kp59zrxFErhORiPcQWXWEakTfedum0u0hFv5G5/
ARC-Seal: i=1; a=rsa-sha256; t=1519217764; cv=none;
        d=google.com; s=arc-20160816;
        b=WWZJIkBp8SbF9dHu3uRSb7ueY65IHEnMoBhSTCCDvDKwI/Ss8B+TTl8NZ5iI8Es3Pm
         3vhjI4vpK3WwTKJ9qu+F7VDUAT61+3HXP3OdWPyDYxbpP4fxMO1bmobwo75GFzaLTDNK
         8/HBrqayqBMnYxcvTq9vlBUHu7o02fnAxzbr10STgXjYLTrZykqWt/V1t5iP/huo0iUh
         IoPnC7qI4vLOAkP4XB3o0QvNLZnwDA5DdIn+T1PmjBcy7UtsR+ja7N/wn6+eOZdMUJyo
         P+mTVMjiiAXkcXER6pdPKzBQDqPIClB+2kFJvuhQAvcd+LVX41FpJ5k0xc7RtTp7cktO
         E0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oF8GvvEmzpeeNxRECgIwU7/dtmSMfPMfFsqSNJUASSw=;
        b=O0irXVnQTjN2oNECYjDnQ/igyW5SnECoxDEqguHHVT8J6vjuCX73InCSAlEQ62X4y7
         yrm7u3HQPkn82BzOfCPoEct2jw4PXBH35BUnmWOS8NvZcFm+7iuObZz7Rn1epNrTGwWt
         hNPjnXO7BQRYqlWb7WhPTZ4I+6+SdjdiZ5H9qz+J25unNwqqdjTWoaeEvFYjGWbfMQ5Z
         Aw4b3Z8CkYKSvDpkzc4gtri+Z+L0ktqymOXSrDVgyreiZRU0XoOTSJu9piOC/u/4CbtH
         LBqT9/k26I5PQyrmy84Hov+v2kaNX4nywUXN75TkrLqdHZUVh5V90zDAxu8s7TrBr/Oi
         j0Og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 10/77] mm: hide a #warning for COMPILE_TEST
Date: Wed, 21 Feb 2018 13:48:19 +0100
Message-Id: <20180221124432.594430035@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014626139492093?=
X-GMAIL-MSGID: =?utf-8?q?1593015286795135854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit af27d9403f5b80685b79c88425086edccecaf711 upstream.

We get a warning about some slow configurations in randconfig kernels:

  mm/memory.c:83:2: error: #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid. [-Werror=cpp]

The warning is reasonable by itself, but gets in the way of randconfig
build testing, so I'm hiding it whenever CONFIG_COMPILE_TEST is set.

The warning was added in 2013 in commit 75980e97dacc ("mm: fold
page->_last_nid into page->flags where possible").

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -75,7 +75,7 @@
 
 #include "internal.h"
 
-#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+#if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
