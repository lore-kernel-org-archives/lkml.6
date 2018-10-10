Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECDAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40741214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xjl7RXB7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dT5nXGtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40741214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJJQBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:01:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6047 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJJQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539160828; x=1570696828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UB+te1PsUm65Ar9XucdQbK2MQpzPY3bVeqNriwp5qB8=;
  b=Xjl7RXB79/GgPQvYq5+0eP9K2jxFcO2cXehuzq+E5L7eiww4xE/RnQTc
   ON2WVMQ+JDdkmNCTD4kwacb12OwiDFbsBKSeF0m67boFvMGTgI3YxYtIS
   cir9BFJqXKwSgTpMNB2HNrBFbKGL5G5vg8L9pxL8OqtFrrfJSo8sSifjU
   5cJ2wzpGScc86DbvC1SA+CXowsCe8/SOGIK87E5VCdMEDS7H2Pv8m53Rp
   jz9rXQ2djZmedWENC9PxUAyjhdFQyjN7j0FOZHEo1pS01Z1sRgMnst3Ny
   LaItmgRY5T/4CJTg66GVoudqJozOPHbmnpSbrvVpkyqk8Ejf0G38ENrZn
   A==;
X-IronPort-AV: E=Sophos;i="5.54,363,1534780800"; 
   d="scan'208";a="91642950"
Received: from mail-co1nam04lp0054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([216.32.181.54])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2018 16:40:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB+te1PsUm65Ar9XucdQbK2MQpzPY3bVeqNriwp5qB8=;
 b=dT5nXGtBJs3xQSJZ1HL2E0QZ268fNLnbJxfZ3Kh4NWwtpOfDr5054fLA5nraHhNL5CO2uc8AgDyMj5QmGfPfkpZyvse1ALqebL4Lkgorm5g39m9JM49zPzMqsVyE80IQK4l65kcn7FzjjeDXiVdGlrPF27SYjoIgz8V1Qph2E+8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB3936.namprd04.prod.outlook.com (52.135.82.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 10 Oct 2018 08:40:26 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b%2]) with mapi id 15.20.1207.024; Wed, 10 Oct 2018
 08:40:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     James Nuss <jamesnuss@nanometrics.ca>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
Thread-Topic: [PATCH 1/7] mmc-utils: interpret OPTIMAL_*_SIZE fields in extcsd
Thread-Index: AQHUX/YEej4VyAL6nEWJsLhNbF43K6UYKXRg
Date:   Wed, 10 Oct 2018 08:40:26 +0000
Message-ID: <SN6PR04MB49256CFEA5B525999B4AAD0BFCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
 <4a016f761d388a989059467507f2bc948ba26c6c.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <4a016f761d388a989059467507f2bc948ba26c6c.1539103468.git.jamesnuss@nanometrics.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [77.138.253.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB3936;6:0C0FqFEb/P+i/xi5TcW3MlBhjCgvrU5bp9izYCcrZ9wSsGoHHYbC7G7CnQGJ4/oyAoiV8riBqTuh1TgnPa8vvXuMRFUElioUdGWnOfpAsEhI1XyG/GMB6L+G+52MykrvgpxRDw4qzk5y95YvKM7Vmt/GFtgehrCGwcuSWZZb9YgNehOpMz8L4lMFSwWlc3S//lwJyWo+Nhy3JC7ZpZg+gsssiDhG36cHCydOrpm/BDQMmiPQ4pcV1orAMhGDWlcvXCCu7plXZPQ12NXviDC7jRuV4RsbGBeoKlVQy13/IUH8EerZ/43os3PTMQTHhpN2hQUf8lo8BuzMzAsYG6JWGirCVgapCFp48W1djzwWRWZPPP2x7IIusN0JqNOJY3y/GFfzMq2cPL0Q4O+isRhUe5lUSkrcMvgLOJMI+G5LsFlXWe2rBJjwRQOJnAjzrk+rJLF2El03Z8l67cPnsCIwWA==;5:VTMIHqFm318G6oD+h7kySL2ETGNEP2FHDHI4U3mnwSqNhUazXKqu9hHs8q11TCyiHT2q/l9tgwyLSX1W4kIyoJE1nf2tIMqsQp9T6qXOTPwH31tolRiRIKsJa9p+oW2zViLMWk7bxzFaI5zzpcXQ+8chhRth7xEKAKvcvZeeWKQ=;7:yJB2HaZ1Bebi77rmYzD+Od1dOr+w+a3M2f5B/qgjjDun3Nz5ln/XgS4wofy69F6OFsn9tTL3MYTHX2TLj9kFIdDhRA1uR1+cbMFX4wcDRuNMJ2rLojyCzsvJxsvnfNyd1SccupAnYAhMGia8lqqL64D/M6QkCxNrXM8wPA/cMHbfr/N8GTRlmqnguuB3Y8xJCGu9tSCPMGdBlSoe05Zj4mJwi7oTOTcf6Q2gI3L//+IR/7BdvqdC7U6N0O26Kx7X
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 77071b1c-ca8b-47d7-14d2-08d62e8c06df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3936;
x-ms-traffictypediagnostic: SN6PR04MB3936:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3936B5B5A373D8E3DB0033FCFCE00@SN6PR04MB3936.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN6PR04MB3936;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB3936;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(110136005)(7736002)(53936002)(305945005)(5660300001)(106356001)(105586002)(316002)(2900100001)(74316002)(2501003)(6436002)(66066001)(229853002)(486006)(476003)(86362001)(446003)(11346002)(7696005)(76176011)(8936002)(6506007)(6246003)(2906002)(558084003)(71190400001)(256004)(71200400001)(102836004)(25786009)(97736004)(9686003)(5250100002)(55016002)(81156014)(81166006)(478600001)(3846002)(6116002)(72206003)(26005)(4326008)(186003)(14454004)(33656002)(99286004)(8676002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3936;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ux7cGVX+s/DTTzMVd0TVY+FUXOmaO8qApZz3GHKafv2tmSzGeH5ve0HrHsrV64SsdR9p8tlRJzvBfQh/3z6v1PV9RvqKUpxIMtyG5RXEVLmBt8XgUQh0mc8JLKq4chcEcG/NQ+O1jXLMm74mqS1Eys2+75wpAwlJle4Hizr2h7E06kaOVVv7MFrecUhQv9xyjFTWXw0qU+KDB9hcjwP6AP5xRQ1vmlqUam7KE4ZuzFt8Z65/+TRpUCRgId/vyJNLdNKusH8hdrOtHBv7ZEl9JKmfX+OBgvUYj1YrRzKvjF9fgCBrtTyElcvMfz/Uy6K+MuJdYyHx7/VGY+cRk8sgvkL/ZGh4Oj93ubDoLwOB8cA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77071b1c-ca8b-47d7-14d2-08d62e8c06df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 08:40:26.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine.

Thanks,
Avri

> eMMC 5.0 introduced OPTIMAL_READ_SIZE, OPTIMAL_WRITE_SIZE and
> OPTIMAL
> TRIM_UNIT_SIZE fields in the extcsd
>=20
> Interpret these fields when reading out the extcsd with human-readable
> results
>=20
> Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
