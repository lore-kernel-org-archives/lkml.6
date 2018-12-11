Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA6EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0952084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544910;
	bh=zmp/Afx/5HvyA/LxB/DX4IZ8l6CbA6pM7CnE+kb2W0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xbd7++V4OkrWHBCuHTMqK0W53lV6x1iDFVMwZI4gIydXO7BwSvNJ3/9HXWBtlhxbb
	 9wYxp5Ql/0z8sOZ23n26MmhxvtKw+wevDtwzDmL4NzJ4TcjPy7kdHa9070rGHV4+Of
	 u/E/u6Ko8o17SjnpEOCoLerqqbmyevy/To7J8wZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0952084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeLKPsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbeLKPso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A2620870;
        Tue, 11 Dec 2018 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543324;
        bh=zmp/Afx/5HvyA/LxB/DX4IZ8l6CbA6pM7CnE+kb2W0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sspVu4Ir2gvF0anHaFo+th6br05n6SYPOHTmv7mawbamalLkwc76Tydl+BnkMPPlQ
         B0oo7lkQxa+jGBa7YJlAFHji8zLx0d2COxoXbjrD3wZiQBK7TIZ4vUUDvjKSUSBrZU
         HgOT7SxN9BnddaXZUCOyzITwTDWJBOctSy3LNZKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 91/91] mac80211: ignore NullFunc frames in the duplicate detection
Date:   Tue, 11 Dec 2018 16:41:50 +0100
Message-Id: <20181211151614.389716789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 990d71846a0b7281bd933c34d734e6afc7408e7e upstream.

NullFunc packets should never be duplicate just like
QoS-NullFunc packets.

We saw a client that enters / exits power save with
NullFunc frames (and not with QoS-NullFunc) despite the
fact that the association supports HT.
This specific client also re-uses a non-zero sequence number
for different NullFunc frames.
At some point, the client had to send a retransmission of
the NullFunc frame and we dropped it, leading to a
misalignment in the power save state.
Fix this by never consider a NullFunc frame as duplicate,
just like we do for QoS NullFunc frames.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=201449

CC: <stable@vger.kernel.org>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1109,6 +1109,7 @@ ieee80211_rx_h_check_dup(struct ieee8021
 		return RX_CONTINUE;
 
 	if (ieee80211_is_ctl(hdr->frame_control) ||
+	    ieee80211_is_nullfunc(hdr->frame_control) ||
 	    ieee80211_is_qos_nullfunc(hdr->frame_control) ||
 	    is_multicast_ether_addr(hdr->addr1))
 		return RX_CONTINUE;


