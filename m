Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEEFC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4E921773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J2UZISqZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lup5V7so"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBIJHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:07:50 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11722 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfBIJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549703269; x=1581239269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gqDu00/WlCcNLoF/eCje6WfpYAwOmXwFys7+1wwdc1A=;
  b=J2UZISqZdKKCX6d7c5bOCC//5nDNBpZuvJO275H42tY0MCzVPLeTTVsj
   r8a1TWWuB9R9dKbSblsaio4zkmvjBzvbbKiTvBCM5qHv/Rl8xoj0nDqnE
   rshn2X0VkqinzErvb1YIXlKHsXaf7NIXZamJNJiq5/wkWrxhTLAAUpvLu
   E67rimLQOYrQqDQnSO5zlO/eqpsEGk8fWgsXVE6B3vv+G8FsC8k9xCE+B
   BfJ/dHJYKxuxFbHH2TZFSR27HEahPGx0CiR6uziQCXCW8bnFaRYEO8tv+
   JhUiFRKwSsZJDOh0ZDmgwCZelvLrVVWqW6owsdy3+XOPmHC1JW0N0Nxb/
   w==;
X-IronPort-AV: E=Sophos;i="5.56,564,1539619200"; 
   d="scan'208";a="102132617"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2019 17:07:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX7VsoX4668aE6RYNIDc+olOTeZHyMMuJmvEYDFEhJA=;
 b=lup5V7soio3MQvQxW2xXK1JP7aLLcV1jqZfmA6vwM0yT5iRAfnNJ/O3MQft2hk3IS/yRr6sBtADW8scIS4+qBc+y//GPetPcsjQDbfQPlpx4uFTuUl4oykdtppWrHLHHV/2JpV+K5y0F/f89ax9CNrCMXe4v7byqvBKNXr/6ZfQ=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4128.namprd04.prod.outlook.com (52.135.71.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Sat, 9 Feb 2019 09:07:42 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1601.016; Sat, 9 Feb 2019
 09:07:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
CC:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/7] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
Thread-Topic: [PATCH v4 6/7] Revert "scsi: ufs: disable vccq if it's not
 needed by UFS device"
Thread-Index: AQHUwE1HKma9rIE6I06Q1mRz/JuPqaXXKk4Q
Date:   Sat, 9 Feb 2019 09:07:41 +0000
Message-ID: <SN6PR04MB49252A044910AC48672F1043FC6A0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
 <817ff724-2a30-99fb-8a92-c77797651bde@free.fr>
In-Reply-To: <817ff724-2a30-99fb-8a92-c77797651bde@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [129.253.244.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4128;6:gVVeAxmVI1uDnyHcDT6naoLm0k22fWdIomjtQ95XZj+/f2VmMXXeT7g+n4juOlVNJFBflJ7ZZ6ByaBsL40R2j8QnUZ7mot5Xx2piiVulFhR8eWo6WWDQpzqdvUCHvr/5Q+SyZQ322Qut769mZyC0arJtuvmSucd76DbIXB6ySHn+Sbes2DUKb2Ma0s2n1NSKWZH4DjaTLiAYcgjr91QkFRlAnzO6FtNaTQQeO8VIKfOfyj19DTA101JWCsKtWwaYx3CIxWEyfpi6lWhk+hexonraVwHgHf0Vl5jNLcJhM1RnEadjisjDE9hrL/4G1feo48tncguEl1jF6latXzckTlOz3CVjsSF5acqARF4xh/dFcdo8W45QEiVZvCu/mdGiRu4jC4Q13ofvAOuYLrVpvhUhG5GQ+dtg+tMdl/OfNwDW1iGKSHKsm/qje6H8ZrhAbqQ4FUzpFZmuE0lvLRWU2A==;5:3G4amXbDugZtYv/08CHFUWoowAAnsbo7rsaFqngjGo9MY+wXmZt5He0EBor6TrPBf6g44Kh9hg8XhdEwLaW7U1fp66bgJJBN9oHDXgwA2QE6CPJIF7ffxAJc//K1mcCv4jZpSRzgx1q77jKM3s1bYd+QfOOo+d46RZHVLAFmFAGbZ6nQJWFeUN2fOb/q3uFcafx7aQtzp15XO2CjQhxNAA==;7:ubOlrx4W/Xwn2XnmcpfBeT0QkFcTGFby8eJloQqqmdYu4DTyTO54R98geExXV3sZlHXZ4jiI5VAm1jzNyBEKzrOUcGx7YjjQKd4c4767Qk4Xp4Hp2suNZW6GwUdu7oes+nnxC2C8qPNDSTQSA0MiAA==
x-ms-office365-filtering-correlation-id: 4dadbaf8-23b0-43f7-3a0f-08d68e6e0c2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4128;
x-ms-traffictypediagnostic: SN6PR04MB4128:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4128BF825F1DB4B973532C27FC6A0@SN6PR04MB4128.namprd04.prod.outlook.com>
x-forefront-prvs: 09435FCA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(71190400001)(99286004)(66066001)(186003)(486006)(11346002)(446003)(316002)(6436002)(72206003)(478600001)(54906003)(110136005)(97736004)(68736007)(33656002)(71200400001)(4744005)(86362001)(26005)(229853002)(2906002)(55016002)(6506007)(9686003)(256004)(476003)(102836004)(53936002)(76176011)(6116002)(4326008)(7696005)(6246003)(81166006)(14454004)(3846002)(105586002)(305945005)(106356001)(25786009)(81156014)(7736002)(8676002)(8936002)(7416002)(74316002)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4128;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ax3o5bup+2Di2FEaA5R4kVbEDSHziFBW8N5L2SIA/m2Es6YOSAjdj9b4KRgSDY372dzRyAU2uoQgCcPvqdl7eBm2jO+SP0KLaKANhTGvWKFZyepf4Xm1a0d6S+bnpBQ5nzsaGjES2li2QBUc7uCc1KFAlpb6ZpZ+Fs2/0k7fJ1EVvwf10muwxUAVhqF1YibmCa+O5w6cHhZHXpxgZKdty9hDNQ1//r6iltZyN9UzX1rfEm3JEgDgNe58QTmZSbmRv6IMkqwokMWDcJ+7+LwNZ9H+R83rQcYXAcDpwFX5cWUz5L/Eji/x7gaAwOh4OHXU41Lxjucq25li51NobiQLunR9byfYK4Ofti/Ye7T1xU5jisPzqbWw9+KxLN66sabzCqldvSyo3M4Dleg3osmQXOpXSNqLkKCoZorkikEnLIY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dadbaf8-23b0-43f7-3a0f-08d68e6e0c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2019 09:07:41.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>=20
> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
>=20
> Calling ufshcd_set_vccq_rail_unused() breaks UFS init on two boards.
> I would say that vccq is *not* not needed.
>=20
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Those  tags got switched off.

I still think that If you are reverting the quirk implementation,
you should remove the quirk listing as well.

Also, as the v3 discussion held on several threads,
and new people might be joining in,=20
maybe you could reply to this patch with a couple of sentences summing-up
the various theories that this bring-up raised.

Thanks,
Avri=20
