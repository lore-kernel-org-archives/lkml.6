Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520451942-2-13199287867548355767
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
    t=1520451942; b=CRAOVD4+WCGF2hIO747kUxr0xo/B6ef4V1Tl3GxpLTkyQz8
    b/GfLr6Ku28KirnBSP5QxXo3tEYfXVZHzPQR6UoPfppTyljeMQBfsNcPql88eG/D
    tDrpuROwXf+tZm4C45YRdWc6dXtf6C4BbYwgveQ1uwFzxEm4mLyQkZUtedvo7B+z
    UjWMxyHQq4eUY7LUklNS48JwvdLxZ12YarF1P+TR0WRtPTTszbgIqvd/5JCH4SuF
    YKXiLQ63eVsfUumzOkeKlTG/VhYodg8kFD/cY8IM7zc5Y/dtRm9aPBQzA5iKwjdh
    yp7ge0jXn+Uz7nKYpBc5sN72Xe7OkSJOo84ZJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451942; bh=a+V3KqfoTEgZsxUiPiICRMgSSy
    eaFJ9K0FZkv2pmvEQ=; b=XQFKpAQTqGKQUSLn/JpkGw0237SMWIoN3/dZXorjYG
    doF/JDg+EBGp8ptDh4ZtiDud280EelqWxmC2ayDUCw+C7deueBtOsTQcoqy+hJq5
    0tPdy+JaIp+x1YEb8aa1OGjo9JTeMBbEP1pw5+iipTU8pUQMbDm1husz6z/YbQR2
    fCy2wLUNRWpAW4qwP++/8zT/itAsI+oDvshjoZq25UDAhM27RxlHjHCxrOvKJue3
    IvtmQegA3/o4JyoegrewQB/48S1eJLkV/C8anMvLvxjs6/dirCJYmW6PhyUbhGwW
    bpR50Ta3Bxc6w1IHm53UgubTLAk4tGo+I2/xympyvlBA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S965340AbeCGTpj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:45:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964807AbeCGTph (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:45:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 038/110] net: amd-xgbe: fix comparison to bitshift when dealing with a mask
Date: Wed,  7 Mar 2018 11:38:21 -0800
Message-Id: <20180307191044.626154537@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>


[ Upstream commit a3276892db7a588bedc33168e502572008f714a9 ]

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -595,7 +595,7 @@ isr_done:
 
 		reissue_mask = 1 << 0;
 		if (!pdata->per_channel_irq)
-			reissue_mask |= 0xffff < 4;
+			reissue_mask |= 0xffff << 4;
 
 		XP_IOWRITE(pdata, XP_INT_REISSUE_EN, reissue_mask);
 	}
