Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDA8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690E62146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcYVzLqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690E62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeLDLAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbeLDLAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59ACC2087F;
        Tue,  4 Dec 2018 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921220;
        bh=wtVx14OOD1E5wWaajC87aGsT/gfnUSj+mnC2i3nq8kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcYVzLqAOkOWmVufZIsCAuENEini0XQ9EqCZRjWwoRQzGNwejNIpmrbU9GDzK0SYu
         0qFkb31oy0eCUEAXbBog0uV1qFB76PNxd+NeBl3xUciT192FQab93OIVYK7JnhzK7v
         0sJn8CWrMWNu5rUtBLZwmKLdtl/U7e6Z74I/jWdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, youling257 <youling257@gmail.com>,
        u.srikant.patnaik@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4.19 128/139] staging: rtl8723bs: Fix incorrect sense of ether_addr_equal
Date:   Tue,  4 Dec 2018 11:50:09 +0100
Message-Id: <20181204103656.008256903@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Larry Finger <Larry.Finger@lwfinger.net>

commit c948c6915b620f075496846df8d4487ee0c56121 upstream.

In commit b37f9e1c3801 ("staging: rtl8723bs: Fix lines too long in
update_recvframe_attrib()."), the refactoring involved replacing
two memcmp() calls with ether_addr_equal() calls. What the author
missed is that memcmp() returns false when the two strings are equal,
whereas ether_addr_equal() returns true when the two addresses are
equal. One side effect of this error is that the strength of an
unassociated AP was much stronger than the same AP after association.
This bug is reported at bko#201611.

Fixes: b37f9e1c3801 ("staging: rtl8723bs: Fix lines too long in update_recvframe_attrib().")
Cc: Stable <stable@vger.kernel.org>
Cc: youling257 <youling257@gmail.com>
Cc: u.srikant.patnaik@gmail.com
Reported-and-tested-by: youling257 <youling257@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -109,12 +109,12 @@ static void update_recvframe_phyinfo(uni
 	rx_bssid = get_hdr_bssid(wlanhdr);
 	pkt_info.bssid_match = ((!IsFrameTypeCtrl(wlanhdr)) &&
 				!pattrib->icv_err && !pattrib->crc_err &&
-				!ether_addr_equal(rx_bssid, my_bssid));
+				ether_addr_equal(rx_bssid, my_bssid));
 
 	rx_ra = get_ra(wlanhdr);
 	my_hwaddr = myid(&padapter->eeprompriv);
 	pkt_info.to_self = pkt_info.bssid_match &&
-		!ether_addr_equal(rx_ra, my_hwaddr);
+		ether_addr_equal(rx_ra, my_hwaddr);
 
 
 	pkt_info.is_beacon = pkt_info.bssid_match &&


