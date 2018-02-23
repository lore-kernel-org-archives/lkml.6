Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414361-2-12939047646953768161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414360; b=bCk0f9qfUBW/Vax2o1EiKgUlgjZodz2MeaJU2G/3h6FpUAe
    kKibTN7OPVShdSvdeaAxOMixjGPKxzexc1KwlSQWLooWFM7ds3aIzfKkKiY5Nj8h
    NzlpFeU5comsg9o2LhrhYwqVRhLrdj9yp+TBQmSVhQXqTs+UFk50wS72LkL2ZCHS
    tR+C+KV2bIMoIjgPWOVuBH8SUFLRLfns7oUICsrCm09ii68d4Q6PRfcDBxqEizU3
    m21DXFVvkR8qT8kdowMRdbZDrCuVCo6if/5l6irNYR8fwsGtD0XEqGJxK3OL1IZT
    +3qQoEUV45EwatZZk+pVc4OGAmk0ZeBCgPXRXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414360; bh=S8+Wh5aH7y9M7GoDrOcxU6eRJp
    j1UrMU0MMrmCHIB6g=; b=Oq+3njK/aDnGY05iB5QkSLHi7Dq4LhGPQEFtvUv33M
    s1YY59fmamgqm7SnRb+14tgUstftdgqm8y/lYUsPkasJZpRzaQHZAByY+Jv2VD+m
    RR6BoSrOMufbJ5GIF/PdYb7nvAABLjLt7uAkRKAdbVMU/c8OAABtHdxSLoIc0xYb
    sGPC8a108oChTyLEwXLmEh6nA1utHKeeU3rrT/PKlUXEr7mR7iEUcnkP+nPEH/rH
    TohY8NRpGWR5BTRvoNu1BQnNm5aU4OmJSRzdDQUQdduun4oFJb9wwXgpkQzWLA4+
    taUUpSG/Bob6f1bTWnG/aanJlIKWVssJ6HqgdrZJZgJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754581AbeBWTcI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:32:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934943AbeBWSvV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Vandrovec <petr@vandrovec.name>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 049/159] dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock
Date: Fri, 23 Feb 2018 19:25:57 +0100
Message-Id: <20180223170749.466432856@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1339,6 +1339,12 @@ static int dn_setsockopt(struct socket *
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
@@ -1446,15 +1452,6 @@ static int __dn_setsockopt(struct socket
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
@@ -1502,6 +1499,12 @@ static int __dn_setsockopt(struct socket
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
@@ -1515,6 +1518,20 @@ static int dn_getsockopt(struct socket *
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
@@ -1580,26 +1597,6 @@ static int __dn_getsockopt(struct socket
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
@@ -1631,6 +1628,13 @@ static int __dn_getsockopt(struct socket
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
