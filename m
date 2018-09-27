Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B93C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC632159B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC632159B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeI0P1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:27:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeI0P1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:27:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4CF71117;
        Thu, 27 Sep 2018 09:10:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert OCallahan <robert@ocallahan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 16/88] socket: fix struct ifreq size in compat ioctl
Date:   Thu, 27 Sep 2018 11:02:57 +0200
Message-Id: <20180927090302.429555162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1cebf8f143c21eb422cd0f4e27ab2ae366eb4d04 ]

As reported by Reobert O'Callahan, since Viro's commit to kill
dev_ifsioc() we attempt to copy too much data in compat mode,
which may lead to EFAULT when the 32-bit version of struct ifreq
sits at/near the end of a page boundary, and the next page isn't
mapped.

Fix this by passing the approprate compat/non-compat size to copy
and using that, as before the dev_ifsioc() removal. This works
because only the embedded "struct ifmap" has different size, and
this is only used in SIOCGIFMAP/SIOCSIFMAP which has a different
handler. All other parts of the union are naturally compatible.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=199469.

Fixes: bf4405737f9f ("kill dev_ifsioc()")
Reported-by: Robert O'Callahan <robert@ocallahan.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -962,7 +962,8 @@ void dlci_ioctl_set(int (*hook) (unsigne
 EXPORT_SYMBOL(dlci_ioctl_set);
 
 static long sock_do_ioctl(struct net *net, struct socket *sock,
-				 unsigned int cmd, unsigned long arg)
+			  unsigned int cmd, unsigned long arg,
+			  unsigned int ifreq_size)
 {
 	int err;
 	void __user *argp = (void __user *)arg;
@@ -988,11 +989,11 @@ static long sock_do_ioctl(struct net *ne
 	} else {
 		struct ifreq ifr;
 		bool need_copyout;
-		if (copy_from_user(&ifr, argp, sizeof(struct ifreq)))
+		if (copy_from_user(&ifr, argp, ifreq_size))
 			return -EFAULT;
 		err = dev_ioctl(net, cmd, &ifr, &need_copyout);
 		if (!err && need_copyout)
-			if (copy_to_user(argp, &ifr, sizeof(struct ifreq)))
+			if (copy_to_user(argp, &ifr, ifreq_size))
 				return -EFAULT;
 	}
 	return err;
@@ -1091,7 +1092,8 @@ static long sock_ioctl(struct file *file
 			err = open_related_ns(&net->ns, get_net_ns);
 			break;
 		default:
-			err = sock_do_ioctl(net, sock, cmd, arg);
+			err = sock_do_ioctl(net, sock, cmd, arg,
+					    sizeof(struct ifreq));
 			break;
 		}
 	return err;
@@ -2762,7 +2764,8 @@ static int do_siocgstamp(struct net *net
 	int err;
 
 	set_fs(KERNEL_DS);
-	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&ktv);
+	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&ktv,
+			    sizeof(struct compat_ifreq));
 	set_fs(old_fs);
 	if (!err)
 		err = compat_put_timeval(&ktv, up);
@@ -2778,7 +2781,8 @@ static int do_siocgstampns(struct net *n
 	int err;
 
 	set_fs(KERNEL_DS);
-	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&kts);
+	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&kts,
+			    sizeof(struct compat_ifreq));
 	set_fs(old_fs);
 	if (!err)
 		err = compat_put_timespec(&kts, up);
@@ -3084,7 +3088,8 @@ static int routing_ioctl(struct net *net
 	}
 
 	set_fs(KERNEL_DS);
-	ret = sock_do_ioctl(net, sock, cmd, (unsigned long) r);
+	ret = sock_do_ioctl(net, sock, cmd, (unsigned long) r,
+			    sizeof(struct compat_ifreq));
 	set_fs(old_fs);
 
 out:
@@ -3197,7 +3202,8 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
 	case SIOCGIFNAME:
-		return sock_do_ioctl(net, sock, cmd, arg);
+		return sock_do_ioctl(net, sock, cmd, arg,
+				     sizeof(struct compat_ifreq));
 	}
 
 	return -ENOIOCTLCMD;


