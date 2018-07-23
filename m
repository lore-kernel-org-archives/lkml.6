Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E8CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917712064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rNFRou/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917712064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeGWWjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:39:01 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:8859
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388111AbeGWWjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb2Rm+7E/gSI/rqCNexGF36ThVjL2mdQETwbSPX26mo=;
 b=rNFRou/QsKd4OO8kk6567i3yIEnMael4qDdgL0Eu18uzjnlwwnB5s+B+EFNGDFaFRHGa0Pscsj7GmQiPdu6XwTE0OEYRwX0UBcRP1+ri6eEV8ORzjesCFRaFM0r7+c0jEgN3QexqUvTrbvwKqHe6mr7bJMDzbMBoTNthMPGd0g4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [192.168.14.130] (79.180.230.147) by
 DB6PR05MB4648.eurprd05.prod.outlook.com (2603:10a6:6:4b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 21:35:45 +0000
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To:     "Alex G." <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
 <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
 <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
 <9d752b75-eab2-6fd1-f9da-09985966436c@mellanox.com>
 <757729fb-1eb5-e1fa-899b-5cef0cc3106c@gmail.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <d7da53d3-1631-7d3f-5b78-15a8af30a759@mellanox.com>
Date:   Tue, 24 Jul 2018 00:35:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <757729fb-1eb5-e1fa-899b-5cef0cc3106c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [79.180.230.147]
X-ClientProxiedBy: VI1PR03CA0069.eurprd03.prod.outlook.com
 (2603:10a6:803:50::40) To DB6PR05MB4648.eurprd05.prod.outlook.com
 (2603:10a6:6:4b::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e48283f-f032-470a-524f-08d5f0e4417c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4648;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;3:sY8Sx4BcCMxv2xya02e9Hu9LtCp6A7WVGIkVd4dmOLd9+JQBNVuHAzkEU6c90zarPm8EEI/DCgWHpnDaXvNhMhE7ZPQ+MChWE8UwKGUGT9hunIfzL7GsDccs1i1EP2OqSjdvK7lgKVmD0uX6HM6FJXvVQG49+ZJJuqcnYpRd86OQUqFnVqEwfLdugMOVSGDVUHpB2xnOnHBWLCu/kWIe7i2JpdJisVkHcnSqEFhU5/IvZu7zoaLpAoPYDipYsEkY;25:CFBMP156pmkDzv0B7+rmhaXSVTXUlBAA2GQTX1Sv9cZy0jnRrNAVDH6ZHpmj0FHrPRBdCe+t/2BpT9zt6RwOCTqD/58dKqbUYtN+kpdomnQjnf6+v9g7iV7903iRRbgVT/UL3q9xVMCzi/QRR79Pxfl58y5f5i31PjlxKLmkkmFYVypNdOHGIEZMKcXZgSr8/R4VnIWCO/2KJzWMHz08h8jdtEQmpEDBtrw38jDMh8M4E1mAxA0eIaTGv179npfO5Jai2Hfv18dvHYTzaWfxnv2GthPeySyDUsQoPYHl/hCemawFYtv1rKFj06ruX/88wUsHVkX3Br8XYC0IDbdLPg==;31:XXdi5jquntAm3Ho+hkMYnK/xP5jwIZv+YoGqwmqBxBOXPy4+Gt7qGfw00MmcZzh+tvx/rfUBycUvu27nGQtuVB+Z4P0JVKbBXEcrrGafykyWlqfr1YtP4ofZeOejFMrzPnZbg0UJYMTQKwZEcZd7d/u7JebiR5bCWPPsZVDdpkeVmWdbrRqUNCq4Vty++DdsU5aOvCp5hO/uES0AUhe2rtfhVMhLUhNECyOXG+WLs7M=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4648:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;20:BHoPpOAsIEeyszEvHGP/UlwCeDiHAUOoeh4W1/F/6PbveY9bNZmgXEoX36VNC7CZuv7zj5YvWqObW5IcljsTrIk+h3V7Gxao//PHj2kMNCm1qfWik+WxNgffn9Bq+1AkRlNYE7V0IiH8ETa2Ee5irFPVzSwEUSfFAzjjaptCL2TWOGH/4tIMkME/vJaVSLw2paEHiXDK3td3IYw8ikR55FWXuNogZsCax4dR8vPMvNB7NMgadV7aEjixC05wN9ZHrxBsTttZK4OnZJ4/h89nFHHi3KakHe9eZ8llcQCRn7ILrHJ6cxZZiVWn59PEFb+oAnIq9W3ak6UldCLp58PjDBopiGLHcnsmY48OkH34vEtuatNjHPALa4q8CXyhzAMc9+pykq7pgs9V2KztyzkvXFMGdwmmh2HRMnymucbHiYmuix4tbmQW5LkjN5EFEVK2OKCi5cOuqOEWaSNY5qXXXqciWPmG4vHNd0zZoY0o5vDR3Do084ldvRkonqQJSXUZ;4:Ni41WlJk9SZNqAEKCqkRA+/IEuou8mtYA6vMEBAnjRuG6GLFI0tpjVWB8VVKB2b4oieGOcnHPu4Xgrk/f7Vdt36y4QjvycsLwIKTFnc8+1rZLrWI6AZfAUYOb2RxVuh1x68ULQqtqHi3qeI2XwpOfsyK2bdbB85gCcAfquftAeU93Y5yD3CQ8vguJnRWmdJYqFLogKwFtIMI4++LF67zUtp4WFSNSxr75W+KTMPxi/Q+x48UO02k0lAlnYWAjiKIb/cREbOAH4a/2fcmN31tzg==
X-Microsoft-Antispam-PRVS: <DB6PR05MB4648A225026EAD2D0923AD94D2560@DB6PR05MB4648.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB4648;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4648;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(50466002)(67846002)(3846002)(64126003)(6486002)(11346002)(58126008)(53936002)(7416002)(65826007)(6666003)(2616005)(39060400002)(5660300001)(956004)(6246003)(6116002)(476003)(47776003)(65806001)(65956001)(186003)(76176011)(229853002)(446003)(66066001)(68736007)(16526019)(97736004)(86362001)(478600001)(93886005)(4326008)(486006)(25786009)(3260700006)(305945005)(7736002)(77096007)(26005)(36756003)(2906002)(110136005)(54906003)(81166006)(81156014)(16576012)(105586002)(8676002)(53546011)(386003)(316002)(14444005)(8936002)(52146003)(31696002)(2486003)(52116002)(2870700001)(23676004)(106356001)(117156002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4648;H:[192.168.14.130];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUI0NjQ4OzIzOmw1elBvaGd4Ui9ROGxqZG1sUGpxa1dMYnNN?=
 =?utf-8?B?eFVpTGtuK001QnlMem5QcU5wNGJMVHZEZmFaQk8wblIyd0h3czRWMWpzem83?=
 =?utf-8?B?N04yNW1Qamg4SnRVUXYvek84Z2lCSWNjYmIvRmErbEh3YzZNRWlBS3hGMjVi?=
 =?utf-8?B?NUhESGh2UzBkUHRGUEZnbVBlOW56YzduUTFkZitqc0NSbEhVbHVOOEZsWjRt?=
 =?utf-8?B?L0JlK29SaERWT3kwT3pFMTNnWWFOTnFKdHJqVXJWZFFnaVRyc0JROEFyWXpw?=
 =?utf-8?B?aXN4TGthTHNtNUI0VmJhUmxkbEMvUllSTVh1clNsTzVTM3NJSzM4d3cwdjlB?=
 =?utf-8?B?U2JRb2haNll4c3pTVTV6Y3d0QUtFOWgveERxdUFZZXhmZHJQOEpDV0VPT2tJ?=
 =?utf-8?B?RTNVQnFNRzN6Y1ZTMFZvK2laalQwU2lvVUtMR004b09lQ3RCSXplVmpEeDh5?=
 =?utf-8?B?aFB4b3hFeWZmTWdIRWhJNnRHK3h3d1FQK3pGYmg4Y2N6Q3d1aWFRWEdiTWRE?=
 =?utf-8?B?YXBiUGFpN0puTXNIVEtsVjNXSzg2VTkyYkxna1ZPa3dRcWtBZzdicUdTUkRF?=
 =?utf-8?B?Q2xJcEgxODJWR2c4emhZR2JEcCtFa292TElXRm9VZ3prbERWZjFzQ3JmdmpN?=
 =?utf-8?B?QWNjVHJRZzFzME05eDhzb1I0eHk0VytlQm82YlFLSDNGZXBUd0NhVFJuYjk1?=
 =?utf-8?B?cGppTmNNdkJUYS93NHBYTmVmMHhjd2RlT0c0R0xNOERGRzJTMXU4QjloYkxo?=
 =?utf-8?B?eWFod3k1aitWeThmcDNLN28waTg0SFMwWHhOY2VpcVcwcFE1azZKMnBKcmg0?=
 =?utf-8?B?elFKV0p4OHNWWHRBSVEvWVJDanduMUhzSEVUWVVVbk1UK2JqMGNKVDZaWTgy?=
 =?utf-8?B?d2Z4aTJieUlYZTdsT2ltMWxVSUR6aUt2a3I4V0x3czg3M3dnN0J3ZXd6TGJz?=
 =?utf-8?B?VmVUWXNTOXRhWnlJSDAyaUcxaHdURm9SZTYxWUxiVXNncC92cTBCNjZGTlJH?=
 =?utf-8?B?NmRlS3Q1VENpLzdPTll3YitqM054eVpRSlNyVkx0ekhWZExIemxRaG14TVVB?=
 =?utf-8?B?TUVVZHFyTzI0RDRJY3AvYjJEMnBBMVZSMWRzV2lHeERrMUd0dVF3R0Frelk5?=
 =?utf-8?B?Y0pOOEk4b3FldGNnQUFxS0I4dWw1VVd5dlZFVGNzTjc0bmZNeCtYaDVLNElJ?=
 =?utf-8?B?MVVzYWdCbmtLUWtYUTJ2a1lQUnhvMm9GZnpUVHhjYU5nUXZ0dS9ha2RmZUJ5?=
 =?utf-8?B?VlE0K1ZJdTVEbDdZb0trVVB4Ums5S0t2c1NQRHpNcDlTcUZaKzNHYUVYSG1O?=
 =?utf-8?B?WkZlZXFUWlVaelk0ejRKd0hmamc2MXE0SlhOWVc4OWVlVml2VDJFQitBY05o?=
 =?utf-8?B?YWl6RVZRQkMzNzRBcFo3V0VsTy9RbVlxMVY0TkJCb1RRcklLTVZrcjJRZUls?=
 =?utf-8?B?UGVMMnhMcUlaL0Q1NkdRSGFTRENKbHlROE5iOEVWQXNhVFl5NVdaZXMzd2xO?=
 =?utf-8?B?Qyt6b3R0ZjM5ZVBXSUo2bTBEUC9zUU9RWGxGZmNrcHdXMm4zNmF2aERDemZi?=
 =?utf-8?B?VzBxR2RZbXl3YmVXV1ROVW5QcVUxbmFjSnhmWWxVdjErUWZRWC90NFA4MW1z?=
 =?utf-8?B?TjVTdGZyRFBoS0d3bWdGSVNNNlFycDVKb1d5ZUdZQVRva1VKbXdZaXUyNGpo?=
 =?utf-8?B?dTdkMHlJSi9Qc0dqeWJ5YWlpcmJzM0ZvNUFXS3RMeXpjclJkLys2VGJadSti?=
 =?utf-8?B?dU91bE1rTUV3NjJCcXdKc09aNVpuWnhqWm0vd0wwck9LUjF5TDBTUWszWlMz?=
 =?utf-8?B?dGJueEFRQ0tDNjc5ZXBqUVZMTUZHZUduVzlNQlBCOWk0VlROS2J2aWRmdHl0?=
 =?utf-8?B?Q0JPeW9DRFVnK21DM0ZxVnFVNmxjMHUzOTJvck5USlJsdkpzc2x5UFgzeDhI?=
 =?utf-8?B?TFltaEViNFRWYXZOdXhKdGpFOEF2Sk9vUEJ4VWhuRkh5ZVhoam5ZbE5wdnR4?=
 =?utf-8?B?Ym1nNVMrSnNyTkdZbi9EZlRSNHFRMEsxN3RkWGM5MUIxeUU2WkJYMW4xaEJV?=
 =?utf-8?B?dGFHNlBRY3RnNUVqUENJTVg5bGZ4ODM1cDdxdHhLMDJmYTZSRFJIM0hLU1dr?=
 =?utf-8?Q?qHOy0foBOh6fSfTHg25ZmSU=3D?=
X-Microsoft-Antispam-Message-Info: H9M8fiw9yd9G1QIx39jO+37adW2HMV6w6S/1flTYTUvlGXtDZ3VedoW0CwRudVTqN7Eff9SRxhEXTPYUTzeuT/HyLVIaHijdGhX1XSrDNzwkeLIjbk7r8bdoTMKeIcCdgdlg2B8Ts5HyO8ZFo4KOWu15P655pfBzhnR+yBNyEB5hq3d+kB/66QMHqONEUmKHLoWm/DZSr/4ftLfqm9fRq3/pzvTOx/FymebtepGeHvU/6yp7J9ZKNT4CE9vvzOwi0ELHiKcdTmzssSb09o/24wCUWx0dPpVNR9tHZ/D3qb53TFHSokJGpAK19QTo5KgTKZ7a7zeijQo56mAWfOJfaqRvpIr5E04NHR71i3UPzQs=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;6:ve8A5ab1b5mswjDv5XzMnt2V9RK1Kau0wBAtMi28kbRqB3ByyoxODxPvq9KRT5b9hB+Qz5+unNRTpjNeHhKndDO9DTuYPm/lwIXINnf6YL4BuI8HNJckk5VTcuxibwHUDMhHJ91UQd9O24AUpLeFYEsSnQTH5UEdsOfxjlL5CI3xOv2seHWrSeIQQCT3qJun8sf8agEBuKNMcj9Y5BTUh+Eh+wtF3QVyX9kocWRioc2JJRT7boYbyBfRQxliUdqparQtwRq8zOlmwFdAH4ys+mLSRlNDhS81BtFTCUCQMictyvMYDri0pLJLp19QaDaR23dPwUeYAN2agpDEdS3Id7LpLBfq7dOHPHdz2QQLeVbfU2NFmDYK6cqJLqMzpeH4hm30+DYOwQuKLZ6rcfDKY7WjkF2ZNcjWVcgFUdMIUTsMjN+y0cEHpaE/s3Tfpd2tXbNjYKyXLqcXxRyCgkvVWQ==;5:HEscn7qPQkicP93fizbuWSZW0kLXnxn6Z7MFDf8PNxjxXyAPsqjt2W1KlOutBBg9168bHm0cKB4qwwWp+Z8cRPsL63nB4mobuVtCmGL9K2h6/ADXCMEs411lOoTfMiuorKrXBw6Zi+WxREnpnF4qS4cmG56HavrYrA2la4YVF5w=;7:wmRJ5WZSCPs+BSpO/xtICnDDXrxEvTn3e4aNA06TEa9qskVGuAVye/7IOB91QHOgGcbOpblvgCpaxp8YeOkoHowxgcEGQJr6iSkamXvaftMV6B2+36FZlM05xWIcWGBTjUP1TK+Sn2O4JwI/3B/Dz5bc+hubhIHhp/RSGrpTuVKKknbRn7EyJasii7QW9Qicl80ph0IR8JnN6OV+45Qtbvgr2tTdhzugMuWz/kP70n2V2n3dwxoWUlWdGEhuzAg6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 21:35:45.8731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e48283f-f032-470a-524f-08d5f0e4417c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2018 8:01 PM, Alex G. wrote:
> On 07/23/2018 12:21 AM, Tal Gilboa wrote:
>> On 7/19/2018 6:49 PM, Alex G. wrote:
>>>
>>>
>>> On 07/18/2018 08:38 AM, Tal Gilboa wrote:
>>>> On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
>>>>> [+cc maintainers of drivers that already use pcie_print_link_status()
>>>>> and GPU folks]
>>> [snip]
>>>>>
>>>>>> +    /* Multi-function PCIe share the same link/status. */
>>>>>> +    if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>>>>>> +        return;
>>>>>> +
>>>>>> +    pcie_print_link_status(dev);
>>>>>> +}
>>>>
>>>> Is this function called by default for every PCIe device? What about 
>>>> VFs? We make an exception for them on our driver since a VF doesn't 
>>>> have access to the needed information in order to provide a 
>>>> meaningful message.
>>>
>>> I'm assuming VF means virtual function. pcie_print_link_status() 
>>> doesn't care if it's passed a virtual function. It will try to do its 
>>> job. That's why I bail out three lines above, with 'dev->is_virtfn' 
>>> check.
>>>
>>> Alex
>>
>> That's the point - we don't want to call pcie_print_link_status() for 
>> virtual functions. We make the distinction in our driver. If you want 
>> to change the code to call this function by default it shouldn't 
>> affect the current usage.
> 
> I'm not understanding very well what you're asking. I understand you 
> want to avoid printing this message on virtual functions, and that's 
> already taken care of. I'm also not changing current behavior.  Let's 
> get v2 out and start the discussion again based on that.
> 
> Alex

Oh ok I see. In this case, please remove the explicit call in mlx4/5 
drivers so it won't be duplicated.
