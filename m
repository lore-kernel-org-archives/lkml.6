Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214643-2-3551872207750695704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214642; b=P6brEYZUy2kxx5WWp5dIztdr66gYkQ4Lq0exf0t0iBq36wX
    jhvww9MaT22q2oraFpxkv+0uNYmyL3HhsfhGKI643BShoFSFxVe/kZPwKZ1RUSIw
    Se/AknoCpQH/1WPPj3Zs57BS7ZupWKPlgFFN49fuPymWyEMuml3seIgWEdr72uxc
    sUJxKXRR56o+DMJOH8BVBCkgg64ayjDjsNjZ2LUsBmK5SFQUuoxJ2HAOzJzaKkYp
    NphWuviw5YbrDBo+H4PHogHi+QSv11BHdYy7CG6EDL58tSgJbZlTbXE1GE+NW8eN
    E28Ux36cZYsULqvcSel3+QROEMo3nKU6l+U7rWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214642; bh=6pXg3gg/TavSUSB3rOtDSHOzPZ
    rtZd8c4za/VtNv2BY=; b=vgUf+6VOFQ/jh45GP0EWBh1Mt/qCJV32CeFVyVb/z+
    5kaSddxl3g4DeznxP91+OmBdqpfgVxkcuzqW6EUuadhK949uamdbqY7iaCSVonXK
    XfgFgot69KH5a2jM8upM+MBv3nOHXW0wnJODKIYvnRWm8ztmOGyMKswnNmLvkOZl
    n8undepCoNcXMhwui/je94sHzeKot3JyosX/NHzy4JFwY7rEALOxRlO+golNEyqi
    dxiQBSfd5YHGDxWCND37jcbu/MBdWOG6mdMyc4uG8W3xOWYHMjX3lnEtU+0z6tw4
    Fq5sliC+Bg6JMHBAa0iRQQWpkPQev88bidCphJzpEWOg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934415AbeCPPhT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:37:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934414AbeCPPhR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:37:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Limin Zhu <liminzhu@marvell.com>,
        Xinming Hu <huxm@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 077/109] mwifiex: cfg80211: do not change virtual interface during scan processing
Date: Fri, 16 Mar 2018 16:23:46 +0100
Message-Id: <20180316152334.161595342@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
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

From: Limin Zhu <liminzhu@marvell.com>


[ Upstream commit c61cfe49f0f0f0d1f8b56d0b045838d597e8c3a3 ]

(1) Change virtual interface operation in cfg80211 process reset and
reinitilize private data structure.
(2) Scan result event processed in main process will dereference private
data structure concurrently, ocassionly crash the kernel.

The cornel case could be trigger by below steps:
(1) wpa_cli mlan0 scan
(2) ./hostapd mlan0.conf

Cfg80211 asynchronous scan procedure is not all the time operated
under rtnl lock, here we add the protect to serialize the cfg80211
scan and change_virtual interface operation.

Signed-off-by: Limin Zhu <liminzhu@marvell.com>
Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1116,6 +1116,12 @@ mwifiex_cfg80211_change_virtual_intf(str
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	enum nl80211_iftype curr_iftype = dev->ieee80211_ptr->iftype;
 
+	if (priv->scan_request) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "change virtual interface: scan in process\n");
+		return -EBUSY;
+	}
+
 	switch (curr_iftype) {
 	case NL80211_IFTYPE_ADHOC:
 		switch (type) {
