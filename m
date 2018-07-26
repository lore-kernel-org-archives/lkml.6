Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF21820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y4XFbrH/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="doaUZKk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF21820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeGZGZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:25:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3971 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeGZGZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532581832; x=1564117832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LN/1hGTcCsHoTYcqDtBQkfCqKduyYmXfYVIydLiM8H8=;
  b=Y4XFbrH/5uMo7hFOz1vCT4vepwsbxYitWDM4o/SvPBvIQdyJI4NK22rO
   HozUtVEscOqDcw73qpD9gu8V0JIaEhketNqBtz+Xm0yHer/djD0WBT2iw
   eL5jwYTLDBrL/OvwPuiYMNY5+V5BMkxt4CnFGo2vIWHYlOHBwcEbdEGt4
   mJI+kr6FFbIp+lflL7mJrwHLs0sreJnipBWThkp0aKUTB1Ryiyjxv0nGq
   ApB5EuCoaZe7qFh+OytJlPwCipAhg5f8RBCa+nhPmGwGKo2UlYTsUyKtv
   h6ov46EbTQd6pdAau/fEQn02pWDsF1BLqcf6qMU+YW9PxFHdSoB/xd4lD
   g==;
X-IronPort-AV: E=Sophos;i="5.51,403,1526313600"; 
   d="scan'208";a="86426575"
Received: from mail-by2nam01lp0180.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.180])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2018 13:10:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COtOIvCHD5al+YVQ/Ozit0Ea0lqDJ91kkCmjIWHIYAQ=;
 b=doaUZKk+JmUSwPrVi4SOeNo8FeVWyeuYA2Rtg9XOAjnBCuCtq7G+ZqvBxj1He2Sq3xOw4DPHElGKCyFJ7ldbisL2daCEio9mTKWk7lQ0epJFgB8oEEwnVu/d6hBKeBT4hsF1+JobszjYsf7uczFsVpUt2Gp/QUIHWFUauSbS4vU=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0879.namprd04.prod.outlook.com (10.174.174.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 26 Jul 2018 05:10:13 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%3]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 05:10:13 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: linux-next: build warning after merge of the rdma tree
Thread-Topic: linux-next: build warning after merge of the rdma tree
Thread-Index: AQHUJHtttZiwxiZlMUGxv+P+9byeZqSg0e6AgAAi9wA=
Date:   Thu, 26 Jul 2018 05:10:13 +0000
Message-ID: <36211fbe8a548742cf8e41a57f02f81e55c86794.camel@wdc.com>
References: <20180726105553.00a36e3c@canb.auug.org.au>
         <20180726030503.GA18170@mellanox.com>
In-Reply-To: <20180726030503.GA18170@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0879;7:SapvBYoSihF1bn3UENfZqkFeKmxSIC7kKpClZW0ppMmFgSvQ2316c8sSQPznrScR5pKx4quNZBDeqRPJFbhgCqrggmQABrJPM7+N9xxLDlwMDa6ca+3ZP0sc9nqoo15QsrEi69ok6GqZYegTQ95RG6E/kt7QvfaYiQRcHaYnbgom/iTmOh8lwW72p0ByNefzXfMxlZfMBc+HHFnuHLsAV5mwADsDEMosAVyoXtK0GO4OVNpJYZ71Z6bdEWYgcuhl;20:cNKVsEWONuSKGFnG92sQKhaGHBkDh2EH8ghm8Rg0ssWk8JaMi9P8qoGA4a3VQDTW3PRXdKxQka26jFngkqTGRBTQtcQYY3aykz/CYVkvbnCjhTJyMR0iQ+RLqaCDgAV8s+cfPaVxiTi0gDwCF+LSjNVmOE2BIbqPQlcOrvgR9AU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c9519ffb-6b91-4164-a167-08d5f2b6118d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0879;
x-ms-traffictypediagnostic: MWHPR04MB0879:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0879700BB61E4777E172B028982B0@MWHPR04MB0879.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0879;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0879;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(199004)(53754006)(14444005)(2906002)(4326008)(478600001)(14454004)(25786009)(72206003)(6436002)(6486002)(6512007)(97736004)(305945005)(2501003)(5250100002)(8936002)(86362001)(229853002)(68736007)(81166006)(256004)(8676002)(7736002)(81156014)(36756003)(2616005)(11346002)(118296001)(110136005)(476003)(26005)(99286004)(316002)(6116002)(66066001)(186003)(76176011)(6506007)(446003)(3846002)(2900100001)(6246003)(53936002)(102836004)(105586002)(5660300001)(106356001)(486006)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0879;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xVgqknRJwyUHwN1XwNd7KfuvRul0QZEjZTT5yGqoMMM3Qn7LK7b2DgRPjy7zujeNbKiZAncAJd61/GrvpfahjlmHuSrC6i0kPDiDN/y4jVSqB6PZZNrFd68DIkf0vPrv0PLZYzt0euNGa3/d3p/gapUC+RuEjcHEukY8j5ahA+Dra6dERV8OevsCZfibZHv4hgVaJ3Fj7fq/f1Ana+zcYezzd1yg28yOBUevZlzfmdfJzIwkBxM9gny2hEK4bv505EtLZKxd8XA+ovVDCrnqJxpY8tDN+wvnR2ZezImqFgGylpipC37HlNKeIYfOzhdhmmApMOc0XCf1pwHUqUaeYXY61rKJebeuX3DbOIfu490=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <AB393101603C584796E2B0D6733DCE00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9519ffb-6b91-4164-a167-08d5f2b6118d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 05:10:13.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 21:05 -0600, Jason Gunthorpe wrote:
+AD4- On Thu, Jul 26, 2018 at 10:55:53AM +-1000, Stephen Rothwell wrote:
+AD4- +AD4- Hi all,
+AD4- +AD4-=20
+AD4- +AD4- After merging the rdma tree, today's linux-next build (powerpc
+AD4- +AD4- ppc64+AF8-defconfig) produced this warning:
+AD4- +AD4-=20
+AD4- +AD4- net/sunrpc/xprtrdma/svc+AF8-rdma+AF8-rw.c: In function 'svc+AF8=
-rdma+AF8-post+AF8-chunk+AF8-ctxt':
+AD4- +AD4- net/sunrpc/xprtrdma/svc+AF8-rdma+AF8-rw.c:350:5: warning: 'bad+=
AF8-wr' may be used uninitialized in this function +AFs--Wmaybe-uninitializ=
ed+AF0-
+AD4- +AD4-   if (bad+AF8-wr +ACEAPQ- first+AF8-wr)
+AD4- +AD4-      +AF4-
+AD4-=20
+AD4- Huh. I'm quite surprised 0-day build service didn't warn on this.
+AD4-=20
+AD4- +AD4- Introduced by commit
+AD4- +AD4-=20
+AD4- +AD4-   ed288d74a9e5 (+ACI-net/xprtrdma: Simplify ib+AF8-post+AF8-(se=
nd+AHw-recv+AHw-srq+AF8-recv)() calls+ACI-)
+AD4- +AD4-=20
+AD4- +AD4- This is an actual problem.
+AD4-=20
+AD4- Yes, for sure. Bart?

Thanks Stephen for having reported this. I propose to revert the changes in
net/sunrpc/xprtrdma/svc+AF8-rdma+AF8-rw.c. Jason, do you want me to submit =
the below
as a formal patch?

Thanks,

Bart.


diff --git a/net/sunrpc/xprtrdma/svc+AF8-rdma+AF8-rw.c b/net/sunrpc/xprtrdm=
a/svc+AF8-rdma+AF8-rw.c
index 80975427f523..ce3ea8419704 100644
--- a/net/sunrpc/xprtrdma/svc+AF8-rdma+AF8-rw.c
+-+-+- b/net/sunrpc/xprtrdma/svc+AF8-rdma+AF8-rw.c
+AEAAQA- -329,7 +-329,7 +AEAAQA- static int svc+AF8-rdma+AF8-post+AF8-chunk=
+AF8-ctxt(struct svc+AF8-rdma+AF8-chunk+AF8-ctxt +ACo-cc)
 	do +AHs-
 		if (atomic+AF8-sub+AF8-return(cc-+AD4-cc+AF8-sqecount,
 				      +ACY-rdma-+AD4-sc+AF8-sq+AF8-avail) +AD4- 0) +AHs-
-			ret +AD0- ib+AF8-post+AF8-send(rdma-+AD4-sc+AF8-qp, first+AF8-wr, NULL)=
+ADs-
+-			ret +AD0- ib+AF8-post+AF8-send(rdma-+AD4-sc+AF8-qp, first+AF8-wr, +ACY=
-bad+AF8-wr)+ADs-
 			trace+AF8-svcrdma+AF8-post+AF8-rw(+ACY-cc-+AD4-cc+AF8-cqe,
 					      cc-+AD4-cc+AF8-sqecount, ret)+ADs-
 			if (ret)=
