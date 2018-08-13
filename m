Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E04C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36C221798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EdST6HsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36C221798
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeHMVtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:49:35 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:53184
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730793AbeHMVtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77tjGqO2kf6ta37MrLh5yNGFe5rqx1Fo9rsMF4bL9po=;
 b=EdST6HsUhyVQBAefQ1FcqOiCLPffQJVEtz3epO0k6O255D6bOmsbYi411nkQTpFXbq/I4MHmPYVG/sqJj4So8D1yYFxeob87okRtH6bSrY5I+NbOn9j0YapvsHvt1TUoF77yl9uzXhArmkrNgpk7L/YVZ98x/buxMyhSFWVkNCQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Mon, 13 Aug 2018 19:05:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1080.002; Mon, 13 Aug 2018
 19:05:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH 3/3] tools/lib/lockdep: add dummy task_struct state member
Thread-Topic: [PATCH 3/3] tools/lib/lockdep: add dummy task_struct state
 member
Thread-Index: AQHUMzifVkK00wRlhUecEd6TkbwFzg==
Date:   Mon, 13 Aug 2018 19:05:39 +0000
Message-ID: <20180813190527.16853-4-alexander.levin@microsoft.com>
References: <20180813190527.16853-1-alexander.levin@microsoft.com>
In-Reply-To: <20180813190527.16853-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0279;6:YYdQqnye0v2xzmrKsZ7thP66OvagUjmSttBlFPDat6wvZeJGs1l143ToCJCJpKkZDOOoTBr7Y4RMOcI2AZqegdmBlEe9qCgYNMHq8qqTQDEgaFtWDeWLbKKICMMSvwzeNQu38dsklrc8OO27Wx4FTZ9WsiBcGXAQxOcr2GxRBXZ93RS0IC70OgE2V+xKzTdkx7qLrNtEb3QKyuUQnZ35bCjj2MXoMdsWN+mABzF1EfvbRXrB79OXGylO0W2ubF3dCV0RlBT9GpY7fTmQqpHwTHg5dYdgVpPbU0+t3WhUd9QNe3KOpSPbAVxT+t0dUu1/W6vA7AEXMxOejtojETXyGrrNgu9My8VjHUBkSHtJ5P1SPMT20wL8aAXwvoVKdCjTo+losgmObZyz+TQRBT9q7c694FvFIWPC4ehi9gQ8RtztFUDQ8ViV85UF4/09VZ0URu/hIVqLvXpvs70UXTAYaw==;5:Hv8QfSJZNRymWmxl13UDV8EvfTehOxBPIcK0maYy1hpcNJR5WT0sSp+38IGlEWH2KfsVtRaBWr74uQ4uz/udWrQ2Dzpe1vmFl1wwK0ZK6rrcmJ928gyUkvBxH5xHAUa4tv8WkqM7Iff0IlbSpFDo1CnBxdtEFt3Ieqi483S/zO0=;7:33EDbtVDIKrKMYGWv6nWumt563/gH/VUqu0q1xST3puGta4e2vOyoOcgvzCWPPWJlEwbGHWMXh7aaQhTPO36WTxmYEzQi6cNqVp8CW/+G6QpId642T1O1QirY795pdnkv7lTaeO10426BsOtNVdcGJR+FJ7/GnA8lwzOx1PeajgIi2GtAV6NFp8HzUEt1W0DIKCvkldZF4nQ5lGbhZ/U3YXEybDJqVH0//gehexDF3maO2mVSLJ0XbZN6OKS6wbL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 95a0afe3-20e0-4a95-48d5-08d6014fc27f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:CY4PR21MB0279;
x-ms-traffictypediagnostic: CY4PR21MB0279:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB027989B60B05D78F37D855E4FB390@CY4PR21MB0279.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0279;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0279;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(102836004)(66066001)(106356001)(26005)(478600001)(107886003)(81166006)(81156014)(10090500001)(8676002)(186003)(99286004)(10290500003)(86612001)(14454004)(11346002)(86362001)(2616005)(476003)(72206003)(446003)(575784001)(105586002)(486006)(6506007)(76176011)(4326008)(6486002)(110136005)(54906003)(6436002)(22452003)(97736004)(5250100002)(14444005)(256004)(316002)(6512007)(2501003)(25786009)(5660300001)(53936002)(7736002)(305945005)(2906002)(36756003)(8936002)(68736007)(2900100001)(1076002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0279;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UuT0Il4QTsxC2PeO9glmZgk/dBDPfHmzVBuyqiSXMX4KcrR3O6/2sluqvCpfR13hKDivwcAgDpFczjr3P4k75OesY4gle4qaHbc+xzuakXhNKjWXg7R64GVm6c/S/z0QMa/eL2rj0zom7rcnTfH9V0E0kz0eHHYRNkZsXQH01NCoYBqRU2SnS2CF0SazjaJI7yV9HpX+03PgTLd4hW15Jg17MjnVp4BXKlqzFz49bKFq9NSbZOeTnkMyixMqyYbPN2Lp27zwjs9UwKY0pnt+b8oUsrV73N97xND2qrSlE6CCMycnOMpAYEAz3/VUU/IX68reBHt6tMHvh/H8C+jRWwrLoAUewu6W1ha1EHcArYw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a0afe3-20e0-4a95-48d5-08d6014fc27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 19:05:39.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8cc05c71ba5f ("locking/lockdep: Move sanity check to inside
lockdep_print_held_locks()") added accesses to the task_struct's state
member. Add dummy userspace declaration.

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/include/linux/lockdep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 6b0c36a58fcb..e56997288f2b 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -30,9 +30,12 @@ struct task_struct {
 	struct held_lock held_locks[MAX_LOCK_DEPTH];
 	gfp_t lockdep_reclaim_gfp;
 	int pid;
+	int state;
 	char comm[17];
 };
=20
+#define TASK_RUNNING 0
+
 extern struct task_struct *__curr(void);
=20
 #define current (__curr())
--=20
2.17.1
