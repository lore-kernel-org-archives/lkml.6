Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804701-2-15577464203901892841
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
    t=1521804701; b=fPdxp1vhBjRLZLMpr6jDJ7nB5QkYtPqqTDlArkkPhb3aJk8
    OfOZ3r0zf9x9fxwvPJnlDuj+7no9iNMMtT9qjyltdE15RvN8eZnhP4dojngo1nSz
    AqDu4XZKkht2hVc89xsrvPpHA9dLOsD/nxbshvFOUtlPuWsZRIM4j+SEOUkoaS/B
    PFxfAdU4zV8J4SuFAFwIQnED0fRxK65NZBSYO9Na3mEVy5X7vATEEvP608TmP0Tl
    fyP8pbKEYelD9zdq7+5c87zVzuTkQhCD+8Rd0FQuPTBuJD2PYmDH0LKc/tAp+aG4
    I510ZTH65hegb0/GHvFGZ+ysD2d/boCTsBWgtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804701; bh=KdryLDj591OeTc6qHupJ7VpmEc
    zC9lRsauaCOkrMPvw=; b=PXhA2ycRZHxcBcBTIHxRgW6iAipJ8F7roeB38ZM0DH
    g8K74aD1p6d6CCWqLc/vjDQBJfwx7Zj8OEJ4nABMzaGRGbCdpCZNpKadN1YyDZHp
    1tLBNAaigPqMIxiA4bCOHnoKCAd0d+8hbbe0LDPHNjuR/pNE7Zb9dg1vKSv+WuSr
    gZYUnKqXOXyKIqVvYHXPxWHRW7uR9rrEpcl58C5Pd1qqIgov+BZrjOnVMtYku5ha
    nXNKZg+kraRnddonIpTd0asggdpqyygyP7r/aF9u3AIREn7BiRf7rdOdWKXLR7In
    aiK7k9eZm9KH5SnvHtgwj2WD2PtFYLFccGnEBedeqzRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1755164AbeCWKGH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755146AbeCWKGA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 034/177] mwifiex: dont leak chan_stats on reset
Date: Fri, 23 Mar 2018 10:52:42 +0100
Message-Id: <20180323094206.669962569@linuxfoundation.org>
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

From: Brian Norris <briannorris@chromium.org>


[ Upstream commit fb9e67bee3ab7111513130c516ffe378d885c0d0 ]

'chan_stats' is (re)allocated in _mwifiex_fw_dpc() ->
mwifiex_init_channel_scan_gap(), which is called whenever the device is
initialized -- at probe or at reset.

But we only free it in we completely unregister the adapter, meaning we
leak a copy of it during every reset.

Let's free it in the shutdown / removal paths instead (and in the
error-handling path), to avoid the leak.

Ideally, we can eventually unify much of mwifiex_shutdown_sw() and
mwifiex_remove_card() (way too much copy-and-paste) to reduce the burden
on bugfixes like this. But that's work for tomorrow.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -146,7 +146,6 @@ static int mwifiex_unregister(struct mwi
 
 	kfree(adapter->regd);
 
-	vfree(adapter->chan_stats);
 	kfree(adapter);
 	return 0;
 }
@@ -636,6 +635,7 @@ static void mwifiex_fw_dpc(const struct
 	goto done;
 
 err_add_intf:
+	vfree(adapter->chan_stats);
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
 err_init_fw:
@@ -1429,6 +1429,7 @@ mwifiex_shutdown_sw(struct mwifiex_adapt
 			mwifiex_del_virtual_intf(adapter->wiphy, &priv->wdev);
 		rtnl_unlock();
 	}
+	vfree(adapter->chan_stats);
 
 	up(sem);
 exit_sem_err:
@@ -1729,6 +1730,7 @@ int mwifiex_remove_card(struct mwifiex_a
 			mwifiex_del_virtual_intf(adapter->wiphy, &priv->wdev);
 		rtnl_unlock();
 	}
+	vfree(adapter->chan_stats);
 
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
