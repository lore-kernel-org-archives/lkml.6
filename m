Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753480AbeE3L3O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:29:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60912 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751572AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Petr Vandrovec" <petr@vandrovec.name>,
        "Paolo Abeni" <pabeni@redhat.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.981632021@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 097/153] dn_getsockoptdecnet: move nf_{get/set}sockopt
 outside sock lock
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/decnet/af_decnet.c | 62 ++++++++++++++++++++++--------------------
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
