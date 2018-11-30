Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCADC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E112081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RDBMhslE";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RkXJopF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E112081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeK3RiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:38:14 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:46640 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbeK3RiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:38:14 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAU6T86o003340;
        Thu, 29 Nov 2018 22:29:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=+GUP4PdSAwCzbW/DPCSfv+1nzSe2pqHKoTdkTsptNno=;
 b=RDBMhslEa8+o45VxyUuAM4F4q/PLofWVy9TXysFwZjFLEmvEd13Aurcdn3BbG5JIUY2I
 d+HqF0JCcwXzuVmlwlzPDwBPh93XoBE2Avf18bA8LmlsqYzwHKFoUyigvu6PlGPjqxbK
 TqBly9mdqBM2paMT0kU5Plx3tfuioCbNEXtoIM1uzyBGkBxD024rYbTVAdjBiHqqwyCq
 RHaMW5bKNHA5GIjIf2xVi13VfellDV4Y+4y1tbvXlMo+vmTxyutFZNW3qmQNDveLgDZ9
 zF3gqTqM6pMd6t8BKwUYQaJS+D4Al8yp3tzHNXtG1eNjAMyxYjvnaH1rRhWeDkFmot0X 0Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp0047.outbound.protection.outlook.com [207.46.163.47])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p270gyn04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Nov 2018 22:29:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GUP4PdSAwCzbW/DPCSfv+1nzSe2pqHKoTdkTsptNno=;
 b=RkXJopF0BunYxNaSyZzGqir6NPa0c8BP+mxCJncN+RUuI+QullqtzsQaZ2uU+h2cTm+sb6VedTx+QFvawWBeA30xtRUXT7QdLU2TA5wYuEzMvODNaxr+ZFNZjy+vFxkpJB7bJDPu6HfjWMHFvBvG8TQ6gj9rd9rBZabVcEhK6Cg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4854.namprd07.prod.outlook.com (52.135.205.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Fri, 30 Nov 2018 06:29:33 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 06:29:32 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     PETER CHEN <peter.chen@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 07/15] usb:cdns3: Adds Device mode support -
 initialization.
Thread-Topic: [RFC PATCH v2 07/15] usb:cdns3: Adds Device mode support -
 initialization.
Thread-Index: AQHUfycXki8AfRuxW0m5LfbM+YmFdqVlHjwAgAABzgCAAqnDgIAAEpHw
Date:   Fri, 30 Nov 2018 06:29:31 +0000
Message-ID: <BYAPR07MB470997B0FBAAE31DABC61A22DDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-8-git-send-email-pawell@cadence.com>
 <5BFE7D2E.7030702@ti.com> <87pnupzaz1.fsf@linux.intel.com>
 <VI1PR04MB5327227A807B92DDA62CF9038BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5327227A807B92DDA62CF9038BD30@VI1PR04MB5327.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDU4NTYwMmItZjQ2OS0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDQ1ODU2MDJjLWY0NjktMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTU3NCIgdD0iMTMxODgwMzI5NzE2NzE2OTUxIiBoPSJsOTRMY0ozTDdReEJmY2JSQXFJclVJVmhsaXM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4854;20:bsTIR9LkG7I2gs7oZFDL8/yrUjKpWWvkVNVLN/evkeszLslE6a2szop2f7bAzxNURlU8B+SaWkCI9m4g8FONFqzxhiWRDl7GP4elUM5mPaFD1KiRhIFXZoMMjLyO/9c5KILaKJO7eZgM8KkMp/RipcqxK+wZQdL/jS3NTV17eX2064Mr4KGxm/0L2/kokiQcCHoFo/6KWDrx5FYjVksq35uVWCUbi2MRDCVvk/1qX78x2L/kbyXJndTAVnXSr8BH
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(36092001)(476003)(71190400001)(71200400001)(3846002)(2501003)(7736002)(105586002)(106356001)(9686003)(186003)(33656002)(229853002)(86362001)(26005)(7416002)(68736007)(4326008)(97736004)(6246003)(74316002)(55016002)(11346002)(53936002)(107886003)(305945005)(6116002)(8936002)(256004)(478600001)(316002)(110136005)(54906003)(6436002)(217873002)(93886005)(99286004)(25786009)(8676002)(14454004)(66066001)(7696005)(2906002)(81166006)(5660300001)(6506007)(486006)(76176011)(102836004)(81156014)(446003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4854;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: fdefb480-90cd-44c7-f010-08d6568d304e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4854;
x-ms-traffictypediagnostic: BYAPR07MB4854:
x-microsoft-antispam-prvs: <BYAPR07MB485477FF2C74A536ED934793DDD30@BYAPR07MB4854.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501462)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4854;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4854;
x-forefront-prvs: 087223B4DA
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0XaowT7HDNGfdXC5LEpq/aeeLQK1vISN7SdN9G10XjqkKnA/7E9EZYVnjmBsbrwuNto7P8J0mC1sMY503hoRrluMMBTkcOvRhpeU2mxTQkn9IFyBeZs5JUgd4HkUsImFmgvw2Kr6B1y+H0zPHP9nzNkCBiv5K2TNXXRMyBNzObRTv/kdu9FD6OLv/PhjJf11k6KAMzzROHLCfb+4dc+Fw77uzG5hn9jYY9kf2J3NDmyrE6ypDlhSI5XZaClQwo+0UnjIS3Yci+XpfgrWslRcl+C7uX8/onevTEzb9ASo75GoT/a2gB34eaMTSfF5JhI/YaXctx1NqEeR3+1OoQ2GV03ZqJONUUpfU3FtcS1qjVs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdefb480-90cd-44c7-f010-08d6568d304e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 06:29:31.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4854
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-30_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811300054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Roger Quadros <rogerq@ti.com> writes:
>> >> +static void cdns3_gadget_config(struct cdns3_device *priv_dev) {
>> >> +	struct cdns3_usb_regs __iomem *regs =3D priv_dev->regs;
>> >> +
>> >> +	cdns3_ep0_config(priv_dev);
>> >> +
>> >> +	/* enable interrupts for endpoint 0 (in and out) */
>> >> +	writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
>> >> +
>> >> +	/* enable generic interrupt*/
>> >> +	writel(USB_IEN_INIT, &regs->usb_ien);
>> >> +	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
>> >> +	writel(USB_CONF_DMULT, &regs->usb_conf);
>> >> +	writel(USB_CONF_DEVEN, &regs->usb_conf);
>> >
>> > If you are enabling interrupts in this patch you should handle them in=
 the ISR.
>>
>> Frankly, I don't understand why this is a series. It's a single driver a=
nd splitting it into
>> a series just makes it more difficult to review, actually.
>>
>> Sure, a single patch will be large, but there's no way to have a functio=
nal driver until
>> all patches are applied, anyway.
>>
>
>Yes, I agree with Felipe. Pawel, you could remove the "RFC" prefix, and se=
nd the whole
>one as one patch. I will test it at my hardware.

Ok, I will prepare such single patch. =20
Peter I know that you have little different platform.=20
Probably you should made some additional changes for your platform.=20

I assume that core.c should be common file.=20
Probably we should add also some platform specific file.=20

Thanks. =20

Pawel.
