Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD65C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914BC2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hqoT4Tc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 914BC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbeJAHTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:19:24 -0400
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:15680
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729785AbeJAHQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKRVLv3xVa3kvSAvIVJLciCw8RaUy2JsoEVlTver3wE=;
 b=hqoT4Tc9ZlDl4G35RJc1e8PorEA0Zl4lYv0zVlVLfDsvVQWNhWQAq7Y4obik1WM7SFcsrLjupS9nPh/2/sgt/hOEMkkby+qr+xkPR3H+XhEflUAWCpvJc+V2E8P1xQl3TE35QXlYcJpP1YfkYaqJwJqsq9usC6l69x8CNDBLdWQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 05/17] USB: yurex: Check for truncation in
 yurex_read()
Thread-Topic: [PATCH AUTOSEL 4.4 05/17] USB: yurex: Check for truncation in
 yurex_read()
Thread-Index: AQHUWR99/BCbViFapECfM7eu11jzAw==
Date:   Mon, 1 Oct 2018 00:41:27 +0000
Message-ID: <20181001004122.147276-5-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:EN3GN72KDFr1B4E91xd0rNt2CboDb7ThsAXX8UCe7F0eTsEfbLwH48xbSMP/45PSpq0PcBF9PELqsqy3bJt621ISWF4ECffmEJcM5mG56m4avvmtLIR7gRcQ3ecM29aYdtutrmipP0f8OHAMF0eD7szsaBSJF/mKhx73kaxhg3fdy2NJIfioBXL5RJotRa4P/6jhQJ1OCpTbrki/se+K90CXR2HEEi2I1qQC8O2UwZrModv10pgBPWpz1Vc78FDoFZiL/9n2HMDOgwkLAOBB0nII9HuWfeKZumbZAAuk3olTgFr6JxJ3ByM0cmHYfI441ZGL1KcmYoRCO7qixSc4rHBqZJAQBCiqlG4mmfX0iCpZZqz79/nUhL0aZE9MLnw0TqQnYbzdyxliR7kVcSmP7CshKibaF7mojrSmn6FOCrVbcefzcgB9WlFcg21l6BPktb2xA4ZrykIvnxbflqdm4w==;5:Px9KouMPdbxFZgC9qcKjBaFXNmolCflCcUeS6+WsaqOeC4tTczAU9HWmD0RagkNQeanXCfSUhe9P87s4aNb758SmlDJV1CNMk5d89OF0ziaz/aNFbpUnBJpkfG2LyGI2R3JbqE6VO385NX7IhTAuYTL6npFKpzI2aYVRxhHnNXM=;7:0f9nQec2Qhs8mgNWQtgiWsCi9sAxxhO4sg4gVh1g5773nPxLSVnF7kRtnPHl6isJz2fz0BAB7aYEtY/os2IrHdu5JkIdqP1l807s4iSp8+gNrxExyekhpj2kGDNi05xbY/PR1FHlpdW0gOYq10Ui/HNiKzfWwz8HIPfar04/++2NxQXDmRHnMWh+jv4gaVRA259YrwMO13/O/M+64Hftpbm3zrABpgE/QeZAVUcBSXM3DehXbvtD2cyYosGL/uim
x-ms-office365-filtering-correlation-id: 7b5c88be-ee52-4694-7775-08d627369fb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165D6A19782E1C5A4F99A14FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: o+rDP0DYY2FVttCm0skweNFx9n67L7xI+BFlKcg4+sliGvzQbwGGwN5XJYCEeVLqnMwt+dZBBd1yWxjsM8DEG1zylKIywfMjfygt15qNkGJ5XeUS9/R1gcc5k1mnS2tma+JDIZuU/XwgoP3x366g2/7KwX7FK9Owku4XuBJHNcJFseFZen9Qo/rMUWS0SySFidhegB/xkcWO6kZ7FaG6VrmuJKil+oNzggj3nlyvSi81Ji1idumX+cl4VnlUEcNOdtL2wyST5FpUvk8wopIuEbdoj1uO978UOanmfxa48bm0IiwLKgj3ea4eSX3ePUOHc7ueQu6YOJh8IAY8Kf/rf8iWuHTfNXAg1m+elVpzJ0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5c88be-ee52-4694-7775-08d627369fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:27.9052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index e8e8702d5adf..5594a4a4a83f 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -431,6 +431,9 @@ static ssize_t yurex_read(struct file *file, char __use=
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
