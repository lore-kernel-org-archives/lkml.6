Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333FC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB762083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nilmc+fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB762083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeJAHPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:08 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:18560
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729457AbeJAHPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swUg4xfWU3GxLfN+2qQFaFCqDo1BE2V7ABQn04TKrB4=;
 b=nilmc+fE+JGOvOBQkpXgr6OF1xPSKY0/dhVRP2jQG6bdEUa9s2kHJrHenlFfzMaBjFMv/mapGxGsNjujos4CHG9/x7ch3K6kJPBTdZSEpnsWFf8HaBoiL3kGqXHDKN3BEA7zr1Gkbvi0CjHRxFJj3JskbKuf5iVQBCH9p8m5whc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 15/37] USB: yurex: Check for truncation in
 yurex_read()
Thread-Topic: [PATCH AUTOSEL 4.14 15/37] USB: yurex: Check for truncation in
 yurex_read()
Thread-Index: AQHUWR8mrGEGXDbHlUK9HiUNQQPkBQ==
Date:   Mon, 1 Oct 2018 00:39:02 +0000
Message-ID: <20181001003850.147107-15-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:A02/M+sY44SaKV0A0IYIBP8QHwfi12fbVo71l+4SNrZrQd5K9YRLnslrHRvtTp8In3DM9ha3jYYCaHMe9MBrr8tFgkvXJ8IJbYRR/LYo/3vwYEeejV6k7wRbeiHxLAERWscWUVK/BI4tu2+GQg9E7yaEIYwTcicIKJV2/3e/tvhV4sRHda002R8DHUTlDPvEAtL6xCiK7ZG0es+FKI6NMc2B8sBOz+IpRQXvO27KBeZT2kSKz/YyQLmOUD8TLw1HhY3B5aBpiOBnmONdqIg45Y21RN0zLbKVYotyiFHiCHHCtp1l3dwiscZitHof7g+3/75xp5Hv9jJaF+OSatoFlRjBgFDB2Mnqjsb29ZfH+DfvL1HzROvZBmQR2KTpOequChxu78XxmTLlmRI/3OKBm/BXdTjtDcEN60BrWKfiS6yqysCmfneUggmuF37RPz6Nkx/u7gIbEPfcnreWMYkyfQ==;5:qqxdMacjENexwm9UxnonJsrSUScbrq8nV6tkCgKn21P6wiWFOWNxYd3abPD5n+Iy7pnyNw6vL8xIt4Xr4BLcVLww8GtuDEr1YafKumjx1SjG347HqRxxLm69t54psLMz5e6bsClUm4KWQpaqbs2aLzisdtExEgTeRIT36Y+IPxY=;7:q0idBfLmW+suAvS8fBCmIiC+kq1JSrobAVw+QSYmrkNU71OrMfywVRm5UtCBzqYWRJHwYVMpxUSWKwNA8MuwfpTSjRm8okCaj6k3avyW8+xVbvqCS5WWLVjWXwanFO1e2gNHG0gGWPyDnGYUiCMVU17lPPx0jW2PppOPJmEddIE5lKKWp/yQLG9miCQrE7hdxGcVukCS9gOBhMblSU6N3ngTrRBGh5Vwr7ghj+MtA1DRfFgAs/LP+f17R21fBL/Q
x-ms-office365-filtering-correlation-id: e879cccd-d293-4e2b-c2ad-08d62736611c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB085417C58D069B63B0B00603FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vtJUlET8c0ZgvQEPJLdg8K2MBvILDmFLWDrF+KKAJw044RMRl7z6ysYmuxMxa8ent2lkix79ztnAJrwdmg4gntiXCx282/NUIEvb6ABnAJ8uQ7aGZlTRT9i4kx1sQspjMSQk77Z+60aruhZwZOODP58r1rHmr/V4O5sDQNKbaKWB93M9Cu3xx70WHP8DXqyytBXGuwY835ESgBfnvzQiEd9JIpSvjNFlsAV87HqiQ4yp8Bmac4PyDuclrCinKqshh5ZvPyraZDayL5crv7BSzDfnUgaWuMQNfJqJX1gvM7SV+hBRXCJZtXGYcYQHhzx97dUguKlbE6rsx6hHKvFZ1p4mzqcfPa5xIVT1Bbg8gkg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e879cccd-d293-4e2b-c2ad-08d62736611c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:02.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
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
index 0673f286afbd..4f48f5730e12 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -417,6 +417,9 @@ static ssize_t yurex_read(struct file *file, char __use=
r *buffer, size_t count,
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
