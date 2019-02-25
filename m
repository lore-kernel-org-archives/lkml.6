Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2383520652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130827;
	bh=DRnQIXVEWbl9MBQJhaE+7VFBkuqtoa1UhMmcPhtp8mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=noA35rIiQXoaI4GWvQmKMqMQagbyjXq7rGTDRmjZxovM1OnLOQEGlSgQ0COWQJiWo
	 dizNvf8M2KUghjkNP69R8aJ8njWMZmxapGwWrbH4lMbuBJHJBz9K6PZYxguwwVWoPL
	 mBLuEKZcireYVJsXUMRWaYg4rzicVBMaURLyY0q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfBYVet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732860AbfBYVeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:34:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 501D6217F5;
        Mon, 25 Feb 2019 21:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130485;
        bh=DRnQIXVEWbl9MBQJhaE+7VFBkuqtoa1UhMmcPhtp8mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtuXLLXnz4+3fKheFX9sEbj6CY93dHJj2BK5DRzDBzUQi8Gu5Z140gpC8o+fqdQdO
         j/iq9mCpIjTaeZPsJ6VC5+OlJkkNb64hgqB7ayfc/5a/e6dCRt1+Y7ODq9e93eFXbd
         XlhiDW/4ITkFinI9HHK0o+EXoNCmxEXWeJdeksjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 135/183] Revert "kill dev_ifsioc()"
Date:   Mon, 25 Feb 2019 22:11:48 +0100
Message-Id: <20190225195117.637340213@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 37ac39bdddc528c998a9f36db36937de923fdf2a ]

This reverts commit bf4405737f9f ("kill dev_ifsioc()").

This wasn't really unused as implied by the original commit,
it still handles the copy to/from user differently, and the
commit thus caused issues such as
  https://bugzilla.kernel.org/show_bug.cgi?id=199469
and
  https://bugzilla.kernel.org/show_bug.cgi?id=202273

However, deviating from a strict revert, rename dev_ifsioc()
to compat_ifreq_ioctl() to be clearer as to its purpose and
add a comment.

Cc: stable@vger.kernel.org
Fixes: bf4405737f9f ("kill dev_ifsioc()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

--- a/net/socket.c
+++ b/net/socket.c
@@ -2960,6 +2960,53 @@ static int compat_ifr_data_ioctl(struct
 	return dev_ioctl(net, cmd, &ifreq, NULL);
 }
 
+static int compat_ifreq_ioctl(struct net *net, struct socket *sock,
+			      unsigned int cmd,
+			      struct compat_ifreq __user *uifr32)
+{
+	struct ifreq __user *uifr;
+	int err;
+
+	/* Handle the fact that while struct ifreq has the same *layout* on
+	 * 32/64 for everything but ifreq::ifru_ifmap and ifreq::ifru_data,
+	 * which are handled elsewhere, it still has different *size* due to
+	 * ifreq::ifru_ifmap (which is 16 bytes on 32 bit, 24 bytes on 64-bit,
+	 * resulting in struct ifreq being 32 and 40 bytes respectively).
+	 * As a result, if the struct happens to be at the end of a page and
+	 * the next page isn't readable/writable, we get a fault. To prevent
+	 * that, copy back and forth to the full size.
+	 */
+
+	uifr = compat_alloc_user_space(sizeof(*uifr));
+	if (copy_in_user(uifr, uifr32, sizeof(*uifr32)))
+		return -EFAULT;
+
+	err = sock_do_ioctl(net, sock, cmd, (unsigned long)uifr);
+
+	if (!err) {
+		switch (cmd) {
+		case SIOCGIFFLAGS:
+		case SIOCGIFMETRIC:
+		case SIOCGIFMTU:
+		case SIOCGIFMEM:
+		case SIOCGIFHWADDR:
+		case SIOCGIFINDEX:
+		case SIOCGIFADDR:
+		case SIOCGIFBRDADDR:
+		case SIOCGIFDSTADDR:
+		case SIOCGIFNETMASK:
+		case SIOCGIFPFLAGS:
+		case SIOCGIFTXQLEN:
+		case SIOCGMIIPHY:
+		case SIOCGMIIREG:
+			if (copy_in_user(uifr32, uifr, sizeof(*uifr32)))
+				err = -EFAULT;
+			break;
+		}
+	}
+	return err;
+}
+
 static int compat_sioc_ifmap(struct net *net, unsigned int cmd,
 			struct compat_ifreq __user *uifr32)
 {
@@ -3179,6 +3226,8 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
+		return compat_ifreq_ioctl(net, sock, cmd, argp);
+
 	case SIOCSARP:
 	case SIOCGARP:
 	case SIOCDARP:


