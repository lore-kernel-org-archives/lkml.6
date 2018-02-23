Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224vBUnj2e9gyoM68jtqL7tU9I2T0BhBgYNrU9hWCo4oE52Q0fipyWxveY7oPpADoTdo/ndM
ARC-Seal: i=1; a=rsa-sha256; t=1519412345; cv=none;
        d=google.com; s=arc-20160816;
        b=GxqCQyH9CpP/LsMoK2jGQWYzo2iJMu4P0FAdA22zTo8+TNavYP2AsxMQFN/+yGAcMd
         Ud9/9r0vmzzMECejsyVnz1JnfVKT0JKUU+SWDQXHb6iyEb+lMdA1GQJAcZf9glmy5wDI
         NdWAsQEUSAnQB4vZt19HHb5SoOsMAC0+LFproIP2T8vYFyaS4vO+KfYUn0uq2kRwotXZ
         +HBpphoKdUGNUIer+N1/ARKYGwzgJDoShVIXZc0dps1OczgX8oxhdt5y07nvVLyRr1Pt
         asQ35vZdiCFj8sOnKlp/ZbTxbAYgZ6c+g0Q5oSP82B+Sq/Kt3boSxi+PMTs5Et0XKltU
         Qsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=T2HD2LrQ0rKcTcyeWv7kU2HacOs3rmltDyO/KSWAoMI=;
        b=USae+hg8jffwJboxRZZfUo69lN+SN8n4yV6fG3uesT5iiz8njYqqoyC+FQrcDJbnKJ
         nwkEn7GjBtUk0lDwodfaZAwqKZ8Kcl3kU0Hf0X7v0fLfCTLRNfJEXoAaADA9Vo7+pOHF
         nG3GesBE6uVWqT6gA9XmL/XoLFjdFoJ7pFImzWcS/oKbZ7roq/QVa3i18RXs7osZrozU
         icBeMrw9turoQg1TuLziN1nzxrgoNygFW0qFzEzJr77jYSLEC5V4Zt/9DxdkdnUY5EnL
         FKbItuNoBCtuUG9SehcIIvieKTqICsc9pz+SdZi4cEbSGeVOkDI8920mtPRYzsDWISsL
         UVcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Petr Vandrovec <petr@vandrovec.name>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 28/45] dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock
Date: Fri, 23 Feb 2018 19:29:07 +0100
Message-Id: <20180223170719.788075661@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217571475377672?=
X-GMAIL-MSGID: =?utf-8?q?1593219320206339921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit dfec091439bb2acf763497cfc58f2bdfc67c56b7 upstream.

After commit 3f34cfae1238 ("netfilter: on sockopt() acquire sock lock
only in the required scope"), the caller of nf_{get/set}sockopt() must
not hold any lock, but, in such changeset, I forgot to cope with DECnet.

This commit addresses the issue moving the nf call outside the lock,
in the dn_{get,set}sockopt() with the same schema currently used by
ipv4 and ipv6. Also moves the unhandled sockopts of the end of the main
switch statements, to improve code readability.

Reported-by: Petr Vandrovec <petr@vandrovec.name>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=198791#c2
Fixes: 3f34cfae1238 ("netfilter: on sockopt() acquire sock lock only in the required scope")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/decnet/af_decnet.c |   62 ++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -1338,6 +1338,12 @@ static int dn_setsockopt(struct socket *
 	lock_sock(sk);
 	err = __dn_setsockopt(sock, level, optname, optval, optlen, 0);
 	release_sock(sk);
+#ifdef CONFIG_NETFILTER
+	/* we need to exclude all possible ENOPROTOOPTs except default case */
+	if (err == -ENOPROTOOPT && optname != DSO_LINKINFO &&
+	    optname != DSO_STREAM && optname != DSO_SEQPACKET)
+		err = nf_setsockopt(sk, PF_DECnet, optname, optval, optlen);
+#endif
 
 	return err;
 }
@@ -1445,15 +1451,6 @@ static int __dn_setsockopt(struct socket
 		dn_nsp_send_disc(sk, 0x38, 0, sk->sk_allocation);
 		break;
 
-	default:
-#ifdef CONFIG_NETFILTER
-		return nf_setsockopt(sk, PF_DECnet, optname, optval, optlen);
-#endif
-	case DSO_LINKINFO:
-	case DSO_STREAM:
-	case DSO_SEQPACKET:
-		return -ENOPROTOOPT;
-
 	case DSO_MAXWINDOW:
 		if (optlen != sizeof(unsigned long))
 			return -EINVAL;
@@ -1501,6 +1498,12 @@ static int __dn_setsockopt(struct socket
 			return -EINVAL;
 		scp->info_loc = u.info;
 		break;
+
+	case DSO_LINKINFO:
+	case DSO_STREAM:
+	case DSO_SEQPACKET:
+	default:
+		return -ENOPROTOOPT;
 	}
 
 	return 0;
@@ -1514,6 +1517,20 @@ static int dn_getsockopt(struct socket *
 	lock_sock(sk);
 	err = __dn_getsockopt(sock, level, optname, optval, optlen, 0);
 	release_sock(sk);
+#ifdef CONFIG_NETFILTER
+	if (err == -ENOPROTOOPT && optname != DSO_STREAM &&
+	    optname != DSO_SEQPACKET && optname != DSO_CONACCEPT &&
+	    optname != DSO_CONREJECT) {
+		int len;
+
+		if (get_user(len, optlen))
+			return -EFAULT;
+
+		err = nf_getsockopt(sk, PF_DECnet, optname, optval, &len);
+		if (err >= 0)
+			err = put_user(len, optlen);
+	}
+#endif
 
 	return err;
 }
@@ -1579,26 +1596,6 @@ static int __dn_getsockopt(struct socket
 		r_data = &link;
 		break;
 
-	default:
-#ifdef CONFIG_NETFILTER
-	{
-		int ret, len;
-
-		if (get_user(len, optlen))
-			return -EFAULT;
-
-		ret = nf_getsockopt(sk, PF_DECnet, optname, optval, &len);
-		if (ret >= 0)
-			ret = put_user(len, optlen);
-		return ret;
-	}
-#endif
-	case DSO_STREAM:
-	case DSO_SEQPACKET:
-	case DSO_CONACCEPT:
-	case DSO_CONREJECT:
-		return -ENOPROTOOPT;
-
 	case DSO_MAXWINDOW:
 		if (r_len > sizeof(unsigned long))
 			r_len = sizeof(unsigned long);
@@ -1630,6 +1627,13 @@ static int __dn_getsockopt(struct socket
 			r_len = sizeof(unsigned char);
 		r_data = &scp->info_rem;
 		break;
+
+	case DSO_STREAM:
+	case DSO_SEQPACKET:
+	case DSO_CONACCEPT:
+	case DSO_CONREJECT:
+	default:
+		return -ENOPROTOOPT;
 	}
 
 	if (r_data) {
