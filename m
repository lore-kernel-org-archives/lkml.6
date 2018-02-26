Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvlBqg+QPwOBvMsfUKFB5mmGWRIwA8c/YHXZcP47uMsFmlHkmobiFUNlm2awRrGuxS5InrZ
ARC-Seal: i=1; a=rsa-sha256; t=1519676892; cv=none;
        d=google.com; s=arc-20160816;
        b=Wa4cvEPbEG5KqWblJI0j/X5Ev6RycY8P/OFqD53ZALitOdy4qUaZmWUNs30lXlwPVh
         5v3oeup17K+NdC4XAKgNLjKdy+k27ALbDa6BK/Gkf/WD15hYT1a/vh8S2weI+O1+sTLS
         mSLPdWzDEnBF6S0xu1z5GdsCGVdZyYranNT1y58tp0Vi3XeRN26ZoKERIqgRxZdy44Hi
         yiJcZuL+hwXgCt5MuPdapBrpu4G99wVxwcnrRnievT3+y4JihFZ7nDI75BqUQioT2atX
         R8UJ6VTAL2sOV1ps9HX45sg4he70ohbCb0cTnjcknVV0SZ2Df8jh04dGRKudXwkc/zwT
         OvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cDCsXoa4oU4CGTwdIHDoYV9LmvSIk745MtB2QGmlhnU=;
        b=Ha626Dcaf6bWRzPDcAutTf4WnTd1mwoHzplQtXqLTNOJrSXgEJ2yHOboyuRuwevpXb
         4VMgkB0V4emqGs66//TU8iyMwMB7yl9AHS1e21/iUsXuXCaZLCGo0NMC32g2vSCnqDMM
         tF5OJzD+Lks0W6WjhtV1QGDcA5xQVHs7SFN+k/dAjvrKAeZWSlreWPrxZ9iRhjheME/s
         c61/XVeR3YNn8GFYJCrfX9wrVTUUtRn8nNcWxtem88o5R1EfMicdJ8+VST3egFCsY31H
         nUb9NkjPc8eQ46LhygRbdht9HS9LhrxOKGez/IAtEAT9qwR1X35KN3XVFmjXJSs0WXUB
         tUcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guillaume Nault <g.nault@alphalink.fr>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 31/64] uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define
Date: Mon, 26 Feb 2018 21:22:08 +0100
Message-Id: <20180226202154.777525920@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496716735673227?=
X-GMAIL-MSGID: =?utf-8?q?1593496716735673227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

commit da360299b6734135a5f66d7db458dcc7801c826a upstream.

This fixes a compile problem of some user space applications by not
including linux/libc-compat.h in uapi/if_ether.h.

linux/libc-compat.h checks which "features" the header files, included
from the libc, provide to make the Linux kernel uapi header files only
provide no conflicting structures and enums. If a user application mixes
kernel headers and libc headers it could happen that linux/libc-compat.h
gets included too early where not all other libc headers are included
yet. Then the linux/libc-compat.h would not prevent all the
redefinitions and we run into compile problems.
This patch removes the include of linux/libc-compat.h from
uapi/if_ether.h to fix the recently introduced case, but not all as this
is more or less impossible.

It is no problem to do the check directly in the if_ether.h file and not
in libc-compat.h as this does not need any fancy glibc header detection
as glibc never provided struct ethhdr and should define
__UAPI_DEF_ETHHDR by them self when they will provide this.

The following test program did not compile correctly any more:

#include <linux/if_ether.h>
#include <netinet/in.h>
#include <linux/in.h>

int main(void)
{
	return 0;
}

Fixes: 6926e041a892 ("uapi/if_ether.h: prevent redefinition of struct ethhdr")
Reported-by: Guillaume Nault <g.nault@alphalink.fr>
Cc: <stable@vger.kernel.org> # 4.15
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/if_ether.h    |    6 +++++-
 include/uapi/linux/libc-compat.h |    6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -23,7 +23,6 @@
 #define _UAPI_LINUX_IF_ETHER_H
 
 #include <linux/types.h>
-#include <linux/libc-compat.h>
 
 /*
  *	IEEE 802.3 Ethernet magic constants.  The frame sizes omit the preamble
@@ -150,6 +149,11 @@
  *	This is an Ethernet frame header.
  */
 
+/* allow libcs like musl to deactivate this, glibc does not implement this. */
+#ifndef __UAPI_DEF_ETHHDR
+#define __UAPI_DEF_ETHHDR		1
+#endif
+
 #if __UAPI_DEF_ETHHDR
 struct ethhdr {
 	unsigned char	h_dest[ETH_ALEN];	/* destination eth addr	*/
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -264,10 +264,4 @@
 
 #endif /* __GLIBC__ */
 
-/* Definitions for if_ether.h */
-/* allow libcs like musl to deactivate this, glibc does not implement this. */
-#ifndef __UAPI_DEF_ETHHDR
-#define __UAPI_DEF_ETHHDR		1
-#endif
-
 #endif /* _UAPI_LIBC_COMPAT_H */
