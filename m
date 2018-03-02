Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519981095-2-7906425533939038927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981095; b=vXmAvG5IZ847+n6lU2o1Lcoq9kVR7HPuws7EcNGLtfiBP6w
    zscVZlRAoiJhY0rjQ8Z//AXChNa+xFGGdMNCRtm1h0SCn9ogGDFKk7kjMsJrEUns
    2Q/5WE/AMNsP8vcNDk1FTysrYcaSpw+XGIYtfmtO+jHDKj5BlEk0eMll7IdYAT8E
    0qbhQ+tyq56wRd80X6Gd5eiZaIW0uCv7+Rw3t2jqVCnM4kCTibnwOC92ciyVYtcx
    Q+0/fAQzjtpnQny+R33S2ASBpmGuhl/4KKjxeeJU9Pvul/mKtlvglPjQCeYC9gGe
    05xsRfl8irnqVzrFdwVXAXpmf3StCXg0Jx/k1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981095; bh=9ERH1cEkryGQzxqroT5A+GVtO5
    XqSiiglgWHbc5CjPo=; b=uM1QshlUt7F8tYffbZsJZ/dWwZO0JYiaTe3XqzFl7N
    55iMCB9x4nX+DtDcpemDHgR0xztLMZpnc2m7VwU5DMjoIL1Zk0dPWz5YIFZpRkWw
    PqmRnlaTNAdT3POe3Eq3QhmTVjbEqFi1h9eb+JxrwhHDUJfBR1SCILVa3zQRypTF
    Mvitwk70+K21lRBYLEK3tEpWI2dwBoc7vaesfokZG8OU5CnOUo7XCKtC1aIs41uv
    15L4BMbrBzATS/xozfZWsaoZfXanYO12XnoAOEKGkNFE2XQ9pEqN3OR9EgfWglZU
    +M3yqzlPa4VGDrxng4XEEc2T4NzNiRhp90EzmpQYPMUw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424169AbeCBI6M (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:58:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52616 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423251AbeCBI6L (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:58:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gui Iribarren <gui@altermundi.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 45/56] mac80211: mesh: drop frames appearing to be from us
Date: Fri,  2 Mar 2018 09:51:31 +0100
Message-Id: <20180302084451.829492398@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit 736a80bbfda709fb3631f5f62056f250a38e5804 ]

If there are multiple mesh stations with the same MAC address,
they will both get confused and start throwing warnings.

Obviously in this case nothing can actually work anyway, so just
drop frames that look like they're from ourselves early on.

Reported-by: Gui Iribarren <gui@altermundi.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/rx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3611,6 +3611,8 @@ static bool ieee80211_accept_frame(struc
 		}
 		return true;
 	case NL80211_IFTYPE_MESH_POINT:
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return false;
 		if (multicast)
 			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
