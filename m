Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8388220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gpfSSBT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8388220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbeGWWzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:55:50 -0400
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:64800
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388088AbeGWWzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUQnBUkWPlFT96YTHv/DEypgkxFlDList0RpbczrfrI=;
 b=gpfSSBT1oJzBwu0kB5DCxCHbHYaFMqZw9hzozyDm6zU9dVYNBgDJw1L/jm+Y4E8K9Ot8gcKZ207vhyMR2t9ODouXArTciz6d5rIXFofKoZaClJmfgrJluLF1pK6TZPalBgBpPnE/chIaM3QSUtDchO65rtG5JsVKXgBAkydGxLU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [192.168.14.130] (79.180.230.147) by
 VI1PR05MB4656.eurprd05.prod.outlook.com (2603:10a6:802:5f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 21:52:28 +0000
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
Date:   Tue, 24 Jul 2018 00:52:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723140143.1a46902f@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [79.180.230.147]
X-ClientProxiedBy: VI1PR03CA0078.eurprd03.prod.outlook.com
 (2603:10a6:803:50::49) To VI1PR05MB4656.eurprd05.prod.outlook.com
 (2603:10a6:802:5f::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a48ace-9ee7-4b86-8427-08d5f0e696d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4656;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4656;3:Er30WxaQ7CgPCIKBswtfpuijdYW1y2Zo53qRCLECF96RYSTcDx5bq9Dl4XL1iAJwQcSK8Q7ijfDrXJyKa+aS7wrNV+tOm8FQtUWxvlKbTT2Rk9zEKKu3QWYZQc8mX0N9byBpg/mypKqkcESDD6dq9bDuDIUULsouQarwPy8yw7IeFWjx/YTY8HN8bYvR10AMg/HQMdjA4yt2wNhb0Aozb/G0KVXCmJbzJAkcw5tDKV6Iy+OxU3Ey0cFKpVt3aYfv;25:ZNZzoEqs8Lb0i2On/3d7/wQS0UNl9wBvlGzf8EtpuO8srYmpOdFsL8d/GDkSyOmhTsC/4cWyncsKAyUJ0VcpiUL9yDwXdS1R43wFvgVvdhUA78Wdwf9oKyeNGe6aqwyUnM/PnJdUEPp5CDijLbWFWRey9W28ws0qfzKbgZVJW2ixTPFlHHtKhl/rYBsy5sUZIN94MJxocSvhbjWxCmAYHJ/xXgnLIIpinIuvopzwvtZ7cx13BpPzQ+unwkGuBkobzkHEDZVGNoeNruPPWKj2t3DSgk3LaakzGeEDqCPW1PnScFA0nbY071ccN4F+9+TYY4Zyoj+emAebI1P8Xr2BkQ==;31:JEsKH2ZiRtBkWQGOOAWTk3ehM9c/QD95uTynJ0EFwDSnq1R8kX3QjU4HgiGQfUkEd49APbUtExI1egb64GocCitpUrGaUTjtqdAvl0PncMnSpDBBRIyr2NTq/wqS1m/nreYC2kqxSUOJoLSX7Zjw8HIqCWx5/6HkFfZwhPkB8IEahg5Wokf7evWBskFRhfvh9afTrRM0i4IKjwl9E4Gu2slT5DlMq7HUE76LixnO/2w=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4656:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4656;20:CkHQivVqVP424Jxr30b3+PUUaQJUfdwF84Nyqqfdi+gfWd4TQ3ZTd+oXFLM4sDFQN7fk+xxetCryK5RFc+Fl8L3vLFHfQrfvlGSGzevMCl/8T7Zq7S1cBrxDL2MqDolvMmb34Ot898+Bm+YrfQxzZpPB5fGxRqguaKkBuke5KTaME4yo1u7QvJbejbIecgxid6obxLz1aPsueEt354NGvS9W71YH0ru4WZ3wJv1qdgv9qjy7UyMNCLVrrgi39nf97YStZ65To0vLvCanBw8Fp9F8bHVOuNuexYyF49Pwdu3sR9IHdU6/lM0JO+DpsMlVozk62zvpODtouV+UslxJlzRZj+pwbzwU2acw09x0DJ3l44Y0qhOJ7m7BXLXEtJ9PRyQCKyvWFjGmWexu4HNjbyZCtGLMFTBvavoomPNPJUpv7qHTHj94IzgOS5QM1Y/a03lIhvM1cFZQ1iya76zfk07CqFN2kNQxKgeZeKt3S5xjnb3sWSQ2NnDSYwndu0tX;4:vQ2pzExJr/kcNs80Igmz4WeJAj7GdYYmHWvyKlknvq2yATW/QFLODiOMCnwjkeV8rILqoZuw04o0BTqAJr759ZgGWyANcDUwPEBAzPMJymrVsCBMzn/vY7EWtq7efSjQ/ZZhUKYvPIE+7BOhMAg4dRSpT5CbdDgkVXXzvgbI0cxonJTVb2UbArc6xkVEuiAnC3bqSMEj0FmBqF+D4LqljftYQWgfXexUcwBQ2vwbVsMzpoEwO2+DjU2undbsePV/AvdTlHz+UWcPYfmOiRkqtvAlKv/WUHZbagK2M4IxEFPv8tEYP16yhllrtFU5VcG/QMisbK/FMWBm6TZEm3qmsSK2wWCtG2If5FOtpmR/Y60=
X-Microsoft-Antispam-PRVS: <VI1PR05MB4656142090FFA40B13745713D2560@VI1PR05MB4656.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4656;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4656;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(76094002)(68736007)(81156014)(8936002)(305945005)(81166006)(14444005)(2906002)(65806001)(66066001)(65956001)(47776003)(31686004)(105586002)(229853002)(106356001)(8676002)(7416002)(36756003)(7736002)(58126008)(50466002)(2616005)(476003)(956004)(64126003)(6116002)(6666003)(110136005)(186003)(16526019)(65826007)(26005)(54906003)(77096007)(5660300001)(4326008)(6246003)(23676004)(486006)(3846002)(97736004)(76176011)(52116002)(2486003)(25786009)(86362001)(3260700006)(6486002)(53546011)(386003)(117156002)(230700001)(446003)(67846002)(52146003)(39060400002)(316002)(478600001)(53936002)(31696002)(11346002)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4656;H:[192.168.14.130];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1TUI0NjU2OzIzOlRZTEljWWw5cW1oeEJVNTdjZTN1c3BXYTVS?=
 =?utf-8?B?Y3FVU1BTcUFkekVoWEVTVzBVR2NYR3BoQ0lYVHdiOHUzNDRKT2pZRGVaNTZI?=
 =?utf-8?B?M1FWVTRyU2FCRmptRGIxMHRoVFcyZlFIbzA2cDNIYTRzd2hYd0k2dVUzTmg5?=
 =?utf-8?B?cDVKWFhIamR6RGh3ckdNQlJ3eDZLckpPMmdjaGdnOVdPT3o0T2hZcG5qWlRj?=
 =?utf-8?B?TXdqYTNrMnZmKzlLTmpmTEkxNkNabWcxL25QZno5RWZFQ1hKZzk4enYxNGRG?=
 =?utf-8?B?Y2hkVFcrRUV3NkxTZkkwRTBBeEh0c2xNTlhRL1ZKMVNOZldhVVVTKzZXVDlH?=
 =?utf-8?B?RGNlaDM0U3QzU28vZkZaSFhjTDVYb1J3UnRhTjQ2RDZrZnFmb1FxdGlObHVH?=
 =?utf-8?B?T2l1N0NxamZxaHhsbGQyYXFJQko0Tnpwa05iSk05MkhsK1RZR3pZN2hpeUln?=
 =?utf-8?B?WEN6K3JHdllCbWUzdVdjcE5pZFFSUzYzRzhjOU5QVXdDa3FQaVlmMVRrRFpl?=
 =?utf-8?B?M1V0OVAxV3pQZGoyTWdhRkQwc1JKRDdoTVQwdnhxY3QrSzRabW5LSXZucXpC?=
 =?utf-8?B?Ym1VQmFXSmxzaERZYTdjZCt2aFZBd0NWUDQwM3AyWXRpMnJoNzdrUittUW84?=
 =?utf-8?B?K0s2emNyUnFLUmoyNzkydytTTEpsVGdVbUtRTzBVaWdHRnNDbThNdWpabDNM?=
 =?utf-8?B?ZzVnK1c1bGtZN3NTckVNWFJKZnI0VENTaUQ1cnFwLy94Q3QzWlZ3cU4zY3F2?=
 =?utf-8?B?M1FoQWZhOXlVcDczREJDWVZXNnpnYTNmQzl3UFV1TXNrN3RuTGFDQ1lOSkZs?=
 =?utf-8?B?OFZ4WSs3YlFDQkc4eklqL05MdlZFNmVqOWFXTWhxcnZ3ZE9IYldRQ1lQZkVj?=
 =?utf-8?B?SjlHa1NxbU1PUEZUZXo5L29yQ2pqSjd3K3dITFhjbVBpZVNuRDF0OVhLQnph?=
 =?utf-8?B?clB0dG5UOE0rWGdOT3h5bGdLd3E4RmxNT1l6RXRrWksyK3puVWtTcDJOM1NK?=
 =?utf-8?B?aXdQYUJWSUdMU1ZDM2U4a2FMWkVyamdwd290aXJGZXFBUTZjTU93cnU5K0hs?=
 =?utf-8?B?bnlKaXlVdDVEbUhxV0ZlSXpRdWtiU2xTc2p5SDNPTm1Oam1QS1k5VFRwTHZK?=
 =?utf-8?B?em5vNlBOYVFOcWNsZ1VIMHFrTk43SStLVlRjY2puVUpVcU1mQ0dYVnY1Y0RU?=
 =?utf-8?B?RHVBcUk3SnBnSS9yS1NmSyt4MFVMS2dNMlc5bGxhMmdmNFI1M0VYR1hCbUlS?=
 =?utf-8?B?YTdPOFZsZ0J1M3FQczI4VTFzTUVIWG1WUkpLUXFIU1JEVldVblBLQURsNjJ0?=
 =?utf-8?B?bFZQNkEyK3pVLzlObWgxNWJlTWFzc3Rqc1NGeWtTSk5CZFl2R2R6RTF3bmZR?=
 =?utf-8?B?ODBFL0FCOHpSZ1dHU2djMzZQRW96cXFsV1RYZlZGbXR2UXRDYjBRTmlMM2tv?=
 =?utf-8?B?NjlETkJMTitVVW00aWJib0FXNDBCTHowMUY3eHBxeVJ2SkQvclFVWUoyeTJV?=
 =?utf-8?B?ZFZ5dEhXMmEvcmRaaG0vRFhqWTIxNXZqK1BGZTdoY0o1MUVHdXZPMGd0dG1m?=
 =?utf-8?B?bVpnM3Z3QnVqVmF1VlRXeEJrRFkwMitiV3hFNjk4a3kwcFI1K2x5c1RRRllG?=
 =?utf-8?B?L0lMaTByREN0azVvOEZSMzNiK3kyZ2JoaXRYUndNTnhEcFBuVU5MOWkxVXNN?=
 =?utf-8?B?WFM2alFXM05idWlhMllHOTVucThKV21xQUVOdWwrK1FGdnE0MUgwMEZ6djMy?=
 =?utf-8?B?anZjak0vWEVaVGt5Nk9BRE0xTllhS25iRldXNDNNWVlUWDAzWXBNNWMra0F2?=
 =?utf-8?B?VFlHRVhOSVFMclN4U0l1cWZoeGlENit1eVlmRW5GelNqR244bTRwWGtwS0Z3?=
 =?utf-8?B?dEhuZ2xPUGkyMUhxRno2QUJZN2p2bTl5eTk4bWQxWWtldnluWVE2M0xDcXRP?=
 =?utf-8?B?QTB0Vy9DbktkSlJQWXVhdytNY09ndVB3dU96VjNUcy9vc1hzRHpVZ2JnREhl?=
 =?utf-8?B?emcvRWVKUXpDWk4rNS8yeUJxVWF6cjg2YUJrRUtzdDJsSVVXb0lvQVhwbGx2?=
 =?utf-8?B?WDdudlZrYVJLU2gyc2xtODNwd0F3VUxJb09nbjF2Zmk0QUZsaTI5ZzZWSWVG?=
 =?utf-8?Q?R/kO2KFgipqHpfKgbaJnG24=3D?=
X-Microsoft-Antispam-Message-Info: LLEGhQZ3UeOI78PUuZG/K1fik4H4kjCbeylZjxmUw2hawwohzEHMJIxXhM+ihwwiq41KczdpIqAPpZEKkkeb2sbvRYe5/cAcCWFfwGKOXqpaPDtqKP4xV4IUutZBYCqnvYQfQy1p/ZcjJdEfZT67hjinADo1Irq3fjhVzoQymFtCYI8pWxXlgMgl+g9YNCQSLX+lREgTGnbLXUycAp3EJoBKcp3Fy8teUyXgq/kkC6tN+0eOHEAoP/7MesBFVZVgLceqU/vmOB60AlZg9X+p2MfGzmCJDAj048ZQ2ulLgeYmUbUr6e+At7oNWeIeTKJY29exKDaN94qoeXAC3nbI6P9drUD6ZE9KOaKwhDV3JVA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4656;6:A8RgWTzG2lw91BXIQ3Jtuo/mG4eVc6Sz9E4Axm9QZe78teItFyalV+s1o9M4UUQbWwH80juvA5qVN0pnpCi64sq1OBha7uraw/YQw7W4jPClB7fADOsLkVLZnIzocctP4Ceq7ErqS3aGXWVMdMIsGXXn8UtxjHqhBwR9u4sh1ZT1vJkf6DPdU7+uNLYMN5jDeaY++Jg2Fi5q0xG/S5k20XsQNM1ViJqpbdcLPhe88HxeFUiR3T+VMEkaQ5gdszHWxbqNYfukp7rr+Fv6cbAXLBfImlxSh6Z/FKQAmDN4uKIoqTrFF8nL7iqKWc+m8llibC6w2etFYC4UbgZeZMIl1WhHFHlA/R74yKO2KDY+7pim8PT52/8Vu7qumIpBoMr1SpyPpuvhLwJlf/Sn+0PLyf+YXe228VMGB5MgZGeG+p/iTlBnXOMPihj4b8yAdbK/YdY6PVsxgy0K82aTV1XNSA==;5:YrcS8Dw6jJ36i649l4+ZKA36UWvWCzNRcfpHpu7DKaWhbAV80dwHFIaj75s5o9urFZS2MKbEk/ujNn7SZes0KVCjsGfjLad5o9rRr5rsncpm+UOOrJAKiwp2kaml3hJAflO1iiQxyumAqjTavGp1OsA22ic1Jm0IoSAj6ygFSlg=;7:bBoQn8G05lLzACu4zUpd9oBoH3fsxXJrdapHONVsRyIL2Yn2Wk9b4Ar32JWXgBKCEwBoHEi8pCSCELGE1Gz3T+Nx93vh1NaNy1DZT8StzCBRtKhjlJcduHx2kUo+BblFB3amKl1IIiE+y0gVrHbDDFdp18cVkSUOobyMp3/ff/TItue63FOM2eyIEVkt0bUOSptyYgWyNvZm7xQ9tfmBEZRVyumsxzuXBGsK3a3ecJRJHCQMCU9r+uatdju6HEon
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 21:52:28.6086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a48ace-9ee7-4b86-8427-08d5f0e696d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2018 12:01 AM, Jakub Kicinski wrote:
> On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:
>> PCIe downtraining happens when both the device and PCIe port are
>> capable of a larger bus width or higher speed than negotiated.
>> Downtraining might be indicative of other problems in the system, and
>> identifying this from userspace is neither intuitive, nor
>> straightforward.
>>
>> The easiest way to detect this is with pcie_print_link_status(),
>> since the bottleneck is usually the link that is downtrained. It's not
>> a perfect solution, but it works extremely well in most cases.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>
>> For the sake of review, I've created a __pcie_print_link_status() which
>> takes a 'verbose' argument. If we agree want to go this route, and update
>> the users of pcie_print_link_status(), I can split this up in two patches.
>> I prefer just printing this information in the core functions, and letting
>> drivers not have to worry about this. Though there seems to be strong for
>> not going that route, so here it goes:
> 
> FWIW the networking drivers print PCIe BW because sometimes the network
> bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
> card on a x8 link.
> 
> Sorry to bike shed, but currently the networking cards print the info
> during probe.  Would it make sense to move your message closer to probe
> time?  Rather than when device is added.  If driver structure is
> available, we could also consider adding a boolean to struct pci_driver
> to indicate if driver wants the verbose message?  This way we avoid
> duplicated prints.
> 
> I have no objection to current patch, it LGTM.  Just a thought.

I don't see the reason for having two functions. What's the problem with 
adding the verbose argument to the original function?

> 
>>   drivers/pci/pci.c   | 22 ++++++++++++++++++----
>>   drivers/pci/probe.c | 21 +++++++++++++++++++++
>>   include/linux/pci.h |  1 +
>>   3 files changed, 40 insertions(+), 4 deletions(-) >>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 316496e99da9..414ad7b3abdb 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5302,14 +5302,15 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
>>   }
>>   
>>   /**
>> - * pcie_print_link_status - Report the PCI device's link speed and width
>> + * __pcie_print_link_status - Report the PCI device's link speed and width
>>    * @dev: PCI device to query
>> + * @verbose: Be verbose -- print info even when enough bandwidth is available.
>>    *
>>    * Report the available bandwidth at the device.  If this is less than the
>>    * device is capable of, report the device's maximum possible bandwidth and
>>    * the upstream link that limits its performance to less than that.
>>    */
>> -void pcie_print_link_status(struct pci_dev *dev)
>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>>   {
>>   	enum pcie_link_width width, width_cap;
>>   	enum pci_bus_speed speed, speed_cap;
>> @@ -5319,11 +5320,11 @@ void pcie_print_link_status(struct pci_dev *dev)
>>   	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>>   	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
>>   
>> -	if (bw_avail >= bw_cap)
>> +	if (bw_avail >= bw_cap && verbose)
>>   		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
>>   			 bw_cap / 1000, bw_cap % 1000,
>>   			 PCIE_SPEED2STR(speed_cap), width_cap);
>> -	else
>> +	else if (bw_avail < bw_cap)
>>   		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
>>   			 bw_avail / 1000, bw_avail % 1000,
>>   			 PCIE_SPEED2STR(speed), width,
>> @@ -5331,6 +5332,19 @@ void pcie_print_link_status(struct pci_dev *dev)
>>   			 bw_cap / 1000, bw_cap % 1000,
>>   			 PCIE_SPEED2STR(speed_cap), width_cap);
>>   }
>> +
>> +/**
>> + * pcie_print_link_status - Report the PCI device's link speed and width
>> + * @dev: PCI device to query
>> + *
>> + * Report the available bandwidth at the device.  If this is less than the
>> + * device is capable of, report the device's maximum possible bandwidth and
>> + * the upstream link that limits its performance to less than that.
>> + */
>> +void pcie_print_link_status(struct pci_dev *dev)
>> +{
>> +	__pcie_print_link_status(dev, true);
>> +}
>>   EXPORT_SYMBOL(pcie_print_link_status);
>>   
>>   /**
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac876e32de4b..1f7336377c3b 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2205,6 +2205,24 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>>   	return dev;
>>   }
>>   
>> +static void pcie_check_upstream_link(struct pci_dev *dev)
>> +{
>> +	if (!pci_is_pcie(dev))
>> +		return;
>> +
>> +	/* Look from the device up to avoid downstream ports with no devices. */
>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>> +		return;
>> +
>> +	/* Multi-function PCIe share the same link/status. */
>> +	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
>> +		return;
>> +
>> +	__pcie_print_link_status(dev, false);
>> +}
>> +
>>   static void pci_init_capabilities(struct pci_dev *dev)
>>   {
>>   	/* Enhanced Allocation */
>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>   	/* Advanced Error Reporting */
>>   	pci_aer_init(dev);
>>   
>> +	/* Check link and detect downtrain errors */
>> +	pcie_check_upstream_link(dev);

This is called for every PCIe device right? Won't there be a duplicated 
print in case a device loads with lower PCIe bandwidth than needed?

>> +
>>   	if (pci_probe_reset_function(dev) == 0)
>>   		dev->reset_fn = 1;
>>   }
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index abd5d5e17aee..15bfab8f7a1b 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>>   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>>   			     enum pci_bus_speed *speed,
>>   			     enum pcie_link_width *width);
>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>>   void pcie_print_link_status(struct pci_dev *dev);
>>   int pcie_flr(struct pci_dev *dev);
>>   int __pci_reset_function_locked(struct pci_dev *dev);
> 
