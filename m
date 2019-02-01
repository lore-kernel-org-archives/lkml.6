Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FC6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A8621872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fel+8T2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfBASYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:24:36 -0500
Received: from mail-eopbgr1310104.outbound.protection.outlook.com ([40.107.131.104]:29088
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730235AbfBASYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NCs0+tF043EbBCcrooP66jL9nAMH8nho5hDICfuxl4=;
 b=Fel+8T2aFH20RAtpbjpTV0MIWGvNykyxBWSSCIWk6TwPboIC9x65qWc1UNP0L2R3hab0P/RvL/MLaEOmICl0oUPPBwt2pMVP4NVlSzSTB24MxjnO7mQI3Sbu5W1xwq/J2GwMsJ8AxFpgp4MDRBzJxONjAs5/N9g7SZ+DNt8MiPc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0106.APCP153.PROD.OUTLOOK.COM (10.170.188.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.7; Fri, 1 Feb 2019 18:24:25 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.011; Fri, 1 Feb 2019
 18:24:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Sasha Levin <sashal@kernel.org>, Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Index: AQHUsfdSwFQKguS0PEqWQ+jwS7iPOKW6o/swgAAzdACAAAXaYIAKRoiAgAAQ2xCABIFoHYABmzrw
Date:   Fri, 1 Feb 2019 18:24:24 +0000
Message-ID: <PU1P153MB0169227534F832C2DAEC02B4BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190131151958.GT3973@sasha-vm>
 <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
 <20190131174707.GA2055@ubu-Virtual-Machine>
In-Reply-To: <20190131174707.GA2055@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-01T18:24:22.8276421Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e63ff4b-0a0e-4ade-bc16-e414040cc230;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [131.107.174.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0106;6:xQi1Cxz4IjzzioIRNTHztwRCBtNsR/9LjQNjlJjzLgJck7vMG3w1s3ySZ5ZJWRn8YQKSSQVmL/pPIZlojG2LTr6h4ybsrabUMvaQAl7kHNzcNDbyA80gG1BUiaNTR9E/zFz2llkvG5K5txRTu1iBZ0IPd1qCqUwO7mZjMNWM+W2DlF4XogbygzlQOVfAUe+LqrmN94+Ufm1rWpdsOSRqXS9oLeGCoy7tIPK2dm802zAw44Qf2nkDAY4X/FCgogsllHz6YjKlmm385dV6QOZxzCzOsQ3/Pni7ZXYo3fa/LDwIo4FU9x7rkI9WATn6UtBV1OsUf2nrDWYcjXcqk3c6havC3faoVKYWZB4fJyKfvR9v4/E8BVLVc25Vo3GifU4WXXWkyn6G4aAFQieanqUkAxgJS8HhY3RrGvjPm4SZ02tdakfmGZN0YPPWy2Xog5yW8dIub+cfb7itEU1zsa1TBQ==;5:Fj6/wLE7LicZ7P0sfbHAOWDAk9FfBoF0RaF/AaB6vvCANXqb7OKcFh5rB+Pvg1R6zWbh4IxzNXhcgaFfEAV5HUFcbrvqRrmw4dUWFrrMu2AO33rKs7hL9iph9wx1i8DRwv/O3RzZiu/eBeVGT+AfdnbU0EpZzDdw/nRscfSOwlHG8vLCVHri9iH++8VGXdI/iDn3C2BQRrNwjsZ0DwRGug==;7:GevPZayVcVcQxmY2qoYsewdAqrvfqxEFw9oQQr/JnBqJv3MYRIWmOqgUvXb5E4/OrkBZIJi2iIOPgnqg6PZKA1KkjrqPa+cexQ0eWc1Kac+KyiiiwDXvcJqALnec1Jj2G9B0D0G/rc42gapIkKxOiA==
x-ms-office365-filtering-correlation-id: b40b5798-082c-43d4-df33-08d688727ed4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600126)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0106;
x-ms-traffictypediagnostic: PU1P153MB0106:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0106FD20765BB2391F91B671BF920@PU1P153MB0106.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(66066001)(186003)(39060400002)(6246003)(33656002)(478600001)(7736002)(99286004)(26005)(10290500003)(110136005)(229853002)(486006)(54906003)(256004)(14444005)(10090500001)(476003)(53936002)(55016002)(9686003)(25786009)(6436002)(446003)(4326008)(2906002)(93886005)(106356001)(6636002)(11346002)(105586002)(14454004)(74316002)(6116002)(81166006)(81156014)(3846002)(71190400001)(71200400001)(8936002)(7696005)(76176011)(22452003)(316002)(6506007)(86612001)(305945005)(102836004)(8676002)(1511001)(8990500004)(86362001)(97736004)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0106;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 87ByPCEVZpfaOugQpKazJ8uffnrFP9p1iKFZhEDFQHqPngehypKc0Yz8XeLPMWe8dtKEByGf2qucM8ZHYAtXmlm+LvLsRg37tLAQgsgDjfl3abQ8mdiFGbO30MAKhNphG7xOPc7gbDEora2FtrL0jTNl6PQa0OiO1czaqXoxu4rxeO2qAPqB5y1Kxgw/g0iRR25POM9GtoOCkciBOpk/STkoySPqfWhymxEEXQq6oIwLdRy2ExUztgrs+4Xfow5KhfqR8aSJD+RiDgLiXNBlY24ERbuWWi+QOEtTQSCF4vdMT22kBykTCwxwC/fN2YuFRzyjsj+mB5vO3e6LMSB3oul5FQtnkM2IQkuLuvjqwMkmUY5n7jH6yWfA+As7ZhmqUdyAJoZaCXWhI/cDm1fiNR0XfMNTp8nzcgWzKChzduA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40b5798-082c-43d4-df33-08d688727ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 18:24:25.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kimberly Brown <kimbrownkd@gmail.com>
> Sent: Thursday, January 31, 2019 9:47 AM
> ...
> 2) Prevent a deadlock that can occur between the proposed mutex_lock()
> call in the vmbus_chan_attr_show() function and the sysfs/kernfs function=
s.
Hi Kim,
Can you please share more details about the deadlock?=20
It's unclear to me how the deadlock happens.

> I've identified two possible solutions to the deadlock:
>=20
> 1) Add a new mutex to the vmbus_channel struct which protects changes to
> "channel->state". Use this new mutex in vmbus_chan_attr_show() instead of
> "vmbus_connection.channel_mutex".
>=20
> 2) Use "vmbus_connection.channel_mutex" in vmbus_chan_attr_show() as
> originally proposed, and acquire it with mutex_trylock(). If the mutex
> cannot be acquired, return -EINVAL.
It looks more like a workaround. IMO we should try to find a real fix. :-)
=20
> I'm leaning towards (2), using mutex_trylock().
> "vmbus_connection.channel_mutex"
> appears to be used only when a channel is being opened or closed, so
> vmbus_chan_attr_show() should be able to acquire the mutex when the
> channel is in use.
>=20
> If anyone has suggestions, please let me know.
>=20
> Thanks,
> Kim

Thanks,
-- Dexuan
