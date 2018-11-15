Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5121321582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3HRNgiGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5121321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeKONDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:03:44 -0500
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:30080
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKONDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jztwi0iLrnI2uVPxbm4c9Ama3YItlM9rYBZeT+Z0ThI=;
 b=3HRNgiGVvJHMYpFT80v392px4+IXhHymUG3Vyt25Sg+x6pwmnSd5IYb2L+OcNv1ViZH9a3erVBmB1free3itDBDy04Z+wUp5saSJGqm9hrOBxOuSRu8mJxzh2GboIrXP7w4rFozzHACEwZyRVn7GKiL4ZMdAAg0JmzC+dPmT5K0=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3531.namprd02.prod.outlook.com (10.167.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 15 Nov 2018 02:57:43 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::bdb1:a728:19ef:e8fb]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::bdb1:a728:19ef:e8fb%2]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 02:57:41 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channel
 validation
Thread-Topic: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channel
 validation
Thread-Index: AQHUWBht6vLGgHgXI0mDLFYdYMiXIaVKor+AgAXHuzA=
Date:   Thu, 15 Nov 2018 02:57:41 +0000
Message-ID: <MWHPR0201MB36283D3B93A3CB6E14165CE9C7DC0@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-3-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20181111102947.GG12092@vkoul-mobl>
In-Reply-To: <20181111102947.GG12092@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [208.98.202.34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3531;6:A5ANfK0Dm7UL4ktdGUTt1+afLwXzL3n/65vG7aUb1DPgMnajr+N7u4WtOTXrKmSlczJSi9jj9PlQ817xaVkIHz9VHodq81zYk8zfadfnyv+tAkvPHKmraxh/YjP56S+lEEmOGiyf/aCHAF890jIwIMg2j4Qt/JXho63RZGFnWinQak4Gv/j5U+7Y97goZo1QtQgRX57JqqY4bhKqCVOjwtmirEAH45MvGcJVKrfs5Dxz5wyfJtsxZN6OeThftdanO/W+LdVd2PeNEge/5kSyjMWeRNtUPvTmZqJj3S78Uw2PyJ1CbtLqBl2Ff4XIX0X2ZUU3ADuRHqQaHM0KnjLEk0kYsxHCT3rCgnFAFp0zMhm/GgAwcG+RZW4ePVOePA/SgA9dXz7hgYYX9a3/8tT3I/pfqWF8FhZXcWvXyXsDuK9P2rc96pE9F7Srv+10+X81eV20UBZD+DF9KXd7n2/DHA==;5:3ifxKA+scMIgagyPbQiH5dS4QAej4rtrSLlylurevFfPkffXOQWu6QaBi8FGXWr+5mcPn9ehv8FfBQ6jQ3/lfM7nwtzz9TNQjrg0yBnAtWkMIclty4g0T6t30Bn9SLINIb9DKvqORGql1zK0714G39GwnWQ2HKV0HADD18qh2Es=;7:KbEgtBC+D5CnDvLUtjk0hDVOwlcxvIhwlJrNJaf3fzTsOZm0JymgjuLgl+UGNGjUrENbgEEPmkyFMTOvYS/nz+5CCowc84raKyCIYyrPIUctIS/cmNAnEqAvfCZE8RqpdFRo08qpMTVB6INAl97b8g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(366004)(346002)(136003)(13464003)(189003)(199004)(14444005)(256004)(6116002)(3846002)(54906003)(6246003)(55016002)(7696005)(71190400001)(25786009)(2900100001)(99286004)(74316002)(14454004)(76176011)(186003)(53936002)(81156014)(66066001)(8676002)(7736002)(6436002)(71200400001)(81166006)(86362001)(11346002)(9686003)(446003)(316002)(486006)(476003)(8936002)(478600001)(2906002)(97736004)(5660300001)(53546011)(6506007)(105586002)(229853002)(106356001)(33656002)(4326008)(305945005)(68736007)(102836004)(6916009)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3531;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 6e3413e6-9bef-4935-107d-08d64aa61c49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3531;
x-ms-traffictypediagnostic: MWHPR0201MB3531:
x-microsoft-antispam-prvs: <MWHPR0201MB353156C9FBC7FDE11810F922C7DC0@MWHPR0201MB3531.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(9452136761055)(258649278758335)(163750095850)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3531;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3531;
x-forefront-prvs: 08572BD77F
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZJiz8hcqD5+Tu/7n9gPKn4ozLPwUIDYUAnnOOqyMhPz9YeI39jAoWBLUqftQqkLa9MH8zg3r7jmgsuG8DyT3Dq1Xu2EGQm5mbIqKM1Kc4FoxfNmJ2QfF4XyhNUm4gG/NXYSB5F+6a6rgOWTwL1wqHJVn7dsdNRXxgovg5ljydar7NvZzVZxfHcs/II1J7SpnkhECipY/rxgPvEQceDhNMwLpptmP7y0HiGLNSzbZeYfNdELK01FVuD6FhdiUoZOAyUHvoikq49vnF1kkbD7LosE7FbzE4CGIDdW2UeZ5Cm/tVwTec3+EwLfLQ4e9wYx64+Jwv7qM28sfqIximG3TZgDq6voHQwjIP8j0jXOozzs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3413e6-9bef-4935-107d-08d64aa61c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 02:57:41.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3531
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Sunday, November 11, 2018 2:30 AM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>; Appana
> Durga Kedareswara Rao <appanad@xilinx.com>; dmaengine@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/4] dmaengine: xilinx_dma: Refactor axidma channe=
l
> validation
>=20
> On 29-09-18, 11:17, Radhey Shyam Pandey wrote:
> > In axidma start_transfer, prefer checking channel states before
> > other params i.e pending_list. No functional change.
>=20
> There needs to be proper reason rather than a preference, can you
> explain why
Initially, I thought to group channel states check before checking
pending_list. It came up in doing diff with xilinx tree and mainline
tree. But agree it's not of significant importance and can be dropped.
>=20
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> > Changes for v2:
> > Modified the commit message to mark it as non-functional change.
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilin=
x_dma.c
> > index 06d1632..a37871e 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -1271,10 +1271,10 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
> >  	if (chan->err)
> >  		return;
> >
> > -	if (list_empty(&chan->pending_list))
> > +	if (!chan->idle)
> >  		return;
> >
> > -	if (!chan->idle)
> > +	if (list_empty(&chan->pending_list))
> >  		return;
> >
> >  	head_desc =3D list_first_entry(&chan->pending_list,
> > --
> > 1.7.1
>=20
> --
> ~Vinod
