Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9478C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E1C20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e2QVZ33u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E1C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbeJAHSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:18:00 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730209AbeJAHRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5ioZBYHU7OkF5oR5IDWuENfZxT80o3vDcwzu1VFrCg=;
 b=e2QVZ33uI97TXclfYzBKow+6gADZzyZt5HdQ4Ap2lk5ECiD4xUac7yyEjyMFZNmUgfUsYCwfyFB0DwhMViL+q5f3L6lnMRcoMw0cf46jM03VSoyq18bVyk+fh5vGbMeBj+jd98XL1XL/5D9wERzXwUq6oLt/3qWUz/eC8+JPGpI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 04/13] USB: yurex: Check for truncation in
 yurex_read()
Thread-Topic: [PATCH AUTOSEL 3.18 04/13] USB: yurex: Check for truncation in
 yurex_read()
Thread-Index: AQHUWR+IDPtP1KdBZUGAwFj+cjCdlg==
Date:   Mon, 1 Oct 2018 00:41:46 +0000
Message-ID: <20181001004139.147341-4-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:sAxg0ASEWg6u18dmniz0/CrezRu9if09p+yEjx9IiZR7tYdKUmzlnKKHFPcAKvQFngx2MAuktjzo3OtBQ1OL0TIqfQJlozyxZ7nwih6GyJ4nZD9bg9ZWSojlZ1p0umHvWM02vJFJuV9oIlKQgRurFnf08p7nnO2nWPlj7zjJAookglSCYb5EpPFc/nKHg/8iXgzCZYm8iVqgBgfpZVXsYz8wXVgV9oiikG5a0aUrnPq+/zt+YD3enx1Bo/h7l1NoMfcPytRD+ZYjm4URgqd3eW0b0lM8dBeMaz+6jFIkojERpcGpQ6q6ayE5dwfNeYGsfpMkh2qe3hafmyjmGu1tmC481tbuZQv61xG0rvGlIAG1EvPFxJpZnCBw56AeBqPnRIZNvLOO7MtQHsep2i5QOwPB+0WJRptaARtMNMnjKAL7kY5XL6PQiJyMx0ToADrFNT1yEHavRpsrfLDL86D2Ig==;5:0jX67xJKtTrw1Ht5vGdQPxE2r+ySVakHWqUaBjIA812rMVOxpL9t0O2Kdoe3FvsaT41LQQR+AMM4lJpaQoMPfrBu0u1xemPpkTXFGy7OB1qrs4zDJaw9gV5OskkENe3PNETyWMgbFtFeBXmWVTTMpPeOUneIbTjmSAtVnKMK5KE=;7:2bkQUMkFeKmeAFfIFoebrQQcJZGGdZ0Mw5OervneSX+s7+xBTy3t9koElha71kBw5IHHOS05Qab0M7F99gcQM788/pVaRgByHfaLNNT/Wr5Z1xQhL/qFhD0gQ8zhVamXacbo958AdMKz5oVgikiQRV42+q0Ayw+/49wDcOqQ1ojcIIv1tKraVDYAqWhLizKt3iyQRLwdbqj6moyzQTBkArPK503oC0YNc9u2+KiMTNyXcuG3rLIPH342tHYYmjMm
x-ms-office365-filtering-correlation-id: 8836a536-fd85-46e7-3652-08d62736aa8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB079199306D962809BEAE35FAFBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WUeX6NHdgagfDQ2GWKDt7ZcSIPFBke2BNKWoQ3EOgNgXKP9INqyiPGbjo2a3G5tJCvOqNuxnpIGijE/9D6Slh9gMpq8W5cfNknYnijQnJZ/dP7KpX1tzc6Pwz+n8/rAvhr+PRWbHvjokiRtxnSEoFpjTaUnXIIWe8fUhL2DY61QCv4zkRe71d/ZaHyAtggWraVJUo8dIHquYytfMY7hH9AzDAIhsHdtqFy72H30fc0bwB+rzmLJ66i80FqJdOedy2eRPcK+lelFQyXji9by7050G9D91AivWz4WhuvbONrLLtOF9wpKGHssgkpUhn/v6gJYQuUd4wSsnt3ymgr/CBDtAdx7BzZyx6/shrFJoY40=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8836a536-fd85-46e7-3652-08d62736aa8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:46.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

[ Upstream commit 14427b86837a4baf1c121934c6599bdb67dfa9fc ]

snprintf() always returns the full length of the string it could have
printed, even if it was truncated because the buffer was too small.
So in case the counter value is truncated, we will over-read from
in_buffer and over-write to the caller's buffer.

I don't think it's actually possible for this to happen, but in case
truncation occurs, WARN and return -EIO.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/misc/yurex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 83eaccfa9ee5..fbcb1cd4c118 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -430,6 +430,9 @@ static ssize_t yurex_read(struct file *file, char *buff=
er, size_t count, loff_t
 	spin_unlock_irqrestore(&dev->lock, flags);
 	mutex_unlock(&dev->io_mutex);
=20
+	if (WARN_ON_ONCE(len >=3D sizeof(in_buffer)))
+		return -EIO;
+
 	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
 }
=20
--=20
2.17.1
