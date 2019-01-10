Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8121773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ELlXN6fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfAJKY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:24:29 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2668 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfAJKY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:24:29 -0500
X-IronPort-AV: E=Sophos;i="5.56,460,1539673200"; 
   d="scan'208";a="25321819"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jan 2019 03:24:28 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 10 Jan 2019 03:24:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgpfCeKgfkTZX3RqEKJ3dgzBkoX9g1oQkkmuBNyk8sg=;
 b=ELlXN6fbsrztoGCZObflJeBhN4bX4ygBGVEd0aVc1ZLR0NpYvx06156TCcPcHu5EplBobculUrMjqc59DOe9T6ZfjHnGlTVoUAy8lrjgHp0ApksZyuEkEHErYUGIJUqbxkXDi6Hm5zfy7awYAI17oNHsCBDnaM2lkWndUiwo/Uo=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2015.namprd11.prod.outlook.com (10.169.236.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 10:24:26 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 10:24:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <rjw@rjwysocki.net>, <pavel@ucw.cz>,
        <len.brown@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Thread-Topic: [PATCH v2 2/3] regulator: core: add helper to check if regulator
 is disabled in suspend
Thread-Index: AQHUp0DQuBK0W+8S40WNFSmYgBfyCqWnKjIAgAEkkwA=
Date:   Thu, 10 Jan 2019 10:24:26 +0000
Message-ID: <76298993-c1e8-1b00-6a54-5d41c48bc2d3@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-3-git-send-email-claudiu.beznea@microchip.com>
 <20190109165706.GG10405@sirena.org.uk>
In-Reply-To: <20190109165706.GG10405@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::30) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2015;6:Ak86KM5CzGuot0e5fEHa0BU6fWzb3u1SuBDh7Lcciwu+edTyFXpqzLylX+aAEsdGXd49Ae7tvcO8peGDA9gzV4XZnkAJmnPZDFug5Ojef1B9Wk+LLPaHTsnVmiWkJlangZ24/mEH7TihRVCMhiWvRgcGQgNdPy6EKwYcBDxjAwjLSd5ctcx7pylY+i8du3cadollnkWbTJu3cAUQXZTfWviQ5R4zBkxijPMPEZHKMbmUziJcFlMlQ81MtD2vM/F7SOVTTq7ZSH+QfStfBGrD6YJwD9OF6ZWO29C1L//kHD/1vyEjUyi9vrhsfVz0COI5D06SSyZpIZNg4mCNpcJjVFA+gj5QaS1xCd0uG4jB9fkoAtNjOqU1thKlh0IWTP5y6bjNAaUIYnj8Io6fpujjEYzf27RvbgksJ2UQ2vKq8Lq2u3PRrZgStG18maHN9oXXTZn85wYA5lkfuLwt43Ed4A==;5:4KACJ2A9p7UyhQMHlaJ+GqHMsu+h0YjDA8L1/ciNrL+yIQ5tuKcpnT836+Gfb7VSe6PubuZ+eDi4eTQayuLa97ceVCqvCKMIFPxuTT5AupvJqKPuNZQhnSyHZNPcVrkcnQiC7JfIRksUDyzY1cFje16mEC0KfBLKbSls1o4SKcKvwgTq8N0aKOkMyPaXXG1EO7aqg+611FfErERVohgp2g==;7:ua1G6rHXJ3Jg1zpfWayzyj0TXAEJQrMxxizG999JNqqGy6J3QJpZKvoLmg44SMoxzq/+MGP74Tk3JeTKldOrFUQ81M7wHDsfbGopcXMuA2vCaEekwAd3lJQy3HMcH98Z2NzDwmulKaCppSSoA+K3SQ==
x-ms-office365-filtering-correlation-id: adb86003-e238-407e-598c-08d676e5cbe5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2015;
x-ms-traffictypediagnostic: MWHPR11MB2015:
x-microsoft-antispam-prvs: <MWHPR11MB2015C394D3795AA2E39839FA87840@MWHPR11MB2015.namprd11.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(4326008)(25786009)(6486002)(8676002)(6512007)(99286004)(6306002)(81156014)(81166006)(97736004)(7736002)(53936002)(305945005)(6436002)(8936002)(71200400001)(71190400001)(2906002)(66066001)(39060400002)(316002)(229853002)(7416002)(36756003)(6246003)(5660300001)(6116002)(3846002)(105586002)(486006)(386003)(256004)(53546011)(6506007)(106356001)(14444005)(102836004)(476003)(446003)(2616005)(11346002)(31686004)(14454004)(478600001)(72206003)(561944003)(6916009)(31696002)(68736007)(76176011)(54906003)(15650500001)(26005)(52116002)(186003)(966005)(575784001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2015;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zQu5FtEeAIOyPFmogXiIPoP41wBACBtzLGOLrohA4E+LWUjlp6YgbYNb2HwcOcvZf3rt+FblgWYRoU2DiSCL+j6x6ANdkp9KrUdAQMHVSpK7XXyo8q2QPllP/O1sPehMq40vq5COllvXJn7wmw4vApJ8jjV92SpF54GJzOAIxNGMRNZmhlUvAPFiW23ZoZSjKJojBiWP3yiif5PJc1rKfDEqU6qUa9Ub1zuiwoPRMTiabLVAelJw7U1ruK6t+c9wBtMcofwgaMqt3R0G+lhs1rTO97AxeaFt19rTZfr6QUiKAZB9Fr5EVaD4uafzGUlJDeorWkFsOolAbseoTZEX0nFeVszqHu4zBJ6rEc4U8ktGV2DgA6XiN4S+pH5wgBX5PTsM2laZfFoj1OTliExTowJ1lWEMHdq9NqpJJPSQDkjAvNJG+d7TrtySXkivTjyRjiR+K8mdIxek1jTnGUgEZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2E877C7434CA9147852E296151A845F9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: adb86003-e238-407e-598c-08d676e5cbe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 10:24:26.2950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2015
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.01.2019 18:57, Mark Brown wrote:
> On Tue, Jan 08, 2019 at 10:56:32AM +0000, Claudiu.Beznea@microchip.com wr=
ote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Add helper to check if regulator will be disabled in suspend.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> This feels like it's the wrong way round - if this is configurable I'd
> expect something to configure the suspend mode and then for that to
> arrange to configure the regulator appropriately (along with anything
> else that needs doing) rather than to infer the configuration from the
> regulator state which feels fragile.  But based on the cover letter
> that's kind of like what the initial proposal about target states was so
> perhaps this is the way we end up going...=20

Are you talking about [1] ?

this certainly looks a lot
> less impactful that the target state stuff though.
>=20

For the moment, the patches which describes the regulators states in
suspend for SAMA5D2 Xplained board (which we are trying to address here)
are in pending [2] (they were introduced with patches for act8945a
suspend/resume stuff). Probably they will be introduced after one more
Linux version.

I can get rid of this patch, take advantage of [3] and [4] and introduce
also the regulator standby states. In this case, no matter the mapping b/w
Linux power saving modes and AT91 SoC's power saving modes, we will be
covered on misconfiguration (at least on SAMA5D2 Xplained board).

And in patch 3/3 I could get rid of regulator checks and rely on DT (bad
thing would be that in case of no input for regulator's state in
mem/standby the board could not properly suspended/resumed), if any.

What do you think about this?

Thank you,
Claudiu Beznea

[1] https://patchwork.kernel.org/patch/9458445/
[2]
https://lore.kernel.org/lkml/1544543768-2066-6-git-send-email-claudiu.bezne=
a@microchip.com/
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commi=
t/?h=3Dfor-next&id=3Df2b4076988a9c229dab373470b4b108ef0e106c8
[4]
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commi=
t/?h=3Dfor-next&id=3D5279e96ff8033500b6008be5925ae2d20f42c434
