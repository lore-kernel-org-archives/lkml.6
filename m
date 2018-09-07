Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A4FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BF22075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F9kmLpmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BF22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeIGFAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:00:47 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:48928
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbeIGFAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urGvkyeDWEIxz28iRvjh1VAHx9+LRwYT4465UwL9KGc=;
 b=F9kmLpmB1p5drdMSL7uw42wptejTGE+lpn7nNWycUvtuGyX7uWLaGeHqJqGc1fPKvYpZb3B7f75tKn1GpUmjzOFJmYxLyYmRrVnpqm+reSn1nHVtoGWl23iWDnC7rLVs9rv+ecEUXCkS0AktQFQjVKg1kVbbQbuc1K/snQUWjPM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0278.namprd21.prod.outlook.com (10.173.193.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:22:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:22:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.18 023/131] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.18 023/131] media: usbtv: use irqsave() in
 USB's complete callback
Thread-Index: AQHUQr1XMJiNwqt7F0W1mA0oF8IsIaTeJpkAgAXVtAA=
Date:   Fri, 7 Sep 2018 00:22:43 +0000
Message-ID: <20180907002241.GA16300@sasha-vm>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
 <20180902064601.183036-23-alexander.levin@microsoft.com>
 <20180903071631.phvvuwxu5ozstq6g@linutronix.de>
In-Reply-To: <20180903071631.phvvuwxu5ozstq6g@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0278;6:pUg/ykD0nPf0XjCPX8J/RoVh9XnOtppua7B2RYFnEAJNKvKu1KOTg/mqOHi6Rz9wGu3DnvT3lwns/5RGOaxf5Wmzv5HAtPED+sRyqL3/MHgCBv46om/IHpOd9MkmFWayWWB4m22v65tpAerYYGjQP/LRMYfy0gqibP+Lz+GsifhTKtjZ31bjfV1LtZ8yRKnPJfN/xRtqIJWKm5WvqmB5TRmtVTtBAIATnjVvqscFosyDFiE2iRp1ZUDJoJQM15L1bh62RomapmPhZguLFQefOyvCv7Ok8K9WgjP5/74q7HRh6ermkw9wRwr3k58E/Uj9XpJsCnSU7DPefG36aG3qTpRo1KuPx+jMQMXntaEt1S9kDt6qnrvPF7HcyEBRjc1nC0cJ7+9FYvvfiG6cBcY/KxE1f9tvXPe3HTeRU0EfHGDMIp2pIJEgZ9VIHEQrUyhWlQVgoH5YB+QWMA55bwM1lg==;5:FtBwoqRolFj1ShJIN9vyfcYJCIyR+Etuq1wlrtv+BvPOXVAkGOiTdglR443fraj8XxAgAZYPJ1ZlfjeAyVeMx5VMjd05Xqum+XyIgzQaMZdQhDdWwOBMJbNpXpMPQAHIVZ2qrg1lXQxH5uRfx9NRFTwtETQcpKv8jjXW6y2u1To=;7:0c/J1JV7KWq9BePpdiSoYpwFB+lN/VZ/vD0y4pQHikbCFzdT/dahJoaIePy4ltR4zHnmitoWnmFCgtL0fCYUED/JckFXUN0/iS+VwRPVkDcDKb1A2tF8ETT0XZqPv9qOP4UWas4YaVYRuWZcqTg00xmfxIY3HbW4De34ZunvoP/bM8WphWTebNJd0GT7JqmS2RCGwjrB3s9GR5/M5ATrN+bXPm1dYXmEelxBWucFVugTe0Z5uUslm0AnXN3w4VFi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1d7efe93-95d2-4a7c-7e9d-08d614580766
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0278;
x-ms-traffictypediagnostic: CY4PR21MB0278:
x-microsoft-antispam-prvs: <CY4PR21MB027859D1084D3F89ED2DB6ECFB000@CY4PR21MB0278.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0278;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0278;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(256004)(2900100001)(14444005)(53936002)(81156014)(81166006)(54906003)(8936002)(14454004)(316002)(2906002)(86612001)(22452003)(76176011)(10090500001)(217873002)(6246003)(186003)(6346003)(305945005)(6506007)(476003)(26005)(4326008)(486006)(25786009)(86362001)(33896004)(102836004)(7736002)(99286004)(106356001)(11346002)(446003)(105586002)(5250100002)(66066001)(6512007)(33656002)(6116002)(6486002)(1076002)(9686003)(3846002)(5660300001)(10290500003)(6916009)(229853002)(8676002)(478600001)(33716001)(68736007)(72206003)(6436002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0278;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: huTgKwZK2otUz4mhzb/gaQhKcElHWSy/XeRJjYK/+xhaJE0NA6bdNkDWZW4FzDSnUz7c5SWRMWKXR0WHa2EN10ufqwUUaHdQeuEGLluV+DlWpZmRHSWSgyo13RUqAhwQjkQAFsQauI8EpgTvL85M0WnhG4i0xXrRS02iSq9brXv8LtnE0fqDLsv25eV26oXBjKK80dR3ekPdiC4Jo6WtbE0CPdNLPQIkifF2oNDF4uriViXvZhO5bmO0gDc6ukP6/+HBrhb9aPU74pu9WSRxdXL5iGx+xbh0jK+gbi3A1bfcDAAPE9M9/lfkSdvq2XGEt36r13QyKHjRJHMiFAD4P7m3F6GQLL7haowfYGXx2NY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9DF02D934503347A130505A58CB1C1F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7efe93-95d2-4a7c-7e9d-08d614580766
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:22:43.1377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:16:32AM +0200, Sebastian Andrzej Siewior wrote:
>On 2018-09-02 13:03:27 [+0000], Sasha Levin wrote:
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> [ Upstream commit 320905baa1dbddd3991c287432176d536e1d5b79 ]
>>
>> The USB completion callback does not disable interrupts while acquiring
>> the lock. We want to remove the local_irq_disable() invocation from
>> __usb_hcd_giveback_urb() and therefore it is required for the callback
>> handler to disable the interrupts while acquiring the lock.
>> The callback may be invoked either in IRQ or BH context depending on the
>> USB host controller.
>> Use the _irqsave() variant of the locking primitives.
>>
>> Cc: Hans Verkuil <hans.verkuil@cisco.com>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>
>This change (among the others that do the same in different drivers)
>does not fix a bug; it is just needed for "other reasons". While this
>series uncovered a few bugs, this is not one of them.
>There is no need to backport this stable.

Out it goes, thanks!=
