Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231F920BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DZQXvPcI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m7ZHSUzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F920BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeGQAeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:34:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39958 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbeGQAeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531785879; x=1563321879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hdjJbWVB7SoPSCsTTdr6hIurVGGo8P1OB5ESL6WA3rs=;
  b=DZQXvPcI74trdz1FajY3OGzyKSUd+TiuoZeQOEbeE3BjClhrsuob1dSk
   F6aA0vu8Y5kuEWpM9YN09h6b3Fb9BkXuVF6TWgKJAZws1PW/q9hDH/Jjh
   yrMKTjFQv10E2JER811MyVFmGR4/hZZkD5iXnecC5HsDE72WgaZha1mAo
   P/jhanxLrbCUeUIQFZ7mOtqO4Ydd62iy3abCj3kv0eCqKnYkDUVq3yEns
   88fivFmBIYAx6G5oJFxbYyCi/Jp1dxhr67/NKzozCBd/R+Vo1HFMJFh+j
   qybQpHqouCXtpnUh7fHelIXYSAyXwvbvCNEgVPiSXYfj/99BEBLkHSt0T
   A==;
X-IronPort-AV: E=Sophos;i="5.51,363,1526313600"; 
   d="scan'208";a="85482237"
Received: from mail-co1nam05lp0081.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.81])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2018 08:04:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdjJbWVB7SoPSCsTTdr6hIurVGGo8P1OB5ESL6WA3rs=;
 b=m7ZHSUzAK+jUjOByz2s4IOkdvAuWa7b5WENQyQTmltv7g+Xww1ajRnOutBejKVITxQ7aGg4dJVeL/CEQdmf9m9sj5Wqmed+JUXAO5gPrLL7TkAroZI6HRWZKZjLbgb1IdGaU13tEjJvNA+rvnkMhdq1GudHKka1CaK3kl0IbCvc=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0992.namprd04.prod.outlook.com (10.174.250.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 00:04:35 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Tue, 17 Jul 2018
 00:04:35 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Thread-Topic: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Thread-Index: AQHUFPGUXhOvLaP+Fk+rdyg77FCdGqSHMD2AgApewYCAAQWrAIAABPAA
Date:   Tue, 17 Jul 2018 00:04:34 +0000
Message-ID: <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
         <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
         <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
         <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
         <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
In-Reply-To: <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0992;7:tQPAoc7BzWPhIV+69LhrWoQh/1hJYJjGt8+I0axwGTeHOjwsAmpCvgeP0yS06XuOYgn8BFce29lU3ByxPpJ65S8Q5fl5+D0N2LpdjeuFy5EMj9JvVqOV2OS5WFehPdVr/keZ+5JccHlgYd9S5RQamLUAyfuk2bsKqILDB6xcgkT8JZfKvt0cFlTnCYpaO0II+4E4dPOluxwTVrSeQ9D8A5bFrPwjTMLHZdq1DX9uktkI6wvgRce0tcJ7J4bvFwam;20:OLL3ejFD3e5gHdjUEbVGZnuP4zEynHHtHFxKIWsHEVBW1vai9sRNH4I5KMaTasfeHs9fX4E5WMETOJk2zhacqQIR82RU6vhyhBRaX8pk/EIrvAKrFcBr5fHxwfBe9svafPo1I2LX8K+M1AU9AIee/VqWJ03FbvaGQSpMe2if3Vc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bcc715d3-402e-40ff-8d7f-08d5eb78e166
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0992;
x-ms-traffictypediagnostic: MWHPR04MB0992:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB099254F9B43C715BED431DB8985C0@MWHPR04MB0992.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0992;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0992;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(51444003)(199004)(189003)(229853002)(53936002)(26005)(6486002)(6436002)(39060400002)(72206003)(6246003)(4326008)(6116002)(6506007)(118296001)(3846002)(5250100002)(36756003)(102836004)(6512007)(478600001)(76176011)(2900100001)(186003)(2501003)(99286004)(110136005)(486006)(14454004)(86362001)(106356001)(54906003)(5660300001)(105586002)(66066001)(25786009)(8936002)(97736004)(8676002)(446003)(11346002)(81166006)(81156014)(2616005)(476003)(7736002)(68736007)(2906002)(316002)(7416002)(305945005)(93886005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0992;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3wukuVaqp2j3a19J9IyPVcTD+t0mXxvxVdpvOcgahih81e/QvauRbhmdr7rhc2clN7iSTVsDaASa7PgQdxbiJXJbaX6Z/cKD9zi2xAnBsJogmldpZ31acE5+eeGymqwjzwDg3P4blWTqOt75Ghx8yhHazU5xewAC5c6hWdNtFxrCGxZREjUl9jwf64pYhhtvtsiYLnMnXvupF80vfv4LJQx/E0hU5HJq0snDoLG9mgBoulqN0VZeQTZkHin/5YdLAh5UUDJjSbh0W2I+38T9pc5ETwTb5RyMpcmxaZs8HNM8VxHGtPxBEYvts5/pjQNiNwaMsMCU28fKI77GEmclQ+rfaBX++onnpNOfy1FfhPM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <988A6E6B013922458A0E07071AF34D1D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc715d3-402e-40ff-8d7f-08d5eb78e166
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 00:04:35.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 16:46 -0700, Evan Green wrote:
+AD4- I see Bart has chimed in on the next series with a suggestion to brea=
k
+AD4- out each field into individual files within configfs. Bart, what are
+AD4- your feelings about converting to a binary attribute? I remember when
+AD4- I did my sysfs equivalent of this patch, somebody chimed in indicatin=
g
+AD4- a +ACI-commit+ACI- file might be needed so that the new configuration=
 could be
+AD4- written in one fell swoop. One advantage of the binary attribute is
+AD4- that it writes the configuration atomically.

Hello Evan,

I may be missing some UFS background information. But since a configfs inte=
rface
is being added I think the same rule applies as to all Linux kernel user sp=
ace
interfaces, namely that it should be backwards compatible. Additionally, if
anyone ever will want to use this interface from a shell script, I think th=
at
it will be much easier to write multiple ASCII attributes than a single bin=
ary
attribute.

Bart.
