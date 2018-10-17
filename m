Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C425ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8802148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nty516ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8802148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJRB6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:58:15 -0400
Received: from mail-hk2apc01on0100.outbound.protection.outlook.com ([104.47.124.100]:45888
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbeJRB6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5aS7gTjBck50vL2k9cEChKkZ0pOGMPqlng4pIz/4MM=;
 b=nty516psCmLh/xoDp5uHrX78AQ29oaYMZ8dfP4IiyuHT/9kMcMesE0m+IN9kU57RnkvqZZ7RM0pVAkoMix46RAKuPFF8bBpNuUs3sPlz38V55X1fAqXIgMX+jN8IaQX3OL6wBpK40v1g+U+vjPXzyIAQRMlIKMUj6I9WPgzWRrk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0156.APCP153.PROD.OUTLOOK.COM (10.170.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.1; Wed, 17 Oct 2018 18:01:15 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217%3]) with mapi id 15.20.1273.008; Wed, 17 Oct 2018
 18:01:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused by
 incorrect clean-up
Thread-Topic: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Index: AQHUZcegulXVID9FCEqE3hUXh86KfqUi4u6AgADXtMA=
Date:   Wed, 17 Oct 2018 18:01:15 +0000
Message-ID: <PU1P153MB0169C3D595A7E427A5A63CB1BFFF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com>
 <20181017050705.GE22447@kroah.com>
In-Reply-To: <20181017050705.GE22447@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-17T18:01:11.4163036Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:1473:6c20:c44d:d299]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0156;6:j4gWR/Tj3bJHShb6k1y9/YX4pKUsMUXs5FhqEM2VvF8SZIqR/mp23ZcBIsmqiY2SDP6rIqHtxZpdvz3dA0ckqhqi3mNUWK8kc/IB22TvlSUbFgwbeDjqzAjfXftx5/DSIfJzKU2rdvXD0JgVt9TJRMSK/DXBGWHVysMiwmQK37XLVvCSEZFVoB1NbkOffsWzzCJlOInMKRzLkfCcKr2+lQ3XrACWhkB6y4VN/IEPhiwLsnLrL6Nu/ujMLaadQrp09VJO/H+2Qvj8iGtpWWuosgXDMS0BLx+vh7pU4Ald/KAMMjJ1Tvit3/14lSeYUlgVnyXoruc45WRd3IXiJTo+Xr7E/BWYMUFkNki+yg7BYIyh1XjYcL4FK4tcQ4dTyhDqz90YWiJMC6J5iILN3Ra39u4QMJHAE6KR8B58uNgenjTjayBVfGusGx1HBvkEBMq9e3M+w4RaD9P7ZlVJ1On+ug==;5:UO996UoK29agbpMlXdmngfqnyrg/fdwdMcQQvxxWyYEmZ5CvIbzhX7qJiB8Bbx8tiuq7Gb3rKoBkJ4oO8ecRh/htvqieNqAzq9hOjPuRYThh6X7DdpT7X50OT9mH5J/SlwAI6ZWFzHi+6nkVcXVvnRYrFUuVsDojb7kDRQbyT44=;7:BVhws3zHBx/nrgUHUBE8lynxdyWxisX74XPQ29+8ALfo3RaDuXmnAL4J3uT6WTM/1su2OBBKz1WfDpeMEmZaZ5XfYS1m2BTmVJMfZOLggiwgTyUPV9gg2p7ySrF6qsBbH0ORGfMCw7zOk8svCN8XdA==
x-ms-office365-filtering-correlation-id: 659b88be-af3e-4758-2923-08d6345a8845
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0156;
x-ms-traffictypediagnostic: PU1P153MB0156:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01567F94F655A04B0620DDE7BFFF0@PU1P153MB0156.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0156;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0156;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(6506007)(14454004)(486006)(22452003)(76176011)(8676002)(86612001)(9686003)(68736007)(10290500003)(6436002)(110136005)(55016002)(7696005)(53936002)(54906003)(476003)(6636002)(102836004)(256004)(6116002)(71190400001)(11346002)(71200400001)(8936002)(93886005)(316002)(478600001)(81156014)(86362001)(2906002)(99286004)(81166006)(97736004)(1511001)(5660300001)(186003)(8990500004)(105586002)(74316002)(5250100002)(446003)(305945005)(4326008)(10090500001)(46003)(107886003)(25786009)(6246003)(229853002)(2900100001)(33656002)(106356001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0156;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d5HDqXgUR0sIyXGr8+C7growOByvWE8vneh6FcxZfGXaOBQRdWjev6jz0mQ8CV1iZf3qh0n9zyw8sIDljC4MwGMsODUdz8heIl+kqzdcFa9amI0P8+scTAjQf+UQXwMQ+5Xbox3zuIbkiZTF/14I/1ZtMi5InHp/49fKrJOVfj+pCsjFhbcS9eJHri5uPz8aLr+5kKbqDD8vMQvryMw+5TFAFo0qXss+3Yxf/b0q8PBkjeCTNuThe6WbDythkPqH1k1iYW5YG2ghLO6Pm95iRo+kaZ43NPIQsxPdXjLMkX8+27lPEkFPJgpf6JkEN7flGb5yJuPJGdYbUJZAJjSYiDCAskWkAO30nx+QJNduDkw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659b88be-af3e-4758-2923-08d6345a8845
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 18:01:15.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> Greg KH
> Sent: Tuesday, October 16, 2018 22:07
> > ...
> > +	case KVP_OP_GET:
> > +		message->body.kvp_get.data.key_size =3D
> > +			utf16s_to_utf8s(
> > +			(wchar_t *)in_msg->body.kvp_get.data.key,
> > +			in_msg->body.kvp_get.data.key_size,
> > +			UTF16_LITTLE_ENDIAN,
> > +			message->body.kvp_get.data.key,
> > +			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
>=20
> Worst indentation ever :(
>=20
> Yeah, I know it follows the others above it, but you should reconsider
> it in the future...
> greg k-h

Agreed. We should consider improving this in future.

-- Dexuan
