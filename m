Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226zmsc7ZeH9DyphkFS4/pYCSQfsGHULhg0K9IgBAHLFwORlZI6tnQ1aE+nHSgvGcacLr0qk
ARC-Seal: i=1; a=rsa-sha256; t=1519217134; cv=none;
        d=google.com; s=arc-20160816;
        b=gE41Y/50Puo6M4HjfRIKK8tlc+0MBIBMZqSe2sjS7QHjwTsVDIKxBWeC9N4pCLKEBw
         EsvzP1A/84xZLsps8feuMtE7NWJ3rjl8ZbxZPpQs59GDux1myjD8O7b8DeHlIy3JVvwr
         zdVoNpiiG62JQdR8JbYET+hdBYHkGemo9/LoDWoYsJD5zZI0hNocjphZ4hcCbfiO1tdz
         D63TACfFOnY0ZCF5Pr5DaZwOWg1JRD94yLwV9eaOWP9jFnASZrB5kdsAcjuxiqHZqdlq
         CsRIEk6t5csaYFZsC6SwkR3sb7Yf6HLwU0FAWCALcr8ZsOT3NT1rAbN+7/n8AV/XzacT
         5ucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=39wnCxJ+i5/2bANMhpKSSFUPojcdNHdGsnGqp1yA1X0=;
        b=z8QaLGRaytgigEB9xNfUt93Fk+6EqzPMNpbOJERtZ8/P5zoa2BIpThLh9Kn/5dUFVZ
         nM31wNrKzLeqwbAUQ3BjIPJ++McrUMD+I0XBnmbFAmGLIaF9BojF6RBMV1myqRVdkx2/
         i4frUITrlRQdWs48kQiadiCuO+p9Ep79H20gNwBv7hqE91/W931mGkRHMQksig+XN45W
         hbM1hu3P+HsYNu1K/t6qBvOAzPAhyhsGKHQfod6tOzqrAjE8B5J6rmlZj7CQ7rBuZPhO
         ri6Akl/h16ZqlM4mkgDTCgqDG4RZ4JbMNM7m1NQm4CAgyQtDWc9RhS+rPZhT6jsj2HBe
         Faqg==
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
Subject: [PATCH 4.4 15/33] mm: hide a #warning for COMPILE_TEST
Date: Wed, 21 Feb 2018 13:44:58 +0100
Message-Id: <20180221124410.439521900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014626139492093?=
X-GMAIL-MSGID: =?utf-8?q?1593014626139492093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -72,7 +72,7 @@
 
 #include "internal.h"
 
-#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+#if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
