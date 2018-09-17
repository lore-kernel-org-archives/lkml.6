Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB93ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD452098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tQZTqfHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD452098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeIQUhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:37:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54791 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbeIQUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:37:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180917151004euoutp01b987fa2fff3f960f891ea2c12ca832fc~VOIfeso7-2472624726euoutp019
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:10:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180917151004euoutp01b987fa2fff3f960f891ea2c12ca832fc~VOIfeso7-2472624726euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537197004;
        bh=u0fOrNBAhzxLln+0luypVqlDhZp6633mF0mVbbx2fiI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tQZTqfHO6Wpq8eSV3LYw9gzzvjs2C7wKzRAboBspndB/lz3CK5n4bM/WkUun6/PPE
         oTxB3QG6q85aoKnuORNmHP0PCRTGuAj1e0yCc0hvxoXPXw5Fx5cnHgitIhUmo/LHaF
         jRwvg6yG1Ot8ylQfTgSRmQXG6+CxfloG3IaTC7Jg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180917151003eucas1p1e5afbf73e5aef6d48897a162bf7327fd~VOIe7KFuU1197111971eucas1p1U;
        Mon, 17 Sep 2018 15:10:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.34.04294.AC3CF9B5; Mon, 17
        Sep 2018 16:10:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd~VOId3-CTL2961529615eucas1p2I;
        Mon, 17 Sep 2018 15:10:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180917151001eusmtrp28a29a5c41b9adaad5cd7ac777c422da0~VOIdl2M462674126741eusmtrp2n;
        Mon, 17 Sep 2018 15:10:01 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-b2-5b9fc3ca52a2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CF.36.04128.9C3CF9B5; Mon, 17
        Sep 2018 16:10:01 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180917151001eusmtip22c3ee9f4ee7974a56063a04df497f004~VOIdF1MhZ2369023690eusmtip2i;
        Mon, 17 Sep 2018 15:10:01 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     linux-crypto@vger.kernel.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/4] crypto: s5p-sss: Fix and add aes-ctr support
Date:   Mon, 17 Sep 2018 17:09:26 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned3Th+dHG/zZymixccZ6Vovju5cy
        Wsw538Ji0f1KxqJv339Gi/PnN7Bb3L/3k8ni8q45bBYzzu9jsvj/q5nZgctjy8qbTB7bDqh6
        bFrVyebxb+EUFo+D7/YwefRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfG528zmQrOsFd8XHuV
        vYFxIlsXIyeHhICJxMWXl9m7GLk4hARWMEp8WL2IBcL5wihxdXMzE4TzmVGi++FnVpiWlnNX
        2SASyxkl7k3/wQbX8m5tFxNIFZuAqcTtu5+AEhwcIgIKEvO+6oCEmQVamCV+reYEsYUFXCR2
        9G9lB7FZBFQlLny6wQSxQE7i5rlOZgj7M5vEgqvpIDavQJnE8vW3oe52kZj04TmULSzx6vgW
        dghbRuL/zvlgV0sINDNK3PpyjRXCmcAocXB1FwtElbXEphuvmECOYxbQlFi/Sx8i7Cjx++5G
        ZpCwhACfxI23ghA380lM2jYdKswr0dEmBFGtJvF6yxY2mLUvPn9lhCjxkNj3SRXEFBKIlXjw
        wHsCo9wshE0LGBlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBCaN0/+Of9nBuOtP0iFG
        AQ5GJR7eBQvmRwuxJpYVV+YeYpTgYFYS4WXmAwrxpiRWVqUW5ccXleakFh9ilOZgURLn5dNK
        ixYSSE8sSc1OTS1ILYLJMnFwSjUwCtruLLhWVM+inJglNj9AeWrqgxtF1plOlvF612MeCX+3
        79EM8ve9elmjwOtUllSBx6Wl8+2n/0o0XR3Dofnmzp2H22ROnA1UnBnqyzsjuNGE68Un1YXt
        vxYmrf/6ZEWhTK294ESjimtFFxjlTDRXs4YJHewT7N51fY+sdZ3HHDPhxVZ/1HcosRRnJBpq
        MRcVJwIAuDYI0xYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xe7onD8+PNlhxz8Ji44z1rBbHdy9l
        tJhzvoXFovuVjEXfvv+MFufPb2C3uH/vJ5PF5V1z2CxmnN/HZPH/VzOzA5fHlpU3mTy2HVD1
        2LSqk83j38IpLB4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
        PUNj81grI1MlfTublNSczLLUIn27BL2Mz99mMhWcYa/4uPYqewPjRLYuRk4OCQETiZZzV4Fs
        Lg4hgaWMEo9/nWWHSMhIzDvbB1UkLPHnWhdU0SdGie4vkxhBEmwCphK3734CSnBwiAgoSMz7
        qgNSwyzQxSwx40kHWLOwgIvEjv6tYENZBFQlLny6wQRi8wq4S+y6OZ0VYoGcxM1zncwTGHkW
        MDKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECAzZbcd+btnB2PUu+BCjAAejEg/vj0Xzo4VY
        E8uKK3MPMUpwMCuJ8DLzAYV4UxIrq1KL8uOLSnNSiw8xmgItn8gsJZqcD4ynvJJ4Q1NDcwtL
        Q3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjDM0e9k2/pdLLrypIZV776HIPu+e
        ZRVSL3PkjKcoMiZ/bJ7mXvbEWfL3U5eiCxJis5Zmck1Y97y0Uum1t4ueoEVjW7aHz+MFVsyh
        5abrlNfUXmezL2110Fvw7+6EV7c3vNDedPJ0QL9KQcaqb8cMzbvvnvv0eH5gbFB4MDeH3rJQ
        /8SXCTa3lViKMxINtZiLihMBD5xQgG8CAAA=
Message-Id: <20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd~VOId3-CTL2961529615eucas1p2I@eucas1p2.samsung.com>
X-CMS-MailID: 20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd
References: <CGME20180917151002eucas1p27689f043367e1bc64bf63bc402dffcdd@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds aes-ctr support in s5p-sss.c driver. Additionally it
it provides a fix, and a minor code cleanup.

Patch 1 contains a simple fix, of a possible race condition.
Patches 2-3 are code cleanup patches.
Patch 4 adds support for aes-ctr block cipher mode of operation.

Regards,
Chris

Changes in v2:
- pass dev->req directly to s5p_aes_complete in s5p_aes_interrupt
non-error path,
- move req asignment in s5p_aes_interrupt before if statement,
- change commit message and subject for patch 2/4,
- remove empty lines and add rationale in commit message for 
patch 3/4,

Christoph Manszewski (4):
  crypto: s5p-sss: Fix race in error handling
  crypto: s5p-sss: Fix Fix argument list alignment
  crypto: s5p-sss: Minor code cleanup
  crypto: s5p-sss: Add aes-ctr support

 drivers/crypto/s5p-sss.c | 113 +++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 48 deletions(-)

-- 
2.7.4

