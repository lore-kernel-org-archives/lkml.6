Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0112174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ScwIvGiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0112174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeHCMgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:36:47 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:62374 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbeHCMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:36:47 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180803104101epoutp02312b24444d3b2d31a2cd6bca78088ea3~HWbv1wx6t3090230902epoutp02d;
        Fri,  3 Aug 2018 10:41:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180803104101epoutp02312b24444d3b2d31a2cd6bca78088ea3~HWbv1wx6t3090230902epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533292862;
        bh=buwWqtZJ5FzwNh9+tqWLi1CsEFWWvcmHeWsVNa8cny0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ScwIvGiZEBH5/yM5ByD29QJ7xWFclZ8A2Eg2XGjr2ywgUxkfUWP6scJgTWqgHodL/
         JuHRGtGOtKcUtHYkX1A3ck9HYGJ9Doz5VmX3cZJoQzrZKYlgP6+duDBJlkuF/1RQUM
         gKjknM+YC60XcEPSMmtbq93CL4B33+OGb1AlYB0k=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.192]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180803104059epcas5p22cc91545670a63e314d99f32e3383b58~HWbtFwWXE0846008460epcas5p2A;
        Fri,  3 Aug 2018 10:40:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.55.04292.A31346B5; Fri,  3 Aug 2018 19:40:58 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180803104058epcas1p1d5cdd51e2774d72679aaf15358cb3d00~HWbsx78UQ3105931059epcas1p1F;
        Fri,  3 Aug 2018 10:40:58 +0000 (GMT)
X-AuditID: b6c32a38-d53ff700000010c4-b2-5b64313a492a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id C3.46.03704.A31346B5; Fri,  3 Aug
        2018 19:40:58 +0900 (KST)
Received: from ktvijayakumaar-ubuntu.sa.corp.samsungelectronics.net
        ([107.108.86.199]) by mmp2.samsung.com (Oracle Communications Messaging
        Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCV003WVSAV2300@mmp2.samsung.com>; Fri, 03 Aug 2018 19:40:58 +0900 (KST)
From:   "K.T.VIJAYAKUMAAR" <vijay.bvb@samsung.com>
To:     kvalo@codeaurora.org, davem@davemloft.net,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cpgs@samsung.com, vijay.bvb@samsung.com
Subject: [PATCH 1/1] ath10k: avoid possible memory access violation
Date:   Fri, 03 Aug 2018 16:10:05 +0530
Message-id: <1533292805-9709-1-git-send-email-vijay.bvb@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSa0hTYRj229nOjubiME0/Fsg44A8V585w82ialhcWmUhCYUPsNA9z6C7t
        bK71RynJu6kgaFjNHJFCUnOFiETNvIOKK9S0CH/lLSyR8EK1efTX97zP5X1fPl4MEbcJJJje
        aGUsRrqcQEP4b0diEuJTyBKNvKf5HLU6P4ZQa94Yqmu2mk896+1GKd9QF0ptvlgRUmPOCOrl
        1EeQgal9zU08tad3iacecFWqmz19QL3jjsoX3GBSSxm6hLFIGaPWVKI36tKIywXFmcVKlZyM
        J5OpJEJqpA1MGpGVmx+foy/3L0JIK+hym5/Kp1mWSDifajHZrIy01MRa0wgNSSpkpDxJplD4
        X2VRikLpt9xkSt0b3/lmd8idx/fnhVVgEasHwRjEE6Fr9gmoByGYGB8EsG2qE+WKPwD+etbO
        P3Ettjw6Fl4B6No8QLiigweHd/aFAReKy+Hk7PJRr3C8B8CB1mleQEDwOLgw4UICOAzPhN8W
        2tEA5uPRsPPzV38Aw0R4FmzqlnLTouDSTN3RAIjvCeDhig/hhCxYvV6FcjgMro97hIEsxM/C
        +dE0jq6E2/01Qi7bCOD4/sRxNh129LxBuH1Ow5+7jQIuK4K1D8ScRQ0/fZgUBLAYL4L9Q7to
        C4BOENQHIhgza9AxLGlOlLG0gbUZdTKtyeAGR/cQSw2C4ZlcL8AxQISK5qK1GrGArmAdBi+A
        GEKEi7bq/JSohHbcZSymYoutnGG9QOn/gVZEckZr8l+X0VpMKhUqlTw5KVlFySkiUqTIK9CI
        cR1tZcoYxsxYTnI8LFhSBewOD+q7YIhxjX0ZPRz6Yc987rh0YDAo9U1x+kJPw793K9dEdu/W
        rnF2MfvK+0T8QJkz+lAiObVWN7PtCI3UzO3l3ePXly3dSnVeXxufhwvpntcNT612b+TG74Ls
        SkENclhxW1kbdFHlOlzNUONXp/OmTSN/+euTvGVnIZVN8NlSmoxFLCz9H35WN50lAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJMWRmVeSWpSXmKPExsVy+t9jQV0rw5Rog4/7VS0eXTrGbPHykKbF
        nPMtLBaLVi5ks7i8aw6bxZsVd9gtji0Qs1h76gijA4fH5b5eJo8tK28yeWxeUu/Rt2UVo8fn
        TXIBrFFcNimpOZllqUX6dglcGZteP2Ap2MRVMbf5EnsD4w2OLkZODgkBE4kbE2axdTFycQgJ
        rGOUuD/rEhOEM4tJYvLnSewgVWwCBhInz99mBEmICCxmlGh/do0NJMEsoC1x/cQSZhBbWMBZ
        4t71qWBxFgFViZlX7wI1cHDwCrhI9C5UgNgmJ3HzXCfzBEauBYwMqxglUwuKc9Nzi40KDPNS
        y/WKE3OLS/PS9ZLzczcxAkNj22Gtvh2M95fEH2IU4GBU4uG9oJocLcSaWFZcmXuIUYKDWUmE
        920nUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQZG7Vs3
        GWV+3l28qXLXovUzP+6e/3PbttOs0t9y+xW+q2tHn9HaH3X4ncsG3/L7SW/jw++senNH5dTr
        5uOh/i2Msr7zayYvOaN8dlnP5nS2bbpirM63/8cv/3fnvsnHqtLbu0vnqDnwpM3uVhdgaJPY
        ee1rwYr3B+9JLY276P9X4ZKb55wPe9xjjiuxFGckGmoxFxUnAgDD1g+8CQIAAA==
X-CMS-MailID: 20180803104058epcas1p1d5cdd51e2774d72679aaf15358cb3d00
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180803104058epcas1p1d5cdd51e2774d72679aaf15358cb3d00
References: <CGME20180803104058epcas1p1d5cdd51e2774d72679aaf15358cb3d00@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

array "ctl_power_table" access index "pream" is initialized with -1 and
is raised as a static analysis tool issue.
[drivers\net\wireless\ath\ath10k\wmi.c:4719] ->
[drivers\net\wireless\ath\ath10k\wmi.c:4730]: (error) Array index -1 is
out of bounds.

Since the "pream" index for accessing ctl_power_table array is initialized
with -1, there is a chance of memory access violation for the cases below.
1) wmi_pdev_tpc_final_table_event change frequency is between 2483 and 5180
2) pream_idx is out of the enumeration ranges of wmi_tpc_pream_2ghz,
wmi_tpc_pream_5ghz

Signed-off-by: K.T.VIJAYAKUMAAR <vijay.bvb@samsung.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 877249a..23502cd 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4721,6 +4721,13 @@ ath10k_wmi_tpc_final_get_rate(struct ath10k *ar,
 		}
 	}
 
+	if (pream == -1) {
+		ath10k_warn(ar, "unknown wmi tpc final: pream_idx[%u], chan_freq[%u]\n",
+			    pream_idx, __le32_to_cpu(ev->chan_freq));
+		tpc = 0;
+		goto out;
+	}
+
 	if (pream == 4)
 		tpc = min_t(u8, ev->rates_array[rate_idx],
 			    ev->max_reg_allow_pow[ch]);
-- 
2.7.4

