Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57450C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB720C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BB0EClwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BB720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbeGKU4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:56:25 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:49632
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbeGKU4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHF0LoRAHxJbY0VWf97lbv7EZiiaXz+O7xHCGYrgs14=;
 b=BB0EClwitTjfB7fziQocUs7w7Xni4zBbe2rpLT14RPQKr495aHKHwyUIDm/q+MjPNPa6cwUlvT02JADrFdjBdzOvsNxtm0YwXCLLHWaO87GGArkel0beXf771FIg9Q5qKggVJ4unxnO0JNAF0D3621tCRMnJ3b7VxeChmuYTyTo=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB0896.namprd21.prod.outlook.com (52.132.116.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Wed, 11 Jul 2018 20:50:15 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 20:50:15 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump over
 Hyper-V during panic
Thread-Topic: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump over
 Hyper-V during panic
Thread-Index: AQHUFmd8DDSzl9n5TUSSYBfAmlZf/qSJMeqwgAESNYCAAD/TYA==
Date:   Wed, 11 Jul 2018 20:50:15 +0000
Message-ID: <SN6PR2101MB1120E0C4B9B73BCE7FF79B2EDC5A0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180708025651.26922-1-kys@linuxonhyperv.com>
 <SN6PR2101MB11207780F4859B196153FF2DDC5A0@SN6PR2101MB1120.namprd21.prod.outlook.com>
 <DM5PR21MB06334938686C9A202BE4FEA2C05A0@DM5PR21MB0633.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR21MB06334938686C9A202BE4FEA2C05A0@DM5PR21MB0633.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-11T01:04:34.2060788Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB0896;7:sIWByKBYyR4xVQz8RAyQoEVjKuoru6XN8Ih2RH3WzX9Ex5JKgR5WFPNCdgcDp/okGfd6l+Ixn8GvhyebyUqtNnRKUcjjNOqDqOynhtQKfm8oq0cb+hAQQMJCD6HIJvo0dIz9tY5GAUB3qaElqFlUSxM4gfQkqA23j54ipUMM0k+SfZ/zj2l5t2yyheZIl4L23uzj2VZSGGmhQoGrOs8gB3nEqeRZ6C86dsvQ9647utaJzOpCtleptM0zdVC2VeI7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1b2b920-7e76-474f-5f97-08d5e76fe7a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(2017052603328)(7193020);SRVR:SN6PR2101MB0896;
x-ms-traffictypediagnostic: SN6PR2101MB0896:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB089639AB29CBD5FA0C212092DC5A0@SN6PR2101MB0896.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB0896;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0896;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(366004)(39860400002)(189003)(199004)(7696005)(5250100002)(10090500001)(14454004)(86362001)(81156014)(25786009)(10290500003)(316002)(478600001)(72206003)(2906002)(22452003)(74316002)(6506007)(7736002)(76176011)(53936002)(5660300001)(102836004)(2501003)(26005)(305945005)(81166006)(229853002)(8936002)(256004)(6246003)(8676002)(2201001)(68736007)(86612001)(8990500004)(99286004)(6436002)(106356001)(2900100001)(105586002)(97736004)(9686003)(55016002)(110136005)(66066001)(1511001)(476003)(33656002)(3846002)(6116002)(486006)(11346002)(446003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0896;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1ejgy7ZK4OLfslFFYtc/b9ARxBpfMjrdbTiSQ67RsTwECVYsvTINBWScqNtIkLmkWHZDD8d48cDz78XYjWD1/mtHO1L9d2NPvZe+K/B4BMT3WKghE0KSDutPUF5TSx/65HGPWIF2ZJqBOPAAFFGRQuYjVF/cQalYTssqPdf+xw1uZdbERfyVZ6/fOREvbYn+mLQZYgQlXZYKJ6Q2apIg3P8swS8SpDYJK0zri3kOVTYMblaW70Gaf3+DEAETzYr9uWpZVhR+K2NW5tqrBpinyB/GRsSbz/VBhw5NSmKnf577MwqjgAOAsTu3p7zoAzaR+QbDAgBi0fDftK8kb0JiNnPnWCmrE19ozJUhfTtXBrE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b2b920-7e76-474f-5f97-08d5e76fe7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 20:50:15.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Muthuswamy Sent: Wednesday, July 11, 2018 9:59 AM
> Thanks, Michael. In which branch should I fix these now that the changes =
have been
> merged with the char-misc-next branch?

If the original code is already in char-misc-next, you should probably subm=
it a
completely new patch for char-misc-next that just makes the fixes to the or=
iginal code.

Michael
