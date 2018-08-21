Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B402151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l+0G3uj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B402151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeHUR62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:58:28 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:34376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbeHUR62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0BfeaMKD3ggrg6VbY/Pc3in0gEvVWO3oCVAJilfDuY=;
 b=l+0G3uj5oCmV5pfBlBGIUX+0hH9dt4xYJXP1vzJZWiBdGplye6VqtTAi8CayX5dgM+caXWMlUYav7xSlQ5w69GRF5qjSGrSHe3ae9M1RXFGwACRpVskvwJ5mkLFKnV2Ep45GP/y/CvEKkUTLLH7O5gjDwXVADWYn1RP0HfMKKlY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:6f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Tue, 21 Aug 2018 14:37:59 +0000
Cc:     brijesh.singh@amd.com, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: SEV guest regression in 4.18
To:     Borislav Petkov <bp@suse.de>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
 <20180821083911.GF24940@nazgul.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
Date:   Tue, 21 Aug 2018 09:37:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821083911.GF24940@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0114.namprd12.prod.outlook.com
 (2603:10b6:802:21::49) To SN6PR12MB2686.namprd12.prod.outlook.com
 (2603:10b6:805:6f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0c37035-1b18-4f74-e199-08d60773b1b4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2686;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;3:4QVvQgabyB1RZSBi2fHL//NT/bouWCL3IAmKjAGKxbXVUwOfC8ihr6S4UEDcqE6MGR5IwA95JIbhxrT/oxCo0RiFpjx6EUtB7vyMcD/e6wCIf+9jSKE+jvMI49ae3HmaeSYiAKSXR074Hsehv/UdVnfUjh0hsNJl66coHdcUAYQdpudCM25MzQTjG2BRPINKC+SFinl1TtXbjylinT57CO+jy5wLgYJRI5HxBv6nHpKhrQyV640u3pEn6RP/NKv5;25:OVr9YLVgKNsiwEoycFt1mRFAhfmesAMJvq8FTq1iZqdm3Yw0FlSW84bcYqk5RxpNkOwsfFLyCykmH1XPClGjPfzC1jmFPyS+LgdyAAUju2IZS4Q2DR3X3XtTZhPW0lnNGXhOXNmUTrhiEp19WKKPsrRbw1WgyP8yBjZaIMliDxWtj2DAJyNYT4UcDNn4yu29//qYcACKz2opi3WWquW8TCXLDIbI8+VoonPOdQDwbl/HoscYemlYc8Tmh84sp+gfPYhHlFtn00mi+pI6Y/AqrwwguIGD1HHtWIcPP//IenYNkouuIRSK4s9jhVqZQ6ypZeSnvB0rU2uIxzmxKOdtEA==;31:3m5f9qq//TQA3quaF+63IPr0U6Vgr7Vm+9dA6Zaozd3laSmId3eNVb2a7y06EgW7S/PlETdr+7x0PfL7gsJmxXW0A/U/oMMQ2lvdgbbItCOoisgsf3uW4hkxBDRKbbUyPxcQcN1Ie+Wb7UnnRL2dvm3fC97Qh7djjsYRowf7OPf0+YHNl4VslTUGv7TUVPe3spAZG5kiRAC2XrfcenBiMap1Vn7PnmCj9m+vLoSJSkM=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;20:pAf5KBADpNqF8oWkmWm2hET7BQ0kAUzkJm/5qld5LBo4YLftBkvnzd2mUcPJLH9XmLSxKYT80AEYOnnjYak4JYiLyxUnEnfh0XqCEvs/QpNSeaQOQ/UtpacTRFHesmdYjhqaAxYoaTENdsdOwute6//2tL8egQhP/v3GJMsXdIxo/PM1JcxpdpS4eeBrO9vwtdwjuqhv+l810yCEu9sn2qgnFwV9aHbauWgVEqbf73jviLBKpZL9RRrnDie84QrTy+m++gHdrul5hdqywwwTZPTHU6912owZkHv5li5B8/l5CwsJCadpO34BKhA+ZNf4U4xWzh/TJp9XhJhKwFwEi7y6XYM0mWrWO9bEfXaYnEcOFdIvVJ6HhxOJFwP8jUx3U079bRPxeCGcmMNxxIGApW+KUEXwPZLMs5HEvUMu3/88TmPP8pUmGTRRhZoNwCZH14W4HU/3gt8kW7T+6eJAprejkSieAKXWGcPxm2XCct9lHdLRJDEyweoktIK4yUeE;4:G1tDDUEYQALqAMuuPzudN4hQxbszrDziY5K2kjXwR2eQ1cy9wyNqdz+tyXPyskMbECIBTcA2fsTFSs2xktn1vKl9fwG5D8TgIuLcgRJGMywBmgm3+sP4TKcRFE3KNa6uaXvYyx3gEWMrc6OXFbwBE++lBjXQZfUW3UtAiybUTf8SQNC+dLzX2TAUaJKFPvX7m8gp1JklOrFMWz3wUDA+cXxPt2E/hPZM9gdMo4EINkz0MMEiwJY2ncNxpihpX0530MWCPfW907a5G68ikH1k/Pz94N7rKHe3Xs3x/iRLHxNyEgoATtHpeDDQb0+Ezna2
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686D0B33051C98D3D8F05BCE5310@SN6PR12MB2686.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR12MB2686;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2686;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(136003)(376002)(346002)(53754006)(199004)(189003)(106356001)(23676004)(105586002)(230700001)(53546011)(6116002)(186003)(476003)(486006)(26005)(956004)(16526019)(64126003)(386003)(77096007)(3846002)(50466002)(31686004)(44832011)(86362001)(68736007)(2486003)(7736002)(52116002)(8676002)(52146003)(76176011)(11346002)(2616005)(81166006)(81156014)(67846002)(31696002)(478600001)(305945005)(8936002)(16576012)(6306002)(316002)(25786009)(54906003)(4326008)(229853002)(47776003)(65826007)(6246003)(5660300001)(97736004)(2906002)(53936002)(446003)(66066001)(36756003)(6666003)(6916009)(6486002)(65806001)(966005)(65956001)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2686;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg2OzIzOjBjZlBiOWN0b0xSWmpROFQ2OHkrR3kyNVJL?=
 =?utf-8?B?WENlYm84bDNXTXpZK0NIeG5IT2pJZ2VWYkJPZnNYMVdmb0Q2VDhQNnFIYmht?=
 =?utf-8?B?UlhicHhjWXZ0Vk53M2dMdkhXOTZFaGVqKzV4VTQ2eTk0aWlJWkZwbHZ0TzZD?=
 =?utf-8?B?WVd1UXcxYzdGOXRpUzJvdXN5RTNTUVdoc1RRSEhaVmlrazVOclQrTHp1SWRQ?=
 =?utf-8?B?MmVjOTNMZyt2K2xvMWw5ZlZYTzlGaDVnK1NnRUFwZm1Ddm1LcFVvQzNtc01r?=
 =?utf-8?B?VkRrU29aVTNKZ3U1WFA5KzZNVytUVVc0N2pFdzJZUDFScXcvenRZUmEzV1lR?=
 =?utf-8?B?QWxaandEajAyRmZYUEx5RU9sTjR2VnhPVUVseUZlM3BackdtMFpWMTQ2R1Fw?=
 =?utf-8?B?UVM5eDNYZEE1eFhVdEJVNWtxVDIwN1FBbTl0MDJHdVNNbmp6Z0QrSjJIUEVL?=
 =?utf-8?B?YmxVazVQLy9NK1cydEt6aFRTaUVYdmFpUW5UeUZwQmZaR1ZrYXlMZGNrWDRx?=
 =?utf-8?B?OEEwTUhLWVdlNXdzSjNNMWRoWnZMUUVXSklVOXlDajRlZUIvY1pPaTI2SG9G?=
 =?utf-8?B?RlFUeHkzUFNlcGxuRG44Wk1qWjNKT2hjNTdtUm4vRXB4U09CZHppNitwT3Fx?=
 =?utf-8?B?TjdscGd3UkdUbWZ3elZsQWUvOVlMYTJiV1cwRGpsMzFBK0x1TnI4VHI3UE1R?=
 =?utf-8?B?cGxHUjdDQjRGQmtReEdJSC9CeTV3dlZZS2tXQUlXYWgyb0gyakxxeElHc1pq?=
 =?utf-8?B?MUdXT2wxYzQxekRnbHBrQ1dPbkVuK1dDOVJGYlhlTzFtOEN3RGQ2eC9DaHY4?=
 =?utf-8?B?SE9kOEFZU3AxNC9QTWdGRnV4bGVKd0xyRHBHQklZanF2RFVxTE5zK3htZlBv?=
 =?utf-8?B?QTBWeCtEN3BqQkQ4NmNrKzg2T25LRFFmZkR0VlVNT05rTkl1UTBGbWRvdmpn?=
 =?utf-8?B?R1FaOXNCd3JmTUxndnRVMDBTL2RGanpVc3ZSU0NQNzl2M0J0VXlRa1A5dXd0?=
 =?utf-8?B?a3BTSTJNQ3BVdER2K1A3djBGRjk5WUlaODB2N3JoTWpQUlBDZmRJOW5CQkZV?=
 =?utf-8?B?WHdtbnQzbnNkRTFHV1RQOXVpYUV5b1lRWmNlRU9meXl2d3VDdFZzUzVlcW12?=
 =?utf-8?B?WmpMUmRjelNCbVVVeiszUEpqc0t4TkZpWGxKZ1hNVXNLbWdyL1RYK1FUY3R2?=
 =?utf-8?B?U0ZnMkd3YnEzMDZ6aExUWlAydlI1UnlBeVRWbXdYd1RiYndOUlhFM0lTc2Rk?=
 =?utf-8?B?b05lcnlDT3RXbUZFbVZ5cmdBbXFxQ3lPSHcxMUdCTzFUSU9UNXl2Qml6b2Iy?=
 =?utf-8?B?SFZjeTZNNGdwV1JESWo1azErYitnV3JXTzdWaVlDWTdRWW9Jdy81dGw1TzBw?=
 =?utf-8?B?ZFNtWlp3N0wveDUvUmdHajlmUEZpZG43a29HRXd0NGpobC82aXdqMUJrajZL?=
 =?utf-8?B?NlNhaTRrZHZJMU40aE5xaUZiU1Ywd3o0TUUxR2RZVGNHdklmZnlpenQxTnUx?=
 =?utf-8?B?OEExcDBXbGhTbXVBZ1VBSDNFUWI2YnNJblE3N24xZXN6NlgvMUNnVGZDMzVW?=
 =?utf-8?B?cHhDaHI4bVlOdU5WbFZkdmpkNDZTU1FMUVlCNmJQRFR5WThDYjZzRVlNTTdV?=
 =?utf-8?B?dU81UkhieHhTVCsvMVMyN3ZISGgxWVk3Qjd1U3kzM2xtbDUvbnk4OEt5b2JR?=
 =?utf-8?B?ZjFPWXRIVERzaTdueVhyNkVLaXY3NzZsMFRRbWNiQkYvYWgzTlBmUzBVUGgz?=
 =?utf-8?B?alloMUMvNW9mSW9Cak02RWhrUWNZMXlRSjZOeVFTU1hHN0lhS0dWbkkzRU1E?=
 =?utf-8?B?b3I3eDBUUE5xS2o4TFYwRThmQ0Jjb09RcThGZjR2c2d3QW00UUVPVmhzTHV6?=
 =?utf-8?B?d0JQRnBFZkYrcCtCcS9IRWhyRExPd3FhZnptQnNYdlBlT2dzT2tYWndJc3RC?=
 =?utf-8?B?dVNyb3YyZlNVc3NTdUtLWmFMUStDTWRzL1k4S0RzR1hBTmVsT1YwZ08xdm4y?=
 =?utf-8?B?dnRiTlJXN2JDNGk1RFZiUUtQdmQxUUFJb1pUazBuL1A3a1VhUHBUemdHWllC?=
 =?utf-8?Q?qEOxNr4NPmGKZnu4EWg8TeHoI?=
X-Microsoft-Antispam-Message-Info: YZvKeQXD+dfQzJtbI2MrFQ61XwMbZc/1UzL2NTi20bSU1luNPDLMT/d6VDe+xaqgSkk1/apTxbKCVtS/BCTT5I5IBmOCKZMxgu1e6RevHKRHhyG6eqpt6Ow318VSStWPh//nQSyA8RtBG2ajz5MZqiSU95UTF95A4Sepaoswi+NAlzw9o4LDSpZAel24WjUrr6sK9W2zcygdeF1ifkel1cCIKsKeskSLbhAK1jSww7iiQ0ftH5bNiu7oBFuck346xpFxjPWUub0qtKgA44iy52X5TlD/O14dq4tpNkBh+LQNaOYBcBtNjl8JUIMDUsISQENhmezirQYEge7uHeJA7TtXo67FVQA7/OL9SyMSJB8=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;6:zrj22CLgM9R/J2nUeyrVGMfuN8hZA6GLkMKjvIDfJ2gaV/RFcmfYWlbSRsexHaKbexA0ju7sZgZVQaik7S1+qua9gXVVCL7f6TYCYcrSlczpTnInMiBRZLzW/6P0AhdQQCbZ15HJR8/rgQ6SeD0qpKfe73hmKwG0bX08YKdtdBp8dHGd4Fhu70fa/5V1ZzryEg+U9qrrm8L59kzVILDxr7Q44SLwboSEX1DOUb028ElQufaaTi3uVeEjnsV8sEr75rVLxSmArntqZM5aeSMGMOLt+d84IPGt+8NZKlgZPZ3yDb+n8983uZJ1/8QDcShsWPiXrr0S7RntuLfSNDNDlFb0eotgi8nINr0uXe/CUBG2OiKr2BjN63Vvz/YK6YjkNXJ0gk1aDP/GUnwdEheGojwCxgSuSqPmOutzfp7I7W8dM8b79dr1keuFVEjAE72d4oFIF4DSL/yhQK6Xyt0FVg==;5:A6mhIOGtIEB36UbjC5uqU/8zeu3NT8PwVYHGFLBTfev4h+5rmlFgJXZNIFWPbRejI3daFE1SmRmESpizIszlDVzVhD/G8qvRuUWEo+w3x2DeULZMqsPy0tUI8lJFzhXwRTKroXJMf3+ItZ9occ0dkKV819Y4IquRu2meG+MvvBM=;7:szRgig6A1sTuwFX8NyCcrUMb+YEZ1zAfUAyCFy9ADZ62JhlA3ucJs7hBQhAQettMPVdbrB2z4a6g/JVWw109KCrRPWrJLcEtCHcMx+jKao087rckJLQo28tF8vjYvTNSK1tSweGkBBCwRtN1E5D6SNg8f+hM9c68QVYEvIz/EDmHr6UAeY/SzN02mvDr0DjknArGooEf6VoAgEutiUsQCGb1Jmnua6MrDPmOVPH/hgU+cMkJ71bnpEe/sM6K0B3A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2686;20:6uBQdC7C3WXlQsmHiyjVpATVgSLb6RFsSXDXYHGfp/4dOjAd1+9FPEJJT/7zHOvf5HKTfPXbSUbVPN3MQSaekQ7DufgiOSFqnGJ2+yy9YAFCBKSjplOG0MPahBKWf0tuMmQYfCpQsZaXQw7/UmN7DIr2qKAeeM7J441XJVCo5RBznW6+ozcW/X7vZbSHg9Fefs4W9WhRRHKw0uD7bc2KymexyqEMgjcSENqFaRtNzPjaOnuCQm/oWTTyNI8XV0WP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 14:37:59.9340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c37035-1b18-4f74-e199-08d60773b1b4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 08/21/2018 03:39 AM, Borislav Petkov wrote:
> On Mon, Aug 20, 2018 at 05:11:53PM -0500, Brijesh Singh wrote:
>> Hi All,
>>
>> The following commit
>>
>> "
>> x86/kvmclock: Remove memblock dependency
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=368a540e0232ad446931f5a4e8a5e06f69f21343
>>
>> "
>> broke the SEV support in 4.18.
>>
>> Since the guest physical address holding the wall_clock and
>> vcpu_time_info are shared with the hypervisor  it must be mapped
>> as "decrypted" when SEV is active. To clear the C-bit we use
>> kernel_physical_mapping_init() to split the large pages into 4K before
>> changing the C-bit. Now the kernel_physical_mapping_init() is failing to
>> allocate the memory because its called very early.
>>
>> [    0.000000] Call Trace:
>> [    0.000000]  ? dump_stack+0x5c/0x80
>> [    0.000000]  ? panic+0xe7/0x247
>> [    0.000000]  ? alloc_low_pages+0x130/0x130
>> [    0.000000]  ? kernel_physical_mapping_init+0xe0/0x204
>> [    0.000000]  ? early_set_memory_enc_dec+0x123/0x174
>> [    0.000000]  ? 0xffffffffae000000
>> [    0.000000]  ? kvmclock_init+0x60/0x1ea
>> [    0.000000]  ? kvm_init_platform+0xa/0x16
>> [    0.000000]  ? setup_arch+0x434/0xce9
>> [    0.000000]  ? start_kernel+0x67/0x52e
>> [    0.000000]  ? load_ucode_bsp+0x76/0x12e
>> [    0.000000]  ? secondary_startup_64+0xa4/0xb0
> 
> Silly question: can we delay the call to kernel_physical_mapping_init()
> to right before those variables are accessed by the guest for the first
> time, assuming we can allocate memory at that point?
> 


Those variables are accessed immediately by the tsc calibration code
path hence we will not able to delay the allocation. Before the above
patch series, kvmclock_init() and early tsc calibration was called a
bit late in setup_arch() hence it all worked fine.

-Brijesh
