Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E652098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DiuhrScR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E652098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbeIXUu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:56 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731150AbeIXUuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKNzJyKytV+ze2+BFyQvKKfpLmxHJUOakszpIIIsVnw=;
 b=DiuhrScRkqrWbTSCFyQhe1WpMlDbhpOlZycdAuI4+ZXCPpoQUvRTY7EXPkMBEy77LgW7+o+0I6T0uIKFyAh9RCwrEFcx51X4eRHx9rD8HSXwt1xNulkgphTyX9UsA8CprCXF2AjM+Qkpzuwkcr2BnltXTRGI+I1PrzqHvCSiio0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 28/76] bpf: fix shift upon scatterlist ring
 wrap-around in bpf_msg_pull_data
Thread-Topic: [PATCH AUTOSEL 4.18 28/76] bpf: fix shift upon scatterlist ring
 wrap-around in bpf_msg_pull_data
Thread-Index: AQHUVBWhYwdqDsxEyEymwM7APNoToQ==
Date:   Mon, 24 Sep 2018 14:48:18 +0000
Message-ID: <20180924144751.164410-28-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:WQiqSJzo7Uo3I2dwF5+s8C7J7/Qzip41W63vf5g2eSJfLK5vb4kx22vK4kl7Fnp0TYLQI+unD6NVk3QzUJo9M39cNDShzVXJxVEs5ver2nuzzS1E0b8yG4YzcVUAOYN/fBddOvFwZwVl2YL348NoW4I703GMxJOwUSPR7HfcyUIFZDut7zl7+ovlEPUXYzfMhx1ScTj+9cJX7TQ9IEwPEsXxz4PmbSW/yHxRvP6ohvG371HJeL7kn40AiHDZlQaydPzU6ai7ssY8aWVeeG2AslgZp2AdQ71zrL609qcMyKGFvbAfB4siVAps15TPNx7mAzXAaMTnm84cntP02a7S3JjqudbXys6WXXBGI9OmWyZ5gCBRgYB1cmjMldT00zbXSelihP1hMwGYZSrd78tpJi8UJonkpLWi+bkitUDKFcVZ5MKkyzxcfHUYHiGWM6fA8hCFV6t4toPJhvuFiWkJ1A==;5:iT3GRD9ddIWNRW8TRUwUFcrYGoN2NGAmKIx5EcwnHU0TWEWmkQ/jqN1w2VlaDfwdrkInZcuuWnmpnpSVJ4U4f1P6XU6fD1ECS3wVYXrZLntQH2+wOJFjUPCB5SAHFXyQhJDatqY7WLRN8f8MVwM7BfVgpgVbgCnmIZzigjmJgkE=;7:VSTi+PSEqAkFvmMdtE8EjBfCSJbiGovGn7Y5Hx8gAalxc5/cdfEYA26CUwLd+Rro9V5biKh3BpM5sDgADOi92A492sF2JNNoQoxNvG3WkBfkK87s+fvRpow5HtxSV78MtqyDZsEvN5/FM4QYX00BKRrMkyNcpXRH5G7ZRMyY/9aKXfkPThkJQFfhOcMeYJLsD+7W64N9HOIc4nQnvnK0iD7Cx76OZmAg9ZvJCW4oe2WHsyWzyqyAKeW6Ct6uAgUD
x-ms-office365-filtering-correlation-id: cc54f82c-2746-4dfc-0ead-08d6222cc40a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821DCC4673238D5B41DA9E7FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: NH8EOghBO1Yu/f04KpbDPLiox/9KnubB0NZqfJyzufzwSKPZYQYZ50gFPOgTASKOTRNohjgpGfAQ+QG8E9CS8SbCvqHamvkhBpg0KWnZvH+wlktTIDxgeMB2PbkVNLEHMNR4jrSHm+WBcE/Az3ablsJP8i218JA4CbTJZeEU4kLmhqfA0wLAUGTEwYvGcxF49280Sk0/oyB9N3I9p/TYJooWcGUbL41QQYoMY86EvHj92oLoQqEWeZY/5I5jWqhD7CvlwQmEe7QO70Nue1iAujpHQunTqEvn6GtoFCFfwP0PxLkS55+tTImOtHSoWxaqgen2/YG/8I+N+nHFCI95qtIHFPp8RThJrRLDvt7mwaI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc54f82c-2746-4dfc-0ead-08d6222cc40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:18.1311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 2e43f95dd8ee62bc8bf57f2afac37fbd70c8d565 ]

If first_sg and last_sg wraps around in the scatterlist ring, then we
need to account for that in the shift as well. E.g. crafting such msgs
where this is the case leads to a hang as shift becomes negative. E.g.
consider the following scenario:

  first_sg :=3D 14     |=3D>    shift :=3D -12     msg->sg_start :=3D 10
  last_sg  :=3D  3     |                       msg->sg_end   :=3D  5

round  1:  i :=3D 15, move_from :=3D   3, sg[15] :=3D sg[  3]
round  2:  i :=3D  0, move_from :=3D -12, sg[ 0] :=3D sg[-12]
round  3:  i :=3D  1, move_from :=3D -11, sg[ 1] :=3D sg[-11]
round  4:  i :=3D  2, move_from :=3D -10, sg[ 2] :=3D sg[-10]
[...]
round 13:  i :=3D 11, move_from :=3D  -1, sg[ 2] :=3D sg[ -1]
round 14:  i :=3D 12, move_from :=3D   0, sg[ 2] :=3D sg[  0]
round 15:  i :=3D 13, move_from :=3D   1, sg[ 2] :=3D sg[  1]
round 16:  i :=3D 14, move_from :=3D   2, sg[ 2] :=3D sg[  2]
round 17:  i :=3D 15, move_from :=3D   3, sg[ 2] :=3D sg[  3]
[...]

This means we will loop forever and never hit the msg->sg_end condition
to break out of the loop. When we see that the ring wraps around, then
the shift should be MAX_SKB_FRAGS - first_sg + last_sg - 1. Meaning,
the remainder slots from the tail of the ring and the head until last_sg
combined.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/core/filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e713a8791815..cc4d660aafe1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2360,7 +2360,10 @@ BPF_CALL_4(bpf_msg_pull_data,
 	 * had a single entry though we can just replace it and
 	 * be done. Otherwise walk the ring and shift the entries.
 	 */
-	shift =3D last_sg - first_sg - 1;
+	WARN_ON_ONCE(last_sg =3D=3D first_sg);
+	shift =3D last_sg > first_sg ?
+		last_sg - first_sg - 1 :
+		MAX_SKB_FRAGS - first_sg + last_sg - 1;
 	if (!shift)
 		goto out;
=20
--=20
2.17.1
