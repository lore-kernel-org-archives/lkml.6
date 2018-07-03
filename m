Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E2723ECE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t6bb7BW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E2723ECE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933732AbeGCQVr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:21:47 -0400
Received: from mail-eopbgr710071.outbound.protection.outlook.com ([40.107.71.71]:47760
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932392AbeGCQVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/9+ykSIHdEM4BWkTn8M9LquO1CjFYgixih0NfSKROQ=;
 b=t6bb7BW95b3m+tXkVx6j0sVs5FAerqD2z9zMha0YRVrW8EG/wGOep4N6qiG7E+tacKOExuZ/mkhmUPd35gOEPNzxN2OEu4W5KWptPYvdcnm36JeTJIDlsXQmBP1psAKCJePJtClp28siEWDxAj39swIWsboJjTuXUy8uxfZfZMY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.70.155] (165.204.78.1) by
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 16:21:42 +0000
Subject: Re: [PATCH] iommu/amd: fix missing tag from dev_err message
To:     Joe Perches <joe@perches.com>,
        Colin King <colin.king@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703064005.18908-1-colin.king@canonical.com>
 <6763ec382f8d629f5f356f4cc023f20c2f76b26a.camel@perches.com>
 <d27fe634-89cf-7d9a-3e3d-a2baafabf0be@amd.com>
 <d93bfa0f52d8907019b16336645986cd339ebf75.camel@perches.com>
From:   "Hook, Gary" <ghook@amd.com>
Message-ID: <f3e15437-68c1-58eb-bc34-93fa70e50dc9@amd.com>
Date:   Tue, 3 Jul 2018 11:21:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d93bfa0f52d8907019b16336645986cd339ebf75.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR0601CA0091.namprd06.prod.outlook.com
 (2603:10b6:910:88::32) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a68d1fde-bef4-4c94-65b9-08d5e1011044
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1449;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;3:yIAYiOVQhMp6APp6mQMG7Rvv5HYofo6Zc6DsIN4YF5t/so7JwkaBzJ9Pa1Tqugr04Ww+Yc8iFwMVOhKlXlq1RvHfDszPm7rQCkPPsUNOqAzYnjgAv0XqTmMWinVnZLyhdjrr59dNjGTEnPyjOyvES0DqrxB1ApOyIHTS2a78DgHHMtCYHbZxMneAnFgs1XYH+RuwulVPUv+ffLLLgMie624NyMq/e1FApauhxL+rMAw0X+OhGBUIbsvIpgCZMKdG;25:kMjdTp03wBtKwhEFB0qvf3xanEX9rfmi3bkxipqj8GKT91R92jyOoJUhvkaiP27Yc4D/XgrCMpb2NVTSTr+Fu+EhJgHxMPBCKzmWBBEo3AjayfQchx4/aJ+oqh1mHXYIc/BWu4lDHBM+A8aMnbugvf8mv4fcGm61s5jKUgao3pHSkMaSuhOmMqEW23CKUd5AnEODq8vGQ09bCBTTOYHFpE9carBaD0ZLKCEAm65ECzNlDX6EvjaIpZUaYS/tl5/uDIavsh+6PcgnwIZ2d+Ub8QVJDD3YmGHRsjj+3J+MgBiDYgLctiLwdNK8T87ZNLi1UjC4tOQqDJhoR9vfGXUtLg==;31:cLp4525fEManjUjbBuw+aL9qnlrRvSSE012AX6iuhXkzYK5o8zaNLUyGlljJY95vHmJ/svOWNSzaA+ss2jLII5DJC8i4oO2acT1eTIdX1Hb73U5J20VuK2eq8ZnjLZBd3QRao8HFIoAu+zIgw42VDfeeHDI0tvaNVYqfEFgbfZGg+lldKM1WxDSwxJ+SwNBwV1P94NMzrcHF4IYHbYhfCWkpxVioK1BnNAnv8jZYf7U=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;20:wMVar3sfGpqeu00Fy4l+iZjPbUhvqFGrGQ6qy7gK+5Yyo1gVJ53dcaZXD3n9NvxZvLp7TX1f6/wN6BDfzG/QPAmvwP1yZ1vmMQWcTbXWIsoY00nzbJCUx5ZWKG1wQLSj2uRcSRrFQRZ2YwhtPqCFJukWAbx8nW4JZakPeMua5gUjwai7/y0smtSAgZmvJ+IP8RmUfbSgU9dZjOq/w9M7e1CUqi6LwUthzCkQSS1WXG+AnD71DcIAHtwChEImNFT4unO1Kr0MwpB+yhGmvMrs7Hx5KTUVB9oJCA+xEY46E5laIqPg+ut1TT6Y9fuwMvhvTE9T+MpnxSlxAZbETld5EzZEzaX06lusLgCPzYO8z0hd5gnF1kEmtG9+T4qBy4Li0L72AwlinS1IgxdCj7aE9sekkqKKXoxXJr6kVycnIAGRcHInn+aXiVy3yWXqzOamxGxT3VduZKP7E3e1ibmxeTmC5pqQgBxe0o+XhmZqtuungOQEQrwuZZvJ3R1q/NA8;4:hGAFanYHvzDlw7/2udWKBMNDDX9+4ErMRoXv6jkfHWwE6CSq2rYPj1sCVA4sKVqxeqrfQcKtdE043rnTMtsIYkvBxZbKyuwdx43lQFtK9uBRS3tQr1J+eQcwGeKNcOSefxZRcR17HUW9VhZHTRYLZac3RSiHSKzhTMewCVdA+xSVCyb3AH862/4/VmcYNM1N0CW9C83QTCLZ5psk/N9JkIyLK9AzA3U31c4ssSMtJMqfxjLNyv5PFSLaLkjyjv18RwU2zrpxJUARfVfJJoi3MA==
X-Microsoft-Antispam-PRVS: <DM5PR12MB14498A08BEA1F71087E06893FD420@DM5PR12MB1449.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1449;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1449;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(189003)(11346002)(106356001)(8936002)(72206003)(446003)(186003)(25786009)(53936002)(4326008)(3260700006)(6246003)(31686004)(956004)(2616005)(5660300001)(476003)(105586002)(486006)(68736007)(97736004)(15650500001)(2906002)(6486002)(6666003)(305945005)(65826007)(316002)(14444005)(230700001)(229853002)(16576012)(36756003)(93886005)(3846002)(58126008)(67846002)(47776003)(6116002)(386003)(53546011)(65956001)(52116002)(31696002)(7736002)(8676002)(66066001)(81166006)(16526019)(81156014)(26005)(77096007)(76176011)(50466002)(2486003)(478600001)(110136005)(52146003)(23676004)(65806001)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1449;H:[10.236.70.155];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDQ5OzIzOkhIeEdrNnMyaFVYdmNVQnlEdDRsSURHQklQ?=
 =?utf-8?B?Q1hrSWZIMDc3dDQ2Z284WDM1TFVGU0ZuMWVDRnBqMElsZElkOXlNVXZNeTkw?=
 =?utf-8?B?SmZtaEN0cEcvWCtBMndzV09rNERnaEp2VS92WXJnbmthbkswTEY0QVZGY1lz?=
 =?utf-8?B?MlRuK1llVTRNM2txazRPRytzVVphMTdRT2lTZ2lCUGd6TFlWSE4wdmV2T1lS?=
 =?utf-8?B?Q3JlUzR3bzVRc0tWN0hjM0JHbXZsQWc0UTlZM25VTGFnWVh3eDRsVElITkIw?=
 =?utf-8?B?Y050QUpkeGMraTlHN09oYUNRUTdxc3laNXZVdk9haG44SEU3N1lrc3FHYjM1?=
 =?utf-8?B?bTdwNy9rNzdNd0MrRmVzSTlQL0F6OHY3OWVSdmg2cDF6ZU81R3dvODVqb2NC?=
 =?utf-8?B?Y0pEV1g3NERKeVgwVEhUL0doRVJGL0N6c2ZVN2czQllLeHQ1TUZPYVhLSG1F?=
 =?utf-8?B?ZmdsR2xYSWoyR3kwdE5DaDhpbnc4cGZnYzdmSzgybE5QSWhPd2UrMHkwVmtq?=
 =?utf-8?B?RXp5ekJHMVd1aFFsOS81elVTVkoxbFFBNjg3aTl6MW5wUmdWSUZtMWVNTWpE?=
 =?utf-8?B?SytteFludHpSQ01HdWF4aHBYN3FJODUvY2ZQc295T1ExSUJKTklJNUpZcitJ?=
 =?utf-8?B?WHpKakkvV2Q5dDg4M3JUbE9tMHRKVEFGK0ZtdGJ3Zkl6eWRiR2hZTEdlL3FO?=
 =?utf-8?B?NzBuZnlobXZaUXFSZTVLVFVZMlVMMUJoRUljdmhXbE55OFFzVDF2SVEzTThT?=
 =?utf-8?B?by9EOWx3b3NMeHJML1FNQ2FvQzkxQVl5eERYKzZkdGQxSU1RMVlVN3ZDK0Ry?=
 =?utf-8?B?WnVQNWowM1l3UXg3L0NOUTBLdzE0VFVRWVVxc3d4RiswVlRPZ0diTWlyNmVi?=
 =?utf-8?B?dVhGNjNDaVZETFdla1Q0ZWQ4c016T20rcFhLZDUzSDVDai8yTDBMMklnQWxV?=
 =?utf-8?B?VmIzWnpOSjBPUFNuQXRWUnl3RUlSbEZrelZDbFVaTzUwMXl1ZmNOQm9Wa24y?=
 =?utf-8?B?bzlMeC82aENmU3RpdU16aGtzL1lkSS96aGIrcU15ekJncDFqZmJheXpqQ3ZT?=
 =?utf-8?B?dTVUdEZpNkZzWGxISWNDS29VdUtQRUREcWp4TGtBSXV4ODBKbGsybVc4bFRW?=
 =?utf-8?B?R1dKK2g4V1dBOWk3SEI1YkpzcnFZU3JnNzM0YlBQRyt4UkdhTkEvRnVTajRh?=
 =?utf-8?B?RklZSUlpZjQzaU9STm1RUjl6d0JjUkljdmQ4YjZnRSthK2U1eUdwcFhyZmRr?=
 =?utf-8?B?dXk3a3BlZ1hwTVJjalprcW83NE9LaFJxQTBZckV1dXgxTHZwT0gyaFdWNGQr?=
 =?utf-8?B?dk1Pb080dDJoaytGa1c4d2tIbnIzUEdBeHJmQk9YN0lDa0ZzN3dyN2hYNXpV?=
 =?utf-8?B?TTdGSFVVNG5NZTNUUFFiTWNmVWtJUjlPZWl3a3l1MlFKdVI0OTI2TkhQNjdF?=
 =?utf-8?B?SHVKZlJOdVEvcjhJZUZlTDdrYjhrM2ZFTXh4ejN5WnNjSWt4Q1FVTDJJajBQ?=
 =?utf-8?B?aDB6QkxwWGVMS2pKZDJxSUdsbTJBc2NJcWpaUXZuUjFRZVR0cmgrRUErTTJP?=
 =?utf-8?B?NktDUXFJZis4TkJYWldDeGthNGRXbUZneUZ1NFdjOEYraC92cXQ5LysrREJy?=
 =?utf-8?B?MDhoSDVqMWRSSmJrbkhGMk1FS0JEZnNnZytQZHJnTjFqSjRQUlkzNW9UeHZC?=
 =?utf-8?B?R2I2YnZlS1FRMERDM0VyL1VibVg4R2NCV3lLeDVZRnAyTGM0YkZsSGE3UTQ5?=
 =?utf-8?B?RGVUSG9xUGJ2TnJTM2pzTzdjVmM0VzdUWExYVTdUL0liR0FnY0tURWVFSmpk?=
 =?utf-8?B?RzE0cXRvRWJlT3JvdzJEZnA4d0hRTWV5bzdCbHExaTBVaUw5ellZTmZkWHB0?=
 =?utf-8?B?Q2JMbGNyWXlRbDR2ZCtBeTByZ3F6R0lqUUZrZTJ1Yk5JWG94Q1pWUGdhck9o?=
 =?utf-8?B?MTJWR3JTT3JCTFRYZGFQeVdhM0tMNzVWMGlpWDNLZkxpZlpJeTdFSnZwbm5i?=
 =?utf-8?B?RTZjaVpVU2d3dmpFMmJBbjJsZFFjLzJOVjZQT2QrVUovZ2xPTGVQY1BwbDlx?=
 =?utf-8?Q?Y2mc=3D?=
X-Microsoft-Antispam-Message-Info: MDiTjzjgU0liTnZz8V7y9szBBmEdcnFUPSHecpxEAzNAClY6UDpOsOuQs0/7hDRj+fx+OJkuxje04iNkqjBkug6ZdfAMw6SFFgsZ/Wnssxha6JcOK16naeWS+xMChKrrGzPNzJt43v7pIPcrhtbsm6HSvkWWGUHKYjkw6uSJsCvHbC+Vd0TaTL9fRc9znuRwzq8I27Dn5DHgR6R9R8dd/2PTy64akveKTY/eMgPJoZjIjsxtkX2ETsrRRBHwjNxJzGbIUYswUchw4spM8ZTKCIWq9TP0JWB8qjpsCWR18Atx/6RpYhKIjoazs1/y3LHrQryhO79TRLWm/wwqEi35/R1YYGCsLwaezjej0IWB5X4=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;6:bjNyMUxP/ym/LMmKX/d3j8G5pPCvT4Pg5BtgWGk3V9s7cweFtx62MJB8r1n6clhn+G3Bw6iHske7ZvKCd+jvi7xSsLZcW6lxAOmYyVavONnMcwbqEAtwUzCZ1DlXYLnfiM3QEDcygTxfWTpCyvcLUQzyEM5mbs7dnBkvETjz+eqUqRd4rd+aAiRw+BqG1a0jCWpl6x86FhXEKOIH1sD3kss53rfx4IfHVCJ+Li95n1BZVH44AXCSuBJ1PLvIFd5dXRtc8P0KGLqNFVvqWz2jbBtzPNVRKpFD5WOVfvenlJWf+1lyVGhpDQUF5nrw4YDVtmVBlMViY10u/3BbqObKgb3ZUkrQ/yD0bgS64V55o8VWMNwss88bsBtj3dGjNL8PVHJmj2v8RxvP6QupU0vhMKar53oNnDYbqu6qAmzhyVUCcORENoEu80joqQUFGGXg9z4O+5bCiBPbB7dAtW+z6w==;5:hKjnHBvAtR9KG9owRfxm8QPqeD5tLRq/4d9oOa/CmAskwdtifM06VRG01dClnbsZUw6YXK4ugQ5V8gd8r0vAIndMzjSQPBPCOBVJo9Hv4M9oPAfm+RZRklb/ABib2KVkWJaMWW6gsW0vXuOWe4VBLY0aJoDD/4MyPH3c7nD35Nc=;24:jtwk9sGhkl8hIYCYwKrYhnFRv3LDn6Gi3EkYoEdNfShBrZul908L1lhRD77BWicmjmXSSPC/c3t8ZtvvbAPLNDd2+4SBX3iNxwojs9Q8vz0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1449;7:8HncqzIgtaw6Rio6tcf7rkbsa4Ba6a6ZdhIxkGoTso3EJLYZMESBaNfKpe91vpu+bMcM6QXN85fk3mNNgbiIENBqupnYyG2IeuLLSBBvd3k4TB69uulARG9BM0MAAn0NcjzRGSyvP45IEpHYlguY+1xbtrKBdKKCplP9kh19pQBc03WvYfsZbW0VEqDc+Mqg7Q1kBPLqtTJVrU09EMgeaWHp3+9tj0SCWnSmFp/vJEusnovxxhrPUmLWMeWvrPnm;20:C3q4S8cEP4Dte6zUYw6JDV2wYkrJq2HAkyc9TEMo/NM18VMbH97KCRvPo4pnYABrwmMBMy1uA9SdKKhy1wUtQGG+TYfzBEY3Lf4wNbE3FVLLcIvzfajxo2uwCCOmdCwkChogquvPWDM/8FMGZVbl7Jadx9UIEKs+I/WpFFkjrRCJk/TTf7Z4Xz/oVguvxhoWe+CHSG9ndw/sZiit8ihX7zXphRWzbBs+lhYJ433kEJp/zPyMb3VscInfXh6o//MH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 16:21:42.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68d1fde-bef4-4c94-65b9-08d5e1011044
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 10:55 AM, Joe Perches wrote:
> On Tue, 2018-07-03 at 07:56 -0500, Gary R Hook wrote:
>> On 07/03/2018 05:07 AM, Joe Perches wrote:
>>> On Tue, 2018-07-03 at 07:40 +0100, Colin King wrote:
>>>> Currently tag is being assigned but not used, it is missing from
>>>> the dev_err message, so add it in.
>>>>
>>>> Cleans up clang warning:
>>>> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
>>>
>>> []
>>>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>>>
>>> []
>>>> @@ -616,9 +616,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>>>    		pasid = ((event[0] >> 16) & 0xFFFF)
>>>>    			| ((event[1] << 6) & 0xF0000);
>>>>    		tag = event[1] & 0x03FF;
>>>> -		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>>>> +		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x tag=0x%03x]\n",
>>>>    			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>>>> -			pasid, address, flags);
>>>> +			pasid, address, flags, tag);
>>>
>>> Seems to have a superfluous ] that should be removed.
>>
>> Yeah, I pretty much messed up all of the log messages in that function.
>> My apologies. I'll create a patch for that problem; it shouldn't be
>> fixed here.

Well, no, I misremembered. The extraneous square brace has been there 
forever. Needs fixin', though.


> I also wonder why event is declared volatile and then
> dereferenced with [<constant>] multiple times.
> 
> Maybe each array dereference should be stored as a
> local variable instead.

(I know you know this, but as I understand it) Event is pointing into 
the (hardware's) event buffer, and the data structure has the potential 
of changing out from under us if the device does something without our 
knowledge. Since volatile hints to the compiler of this possibility, I 
believe the compiler should manage this situation. But I could be wrong.

I don't know that we need to atomically copy all 16 bytes into a local 
buffer, as I don't think it's possible for the device to step on itself. 
It will just stop recording events if the buffer gets full. At this 
moment I think volatile is overkill, at least for the EPYC/Ryzen IOMMU.
