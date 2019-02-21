Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68157C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B41F20842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mrHvpPTv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m2PnIt0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBUXSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:18:21 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57077 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfBUXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550791101; x=1582327101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t2ufkmLVrqeON3qHMpHGzL6gUrFtZxAIOJeMiO745no=;
  b=mrHvpPTvhiytbaghjJGEVsReAvjVTAPWodbFdM16TomUK8CR4TQpA0vZ
   6/nXshBVM3LlP3t1AGTsqVe/73FygRvbAcGsFY/YUI5914MiIs9wkD+An
   JyHxCgLn25HCb9gSCnQard677fNi5qduzToooVx3rQrDSJrsGbFBkCDBM
   h5JhAp5/B6j/UhGBWzWrzw2TSdcz0kWud4GG+8g7LMHjRphQJttLq1e+T
   Od/YyAvnBAxzIifVBx6k3wEH+cJYP0eh0hhvIrSaa+flWBV9hPqHZlmeE
   Cv9GdYYJKxOU61F1WPfW0G+0OSiWqcR4CMvBcHQ7y9B73pSCDTpFcYs3f
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,397,1544457600"; 
   d="scan'208";a="103648970"
Received: from mail-dm3nam05lp2053.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.53])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2019 07:18:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2ufkmLVrqeON3qHMpHGzL6gUrFtZxAIOJeMiO745no=;
 b=m2PnIt0UoX63IvXAbm4gbfJ/gpLA0LMIFYOSCM0cQbawUQK1QAIN019lnL69NFsZ0Sj+4oRSk7CpmzxzK/BTZil+CD+DZ1l/IwufrykcT6HIVrye7l+VS2vBnMi0hN9FJ5vj0H+FSIaicXlGuyhpvR22KJ5lWsOBXK5/rnnVERs=
Received: from BYAPR04MB4357.namprd04.prod.outlook.com (20.176.251.147) by
 BYAPR04MB4310.namprd04.prod.outlook.com (20.176.251.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 23:18:15 +0000
Received: from BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::91f1:a2af:8793:94a2]) by BYAPR04MB4357.namprd04.prod.outlook.com
 ([fe80::91f1:a2af:8793:94a2%7]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 23:18:15 +0000
From:   Adam Manzanares <Adam.Manzanares@wdc.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "cl@linux.com" <cl@linux.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>
Subject: Re: [LSF/MM TOPIC] Page Cache Flexibility for NVM
Thread-Topic: [LSF/MM TOPIC] Page Cache Flexibility for NVM
Thread-Index: AQHUyjrUW2lvg3E88ESemij+/GgUJKXq4g2AgAAA7IA=
Date:   Thu, 21 Feb 2019 23:18:15 +0000
Message-ID: <08749b6a89cf1abe75820ada3663f2a983b0bdc3.camel@wdc.com>
References: <85ddda85755bf15ed2e56bce21f711ae8154d304.camel@wdc.com>
         <43c53a7a-63cc-1968-eb5f-59115f918441@intel.com>
In-Reply-To: <43c53a7a-63cc-1968-eb5f-59115f918441@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10828fa4-e8f4-442e-f167-08d69852db7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4310;
x-ms-traffictypediagnostic: BYAPR04MB4310:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjA0TUI0MzEwOzIzOm5aUkx4YWZ4M1NlWmF0MlNHRitiOVRGSUdN?=
 =?utf-8?B?UkZCVWpYVTBseDNMamp6NTA0NUxZNDZRMnk1bktTK3dNSEc0MExvMWw5N0t3?=
 =?utf-8?B?QU1PaytJYWRoUE5ybzVId2xYU0RrV0xsRk8vRC9zQTRJMHF4QmUwRERtaEhP?=
 =?utf-8?B?WmRxcWdpeFZkL0RCcFpWUFJPdWZCaWZmbUdPcStEcU9MM2FqVlZEMkxXOS9I?=
 =?utf-8?B?azc4T3puSzJHU2trNGdoTTd4WFRqczdEeWtrSXozTVVZNzNHb1ZKZGxoRjMr?=
 =?utf-8?B?VW5RekpnRzFBcVJvY291cDdEU1VadkU3V1Uwazl5L0VPNUdpL1lTMVhWTkxw?=
 =?utf-8?B?ZUovMHB6T2ZkVEk0WTA5OGpsQUFBMCtOVEtpbkJrd2YzamFCWUVZQzIrekZu?=
 =?utf-8?B?ZTYrbkJnajJmUXc3THdUZVVKR08vcnNUL1hVeXFoUm15N0RNUVFEbEZMTUQ3?=
 =?utf-8?B?ZHRCb0xuQlhVc2phMFhMUHI1MmRmUEZBYVQ2V25obGNGSFVRMHdrQnAzT2h4?=
 =?utf-8?B?czlmczVjZDEwQnEzcGxVYWI1cFZvODczdzVyWk5jZ2NxUW16OVFQaFpwRUlo?=
 =?utf-8?B?N2FlQmRocGdBT1VwdmFJbjY4R0hLK0R6alVJeUEvdkJOdU00Vk9NVUc4OG0x?=
 =?utf-8?B?dEVoSEZ2TWN0RmtuMzc3cnVibXd6U3c2cjRSVVg3enBhSC9Lb2ZldVkxb1lO?=
 =?utf-8?B?U1hlbFhkRFdBT0dQeEtBeDVpVDRHNGhVcENXK0ZxcnZzZithQ2VSYTBOb255?=
 =?utf-8?B?TWdoY0VmbHJ4cjU1dTg1dnZCcm95LzNFdTU3QTB6czB0NEJBNzR6bkZkVlMx?=
 =?utf-8?B?TlZkQ1cwWEdZRG5wamJjcVRxUGZnbUFMdzRZRGM1UUtrTTdISlRJaHNzTGxm?=
 =?utf-8?B?TmV3UmZ3b05oMnRGTEx0cWl0bUZ1RGtVV2d5Vk01RWljOWI5UzAxYUpjYkdo?=
 =?utf-8?B?Yys0aS9ITVhlbTI1c3cxb2doUE5DTi9UVFJxS0xKQWlsZTNTVkthckFKNlhm?=
 =?utf-8?B?UHMxRHo4YUlWRlJ4THZycDRQZDg0bWRLd2tMWGM1ME9icmtHeTZXSXFpT3F2?=
 =?utf-8?B?d0V0TGxyRTVJY2NSNkpaejJSWlhaY0RaZTlUNzAzMFlMZGZvalN3SWh0cEYr?=
 =?utf-8?B?UUplbmpXTllyZ0lRWlNwV0VYemJ0aFAwQU0xbHZTajlUVTVFdXlkMnJSQ3NV?=
 =?utf-8?B?VEhvOEFPYW1SVVpWaHcrZjZLazFTY2JIUUxRZUY4a0NqbTE3VmhRZWszOGNn?=
 =?utf-8?B?WVRpUzJvOWM3SG9HZTdNcnhvVE1GdnhMRFlyS3V1VjVub1BzcVFNZ21Ja3hZ?=
 =?utf-8?B?aGE4M1U0YmFTZ3NzV08vK3lpTGttRFJxVGVPU0VqdFh5ZWNNVllzWFdkbXA0?=
 =?utf-8?B?TTc3c1VCcDZlRjFSYmlaZUlFa0Iyc3NQMzM0UjhpMGU5M29iYTd4QTdRalBk?=
 =?utf-8?B?OFRqMm9QOStIODZEdDBONXFwcGlOQlVOUEQxVEtkRU15MzFkei9EQkVyNTdv?=
 =?utf-8?B?VWFBb3NrcFVWM2VPMzZjRUR1d3lwOHVrd3Y3VWFpVkF6ZlZ2SVBSbGhSZ3ZZ?=
 =?utf-8?B?b21BcTVSOWF0S0NGajRCTnoxZXM2N20vTnM5bGl5M1ZiWmtYTWp5L0JqUmNs?=
 =?utf-8?B?VWlwbmJheFhSbVB1c2R3M1dGM1M4ZjJCQjZUZEpCa1lrYkZjQ29kbnBwSE90?=
 =?utf-8?B?U0IyNk00bG1qbHhxOXA0YnFaa1c5c285VEFTZlBtTkNyLytWZmVUc0JDd3ZB?=
 =?utf-8?B?bFAyaTlWeUdsZDJka2Y2dz09?=
x-microsoft-antispam-prvs: <BYAPR04MB4310D6D729A10A0C807E394FF07E0@BYAPR04MB4310.namprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(6246003)(446003)(72206003)(186003)(71200400001)(68736007)(76176011)(2616005)(6512007)(26005)(99286004)(6486002)(86362001)(256004)(316002)(8676002)(229853002)(97736004)(4326008)(6116002)(478600001)(3846002)(81166006)(476003)(81156014)(66066001)(118296001)(8936002)(11346002)(14454004)(5660300002)(110136005)(7736002)(71190400001)(54906003)(106356001)(105586002)(2906002)(305945005)(6506007)(53546011)(25786009)(486006)(6436002)(36756003)(2501003)(4744005)(53936002)(102836004)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4310;H:BYAPR04MB4357.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gziywY/8dJM5mxM5x9A8z7g3KnFe+mDpGsnbclvRSE75QR7a5Ums7anJykZqN15phHDm1rGcERgOKznVxwuaiZwSuuiFfq3u1ZO5RK5ED1mUkGiHsgUMphc56TXN15jRIlcaeqQczdaA4xeHdUSAsGXcLLx33WyY0qtUiT2O0Rj/owCAd47FMLgoHQTFd6L+n6qjPLLXmw73TR2u/iUbR6r713/rqZvkwQH8eXfNL8pCiw7L2I9xDk+5KgZrGPeKb5BMuh/G7pYuwjM0LuYP50998/cBDOkqpcDaK88uQf6fGU0vB0lp51+qEa3owKA5hcDNsWd/m4qOLnZlkWLGy3V0OJA8sePxgKzH7UxbtFcGptHFzfRZwjA0qBD3iZpx71Z/B7zHGvUlQ+gQ70fMfqmz2f8TWoS9UXx222d+B5A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C383310964CD834781776CB0CEDEAE11@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10828fa4-e8f4-442e-f167-08d69852db7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 23:18:15.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTIxIGF0IDE1OjE0IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMi8yMS8xOSAzOjExIFBNLCBBZGFtIE1hbnphbmFyZXMgd3JvdGU6DQo+ID4gSSBhbSBwcm9w
b3NpbmcgdGhhdCBhcyBhbiBhbHRlcm5hdGl2ZSB0byB1c2luZyBOVk1zIGFzIGEgTlVNQSBub2Rl
DQo+ID4gd2UgZXhwb3NlIHRoZSBOVk0gdGhyb3VnaCB0aGUgcGFnZSBjYWNoZSBvciBhIHZpYWJs
ZSBhbHRlcm5hdGl2ZQ0KPiA+IGFuZA0KPiA+IGhhdmUgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucyBt
bWFwIHRoZSBOVk0gYW5kIGhhbmQgb3V0IG1lbW9yeSB3aXRoDQo+ID4gdGhlaXIgZmF2b3JpdGUg
dXNlcnNwYWNlIG1lbW9yeSBhbGxvY2F0b3IuDQo+IA0KPiBBcmUgeW91IHByb3Bvc2luZyB0aGF0
IHRoZSBrZXJuZWwgbWFuYWdlIHRoaXMgbWVtb3J5IChpdCdzIG1hbmFnZWQgaW4NCj4gdGhlIGJ1
ZGR5IGxpc3RzLCBmb3IgaW5zdGFuY2UpIG9yIHRoYXQgc29tZXRoaW5nIGVsc2UgbWFuYWdlIHRo
ZQ0KPiBtZW1vcnksDQo+IGxpa2Ugd2UgZG8gZm9yIGRldmljZS1kYXggb3IgSE1NPw0KPiANCg0K
SSBhbSBwcm9wb3Npbmcgd2UgdXNlIGEgZGV2aWNlLWRheCBvciBITU0gbGlrZSBtb2RlbC4NCg==
