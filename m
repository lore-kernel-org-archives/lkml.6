Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226gND9wN6Hk0nhXbiX5BEMpfdnVEx+MiO8DbM6tUUClCI0vozeeXmQoSu7eYdayghF6J7tv
ARC-Seal: i=1; a=rsa-sha256; t=1519218262; cv=none;
        d=google.com; s=arc-20160816;
        b=UbH5BHSjvi2fz3IPTh3UChqWMCRJ8ioRDnKkiWZ3wfGF+OScKnRJVJH4bVRfpzJlFs
         KqcAduX33dP0v4ZWXheKkYClaCqnsJnlM3yCOp8lKsI09qKU9csR1NEme6X6UJjESqj7
         2ZjnaF910akmKpG/4YsFJx8VkZeIbtw7TNDeFRkVsIzmygH+UtqaJnncX1HkzG670L3Z
         QDYi/jXcvrvNxWoABKyVd6iqXec8j0OAj7PevPYl1oJFfFvGU54jRG+WSQB42JtSEx0a
         ydLcwckNNdYFRyAkf+gdbD4CROpOBEbPb0shvKmdBt16n7l1WXDgj0vN97FjaBT8bAjw
         8qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bPmpntl+xDrEtP5jafpUKmvr/CILHB6QJNg8jR6D7KM=;
        b=fDhhJ3K6C2FP+60tiFTpc+74i2xGelHd7qQmpSWEk3tQEDBVgxAOorLHfAAfAxrtk+
         ydrH1cOuXPE2EuXclGBYKQ+3TMNpGEcC/zu8zf2J1lN7oFKdPfjRhxOvmrnHIQ9t+TCV
         Yz3x8x+hdLiJ1VU2qvbo72VZQgSMzxrQwCxzTe7NGsMN1MpmAqB0gAYQlEoiCMNl827v
         TWxcdcc5mOConjTi7MRiCtD+mKKdDocakN5NkLVGZ+mq49WXDYb40MfL21uiHrikQhK0
         QsC7X+mNvMD1HhSvUqm4bRqPVnyspXfXTnZ75yseeBwxiskgm2Eqr/PdJF+WZqW8oio5
         +Xug==
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
Subject: [PATCH 4.14 109/167] mm: hide a #warning for COMPILE_TEST
Date: Wed, 21 Feb 2018 13:48:40 +0100
Message-Id: <20180221124530.329445704@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014626139492093?=
X-GMAIL-MSGID: =?utf-8?q?1593015808608062215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -81,7 +81,7 @@
 
 #include "internal.h"
 
-#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
+#if defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS) && !defined(CONFIG_COMPILE_TEST)
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
