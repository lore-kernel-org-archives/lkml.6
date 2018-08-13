Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD50C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0773C21899
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CQaZqMIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0773C21899
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbeHMTYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:24:18 -0400
Received: from mail-bl2nam02on0096.outbound.protection.outlook.com ([104.47.38.96]:45184
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728540AbeHMTYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYDDyKHWg8190iSy0plF61s7VZJXwtxTeEiQ2tuUtCA=;
 b=CQaZqMIt49dPgsyQwOkzHSls3GVjYu7rK22w62OSL+L8mqDbfv15s+uoC8ek9V/xMnx7BgbFTlxlDvxoM7SFZ/py5l2VMzlxAtVWJN2NLyJC/IdQAkAy3duLS89N4Yaw08MFoZJcjJ8HFLl/BPwYVEjU9Ed24BGtsnHDFv3/8g0=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Mon, 13 Aug 2018 16:41:10 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f%9]) with mapi id 15.20.1080.002; Mon, 13 Aug 2018
 16:41:10 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/5] Tools: hv: Fix a bug in the key delete code
Thread-Topic: [PATCH 1/5] Tools: hv: Fix a bug in the key delete code
Thread-Index: AQHUMP7hRBeey+i7A0GymtD8faQmKqS95oGw
Date:   Mon, 13 Aug 2018 16:41:10 +0000
Message-ID: <CY4PR21MB0773DB90FAF51BFE3FA45C68DC390@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
 <20180810230611.2114-1-kys@linuxonhyperv.com>
In-Reply-To: <20180810230611.2114-1-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-13T16:41:09.3337869Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:3:e19a:eef5:264f:f70c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:zLxHRijJwEhrsJTPu3t/2klj7QFauYMvC0U3AfUSMm7NrgAbaBdsrny1PEHK4q14iDMXlZ8QDFlYMcNWPwpNMT77NKAVaKKU7rChQHJCqsjaRzNNy1IXcLQw4mhUyIdLgmsbd7gT2S7w7gnViFHhHh5kkGJ0+bDvs4Gu1l82e5iUeRYonQnP0FRnl0IvI9eK9dd4LirQA99QzZBkvt1b1wgocTe6HHM19TEA0wuCcyGucRvZfvUKeGgFR6ETbDabH1TBvBA7p8J4DcCUe7VIPFvGXEYMKNWSv1dnfPXM/kdQ1LCibq8z6ydHdJuhR4tHvPPlMq5GD2JWfXX8UEeRSQE9KBvcMnbK8m7floPI5kHMmFvkUI05vD4cqNQ7YLMvdXMfcf5XjQBJCI2v4UIxBgPxIDIgLTlsbx2PA7GmqwuVCuRw4pBV2YUEiwaC+et4QsY2My9e1ro2qpJA03Nkcg==;5:JDbh4zlcjeNHHqHvytkZBIGx0UV1q/bvZuu3fMGJ+hHAk86U2c0Z4l0UJCfpxu84zG83QDal8hdQzleVO+WdLV8Efbc+QChzAMFZyRNkmqkuEV3j1y7mQSWtTSzCevxqfySsORZyiH+9Vw2qHqmqj5B3bhd2Y45lxdHU91s/hUU=;7:EvpC1q5lohSR/HtPJI0kUJmGdKMyNotkirLXH2MCd4MFZ67VG+sC1zqF++pFcI7DzCCrkAkU5Jx1vGJk/3ANtkIRYm1nnbq7tKP0o+n0bmnpheNCBwIBq/g3u4kgci9sIhyAzwMxekVT25/OBJKlS1QuSabhKodYSiO5sLfT+4r99fVLYKFZCt6ZjDV/CqOV8OlGW534Ih3LpcGfCvDco5ZoqBA34Y9I3/HLvds+Ye5G508QKvuhWm0zyQY4sg1w
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7f17dce8-0f91-45f5-2d7d-08d6013b9367
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0150BCE2134FEB2898574F69DC390@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(130873036417446)(194151415913766);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(6116002)(478600001)(10290500003)(486006)(558084003)(6436002)(7696005)(4326008)(102836004)(316002)(5250100002)(446003)(256004)(105586002)(305945005)(14444005)(76176011)(97736004)(6506007)(55016002)(8936002)(8990500004)(6246003)(229853002)(22452003)(110136005)(2900100001)(25786009)(9686003)(476003)(72206003)(5660300001)(2906002)(86362001)(74316002)(33656002)(14454004)(8676002)(7736002)(1511001)(68736007)(106356001)(11346002)(81156014)(86612001)(81166006)(53936002)(2201001)(2501003)(46003)(99286004)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G9RNslN99l4SIiU44OuyhBuywruYBfBF1D5iVzbsJpyoob1t3KKpArFFg5PP2Z3l7danAARdOTD8GAzmTG0876mQr6CmRoB6c2JVGtXDYzN1OQwSy/UKSp/p5eIX8I9AZkHLWF+Hii8BVV9NNu1mc5xsMyOESdHFJxn4G5CqcW/z2SPPK+z9ofjfSvEuqJ9jRVx2bgto84rAK5d6k63xtIcuAJlId1I62YMQpL3I3VTL18IX/Alh2HKN6QJLvnzYWmQCchO0KMaIWb97cDwSa2DVsUX4W6aCasOxWpekjsQOJHogBXHsFo7Icy5Q6Za4a9UYmE4qa10J6lpsPuGqFa+r09/k/biDhsJYeE3gsLM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f17dce8-0f91-45f5-2d7d-08d6013b9367
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 16:41:10.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kys@linuxonhyperv.com <kys@linuxonhyperv.com> Sent: Friday, August 10=
, 2018 4:06 PM
>=20
> Fix a bug in the key delete code - the num_records range
> from 0 to num_records-1.
>=20
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Reported-by: David Binderman <dcb314@hotmail.com>
> Cc: <stable@vger.kernel.org>
> ---

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
