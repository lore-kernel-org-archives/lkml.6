Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7885FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2346E2175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R8Tn8Mcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2346E2175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeHMVtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:49:09 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:53184
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730093AbeHMVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBY3QUJ6ZplbrdRot1PVmj35cfMfvnVIkzRtkjJNrqI=;
 b=R8Tn8Mcx9fQP2+WhvURiAiFmGQP1dpbqu6jrFtot0ABluNwcyy8IGZkEeLFZpc8uAIi6K5/YyrT9vVaYGjCo5FDHlu13F/uTnzs51VmwIAaBwmeyM1xP1MJvH6UzC03S2sQHUqjsjGMnwIYv1ULu8fi5YWSS6/HXD8mrDajLV0U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Mon, 13 Aug 2018 19:05:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1080.002; Mon, 13 Aug 2018
 19:05:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH 0/3] tools/lib/lockdep: fixes for v4.19
Thread-Topic: [PATCH 0/3] tools/lib/lockdep: fixes for v4.19
Thread-Index: AQHUMzie9GcXaVXrLkSu7mr4FMUeBQ==
Date:   Mon, 13 Aug 2018 19:05:36 +0000
Message-ID: <20180813190527.16853-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0279;6:O6Vls1+KUaexoC5kdXHMWCGEpUwQPTc4SIg8I6g+5z/jrcoShHO2Efoj9R1TQe0yp7KcOjOuXkU/Sd0QOuYhAFygbN71tjfk5AP93e+QvvjRZ9iZqKd35TZfqb3QQcDSeSC863ixK5jJR2tbvBDU7IyXIGxQiz0gojgtUJ5Lemu7qWzJCjbnRY8as+B4q8ySRFm2+SsNmTcEAIi/O3y6zAVtsbrf9RTAYkJkMrt1dgoqeuN+Dr4P2zpg3P38DuINCaJvNd17x5hmuPRzOcj5jECBKsxNyhjOlEJEVug3XnP9vo8Ezd+9bRNtOrM/xdTzPQcyGvuYxi02gpuckBu62RErX0RqwP63XawHR1PDAyomh40Nwql0Z0SESCHreT77N5zHc2eemhqg6XWb9LegbignqpXmAsgQWEJGHNr+Ular2CzaMHzpew19smPZ1Dx5L6kVQ5asznzLnqvrpfwUpQ==;5:dQbeczQR2j0Aw4Tps51A7X9I5dT8c9l8LU9Ey4nI3tYtf1kGl2+K9gY/ChUp3z/yvGKaD7EdckF8njbnAysc2a1ZSBY5flxh9Wiz8XCFPefWgMxrk4jtrgoWA7ldXeOw0Iv5npL9fgi463rGAEjNZKgq/s05rM/qsOrMBQ25bK8=;7:yvqKeMtDiSVcbcMjnCwdD9sX01oYlu7vRDEeIQcyyBjC3CjBmo9ysGalfOzaQu19QjMq8gY/jVFMleuV+RI4sOkvZz5dDJbApHoyeShHhhPW/hyk12x+pJsUctA8yQnnHgHbsiqA/H6kzZDy3jbwsXYaKpD4IwKzKnpX4x2ghXclSh4SdEEqsQu88V1Y8AX1Vf6vU5FRV8h6/ssnfgeuL72/FHh1zzLVdcV1SEBxsHsadUD6RITEFKcnSJogj6aq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d07951a4-e846-43c5-d43c-08d6014fc0e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:CY4PR21MB0279;
x-ms-traffictypediagnostic: CY4PR21MB0279:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB02795DB70647F2ADA4285C44FB390@CY4PR21MB0279.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0279;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0279;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(102836004)(66066001)(106356001)(26005)(478600001)(107886003)(81166006)(81156014)(10090500001)(8676002)(186003)(99286004)(10290500003)(86612001)(14454004)(86362001)(2616005)(476003)(72206003)(105586002)(486006)(6506007)(4326008)(6486002)(110136005)(54906003)(6436002)(22452003)(97736004)(5250100002)(14444005)(256004)(316002)(6512007)(2501003)(25786009)(5660300001)(53936002)(7736002)(305945005)(2906002)(36756003)(8936002)(68736007)(2900100001)(1076002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0279;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xV4aYMluSiKNk3Fwf7VuH981dTud/v+0nJssVOqOzqer3MKxckrFi+de45u0ZYmOiLog+u7jITiFZhJX2PfE093cePH5BhUNOOF3HY8/++y2Zl0qGOKkh6yw6v8A46tnV1Tj266rJAyutfmVyYOYPpXGSDHGzn1GrydmBaIbKo3n7catfrEesWF+gRNJMatOo6HVPzKEK5R1ZVqAhdsiPCAdWTKsM5R+WIyfBRmV/MRYVuPZQ/7R1p19oRbOopjgHyUFwVGjq4uphfxmGPlJa3tUoSVWUThbmu3Th/MW/hEe1ChKuBo/8/GGxFayA+Ncr6rYTZASYWEGaqaRgBulGi+slHZcYrdaZ9Wz7DuloqM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07951a4-e846-43c5-d43c-08d6014fc0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 19:05:36.9437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Please pull the following minor fixes for liblockdep.

Also available at:

	git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux.git liblockdep-=
fixes

Sasha Levin (3):
  tools/lib/lockdep: update Sasha Levin email to MSFT
  tools/lib/lockdep: add empty nmi.h
  tools/lib/lockdep: add dummy task_struct state member

 MAINTAINERS                   | 2 +-
 tools/include/linux/lockdep.h | 3 +++
 tools/include/linux/nmi.h     | 0
 3 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/linux/nmi.h

--=20
2.17.1
