Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B22C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FE720855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543953;
	bh=W0ihdPsMQJky1R+o4iPgHKclaxeC2oiVJc644vZ2CIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A3KBaSkZyK7B/gdOvCjobfuWZRdOIe09p9Qmb0cY5n8egaf/p0cFchQRNkQp/G+eF
	 wYz/QGdqJizQ9emIR7O9OF/ci3Nbgj2zF7djxfktZ91bGj47kwGCBAKKdW71xiF+qP
	 nzoHIuAMl2PftvAaSHJZuNymC4kIttOjjoBOP26o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FE720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeLKP7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731150AbeLKP7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:59:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141DA2086D;
        Tue, 11 Dec 2018 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543948;
        bh=W0ihdPsMQJky1R+o4iPgHKclaxeC2oiVJc644vZ2CIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8BCzA5t5tUx81VQJsj68oAn+6kxl5yXoDuwO9vymaurs8C5u0T5VC7bGTG/xtsAn
         0R9//kMXbdd4jg13GnkG/ILF0SMVPEX+zCvrCNO2UnQjgSJHRYeK/oIQrd+qsxoG63
         CxujKGkJOm7OO0aAAu0uLvPWKbL/65QHwiPh+wsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jouni Malinen <jouni@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 111/118] cfg80211: Fix busy loop regression in ieee80211_ie_split_ric()
Date:   Tue, 11 Dec 2018 16:42:10 +0100
Message-Id: <20181211151648.745981808@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jouni Malinen <jouni@codeaurora.org>

commit 312ca38ddda64bac6513ec68e0ac3789b4eb44dc upstream.

This function was modified to support the information element extension
case (WLAN_EID_EXTENSION) in a manner that would result in an infinite
loop when going through set of IEs that include WLAN_EID_RIC_DATA and
contain an IE that is in the after_ric array. The only place where this
can currently happen is in mac80211 ieee80211_send_assoc() where
ieee80211_ie_split_ric() is called with after_ric[].

This can be triggered by valid data from user space nl80211
association/connect request (i.e., requiring GENL_UNS_ADMIN_PERM). The
only known application having an option to include WLAN_EID_RIC_DATA in
these requests is wpa_supplicant and it had a bug that prevented this
specific contents from being used (and because of that, not triggering
this kernel bug in an automated test case ap_ft_ric) and now that this
bug is fixed, it has a workaround to avoid this kernel issue.
WLAN_EID_RIC_DATA is currently used only for testing purposes, so this
does not cause significant harm for production use cases.

Fixes: 2512b1b18d07 ("mac80211: extend ieee80211_ie_split to support EXTENSION")
Cc: stable@vger.kernel.org
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/util.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1418,6 +1418,8 @@ size_t ieee80211_ie_split_ric(const u8 *
 							  ies[pos + ext],
 							  ext == 2))
 					pos = skip_ie(ies, ielen, pos);
+				else
+					break;
 			}
 		} else {
 			pos = skip_ie(ies, ielen, pos);


