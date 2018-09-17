Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8201BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC22214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MLt3n6vO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC22214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeIQToX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:44:23 -0400
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:39576
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbeIQToX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfQ29uFb3F9nl0ueY6fUFjzOULYfg1MrWgOG9aw6ILo=;
 b=MLt3n6vOMm7fBiVr/ZE8LBl++QNyVEmBHUhEWQ5CMbZe4N8NTn7eLdQci9jbjo2io3ryiyap8ZDUPbgyCwE85RiaxattlD3wKw+62EGYEnvFh+pPFVhYOrTqkTKj5lfV/ZLkRGrkPD14QlG3NYZ9DMU/PkXooE4iy4WW7ViOtfU=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1068.namprd21.prod.outlook.com (52.132.149.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 14:16:49 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879%5]) with mapi id 15.20.1185.006; Mon, 17 Sep 2018
 14:16:49 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
 operation was requested
Thread-Topic: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
 operation was requested
Thread-Index: AQHUTj0kC9QAPEQ0iE6UniLG57hPj6Tz6QmAgACbuWA=
Date:   Mon, 17 Sep 2018 14:16:48 +0000
Message-ID: <MW2PR2101MB11138F9E55814399F152859FA01E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180917041352.11402-1-kys@linuxonhyperv.com>
 <20180917041455.11455-1-kys@linuxonhyperv.com>
 <20180917041455.11455-2-kys@linuxonhyperv.com>
 <20180917045613.GA25435@kroah.com>
In-Reply-To: <20180917045613.GA25435@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:2537:f2ed:4e7c:3212]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;6:Ss+VFYlmszpXNUUytDbM67gZltZ6QAveUoeNXFM1Z19gjuPiXN1XHyhbw0z9ntv5ZJbClBP7FYyZxttNpKfdsuuQh8ECR4QpXqlzsgRpvbPRnvMNDQWQsJWyxnHCLy0MaONhSKESVYn7vTw8Qnw52dbDjYHy7JzH4H9wD8Ts4Ku9+PZSzErN9e3CkPBMXR1heasVQOtjGIsMbyj5uevqyRL8c9hMEKFfc5Y7Vy8xlbd7dRFdGHKE5sOdW2UAWNqk+uF+ZuPzC8WibaJt0HaswG1+KTknJBmgy0RJ5NByA1V86YG+rmZyGfXXcXlA25BduYzWxvfMjqkJmam5huyLpLIBfMn42Hg09lejaVp5DA6Que/M3v8f3mAZQZ8YhQCaaGRU7dI6HV12xiZeQJNVwjZW+KqS97pyxmx25xuMYY4Ftm4Nwx/S7UIDeH4eFB0nYuwQtvDj/QAmhC5QCdAD+w==;5:H/zvx8O0qUkOCEEcKgPtb/XCpo3vtGsdV9dOaQ63SWOV+qNFszOXPCeaHYmX77FzMjYNunlDu/XVTCmzcnHcuhFkCnVuXsBkrgx2DjTfp/VcyPHaZn4+8PzCQJff/nHPNMY0ae6WQPqbu7j3O2Ftne3u9w0CVRWHyIo7X10rqk4=;7:UJhlKOr4Y8KMNM9vhs7Llij4P0zcnd4KF21JCghDmWs+6GkMIsyyTe5xyzGvQWdXI7KX/xhqsJso8+tr0sVCCUdLUTeVI0u5ezYdudkNlpvCUqUZrxVST8VTIIpyL9GRRPrpnwdf2B9JxSHZ6FkWYoLAWtqcsxyXnHccwsj3ONNg/3wfzkPLROrwo9E+uqJVVPuuupja1wz/yyvOZOkcBd5m2i4GokveNzcxntRLKn3XWIUphnRwA4C7ExLbyGG+
x-ms-office365-filtering-correlation-id: baba17fb-eb40-48f1-2a43-08d61ca8351a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10685C2D5C0AEB4A66AC7315A01E0@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(13464003)(189003)(106356001)(105586002)(33656002)(305945005)(74316002)(81166006)(14454004)(8936002)(8676002)(54906003)(81156014)(6116002)(97736004)(229853002)(2900100001)(5250100002)(9686003)(7736002)(6436002)(55016002)(478600001)(10290500003)(53936002)(6246003)(53546011)(2906002)(5660300001)(4326008)(76176011)(186003)(6506007)(7696005)(25786009)(6916009)(86362001)(102836004)(46003)(99286004)(11346002)(486006)(446003)(476003)(8990500004)(68736007)(22452003)(316002)(93886005)(10090500001)(256004)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JVlINot+ifNvUVxPhyid835IFXdGZtfUGMDxbOlANnmdUMF+0w6dq9rmzTRW5iRjN2vtSAaW4dy25tG36R7TynUueEzXKmYsZluStsI9Iklj2CWjQE+gcyi0nr1exev5QymPbpzVoFL/r4J2QZq20eQhxIy4qw1Kyejq0YC1JOKEBx4vaXNWnYEsJIVedR4Q3g3RCTnAFGEZBzheO6Dx61y0csVSRXVb76T2w05v4AhFKuxut2Qo6SanRkmiMTgqbrjWxSBWoYKguFTa2WQHIVjfY6jFVCdqgKwvkJA+pHLKvRANRTg807SkXONZJMkiwk36TmL642ijHjKj0Y/x9xX6bvzHNM2Wg5B/psVMLM4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baba17fb-eb40-48f1-2a43-08d61ca8351a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 14:16:48.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, September 16, 2018 9:56 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
> operation was requested
>=20
> On Mon, Sep 17, 2018 at 04:14:55AM +0000, kys@linuxonhyperv.com wrote:
> > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> >
> > 'error' variable is left uninitialized in case we see an unknown operat=
ion.
> > As we don't immediately return and proceed to pwrite() we need to set i=
t
> > to something, HV_E_FAIL sounds good enough.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  tools/hv/hv_fcopy_daemon.c | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> No need to backport for stable?
Thanks for pointing this out. Should I resubmit with the stable tag?

Thanks,

K. Y

