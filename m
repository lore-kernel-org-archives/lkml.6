Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0CDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73912146F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GVCU/+bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73912146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeHPW4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:56:23 -0400
Received: from mail-eopbgr710070.outbound.protection.outlook.com ([40.107.71.70]:39871
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbeHPW4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ2fzBxoiLs5G5HWM391lObr0nyhbWqJ6qWqEQX1F3o=;
 b=GVCU/+bOV46ibHAUoU5iPHGzy7htxFjN4VLefO8nd9i1+oRJAJXUyPZUkLGgASIN2/U0zIoL8KZ80xt5MoIAzz0sVYcvcXFv/xOGb+hCDVV7L7XkVkYSQk93i+gKzE6dPWGtOdmdxAAoB0hmQ1yTlJbmktCpkchZisTLkB1fxv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
Received: from [192.168.1.2] (165.204.55.250) by
 BLUPR12MB0595.namprd12.prod.outlook.com (2a01:111:e400:594f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Thu, 16 Aug
 2018 19:55:53 +0000
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
To:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Shirish S <shirish.s@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Lazare, Jordan" <Jordan.Lazare@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
References: <20180811155554.3382650-1-arnd@arndb.de>
From:   Leo Li <sunpeng.li@amd.com>
Message-ID: <0e2639d6-7816-4e85-3212-74fcd118e396@amd.com>
Date:   Thu, 16 Aug 2018 15:55:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180811155554.3382650-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To BLUPR12MB0595.namprd12.prod.outlook.com
 (2a01:111:e400:594f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 869575bb-3016-40b6-b932-08d603b24656
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0595;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0595;3:elttS6qGVZ9aGtmBhXjFuQIxdxeBK3JF8XiAP77k1WGoILj2uuNKA9oVoudt7PFtMN21EtecLhcGNsOHYqYdA/AzwWDuPz3rhNmiMgExJaA03belD6oB29y9bdN3S8ZNrVFBDOXQn0YA3Xr5vrD3hWBY3hU95gf8P6kWpnVdoTIypyWHqReTUcCYkpcs2R4mihoXMUkyX+3FpgqDWpT64mMNI2ac+xCfUVshbdj2hHm0e8moEoThGy+VU6+OiLt0;25:dtd5oSXAADEne0Y66cO+scgE8oR6O07D/3GbqV8b8mZtb5C+hVbe7Q5tToRn93eiPWtDBt8GFpMODISa+gS7+0mczlbwceXW6vy6cuEW/pNs1qMQaISTgPsxHPCWkgV5yFlDZbq7omObuWSHXV7QQz3lYhCl4blpYyfx6EqZxZYroOz3Oz15cIg4X761rO8qqNs/tzo+ao9gafGl5Xs3ry5VPy5kNCucX3BnZixf0btHkZisHeHpLycOJECIjB6bzowRq+VoT37xmk3cSGTDgpQlG62Ns1VBiVAPFdfthH+FmNC099JX3UksNWA9znuhsdsW83n38cFK9kATQ0eJ7A==;31:e4I2zvvayjOlnaLV2AJHCVKxNolby/u39nCOlLS4HAVHy1JYKpVfPkAJfk8iQDvdXxWaWGJSWY/ofowZloUgF51m7sQlVgJeiO5S/wf31dLNaqQaQ+g3zIxT133BWii1eSJEZnKTHLTD9CvpJTmx/hT9eYNP2gjSrBhEaxFgXKwhcUrkIWRx/tzRJ4rEr8RPn5IZoaWMBb+jSGoP9Ksg3dpqlLVT3TNnu3Bqu/RmzhU=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0595:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0595;20:mpXYWwx82qiwW1JBUvF3LqfBxIHFPXB9V5MyUU3xtMc/duIddgy/UU4T1QO2iP68cTUAWJqjKKgGakSIZ7aBjXCZ8lDZtIpTTNiTxT//opGgrhJCffABl2PFhCvH8qx6fOfW5KQEyYh8QmesivFzxSZ/reqL967ppxiBBaC4wPCVjF5eHuRbjuniHiAxkCb0Fu01wH7SUQGPnSf+s56uJFruUPsYHHBQzzh+vHyZAumOhFDLmYZzHJ0vkJH+WuRrpbXgWis/nAqOKFPpx2Pci8PzMa25ZuFKr9d1DbWXkyJQrj1QIe2isdWh1AwxE0PLFcNHHEjHC+mRRF/LiEywPCBvDmVdC/5ZxH0OAz3ya298KDNJHJOHQfITR7U5AVwCP72waxBwzLi0wvkYzIRfgdYvPUHY9bkA0fHzuBDeEAH8r7b//hYEOv6DmF0dFprVEeQmxw+ydMdK5X1/IWWDi6Q2jm/+nzyv3lTQJvUsyWBS43TDke7qo+cQZaC1a3eR;4:TlWDOdgkNOUwo2GjFZs13zIvei3sspkaKK5QbSo4F880GiEW+ZqNVsNjlPDjuryDmZQw/+Ma06KOLQsG61fiC3iN1iQPNIcFV7TXhTCHFZkj65zzDI2iMEhEaaRj0w93Ar9KUQvGhyXp/ZCWeOp5Yjslnb6Pik93pwa53VimizrmshnyZ0igWLdLH9NrWInkl7bw2jwYGTVAwg2ytBL47HFPe0QBzXCPWiH1joxvsCRmrzvNQsIvx/hGvtLYQyqC0KC9Ktts/TsudfU3hxnZu8Qqo+5nLYF4nJKBKonK1xqKFjhvfMLLrQ2orxVuS//r
X-Microsoft-Antispam-PRVS: <BLUPR12MB059561549BFD38F55B0784F9823E0@BLUPR12MB0595.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BLUPR12MB0595;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0595;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(39860400002)(396003)(346002)(136003)(189003)(199004)(26005)(476003)(6246003)(52146003)(2486003)(52116002)(64126003)(23676004)(77096007)(67846002)(16576012)(58126008)(76176011)(7736002)(54906003)(110136005)(316002)(305945005)(117156002)(68736007)(446003)(81166006)(25786009)(11346002)(4326008)(81156014)(2906002)(6116002)(8676002)(386003)(72206003)(3846002)(2616005)(956004)(8936002)(230700001)(31696002)(53546011)(16526019)(86362001)(575784001)(486006)(97736004)(65956001)(65806001)(6486002)(31686004)(47776003)(478600001)(66066001)(229853002)(50466002)(6666003)(6636002)(53936002)(65826007)(36756003)(105586002)(5660300001)(106356001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0595;H:[192.168.1.2];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNTk1OzIzOlZEY0hoNjA5N3M2R1RjSkJVaGM2aThRbVhv?=
 =?utf-8?B?OUVoV09hMkkzbjhRWG9XbXlhZmwvMGZnUHdPeFpoZUpNaE9VM2R3SFR4cCtD?=
 =?utf-8?B?bW5Cb3FPRVpYWTc2TXFKVnRwQVMvM1YwaDhxMUNuSCtyOThMZkVZTW1FUmZW?=
 =?utf-8?B?bVJMRGl5RThLelhxS3VYbHdFdnJ0SEluU0lxSnVQQll2T0JjR2Rpd2VZa2ho?=
 =?utf-8?B?VTJvRy92Y0pDRVkzQ0F4d0h4Q1FRdkRwQk9qZ0ZxZmZMdERmdXkwTW9mRSs5?=
 =?utf-8?B?bU5DdnNNQ1p6ajRnQk1kVUlpTm9xd2lvc3NTb0pFdXNJclVTS3BUYjNSODc4?=
 =?utf-8?B?YVhOUU81VExNTDFCOVg4ekhEOGxtM09HOXdrd0gwSy9qbGt4bEsrU3lpZzAz?=
 =?utf-8?B?dTlYeDVnRkRPbnZmV1NDQmtLUVRCSGpQSnBEWGlsdVZNQXFub0JjMHdjNFJo?=
 =?utf-8?B?OUdkTXFmWmUwNVFBWER3N3hWZkVGMmtRR01qN09UVjJubHZFdjYzenZPREZF?=
 =?utf-8?B?alFJTW0reEk3U1lVS3JtVG5lUWl4QWR6OGpNRWhobThLWnFJaFVWN3haaU5t?=
 =?utf-8?B?VENveHM3ck9TdER5UXl2d3FVZndXNU5FUUNaRHpBZFcvY3ova3JpYWJla0di?=
 =?utf-8?B?b0oyRHd5TEttL2IvRFlaeWdVdXluOGZTcENYNGt5YVVOdCs2cmhBL1VqVTA0?=
 =?utf-8?B?U3JDTmhqbjdCNGVBeFRkUTUya05JRUd0Z0J4YkFZLzFNZUVrQ0JEdEIyczZ5?=
 =?utf-8?B?d045N2ZybjhkeHZCZVU1NkNOajd1YVg5QWdSRDVGV3hSTDJlU2IyRVBwN09r?=
 =?utf-8?B?YjZWRTZsdGdHeFNjdmRFNEg3MEFqUHJuU3FEWHVMWENtdm9nakZCaFp3RlJC?=
 =?utf-8?B?TGVWZ2xuT3lBMzBzdStzNTJzUCtvRXFZb0RyU3JMb0VoMW9NVVkrcmhZQ1dV?=
 =?utf-8?B?TUhhVnN2QllQaGZuVXFQN2JTdG5KRERMYXlYMTNnZFdWTXpHVlRKUFBMSk1x?=
 =?utf-8?B?QXhhamJDWG5wREd2eHdORUhCYnhONFhMR005MnZHdkFxR1FZR21MNU1yNXBl?=
 =?utf-8?B?Z1p3S29pU0dSQUtqOXUzS3hQU2ZCaXdhNXJDR1U1M0IvN2NHbkRUK2RJSTFD?=
 =?utf-8?B?TUhBbm5xTzAzRDRwK1c5VmRyZ2poR3IvY2g0RURZUFZ4SEx4elpCSGt3aGx0?=
 =?utf-8?B?MnRWbnZldUlGVnY0MCtWZEFQZC9pakNkd21zUTZDWEpNZ09RV0JZNEZyTjBD?=
 =?utf-8?B?Z1ppcURoZUlRRVBKSVhHMktQOHNxeVNiWWZ6azdXamNpbWFUQnNBZ2N2NWho?=
 =?utf-8?B?dEdlRjVwdU9xOEpORERxSEF3SDkwWldvQUVlL2R0V29tcnNiOW1SRGJESTl4?=
 =?utf-8?B?LzZ3cFI0Yi9WeUFzeStzcXlqK09VaEM3UjBuZzkzV0RndDhja21zWHBkMlVW?=
 =?utf-8?B?VVJ0RnppY1NnamFvR3R6Y0hSTnRFTWpZVXVVNEszSE5yd0NwanhHdXFsWGk4?=
 =?utf-8?B?OEFtV3A2STBMemlJa3daVC9JMXFabER6MTBYTmdyM2kvanA1dllKeGtLK1ZY?=
 =?utf-8?B?YjdEL3UveERTakIxUmwyRVlnM0dkU25iOFdETFF5T0NuUUdmelBqVFBkcEZF?=
 =?utf-8?B?MDVrZm5HZXdnemw3QjBoQkJ5ZFRrQ2RDTmhWUmE3L0gzaHA3MGxKVm52aTFG?=
 =?utf-8?B?Q2Z5ZS9ZRDdSdGhMd3BMallZQ0VzNERuc3V0NWNzZ2JSOXBBd2xKa0VDT05s?=
 =?utf-8?B?U1dqU3hSaUN6YlZLU1ErZlhWYlFBQ1hlRE12aTZtRlA0YzZKUE9VUHFhclFV?=
 =?utf-8?B?ek5WcEt5eE1VRVZMNlBlNUVsWHJHSEQ2UW1vUGxDdVAzS2pzbGV1YkpBV1I3?=
 =?utf-8?B?SURVbzVDVUxvRzdSRVp2Z1JWblEvNzBFSEFLOWZKV1pEMWIreEgvZnRqazhC?=
 =?utf-8?B?OFVtSnpBQlZGSUtDakZKRjAyK1Nsd2FQOEIzOWIxMzRqNXNsTnRIV05FRkhs?=
 =?utf-8?B?RU5VS3VucW1mbFUxSnkweEw4eDZYZGEyNXo5M2RaWW5lNjlmTmRIN0dTTVFR?=
 =?utf-8?Q?+HNDFdudoQMGge1QmvTGWTRWp?=
X-Microsoft-Antispam-Message-Info: uaHLPxz2MuSuLrIzoS1a4LxrT7HnyBhuLo+ATxkc2r+6zo1B9sRRGnxovlx8HT5tpP4sRYtY6LsM68zBdqTzyNKFQkKtiTHm80bGKh1gDMUoTdY9RHl6CgSs3EusubIfz08q3X3SsSIGPuIL4+pv+zYSMPKXl4LbCgC1yUBJ+oWEu0C8IzREnLlI2SrSA4ecJWy9zmHZsUCX/F8hEd6FkcmxsjKLs9n+J5jicktu+1B5aPkXP6yZcIHWoY/7WTyVr+RYPQfYz5hSZ6PSIpNs2M7BbHh7ZiUH4cqQYofRgEYCgyqRH7f0pf86gT1hSsxPkR8GHOlyeEkqxk6DuY4/1bdnP3mqQpQHPLOv6j6H4kg=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0595;6:lk/chrKRt/QgUbZEpcmEMb1TXoM6fAqt12+rwTP/5DXwcZyZer1jU9soFxdmdP4tK33OjOJaM4mc8oy08Lmsm437aog3f1FbkBXe3U7tJ3yaPbP89BpT2AWtDi1l25PouoyKDuqM7tc3Jxtmb85VMDSDA66cKBDHLGBGllnfuYmPN0GBslDf3VIzXwQNlzJFdb3aP0GNKQirbdMaIylRhUH0IGsrP0IsaNA8aBJBPgKhZtiuRqTA/dskFtiTbmhG19rPGN+d1rw52Z+TyOOv0SKhZZI0oKMb5PhaYyODlI2b3gY6L0uhsS+gWJgEJDLmasRp+zPD/2SJ5NsZeaAy7euTzC0IHGWX4GioNT0oUceY5aQml7TB/Oq2mCYiGdGn1kC1opPTxSLN6ZqyMcMVBN6+4nXXGRIW7T06Tt450anhr9wzqSH+CwT3c/rgH1hCd/zrNDShMF3jeo1Ti48bBQ==;5:jhkR18HpK4GWOSvW8YsOH3unW9PGvIBlSrieehXvuO6FJMk+MfliioP+FHOJt60moj+iDAfgLxPQM7NT1yN1TeLYiO9Zub2AQpbbRwfy4JZVYnSgcrdVfnk8F/EhYTJ/EdV5fASD6Vk8a/6SbiFJ/hNVpFf14H8ROiTPNdPipOM=;7:n4IxeYFjYrfxHMmWGkVpFyEYg/AiOYzNLkeKwy5H4y8osTDBKs0VWSszFyN2rWuYlrQO1b11id//JRK6pkuWVz5zMTiM45gVN/u76/ruaa/Zgg22r0/+dpE1c7wWVnt2+0eQMw6+r/dA14dbPWrI7SXyxEEWspUslahyAeRiOpEX+dUPw9YjVU7ZuHFZabRKINvwt3k0V5a7oV+pM4qfchvsmp9qvIQYz0E/u1xSXe7y4Ix+c/udqr3HQ2EhF1cV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0595;20:Ii+iOK0biOYVAB7PV16fcp+ZIJjsurTomeHFYs0AAyUinFAZfXLTmwZsq3g/vQ5VF1jrcQck8a580EnxchG7QBoxbo5/QKgW9xL1X5yMpmfquoz9jgvnsdm+t7+76uOq1uPoi0zVczDfopMxlcaw+Ul3RrsfY3kkgRgsBeh2A10zYV0NNgnjbNK1hhr8GflxUmQOIE1/eUsxAmrrmbQoCvbLRsUGTXIEfsDStVYsZlC/UYrd7VwOIbYPgyZ2z0h1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:55:53.4470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869575bb-3016-40b6-b932-08d603b24656
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0595
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-08-11 11:54 AM, Arnd Bergmann wrote:
> Building the DCN 1.0 Raven display driver with CONFIG_KCOV_INSTRUMENT_ALL=y
> and CONFIG_KCOV_ENABLE_COMPARISONS=y results in warnings about many functions
> that do a comparison of floating-point variables:
> 
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_bw_calc_rq_dlg_ttu':
> dcn_calcs.c:(.text+0x263): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `hack_force_pipe_split':
> dcn_calcs.c:(.text+0x155b): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_find_dcfclk_suits_all':
> dcn_calcs.c:(.text+0x190e): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.o: In function `dcn_validate_bandwidth':
> dcn_calcs.c:(.text+0xe121): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_mod':
> dcn_calc_math.c:(.text+0x22): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_min2':
> dcn_calc_math.c:(.text+0xb2): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_ceil2':
> dcn_calc_math.c:(.text+0x2a0): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max3':
> dcn_calc_math.c:(.text+0x325): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_max5':
> dcn_calc_math.c:(.text+0x3c3): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.o: In function `dcn_bw_log':
> dcn_calc_math.c:(.text+0x54e): undefined reference to `__sanitizer_cov_trace_cmpd'
> dcn_calc_math.c:(.text+0x57c): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `scaler_settings_calculation':
> dcn_calc_auto.c:(.text+0x5c5): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x137c): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x9233): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0xb70f): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `mode_support_and_system_configuration':
> dcn_calc_auto.c:(.text+0x121fd): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `display_pipe_configuration':
> dcn_calc_auto.c:(.text+0x15a2f): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x17c2d): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x19362): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x25575): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.o: In function `dispclkdppclkdcfclk_deep_sleep_prefetch_parameters_watermarks_and_performance_calculation':
> dcn_calc_auto.c:(.text+0x27f33): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `get_refcyc_per_delivery':
> display_rq_dlg_calc.c:(.text+0xb5): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `calculate_ttu_cursor.isra.1':
> display_rq_dlg_calc.c:(.text+0x9f6): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.o: In function `dml_rq_dlg_get_dlg_params':
> display_rq_dlg_calc.c:(.text+0x82cc): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_refcyc_per_delivery.isra.0':
> dml1_display_rq_dlg_calc.c:(.text+0x6c4): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_vratio_pre.isra.2':
> dml1_display_rq_dlg_calc.c:(.text+0x957): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `get_swath_need.isra.3':
> dml1_display_rq_dlg_calc.c:(.text+0xc8e): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_extract_rq_regs':
> dml1_display_rq_dlg_calc.c:(.text+0x30a8): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
> dml1_display_rq_dlg_calc.c:(.text+0x41ee): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.o: In function `dml1_rq_dlg_get_dlg_params':
> dml1_display_rq_dlg_calc.c:(.text+0x8f95): undefined reference to `__sanitizer_cov_trace_cmpf'
> drivers/gpu/drm/amd/display/dc/dml/dml_common_defs.o: In function `dml_round':
> dml_common_defs.c:(.text+0x77): undefined reference to `__sanitizer_cov_trace_cmpd'
> drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.o: In function `adjust_ReturnBW':
> display_mode_vba.c:(.text+0x4490): undefined reference to `__sanitizer_cov_trace_cmpd'
> 
> We already prevent the driver from being built on non-x86 architectures
> because of its use of floating-point arithmetic, this extends the
> dependency to also cover Kcov-enabled builds, which arguably is a much
> more severe limitation.
> 
> I tried implementing the two functions in KCOV: __sanitizer_cov_trace_cmpd
> and __sanitizer_cov_trace_cmpf, but that fails to build on architectures
> that do not support any floating-point functions, or would require making
> that code x86 specific as well.  I also looked at what it would take to

Hi Arnd,

Is there a reason why we can't make __sanitizer_cov_trace_cmpd and
__sanitizer_cov_trace_cmpf X86 dependent?

I sent out two patches to disable DCN1, but would prefer implementing
these two functions as opposed to disabling a component.

Thanks,
Leo

> convert the code to fixed-point arithmetic, but quickly gave up. This
> is probably the right approach, but it requires a non-trivial amount of
> work and certainly won't be appropriate as a bugfix.
> 
> Fixes: bf2e2e2e0ea9 ("drm/amd/display: Limit DCN to x86 arch")
> Fixes: 4841203102a3 ("drm/amdgpu/display: Replace CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86")
> Link: drm: amd: dc: don't use FP math when Kcov is enabled
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3: rebase on top of 4841203102a3, which removed the option for
> CONFIG_DRM_AMD_DC_DCN1_0. The problem still gets hit occasionally
> in randconfig testing.
> ---
>   drivers/gpu/drm/amd/display/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 325083b0297e..b132d434e572 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -3,6 +3,7 @@ menu "Display Engine Configuration"
>   
>   config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
> +	depends on !X86 || !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS) || BROKEN
>   	default y
>   	help
>   	  Choose this option if you want to use the new display engine
> 
