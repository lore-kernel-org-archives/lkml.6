Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F121BC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3D92083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ay/zQ1fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3D92083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeJAHQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:04 -0400
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:65184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729862AbeJAHQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDCoO44LcSMAzrBV/m/lewt4FM5fk4qfOummPksmzAk=;
 b=Ay/zQ1fFuuPVbBGHDP8wpv+EfYVHFNQ9qlLTSPjORRidIGrr3saoOvhLl5iEasXfznws9mdO8C8iOje22qZ/QoruqJawRRHGb9oB5ceLHQD3pgqUQF8Wc6fDDEbGGbsdL3+r+mvcugUFBsB6nxxz0bdsmR7WBJSU2+A6JpMOOVI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 08/26] USB: yurex: Check for truncation in
 yurex_read()
Thread-Topic: [PATCH AUTOSEL 4.9 08/26] USB: yurex: Check for truncation in
 yurex_read()
Thread-Index: AQHUWR9dm3bt3KY48EOVxiwE7TQeew==
Date:   Mon, 1 Oct 2018 00:40:34 +0000
Message-ID: <20181001004026.147201-8-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:ejDhA3Ws7FgWx42H8ZEJ22F5dJL5htv4qnEFITooy0PG24+KZXQV0XrnzTdqr9SKMyy9rVtVFeVTe7y3lE0qQm1dVXXsxygv89FyYQtF6sPVx101FERgR+k2fZLmUxNE31sC6LzAqJusSRUNZvwlB6gipaVsVCdUKRM+elAqWcskT7a0rCRcb5R6r3ZY4nN66+iClZjLpPVEUC7qs9Ml7s/IQrOvalqO/1ovQJfss+ozlLTS+1CbzZaNIaoARNPmf+c2KFyNstkoev2ARdT1/9zjxUTXJY6p5hU9qEFELBKC1V+dA68vQHHPYpUD+xUgFzmwNyniM2e2UNVt6HNurG/bmydUjfemh4HpALm/n7desMson8rwW9wXQgtXgYvld2UceDaPy2fNa1tCwV7rG9r5RNW84bbVa4LgpKRxwpKOtzyism39sQybk75ow5ZpSx3pWPeJ/jzcEow6FofVEw==;5:pd4LTiJ1PeQBWlTkLieNjMtvvuCE9+3Ssk3v2cach+P6JV6VF0SHr84XoXibpSYs0nUx/aP2jGFOcovFhXQDWiV6u2dotVY9jr/YBw9QCsnp71eBq4vb6eAxIRE0iO/fevwpnt9QgOUqWnUV/tZaNJLwkRsK3nFG1qAeBy/gjro=;7:aCrMFG6lf/jp9kdJu54M6jqrkWgO68o5+jXso091OgvZAhErExOtxnDupf0HiGVJKdeE0nIpOKWc/U2AvUWSCOpwuoEOJoE4Hlya/+hT5uPStMQkbqIrDEnkbHznn3kw1QsM7ektbPQwxCmRKNacDKX1fjCH3z1GKSvv2tB/oR8WdPJpQI+6tBDGi4fFL/ihHAjVIhjMZRiWAUjTek4A42nDJ9cG5le/2vRsrQY2KRRlWO1gPomBIVTMX95eRMPt
x-ms-office365-filtering-correlation-id: 29f4f84a-86f4-4253-41d0-08d627367f9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012044F3462107DCE22FFB9FFBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BEaALJ+sVBAPCp6CAxm5n5eZh0mk0qEok9qLdC001TqZly6REvnABoG/jBtlTKfq3I0nzIIO9uuyvi6XbUMwexpYKpWrVqEMDIntUOfCUGMRXXXUPT+6Lq1vNRpCNvFxsZV33EIZwYPji9eqEfYpVp1PBO+atVCF9ttJ8CilFpW1peE1O3ssuY9KTCpnZE/uRiVAfBXLttWCJnqN1ejBOqgJnii+N8XenyJ9xMWPMylM9hXiKAWZxiBarRJU6xER6F03XT9MBXMUNqv7omznB4lY1Ah2W85UjKCZew+U6eLSioLtnA84943jopTt7EoqxpD+0UTV+xzAMmKZoCKB70/Cv4OKnQScK2joZSkm1gc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f4f84a-86f4-4253-41d0-08d627367f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:34.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index e36c6c6452cd..1e672343bcd6 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -423,6 +423,9 @@ static ssize_t yurex_read(struct file *file, char __use=
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
