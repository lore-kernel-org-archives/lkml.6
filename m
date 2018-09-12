Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84ADC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C14020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GN5OMuSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C14020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeILWnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:43:37 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:16689
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbeILWnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnkSBaN1ruHaQ32xAYHkRJYblG9RNC0rzV/iDqqYSoU=;
 b=GN5OMuSWaxYRIP8cVUo13BWF0wrHRFPyegQh+C07I64NUW2cPjVnxSWaBxpdMSUKvRU2KeHrtyYF5/a3n0N7TjlnjfZUagscJOytyPpyXUiSmlq5k6AXXUUY11MrIN10rd0IcGf+lIxt18tfYk19eQUmxTr3gigPHqasDq64cS8=
Received: from DM5PR21MB0778.namprd21.prod.outlook.com (10.173.172.148) by
 DM5PR21MB0746.namprd21.prod.outlook.com (10.173.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 12 Sep 2018 17:38:02 +0000
Received: from DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd]) by DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd%9]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 17:38:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH AUTOSEL 4.18 02/88] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.18 02/88] usb: usbtest: use irqsave() in USB's
 complete callback
Thread-Index: AQHURkK71BKA49IDeUKhAeCyP8Rc3aTkTpSAgAijmoA=
Date:   Wed, 12 Sep 2018 17:38:02 +0000
Message-ID: <20180912173801.GD3821@sasha-vm>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
 <20180907003547.57567-2-alexander.levin@microsoft.com>
 <20180907054223.GA10250@kroah.com>
In-Reply-To: <20180907054223.GA10250@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0746;6:BqRj5DFK4VebHz8uIazVLI11PU0+d3FVCr8sL7fmxQaBAqeKVD7xmeDzY3c7dhJws6wZhJsa9Q7gss5yvtINzy3XT+dm9HS79F83RVGv6o+ujewxfaKHaEi/D//j1JUB20OlCPIQuODyeoku+I0lmw5mrGdLq6PDqvygYAa1kxIaSWFsJamg4gOjneUNaM2wsKrYWOyGOHU9LvfVl67mv8ZF7ogyAO2/uzA+4I8qb5GPbeNaaoBC1RhnNck42JWJKQJq5NbbPSkuQ4oR0i95advWaR5Is+5+3HHCZUvSgjENcdrIJlO6yJb2TcbElGVXktZIiTj7S3RiOZSkvRQLzDbEsj5OlUv32ahA4Tuvd+lbqJgSNk4FxGY1jOVUuzbDnEe9dHsEjdrOYX8EAhrEer0UG5iK4gUP4MMUa1rX3yz5RY2/sWxaBEYbAJ8uqzeH5a7qZEUSHOmsj6iZ9iWVPg==;5:XhgHjk2uCsivJRi280eQriGAjaRwkGzH4Kh9yRqL7tJVBRbuQtX2oTRM7ylb+1sK2FErT04JUcEYR5Y4Fab7byQ89hR6P7QeGADGZ84jKE9SFUb016ie7dk9kIqWJp6/skoBmJJIk0TtTx/P3fzpAyHVJgNhrWelzkfQRdaw21g=;7:LsccWW0GKtYslvJDUxb15cUC613AqQS+Xp7NfeYJtOfEKreS5oMimF6x0h7LCiTKQ+MW3VKmxID28HxdDRKaEn8/hHnlpIp9i9fwF60ZHzBrRscAV83fajOUDhkLH6R/WkEti7gLWp22uJQdGIVW3aINFlKDA9DG5AhRGvTUU2i1xe0saLAbJGBHsSaqTqvWBqzqKg6KLcq5lqIDe7RL10ggGDUFkNpd705LrZIqNQ2yrrx4RiuKvrnwybcXketo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cb56dcb6-df75-4db2-df08-08d618d67d63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0746;
x-ms-traffictypediagnostic: DM5PR21MB0746:
x-microsoft-antispam-prvs: <DM5PR21MB074645F98760BDC52E1B1851FB1B0@DM5PR21MB0746.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0746;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(136003)(396003)(39860400002)(346002)(199004)(189003)(478600001)(229853002)(72206003)(6486002)(81156014)(81166006)(8676002)(2900100001)(9686003)(6512007)(10090500001)(10290500003)(305945005)(7736002)(14454004)(53936002)(33896004)(76176011)(99286004)(2906002)(54906003)(97736004)(316002)(5660300001)(6436002)(6916009)(22452003)(33656002)(446003)(25786009)(11346002)(6506007)(106356001)(105586002)(33716001)(6246003)(3846002)(6116002)(102836004)(1076002)(186003)(6346003)(26005)(86362001)(86612001)(476003)(4326008)(486006)(68736007)(217873002)(8936002)(14444005)(256004)(66066001)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0746;H:DM5PR21MB0778.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0Jxp5lIDbpa+lVDgoHTeAvqbdIbGyiRmKnbRpzpDZVtQCoCF/nBlIFYm6Gnil3OIcWoQYQzOUxOvvmMptOzFIjsuVQ/OqWtSjozzgmUTEPfilu3vTccXffRudnB9ohpGd2+R1FloQKT6bpG+3tYj5A4gDz1KbCUpbf+DTQqxk/I87nd7wyFMQBBWjnL+NZf6VqqZG5Hk1l4GcldmIeHvkCX17jn0WYC5i8qt+nHK/k3OBS6fBcDBV42nN8zbTFZcMYLyUQXTGAL3DL3lA5cwpVxr9T04UAJPHPsjnbTGyjJ9p29b6Kz4L0wRkMokTbLjKLAy/gKtLNbEvvCo18yVFF5SXyQdtI9S64BW/bdX9cU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0163C10C9001B4F9B29CE0979877A8B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb56dcb6-df75-4db2-df08-08d618d67d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 17:38:02.3717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 07:42:23AM +0200, Greg Kroah-Hartman wrote:
>On Fri, Sep 07, 2018 at 12:35:52AM +0000, Sasha Levin wrote:
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> [ Upstream commit 6f3fde684d0232e66ada3410f016a58e09a87689 ]
>>
>> The USB completion callback does not disable interrupts while acquiring
>> the lock. We want to remove the local_irq_disable() invocation from
>> __usb_hcd_giveback_urb() and therefore it is required for the callback
>> handler to disable the interrupts while acquiring the lock.
>> The callback may be invoked either in IRQ or BH context depending on the
>> USB host controller.
>> Use the _irqsave() variant of the locking primitives.
>
>All of the "use irqsave in USB's complete callback" patches are not
>stable material as they are prep work for changes that have yet to hit
>Linus's tree.
>
>So you can drop this one.

Now dropped. Thanks!=
