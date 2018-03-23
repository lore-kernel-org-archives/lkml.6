Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804130-2-16862216561779658965
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
    t=1521804129; b=lqonXnjGk0UR1vhLe+349PxUq4Q7QBZNDhEgLPeRu29DqOJ
    HC6Dr60r8AITj1SozIcM2I1R1xsQIfczL9cpXgAv1bwDNx1o1yQ73ou6/DodILoU
    8xTFF4mkn4dEC3DMcAZDRoKtnjWOtivmISfNXPTbySOs1iXQ5Z5SapI8HoqHl/Iv
    A4xDvv2OoQdk6U6DQQ/8U6Ynohi9Wr6bNi21RQTxtXiDkr742Bxu3zUVyRxDITsb
    P5e6wHaxELFCXa+DUFdfq46KX5/rb4CXhEhpUuNjyoOzmWnjq3POQsUSY0ZlGO2N
    Ds7jCGl/nfnciqrhlZwb9pLSHM+bBZprinaun+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804129; bh=67WGen8AB3Kniv3ms56S5YwTzR
    XnJBzQ64hlsDM3OOE=; b=MfYWNx0+D4R83djmKNh0E6OnBjG1TycUqK/AgL09em
    3uawZufQQTzNkUKtrol1hjl2LDxCbJTDx2a6YnsXf2+uCV+WLjReVJzKoeGGkHZb
    3T4TsZNAoMV3kBp0PNxp5nczLu39ZB8vLlJ//8ymquCaOwPON+ep34pbDUKjt3Cj
    NkJvrp49hLDSpi9J29RbKsWEKqh11l8lKepMU/ISjV+A7NIxYiBsw8nwO/LfCW7z
    l8zQksbmO5IoaCxHc3QxVvAaA1Wpy8cak31k+q0tkpD8k2DaAV3Bzq41NzGQpjG/
    7Z/1pxxXaqrlqhnoDixCM8wOr4l1veCXiOezXOK7V76w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCWLVz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:21:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755515AbeCWKIT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 080/177] mac80211: dont parse encrypted management frames in ieee80211_frame_acked
Date: Fri, 23 Mar 2018 10:53:28 +0100
Message-Id: <20180323094208.834059742@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


[ Upstream commit cf147085fdda044622973a12e4e06f1c753ab677 ]

ieee80211_frame_acked is called when a frame is acked by
the peer. In case this is a management frame, we check
if this an SMPS frame, in which case we can update our
antenna configuration.

When we parse the management frame we look at the category
in case it is an action frame. That byte sits after the IV
in case the frame was encrypted. This means that if the
frame was encrypted, we basically look at the IV instead
of looking at the category. It is then theorically
possible that we think that an SMPS action frame was acked
where really we had another frame that was encrypted.

Since the only management frame whose ack needs to be
tracked is the SMPS action frame, and that frame is not
a robust management frame, it will never be encrypted.
The easiest way to fix this problem is then to not look
at frames that were encrypted.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/status.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -200,6 +200,7 @@ static void ieee80211_frame_acked(struct
 	}
 
 	if (ieee80211_is_action(mgmt->frame_control) &&
+	    !ieee80211_has_protected(mgmt->frame_control) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_HT &&
 	    mgmt->u.action.u.ht_smps.action == WLAN_HT_ACTION_SMPS &&
 	    ieee80211_sdata_running(sdata)) {
