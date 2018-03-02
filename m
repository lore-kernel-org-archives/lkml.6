Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvNL0U7hNTs+9zjAVVDP646DDe+vej9vz8Zg7mxMOPk0RS511vInDFyi8cPMfPPE3GkOmPv
ARC-Seal: i=1; a=rsa-sha256; t=1519981082; cv=none;
        d=google.com; s=arc-20160816;
        b=LwYZIwxmdxr0wNqj11ktwTd8sO5Y2lUlbI9smFaldlXUfFExuxx187KgKPE2Js6NXN
         E+AH0A/pJUj9WJHLjfT78AV0TfeYHQAhti1tiqmn6o3/MeBF396L/GsjlOrLgDxt6a/I
         XHlZqJPAQb5OKNjIA25/tXzQLSwmORNcJh2Vg/CULun2Y+jK54RIdbklv4Sf4lhcHY+y
         IQIvoYnw+vks2XAeGQzS75Dufq9ABh/016byPIZPEG5LOBIA+eLBnOdc1q0lgXtkByQL
         nKmfyBULNCRhWyXx7kkrBzwSGAa14KTNvjSoYpem0EPxuX0ledBT+w5NarjNmte6Mzf3
         LaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A2tkZXu7j6rh9CjIehh3tzwr5H8MyW4bpTQatjA1xIU=;
        b=GzOLDmdFMcacbru0KtkK3ZeN+Xf+CXS1QqMOJ/pShzOCv2m5C3W9kJt479P93SQ6ZG
         TVB7G3HsQhtbQHl5JvI+k+bRWyRHNUtVBpbUX4wmAf59qYW+ia/s7UxDUgM61RklnHZt
         G7ku7EQ0yB9xhVROiOM92KEPXVmxf32WhFyjmz08nOwBfE09EDkzTfd8uh8azKIu/NxM
         /a7gl4KhMa0NXLqwo3iY6YbQTJ8RwHxCC614bcjfyHzJLg1Wtj9NCPRj2Jpf5oa5WbPq
         yDNhY3M93DwD/uYGXYqAxcTlM4MiGyZH/H3YKmAR4dOGErWFkwxwUA1NMj9MIHf7/0rI
         kfUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Felix Janda <felix.janda@posteo.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 42/56] uapi libc compat: add fallback for unsupported libcs
Date: Fri,  2 Mar 2018 09:51:28 +0100
Message-Id: <20180302084451.692935272@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815683631546105?=
X-GMAIL-MSGID: =?utf-8?q?1593815683631546105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Janda <felix.janda@posteo.de>


[ Upstream commit c0bace798436bca0fdc221ff61143f1376a9c3de ]

libc-compat.h aims to prevent symbol collisions between uapi and libc
headers for each supported libc. This requires continuous coordination
between them.

The goal of this commit is to improve the situation for libcs (such as
musl) which are not yet supported and/or do not wish to be explicitly
supported, while not affecting supported libcs. More precisely, with
this commit, unsupported libcs can request the suppression of any
specific uapi definition by defining the correspondings _UAPI_DEF_*
macro as 0. This can fix symbol collisions for them, as long as the
libc headers are included before the uapi headers. Inclusion in the
other order is outside the scope of this commit.

All infrastructure in order to enable this fallback for unsupported
libcs is already in place, except that libc-compat.h unconditionally
defines all _UAPI_DEF_* macros to 1 for all unsupported libcs so that
any previous definitions are ignored. In order to fix this, this commit
merely makes these definitions conditional.

This commit together with the musl libc commit

http://git.musl-libc.org/cgit/musl/commit/?id=04983f2272382af92eb8f8838964ff944fbb8258

fixes for example the following compiler errors when <linux/in6.h> is
included after musl's <netinet/in.h>:

./linux/in6.h:32:8: error: redefinition of 'struct in6_addr'
./linux/in6.h:49:8: error: redefinition of 'struct sockaddr_in6'
./linux/in6.h:59:8: error: redefinition of 'struct ipv6_mreq'

The comments referencing glibc are still correct, but this file is not
only used for glibc any more.

Signed-off-by: Felix Janda <felix.janda@posteo.de>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/libc-compat.h |   55 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -167,46 +167,99 @@
 
 /* If we did not see any headers from any supported C libraries,
  * or we are being included in the kernel, then define everything
- * that we need. */
+ * that we need. Check for previous __UAPI_* definitions to give
+ * unsupported C libraries a way to opt out of any kernel definition. */
 #else /* !defined(__GLIBC__) */
 
 /* Definitions for if.h */
+#ifndef __UAPI_DEF_IF_IFCONF
 #define __UAPI_DEF_IF_IFCONF 1
+#endif
+#ifndef __UAPI_DEF_IF_IFMAP
 #define __UAPI_DEF_IF_IFMAP 1
+#endif
+#ifndef __UAPI_DEF_IF_IFNAMSIZ
 #define __UAPI_DEF_IF_IFNAMSIZ 1
+#endif
+#ifndef __UAPI_DEF_IF_IFREQ
 #define __UAPI_DEF_IF_IFREQ 1
+#endif
 /* Everything up to IFF_DYNAMIC, matches net/if.h until glibc 2.23 */
+#ifndef __UAPI_DEF_IF_NET_DEVICE_FLAGS
 #define __UAPI_DEF_IF_NET_DEVICE_FLAGS 1
+#endif
 /* For the future if glibc adds IFF_LOWER_UP, IFF_DORMANT and IFF_ECHO */
+#ifndef __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO
 #define __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO 1
+#endif
 
 /* Definitions for in.h */
+#ifndef __UAPI_DEF_IN_ADDR
 #define __UAPI_DEF_IN_ADDR		1
+#endif
+#ifndef __UAPI_DEF_IN_IPPROTO
 #define __UAPI_DEF_IN_IPPROTO		1
+#endif
+#ifndef __UAPI_DEF_IN_PKTINFO
 #define __UAPI_DEF_IN_PKTINFO		1
+#endif
+#ifndef __UAPI_DEF_IP_MREQ
 #define __UAPI_DEF_IP_MREQ		1
+#endif
+#ifndef __UAPI_DEF_SOCKADDR_IN
 #define __UAPI_DEF_SOCKADDR_IN		1
+#endif
+#ifndef __UAPI_DEF_IN_CLASS
 #define __UAPI_DEF_IN_CLASS		1
+#endif
 
 /* Definitions for in6.h */
+#ifndef __UAPI_DEF_IN6_ADDR
 #define __UAPI_DEF_IN6_ADDR		1
+#endif
+#ifndef __UAPI_DEF_IN6_ADDR_ALT
 #define __UAPI_DEF_IN6_ADDR_ALT		1
+#endif
+#ifndef __UAPI_DEF_SOCKADDR_IN6
 #define __UAPI_DEF_SOCKADDR_IN6		1
+#endif
+#ifndef __UAPI_DEF_IPV6_MREQ
 #define __UAPI_DEF_IPV6_MREQ		1
+#endif
+#ifndef __UAPI_DEF_IPPROTO_V6
 #define __UAPI_DEF_IPPROTO_V6		1
+#endif
+#ifndef __UAPI_DEF_IPV6_OPTIONS
 #define __UAPI_DEF_IPV6_OPTIONS		1
+#endif
+#ifndef __UAPI_DEF_IN6_PKTINFO
 #define __UAPI_DEF_IN6_PKTINFO		1
+#endif
+#ifndef __UAPI_DEF_IP6_MTUINFO
 #define __UAPI_DEF_IP6_MTUINFO		1
+#endif
 
 /* Definitions for ipx.h */
+#ifndef __UAPI_DEF_SOCKADDR_IPX
 #define __UAPI_DEF_SOCKADDR_IPX			1
+#endif
+#ifndef __UAPI_DEF_IPX_ROUTE_DEFINITION
 #define __UAPI_DEF_IPX_ROUTE_DEFINITION		1
+#endif
+#ifndef __UAPI_DEF_IPX_INTERFACE_DEFINITION
 #define __UAPI_DEF_IPX_INTERFACE_DEFINITION	1
+#endif
+#ifndef __UAPI_DEF_IPX_CONFIG_DATA
 #define __UAPI_DEF_IPX_CONFIG_DATA		1
+#endif
+#ifndef __UAPI_DEF_IPX_ROUTE_DEF
 #define __UAPI_DEF_IPX_ROUTE_DEF		1
+#endif
 
 /* Definitions for xattr.h */
+#ifndef __UAPI_DEF_XATTR
 #define __UAPI_DEF_XATTR		1
+#endif
 
 #endif /* __GLIBC__ */
 
