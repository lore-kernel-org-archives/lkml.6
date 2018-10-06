Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A17EECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F358621473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="e0h/+H97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F358621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeJGEr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:47:59 -0400
Received: from mail-eopbgr710133.outbound.protection.outlook.com ([40.107.71.133]:53664
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbeJGEr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g85h3t4Kbnn69ZgyBB7nZRtqdE8+DHF0wuD0TRHUk/s=;
 b=e0h/+H97rIlfZ12hZPjE8xF4JLZSnUtJ+AF/3lO9rRZGqjWNBgjPaHN1euNOdbqtGwvLkv8c7I+REZ46koosTD5L//igNuYB8oEc8ZTGGIAY/Qgwpbk0Krm0+eUddJFxMTd7ohwAq0WSl6jC+GrewMkAkjVVKEzwsdN02Dj/CIg=
Received: from MWHPR13CA0028.namprd13.prod.outlook.com (2603:10b6:300:95::14)
 by MWHPR13MB1423.namprd13.prod.outlook.com (2603:10b6:300:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.18; Sat, 6 Oct
 2018 21:43:02 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR13CA0028.outlook.office365.com
 (2603:10b6:300:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.12 via Frontend
 Transport; Sat, 6 Oct 2018 21:43:01 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.229)
 smtp.mailfrom=sony.com; HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail02v.am.sony.com (160.33.194.229) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1207.19 via Frontend Transport; Sat, 6 Oct 2018 21:43:01 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com [146.215.230.103])
        by usculsndmail02v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w96Lh04r025333;
        Sat, 6 Oct 2018 21:43:01 GMT
Received: from USCULXHUB04V.am.sony.com (usculxhub04v.am.sony.com [146.215.231.18])
        by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w96Lh05V010537;
        Sat, 6 Oct 2018 21:43:00 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB04V.am.sony.com ([146.215.231.18]) with mapi id 14.03.0408.000; Sat,
 6 Oct 2018 17:43:00 -0400
From:   <Tim.Bird@sony.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <ksummit-discuss@lists.linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Topic: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Index: AQHUXbzsST+hQw7zT0eB3iy5jbswn6USvpZw
Date:   Sat, 6 Oct 2018 21:43:00 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861851.4088.7.camel@HansenPartnership.com>
In-Reply-To: <1538861851.4088.7.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.229;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(448002)(13464003)(199004)(189003)(55846006)(3846002)(6116002)(229853002)(316002)(2920100001)(2900100001)(106466001)(76176011)(8936002)(186003)(6246003)(55016002)(72206003)(2906002)(86152003)(8676002)(5660300001)(50466002)(4326008)(26005)(102836004)(478600001)(47776003)(33656002)(7696005)(2486003)(86362001)(23676004)(426003)(336012)(436003)(85326001)(356003)(14444005)(246002)(110136005)(476003)(446003)(2876002)(126002)(66066001)(305945005)(486006)(11346002)(7736002)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1423;H:usculsndmail02v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail02.sonyusa.com,mail.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:WSdpD9MFayIWRgaUNMJ5DiwzjeaAYDxfuHlwMeC/xY8ALxUS+G2Z0K5V4BsXz7OoDlBkrOB4hfNnoqgVYHf7Re1Kfcwwejz6k2vgWoew6IPul1/9nO5D4RqWwyQl+uC1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fba86f9-1aee-4a88-daaa-08d62bd4b06e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:MWHPR13MB1423;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;3:YHY6p0h/1avix+7yRukjZAOGziakVrIQPoS3aSNzsj8z6ygHLT3LYETuI/aFFtm1heSv0ZsuaLsxQ9o2xoNBeyhYK09eBq4s3feKVpqh2UOBGvCfdngKzrSoEyMi0GNVZt2hBrdAqSuNNnXhj6zAYIM09w48+IR0O9uNLMbXcDC0YMz/dg1YRG2qb+ALm8WCUVu9fnyaQJYXPI9c0Kl4ow3af1WA0OZkpt+j3Cu1YXXVU6bkltNrgaupkfYvDFA5Z0OtnKZhVDAQtY5TvfmCjYtZOyPIW31nqN2pOCACDUjCbT3zjKsv2vJRpnRZw0IbYeBiPLTg1W+iOuibCt4OWARBx4SNEnSdm0g/jS0pMLg=;25:DhEyabEHtuMk9Ck5jPZ/D/Z9BdMMkcf/Lkiv+wjsm3dMX+nQw/eh3lE/LHn/cVT43kAswXAQtGUSxAl1sLbvozLwha/K0GbTSM0rd/blkiL9mtF+B31pEeIG6jmdiCtGW6xC8nMhpOtp4xqvbYPhX+H5U4KZTaHAUH6nEWimUhbcEFypA/vVUthSh8oEJB76hdldUxX2XIctmnQ07mYXuv/qdaiK84AOhZbz+MhxOOdL+/zgsn3rEzrslBCMfz8FBeT3X74FibL53rYbH8yLzW2wlwZypAygkbjoxlMLUXq7qAGkXHXF35U6osMzgyCTjiAxUdcy2vLpTN284vlgjw==
X-MS-TrafficTypeDiagnostic: MWHPR13MB1423:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;31:PIb8hW21xYuhqams8t73yN+om6LK+Hc3gJ4cpNtHvA1EwNBe0/L9uZSmui2xO1dr5cXYD86vxw3MkUFzWWtiKg7GzDKo8d8WFFcEwIcM4+Z48PtqOkFi0RXXl3N7ANHZdaMIrZOQMS6g0OHayPkGWs80PjYh03QgRR0Xb6MmzRv0HxWC9Vt+ClQnPDp5bUz1rE0oxn0JnUbaSVnvDMF+//jMANfPvqAYxtHN0czy99k=;20:fddEGJuwfiZN/rcwKupUvqQ6WT4Q2SGqc74f5UqMRAesl71+UNKbVRKcI6SuRdlWSHyM5YHGtZrrr9wh3sOb9UCAA+EfbKpNZydHExpAmhQSzfDTOT8InpioFIJTz4zGgyQw2DCBRJAwqaY/67Uec4Ix+nzNP0clKH1l3ZnR36ZSdMNgUCcevl6IV2zI/UX7llEhgDt8ZBKr5e8j+ZAaAgAOVzIKxeWWThhYTKg1jdoJbzLC0RZLEP4too1kxfUwVfTx9Si9LMk5VNpdbMHB9PjLshKGxVxEkbL+nem5hpUA+A96dISzplye/mdvUSvj7DnMHN190mu/814RlRp0lsPWW7oDia/LHNTRZypSH9ugzv2/dhHYf5Sh5tJN98cn9IkAlu5/NoPAdpj8bmYPR0Ywqw3UJ4lSTZdW9cPGgMU8BvxIyihXGwgRd3lzQL6HjqitKV0eG7GI6d9LEzL5LTPXeIHYznoM++P5xKaC/PCtzue6DyaUAMIkBJiRnFJt
X-Microsoft-Antispam-PRVS: <MWHPR13MB14237036D99ADFA37D9C2F8FFDE40@MWHPR13MB1423.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:MWHPR13MB1423;BCL:0;PCL:0;RULEID:;SRVR:MWHPR13MB1423;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;4:VDGHTpwY+MTzsPS9dwHxylhLZ2SxOMuuRD24Sn8YkijibWyT7ZkcrJ2hRxkMVhC/8wxWQizTVrRVuSp9vTDBxHoFZeI8KbKiBTW4TIzF5LlON3n9O8lJxTW6zxWtlr48jwWJPwT+OvbTAnF/hgqNeMByFJ97BfRbhTD/Kbla8iXR1ia/cQiuOgLlKQ90hXjYlwi7m27XRmWl2YZTkCQDiM7qScAlXijLfuGEnmqQTbKKBHeI6ySHVDxf8lhdG8rJ01lhag57ICPwhPjKEyNT1NbeDS5XSi3F6x7CwGN9pur/z+pHRmmyeDXhWKHM7MfFoAydJBUFiHniunboAe9mQ0MnXr1r77xs3MZ/k828aSQ=
X-Forefront-PRVS: 0817737FD1
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEzTUIxNDIzOzIzOmd0MWp4NU5JUkxwWHlueU9hcERrOFpJaTJp?=
 =?utf-8?B?SnRpVXdVZENrR1JYdUJWVDMrNFR6c0R5Y0VwZVN6RWdlVFcwVGI4enUzNHoy?=
 =?utf-8?B?RTI4eCsweEpFUHMzWWpNcG93enlVaHR2cE1RZ1ZtRWkva3JUZlhIa3kvblF1?=
 =?utf-8?B?M2l6Z1dTNXRMbnYvc1JWUm1PTVMvZkxHcmY4aVlqZnJrUy9adHRKUXNKMVk3?=
 =?utf-8?B?U3AxWWdhSHpWRWkzZ2lWZnNXc1dPQnN4ejJHVnNJSXB5SEpueFF5cyt5c3d2?=
 =?utf-8?B?OEVOKzUyUm5sWkZLWHYwa3QxSDFPUUhEanVPcjQ0bFNBdjBQUkUxSjZZMExY?=
 =?utf-8?B?SE12VEVZa0JDQUgyNlZHL2xFOEhrM3prRmpueU1VSmNsb01pV3EwckVua3I1?=
 =?utf-8?B?N0JMclFzWGZLbkl0dTMrcTZWUWJFMlY1akh2ZGRwb3JETmh2NXhtS09KaWto?=
 =?utf-8?B?aTdtcnh1a3h1b0VGQy9vazdKN3ludS96WVpFVmt4MjVnRngwMU5sVW9Ub05r?=
 =?utf-8?B?azBrSkdySk1yQzZodUpUODgrR3RqWG16bWg0S1VZY1RFeXArT1NBVUV1RTN5?=
 =?utf-8?B?U01TY1lJcFcrblJ2UW0wNUVVa1RlYlRNTE9sQ1l6MkJISXNjSVZtR09NaGZZ?=
 =?utf-8?B?NS9mUGdLQVl0bUlNTFUxSmFWaDZjNnptdnNKSHlTMWlzUUhrMEVOR2Zoc2NH?=
 =?utf-8?B?U0E3ek51U0xjckZTT1hhY0RHSitROHdJYTdnTlBaSFQwUWVHaVh2TmNSNmU4?=
 =?utf-8?B?Kzlkd2U4TjVCY0RXM09PalpQZXB2MXJGZ1pxWHBBQ21pdXFLczFndUgrS2NT?=
 =?utf-8?B?eUdnKy8xdDVXQm5sRndUdWR4STh3aG5oVDh4THFCeTYyUGlpMnRyRGZLcmFE?=
 =?utf-8?B?bVZOS09DenhhYmFrUzZSV2NTR1M4d2U5YkpoWTI2QTlGMmNRUWROaTNrU1Ji?=
 =?utf-8?B?VERZVWhKT3hqYW5RWFFWeGJVS0Fmc29aVktrc2FBR3grK3R3QWpiSXJTT2V1?=
 =?utf-8?B?bEw3blRzVDI1RzlkazVYYnJlamc1OCtXM0pqRDY5MUhCb29ScjBtYnI2M1dQ?=
 =?utf-8?B?b1NkbUpoanF4SG4yY0o4WTF5U0NVUVRMcmFreTRZbzFZaGZDSDl4bmV4M3Iy?=
 =?utf-8?B?dndKY1FaTHVwdmJDTEluTW8yVkJ5eVlHaW9pejhQTjZRWW5FVFNZekpXaDJt?=
 =?utf-8?B?dzV1dTVSSHYyQmttdzhXNEQ1RmtBWitqa1dlZ1B5Yk0xL0F5KzdBSlh2QkNh?=
 =?utf-8?B?UkY4TC90Zk53dk1BemVEQmk5Yjd1UUNPWldqekdseHBpaERJTmN2ZThUaUx4?=
 =?utf-8?B?TlJCejRuZG5wVDlqaWoxVFpsTVR5dlhuZTdBcFBRTEQrRDRDbTBPcnlOWmdU?=
 =?utf-8?B?NmhNNElBVWFIamlzd2Z1VURRZWU0QWQ0NWFNdktqNDRRUE5yeFVjOXBXKzYz?=
 =?utf-8?B?MEZ2b2VPSCtzRjRDZmpXVWxySFpHWk5GN2I4N3E2aHNteGttMnVLdzcxdENI?=
 =?utf-8?B?WDQ3RTBHYkdNUXBraHJmbERwWFNvVFJBYXlDWUZYNmNTQW5jdUhmbllCMzN4?=
 =?utf-8?B?RFYxdU9PTndaUGRUWDBQYUpiK3ZTTmRLYkY4dU9kdURHckFHc1RKb1BkMFdr?=
 =?utf-8?B?QkxTV29uUnNldmFCcCtzY2RwZHBUNVNDalZiVUIxaFJWTnd6eWlXVUhsRm96?=
 =?utf-8?Q?l17b5LkAwubSSiT0dM=3D?=
X-Microsoft-Antispam-Message-Info: dORlK0ILSAfrZDnI+JU3/MLGNa+9tWPCHwm9DugFVRfsch6PIxspGR/S0iuUNhOb2psCDOMxN525MivMmcTLll384Fooa5nWtdy2LJnC+ciRaACGnOT6U0+9XFVq2zTeW29njqPWhLeeQzRismVU8f2oXXOTgLkG3TBY2gEzC+lmeaQ+jvGrVSWJ9qoLfADT/WFSqIVF4pA1pkF8Gt2i9FLC4GJJx5XQhwJ2cMOrr85oUmdhodpfsPJyNv/rcZ415sDaWbF/WmhTbSJtBVc4YdG4oKGddHJNeIQNUnL4gO6xGHdOwbbG4a5s/QXiOSaqwsJn1h0CneBPEXUegUIdjF9TqVSWIYj/D/E1lerYiwI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;6:y5vRKR3NwhsUxByMT0Y8RyUjlxBMMHD5nX2iGijwo3xBx+5pefp/qrhYx4zQCbFVjM1Bnv5JWwLlNKbKm2afVKTls13ritj2L2BzA3E/uBsJOxpGx7s8IYRAKoLv39LEYbjt3qoQDHjyC9zcbvZ3IOhTbnpGSSrC67P682K29WBzFFACBi4GeOtvTDN049LIAxPCPhmM8f7LVpnZIaLQYDQCZWrF4jbgy/jtycSgjo1pL3S9j38PNs79TCkLCQ6c3MFruIWkeetfwuVc0lywDbvBmrPhjBM8PrefI9oPAi0Z4GgK5KEmIFo2v4eRs0/2aPw7SJbPE5obyfN+I7zKqETuE6X/syd6gxSO9p7b9hHb+L+qrr2oy0tQ5ntvA8H7pEhq0mDl6B2PJpC2LDbDsfRKhMk8x5un0DdJFIR2qEikVlqCmzPzyrdTfEHzPy7oF8IXjDwBm/w5mOZfUg8MjA==;5:n1fiNGJ6epru8IsCqaBy6wNdgLECDJKe7gjYjCMuUAW1z/8eTI8sp2370qcz31VV0nCGi1/m3CtsIDY230qrM7yqqUMmog973V+sck8AGW+qCac2DNBV8F0SeUlbg6y5B+ZUDwPxOpU39/aCWw7GIt7aT6JPxgo6UKhOjtD4gtI=;7:qq3KhhjnxahUu/SlV3gX9dYB6H155iJKTp2KJGRTPHuBgsgJgMa65mCEn1hTCTvFOlvjmQv5iEjlR6wFU/C6Xj/Tzrd+u3KuBlMA7p2xdzKSFuK43FTeeqe+3Nsz95qSaQ6SWORNt5jGFN6aMJiWeAbJcACJ/MCtQmlZ7aeSyfLd8CRrqDAMp3oWnbzx83eegw44+fD/L/47dJgSdmHbGLCM2t5o29OfdPCQZHs81n95+C4kojRB5y5oWUvNEggb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2018 21:43:01.2151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fba86f9-1aee-4a88-daaa-08d62bd4b06e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.229];Helo=[usculsndmail02v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW1lcyBCb3R0b21sZXkNCj4g
DQo+IFNpZ25pZmljYW50IGNvbmNlcm4gaGFzIGJlZW4gZXhwcmVzc2VkIGFib3V0IHRoZSByZXNw
b25zaWJpbGl0aWVzIG91dGxpbmVkIGluDQo+IHRoZSBlbmZvcmNlbWVudCBjbGF1c2Ugb2YgdGhl
IG5ldyBjb2RlIG9mIGNvbmR1Y3QuICBTaW5jZSB0aGVyZSBpcyBjb25jZXJuDQo+IHRoYXQgdGhp
cyBiZWNvbWVzIGJpbmRpbmcgb24gdGhlIHJlbGVhc2Ugb2YgdGhlIDQuMTkga2VybmVsLCBzdHJp
cCB0aGUNCj4gZW5mb3JjZW1lbnQgY2xhdXNlcyB0byBnaXZlIHRoZSBjb21tdW5pdHkgdGltZSB0
byBjb25zaWRlciBhbmQgZGViYXRlDQo+IGhvdyB0aGlzDQo+IHNob3VsZCBiZSBoYW5kbGVkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgQm90dG9tbGV5DQo+IDxKYW1lcy5Cb3R0b21sZXlA
SGFuc2VuUGFydG5lcnNoaXAuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vcHJvY2Vzcy9j
b2RlLW9mLWNvbmR1Y3QucnN0IHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9wcm9j
ZXNzL2NvZGUtb2YtY29uZHVjdC5yc3QNCj4gYi9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kZS1v
Zi1jb25kdWN0LnJzdA0KPiBpbmRleCBhYTQwZTM0ZTc3ODUuLjRkZDkwOTg3MzA1YiAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGUtb2YtY29uZHVjdC5yc3QNCj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGUtb2YtY29uZHVjdC5yc3QNCj4gQEAgLTU5LDIx
ICs1OSw2IEBAIGFkZHJlc3MsIHBvc3RpbmcgdmlhIGFuIG9mZmljaWFsIHNvY2lhbCBtZWRpYSBh
Y2NvdW50LCBvcg0KPiBhY3RpbmcgYXMgYW4gYXBwb2ludGVkDQo+ICByZXByZXNlbnRhdGl2ZSBh
dCBhbiBvbmxpbmUgb3Igb2ZmbGluZSBldmVudC4gUmVwcmVzZW50YXRpb24gb2YgYSBwcm9qZWN0
IG1heQ0KPiBiZQ0KPiAgZnVydGhlciBkZWZpbmVkIGFuZCBjbGFyaWZpZWQgYnkgcHJvamVjdCBt
YWludGFpbmVycy4NCj4gDQo+IC1FbmZvcmNlbWVudA0KPiAtPT09PT09PT09PT0NCj4gLQ0KPiAt
SW5zdGFuY2VzIG9mIGFidXNpdmUsIGhhcmFzc2luZywgb3Igb3RoZXJ3aXNlIHVuYWNjZXB0YWJs
ZSBiZWhhdmlvciBtYXkgYmUNCj4gLXJlcG9ydGVkIGJ5IGNvbnRhY3RpbmcgdGhlIFRlY2huaWNh
bCBBZHZpc29yeSBCb2FyZCAoVEFCKSBhdA0KPiAtPHRhYkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZz4uIEFsbCBjb21wbGFpbnRzIHdpbGwgYmUgcmV2aWV3ZWQgYW5kDQo+IC1pbnZlc3RpZ2F0
ZWQgYW5kIHdpbGwgcmVzdWx0IGluIGEgcmVzcG9uc2UgdGhhdCBpcyBkZWVtZWQgbmVjZXNzYXJ5
IGFuZA0KPiAtYXBwcm9wcmlhdGUgdG8gdGhlIGNpcmN1bXN0YW5jZXMuIFRoZSBUQUIgaXMgb2Js
aWdhdGVkIHRvIG1haW50YWluDQo+IC1jb25maWRlbnRpYWxpdHkgd2l0aCByZWdhcmQgdG8gdGhl
IHJlcG9ydGVyIG9mIGFuIGluY2lkZW50LiAgRnVydGhlciBkZXRhaWxzIG9mDQo+IC1zcGVjaWZp
YyBlbmZvcmNlbWVudCBwb2xpY2llcyBtYXkgYmUgcG9zdGVkIHNlcGFyYXRlbHkuDQoNCkkgdGhp
bmsgaXQncyBPSyB0byBsZWF2ZSB0aGUgYWJvdmUgc2VjdGlvbiwgYXMgaXQgZG9lc24ndCBzcGVh
ayB0bw0KZW5mb3JjZW1lbnQsIGJ1dCByYXRoZXIgaXMganVzdCBhIHNldCBvZiByZXBvcnRpbmcg
aW5zdHJ1Y3Rpb25zLA0Kd2l0aCBhbiBhc3N1cmFuY2Ugb2YgY29uZmlkZW50aWFsaXR5LiAgVGhp
cyBzZWVtcyB0byBtZSBub3QgdG8gYmUNCnRoZSBvYmplY3Rpb25hYmxlIHBhcnQgb2YgdGhpcyBz
ZWN0aW9uLg0KKElPVywgSSB3b3VsZCBvbWl0IHRoaXMgcmVtb3ZhbCBmcm9tIHRoZSBwYXRjaCku
DQoNCklmIHRoZSBuZXh0IHBhcnQgaXMgaW5kZWVkIHJlbW92ZWQsIHRoZW4gbWF5YmUgdGhlIHNl
Y3Rpb24NCm5lZWRzIHRvIGJlIHJlbmFtZWQ/DQogLS0gVGltDQoNCj4gLQ0KPiAtTWFpbnRhaW5l
cnMgd2hvIGRvIG5vdCBmb2xsb3cgb3IgZW5mb3JjZSB0aGUgQ29kZSBvZiBDb25kdWN0IGluIGdv
b2QgZmFpdGgNCj4gbWF5DQo+IC1mYWNlIHRlbXBvcmFyeSBvciBwZXJtYW5lbnQgcmVwZXJjdXNz
aW9ucyBhcyBkZXRlcm1pbmVkIGJ5IG90aGVyDQo+IG1lbWJlcnMgb2YgdGhlDQo+IC1wcm9qZWN0
4oCZcyBsZWFkZXJzaGlwLg0KPiAtDQo+ICBBdHRyaWJ1dGlvbg0KPiAgPT09PT09PT09PT0NCg0K
