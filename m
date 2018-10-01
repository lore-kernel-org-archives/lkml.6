Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAC5C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A0A2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="egeb9n3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A0A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeJAHNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:38 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeJAHNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbzJIiti1/N8UzHLJcAfstWqQubMaVzOH87JgSHLSS4=;
 b=egeb9n3q0gx6rETiL0W24klfaG68gqt8IQLzNYpczCvF+6VP/dzIjfszKcTpU1FdzmyOUPeaTBEgz/LhEOHcn+gz1XEaljmBpEzC+VeAW2O1J/EGEHq5SjKhSx0hW7SOFpzZ1NEbQyjGugtIw9quFUkhvvr4fUnxe7QbrzGQHcs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 24/65] USB: yurex: Check for truncation in
 yurex_read()
Thread-Topic: [PATCH AUTOSEL 4.18 24/65] USB: yurex: Check for truncation in
 yurex_read()
Thread-Index: AQHUWR8L3H4dlr0nUEihP2/UAJdFrQ==
Date:   Mon, 1 Oct 2018 00:38:17 +0000
Message-ID: <20181001003754.146961-24-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:TXAV9tTZ4e4VW+1F1Puglh+uceAEjiukv7orFIVEadKanrYb2VCFNw3WZ5RrmcxXHbMIhq8M9VxjgyIkVovRTjTjSCRgOWeJX0OWyub41fAbu0Hy4ZmoJycVcD82I3nBU2pdIaqDErRq/lmHAZxsBOXVir3YMPWY98/t917EJUAmpS+1lzJUFgZDbQODHR7KjWA812asuVnpK0IUH3jmwy6B+1EULOYSy/JU/LaurjXcsceQ9XW9eQdZOPqBPX+ISfOggrgYMd/5+W1YyS1H30iKww+vNa5lAhNh1ndYVI9LXFpK+71CmuCWrN8jdnmd5mFE/1P2ISqvUNaDWtW7CMDWNalNCf0r+uViyPjWne16cD8MQpF8p2/bEdw83eP2YxvhSc14043YIUMThjU9hDFD35j7b+d3jAAxrJ4bxOKkMKVlfZAg9F+zPEwnWFGIkuTIS7uUcY8XNPJIEl5/nA==;5:uyWBrTjBvJBv9ntQZ50PxxyYm3jeNjzZ6q4DQqc1EUnrPSDreoVnV+WMB/oaIvdkDK4oHX5uef1pFAyntvMlUHZPDZL46SLNrwushrVdhpAsKpQFRZs5m1MA75p6vQubd9CisFcxa90yqHIDhYyQh7JjtxO9y1gC4cLolyTF7Mw=;7:GoZkQ7ny4PNx9lkmJ9nt6q4HI1SMfFVQOfTsFDy7bxl9SDUUItu4lZ9YysKQRaS2G8urLBGHzjLyGJKSo84XUCP1GTLVvW63rS5Ep4jky2BfORMQLVp9Y0HvJduI2K2JOdedY0S1yZUiFi4lcX//VKZcclQigzNO++VdUyftuxNdMVTVPCp0L9vaGBkJj0L/aPRWZ0R4YHyXWHNM5w8ZcwBhcNhxerUw8Mpb7KEppc2ZNpjd+Q1x9h4mjwW+eUJi
x-ms-office365-filtering-correlation-id: c5aa3457-191c-490a-ebce-08d627362e58
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472394C4AB55A9834002BEFFBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4XJRNSWW/gq/7XlQuGWxWrxh6/YKlzwPLM7Qc2x4vqS9WDEsew5hQT2OhM3/aCerK0ZHyC1WTSSM+CWob7ldKjzXxitHUYt6LwJmBWb9njtf4+KZTw80ckR6qBUBP3sAO0b8nmCj5K+20ODceDfp7RiJy8d0XrD7/bDZzx7GqRU8DEkHvxoeSFLedVDuklr7JqsdGiw77az0xbhl+lo+O1TzUVWK03V05KxJ/c/kngFTWxu2g/+9MCmg74Yqpep9+1mFvMvNvyuBnqe8Akz32vv5rIOqIUZ2Xi6UuOH2HyrRZiIsIjcs9gDAsFuNAhsoYNAZV1bm11V+hulUpeuGc4zeItSVwzNnYsWR+nZyhPg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5aa3457-191c-490a-ebce-08d627362e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:17.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
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
index 1232dd49556d..6d9fd5f64903 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -413,6 +413,9 @@ static ssize_t yurex_read(struct file *file, char __use=
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
