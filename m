Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CEDC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C9320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HgARmtkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C9320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeIKACe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:02:34 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:59392
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbeIKACe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uycPB46MNyw/n+/CEBpB7zv7VOZU15zsccrZt1ElfhQ=;
 b=HgARmtkjqLRQzu7ZKn52qSj1ssIvqH7S56oydsnbQdJCpi5/a8hIKnuo6Kj7XVY8OL5T934o6L8ILI2iv920XyfZNs6J3hwK4zZfAInU9b7PRtDbKaCsy0vpKvsv643aSx3WpSo3Zq5hIfBJCD7ogpuLKCaigpIk77j2cIJxvAM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 19:07:01 +0000
Cc:     brijesh.singh@amd.com, linux-crypto@vger.kernel.org,
        thomas.lendacky@amd.com, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH crypto-2.6] crypto: ccp: add timeout support in the SEV
 command
To:     Borislav Petkov <bp@alien8.de>
References: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
 <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
 <20180904081151.GC32615@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e327fa7f-2d4d-2181-c3f4-607faf16c9b5@amd.com>
Date:   Mon, 10 Sep 2018 14:06:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904081151.GC32615@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d54cfff7-987f-482f-ab1a-08d6175096d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:+eTb7XcDKrKBfvT103wNmZNBZrk3QyxPa6F+ESA4/leY42vVzXh3SCAtt8IVrktpGdHiF48K4vY1nOzLxCN3iMYJM9sNAx2JgLzOfrqEYNW5lb7ioZ8xeto18jZcg00HVsLqLw/5Swc8/YH/aEL6zBkzRCTA+OV7I8EyBbQgc42LCXNY7xk/rbFGaOoayJvS1XNktf2+wLNaQXBKmY8UjyuzG4eENQkjYbAkNH2zA4P5hbublaNrteb0PdbGLXbE;25:EeLliV/ocrk+7yr5e7YxwscQjuXtiQ/stnbjbuaPoN/tN2MhKArhyctiCTeeMYfIClYuZVKimd9xYg2EMNceQOR3DJn2Twxv8ECdwP3xXb8zBGycf1OkJpx3vyBjw/WFT1YxEfDfBtdTVYAGNwAhHP2IiJ/ExZXwPgWVv9gX++qw2Mu9XJ7YSsQeZ0WkWFoeOK7xFLW6E15zMjUbg1NZwE2h/gNZwRZ3BfZLYI+5wNkrk2BCCDNUirBIE/nBa6QhrAd89YqCrP8SWlCpRxigHeeCms2+PnNokVxyCnSAcgmnBlro6RJDvIVPjf4cbAXu3ypPwpRbod7Y8ZxssS1wmA==;31:dup+ZneE+xOv2fsF87xa8oIkxA3s86Bk2WYAj6P60zcsln5x6RSE8aOnsEOCClkiQwQNpTOV5S3Z6a50hvJF5/prPxzj5W2G+VKLimqKOxB/gsRXABpi5AgJTmBgFdqfPay7Phf5eG8aOdSok5vZ93/+JIT6RLZmxsgXyDDvNScRQEbXOcFA6GUgkWYwbuvoE+V6VPuwJBJ5e02g5wqGqmbMxLQRarhAMjS79pgIiik=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:0QbghjosrFcE75/c+8BJFejcT8yekJ6v9USWPrjsIusu6xYaCrjl4UtKUbLwTG5iEn2OwRGo8skuXAV9CoeH8ZHPKpBkyZBynVaDVW1ImHO9CrrMVWSZ2WHl9NXIDgMKm78V8DgfUqxLdjJGTWJl8Z/xWrqZJU0KoTPUmd+W1HVy9Nx4GmpM/5L6r1pRKCyNswkS1gCBNjXrVvKir8hRSo0UWGxw/2GVyTXPGJoYZ3XeX4jkKvG+Su54zcH/zpEi3GQnL6hVOPpFekHZm5nFUjHeQWMG5dcaYaUI9qioWfcB0B/8zR/v3NCjziKSzNqCreENAqed/puPfO90JR/xOdCVNgM6FC8odyk6Ej4lOD4egW3++o2+PoT7CR8QsI+Zm9rdK/VV6qLU5g7e1y0X4bb8dljYGZgi+EJWUiCLY52JywdWtJwGhAMKSi7Sf2nq4+UR3iIufVWsU/yHlUAPfZjT7lsbWfiR21z6WrK/9diYSu2kYSnaM/SkW2V+rfnA;4:XaJx0075oweJX6aLmJeoTyAerYoUujpMBrL5NbzvuFG5hsZQzGEf9gghkz4qlL+Qfvnc+sxFSf8riq+Ze/j2kHvLsCMz+zBSdDJLBfWZzW8y6yH7EANSYytRKPMjIi2kA80lwIy0wWBUFaJ2WWacUnvmZ2CA9jIZ+FU67ABmCCv8mvjpCzMX7nmft2TBkNakrbzp1FUoRfu5C5bMrb7cQxheArI2BMdfbm6QjOuC9dLHHlBWwd4rE+RDmP5I/bwzNrcKIor/TDiYSgr4ccd+PQ==
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682E67EAB7B333E4B182B5FE5050@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(446003)(25786009)(81166006)(956004)(2616005)(8936002)(81156014)(476003)(7736002)(305945005)(65956001)(16576012)(316002)(66066001)(65806001)(36756003)(2906002)(6246003)(97736004)(31696002)(478600001)(44832011)(4326008)(11346002)(8676002)(64126003)(486006)(86362001)(50466002)(5660300001)(31686004)(53936002)(53546011)(67846002)(229853002)(2486003)(186003)(52116002)(16526019)(52146003)(23676004)(54906003)(58126008)(47776003)(76176011)(77096007)(26005)(68736007)(230700001)(105586002)(386003)(6916009)(106356001)(6666003)(65826007)(3846002)(6116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOmNSdnZzSDZtQjJZRmV6RVAzcEJXY1FZbHVD?=
 =?utf-8?B?ek5tYXB6SW1GVlo3eWFaZVhBQ0Y5c0xmRFFqeHIvaUVWWHFYNytPWHB0UnYy?=
 =?utf-8?B?cjhrRWdzeEdwVlltTyt0SXpYYTV3UjBGV1dtTGhMbjNpdlZpVWFvUnM0UHpE?=
 =?utf-8?B?bjJ5cG9Na2QrQzN3aktOU3A5YTZPWFZXRUFqSGFOWnE0bEg5bTZTM0ZYWFpS?=
 =?utf-8?B?YnVZbVF2U1pPaGc5N1lveVd1bC9zSFhNT2FvRlZvbFNDemg0NVVWR0UwMUVW?=
 =?utf-8?B?SEEwSnMvNnc2czNiS1BaMmp4K1NqOXVXOG52bHFJU0pDVDFZK3FhM1dXamR4?=
 =?utf-8?B?aHp6Nm9WS3ZYVE1BcTRRN0xxVlFtZDk3cVZmcXdKMWN3NG9QTHU5ZEtQMVFh?=
 =?utf-8?B?dU5zb2NKUk9za1RZbzQvTFhGUklzdU52RkV2dWJZeUV3Q0NQWG40ZnRheWpS?=
 =?utf-8?B?TWNIUTNaSUVNd1ZnVVNRV0tObWVBYjRqSlBXSS9QazlJam9BY2JNOE9qeXlE?=
 =?utf-8?B?Sys3SUZHaFpxNTZkNVRYWDArZzgyL2hQTnlEU2lKcUNzSjRDTXZ6QURKYzNY?=
 =?utf-8?B?R2tCbTU1NUcwN0lUY05ObHZ3UWNCSkxPRkZZWUpkTmxVaVZtOVRScTBLc1JE?=
 =?utf-8?B?bmdjMERHUjRBRmVHUS9UcEZpRk5wTlVJVkp4Q2QyWkpvZWt4MjhVSlZwT1VK?=
 =?utf-8?B?MElaeXM3aU9ZYUJzR1VGVjJqY0srejlwcUgvUG00NVRBMmlMa2dOUzgrUXI4?=
 =?utf-8?B?ZkpiUnYzNFJXR2kybExXWXlSRE8vMk9mZlJHYnlLNk9tdGJaY0xtODBUc0RB?=
 =?utf-8?B?bGVrN0FrQjk4TE1zUjl2T1pLQ21jZmJrYytOeDhEclEyODNrT1BTd2ZLRlRi?=
 =?utf-8?B?elRVQnBUY01ZM2dwelI1WENsckZjQkV5MUU2V204VWZmcEdHdjIrdzA4NVJh?=
 =?utf-8?B?MkszOGVXMWRIazYybmlJVnArRVp2YUQ4dXB3UlBZc1dFMTZHN2FaR1RVK0g0?=
 =?utf-8?B?UDc0Z1RBL0tsTkJzaGR4b3NPWHZobitZVFhzaC9EVEZhNHlhbEZjSjlLd3Ba?=
 =?utf-8?B?aVpyQThPWFE2eHBUSE5KbGdtTjR0OTZRNERqRm8yS3p0NFlPank2RUhIemRU?=
 =?utf-8?B?UVpYRU5GR1hSQXYrRkdkTG1EbmxNc2FvZ0RnQTROZWhLTk51eHhvaUtDVFVy?=
 =?utf-8?B?aUZpQk9VQjhOSldEY29FY3RueHFBcUJscG1TWjJ1c3Y4cjcyWTlnR0ZBNVlJ?=
 =?utf-8?B?YTRhc1JFYmM1N0tma2V4c3FLdFpCam5LTCs1amdscjFGTXhxNkUzdThJVXdx?=
 =?utf-8?B?OGhuWXdnT1RtYXBnVGFmQXpuZ3FMRTNGS3ljcVJRTUdPai94TGdablpjdktB?=
 =?utf-8?B?MXkyVk10TVdyc0lxVXprOHQ3SjkwWTRxYVcwQm9sUkRiRzB3VXk4TlZiK2VX?=
 =?utf-8?B?VmNSZjVXcG9XZkxFMHNmVmpTbTBCUDdRL0FFVEdSejZ0Yzg5RHNNdzZ0Zzht?=
 =?utf-8?B?Mjk4VkxNcWdlSUdpcml0OEwzdURXWCtOaHVyWWh3bUhBdXNhWnQrNmkzUFpE?=
 =?utf-8?B?OENuU1F6WVh1NEtOZGs3YWlPV245UWRRem5vWEpUK0pJZytURklDc01XNlcz?=
 =?utf-8?B?V1dLNUQyN3puWnVXUGpGZTlkcUNTZTR0azYzL2tPcExHeC9wcXNrNEJTbk4x?=
 =?utf-8?B?SUJNQkRLMHByc2hvbE9TTjZod0VCSGFUcHQzTEhaOCt3di93cGtiU3hGYzZr?=
 =?utf-8?B?N2tWOW82Z2UvTU16ME5SYmtMeEQwNy9SbGdNY2RuN3dIdFV3SjdGRjkybW9l?=
 =?utf-8?B?MFVvdHlEbk0xd3BxZWtQU1ZwL0F6YVlmUnlZV3YzY1l4LzZ4LytybFFHOHk4?=
 =?utf-8?B?eU9KVC9RQkkwQTNNNVRXcERsbVRBaS9PUW13Q2JOYjUrQXZiU09kYnFHRVBR?=
 =?utf-8?B?MDJnbUxnc0dWRkwxT05qa0RzWHpjYUlTd21YOHBSL1dLSlpEb1IyQ3RJWkIr?=
 =?utf-8?Q?SjFXGb?=
X-Microsoft-Antispam-Message-Info: luDzmn4CChqHlTByt1q3zsBzZaFQ9f5e5KpDtP5A0MbfiMFyVN3CqVB3R5y4gIL8vN3vdOjWHquJ7AKTTd3LtPB1bawBGkXD5fyQaoLCPtkufdosA1ccdB/TBFPpLrAll4Wx+JmmcTlw53KmTRwYc+8xck6cP9+FjBaysZt97CH4u83+p0JGfPExthywa00sG0yv597/1sZKBaC2OOVT7qeszTAmyO+UI+NIGtYSM3lmX9d4gNGJB0Alzl2jaW5M2V/GwWEy8A4NR9L39PfLNkbu9wLnwW/pqR++oksrOP3NfON6ojO0ORjux9ovMZT2SRtwkCQdjP+WLCkjXVE7YMLwSCQ4TR8PTfm9R65jIwQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:sGyP5POPR9kHsaQcBAdzvsyFCgrTqshHBGUdtRgawz4j/FjUsplpuCfDbwmS+QYruOBZvZpWOAIzzML/xccp7dxaZod7W6fkmmCYjeX1gokZmm38cgnJipBzrZMwrp2djtAYOK5vNl+fQmHOgSD9O5jkOs6hX0iLVoSpLZO8qXLB5KRhs3+aHC5l6XeGVYJogqGFkKls4DFS9Zgi4DddrzpzBWc3CrDY3Nh0aS2GNwsUZJ06LystXAnkqUcKFuEXikkzkSn2xNuqGeuYtGjcS7woYzvJ2ZOVlCpY1i68Eg50tvDMNfcUStdiV5B2tl6ShR87Q0w7WlWbgQ0jg3stTa2MUvpJMWsY6hxqUo8J8XAvBFRczgREcW4rf/aikWxjl0gxPrbqnCQDUzV0SIcQYLY71xmDIY+2zPEO/Kf4ev7fAIByzUeNV12BW95A6AGmuEjuYuEUBD49yik1SRbzLA==;5:PZ41VnpT77VzyGyuZzkG9xdDX8owyOMqBzIIRPWU/rwsyoaYPFM9Ggh6Jgqbk0mj1RD4rdyUtLL43g6nekrHJOzlZTx6cIR2i2P5Nf5iebv/R/BFSSVMlOhQ8JV8HTWoxZMkqJRyB8MmxFz7nxKVwCi3keZ5dvu29Y5VfGI1/e4=;7:XUBKi2cZnJY7aIroz/uhZcrSdvDpOH6RTVL5qusXjeE+cbg7sAxmltEcSXDTr2wvBJTBhAZSYzc5SC7S6Q5zIgoV6u1/vVzUI8UeOElkXLVrsYKz65gy6gJxYCvaUe+ECU/x9Qa3IL058FCMPrNL6uljJ8kOnELkJ7BNogfKrlwxM7AbThnCbo4SsULhLRu6CQIPdlsZ9u7GfEVfV7MHS+lBh6FSC5Z1vqTFdhWZlhOVymwkoA7TSpDxB0gn7zy3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:iGVZ2MoWXLjPQlO5Y8CaqIF+hKQfvpko2W/ELnfAIMuigIKajMTPhZfiJOTcEiNkb7C8Ki3WFTP8Uo6cvRjrSPul/dVXLPjr1m7MB2CbYQMWTNPC0/lqTs41Bmvw1AKAmiSeTu2Z9GfnNI86o/2sCF9ZraN5s42wnt0u/chhIS3dpYbPOvGgkAAk8Zfm0vx+MRO5gOxVOLItR/aLWsx/98ndYw42Ffe7qc8TiJHC2W8dnbMYyfZluGjQ0ksicyJe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 19:07:01.0322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54cfff7-987f-482f-ab1a-08d6175096d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 09/04/2018 03:11 AM, Borislav Petkov wrote:
...

>> +
>> +static int psp_probe_timeout = 5;
>> +module_param(psp_probe_timeout, int, 0644);
>> +MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during PSP device probe");
> 
> Just a question: what prevents the user from supplying non-sensical
> values here?
> 
> I think we should clamp them to only allowed values because I don't want
> to be debugging some strange bugs due to that.
> 

Nothing prevent user from supplying a bogus number. The main question
is, clamp with what number ?

IMO, if user is overriding the default timeout number then its possible
that user is dealing with a buggy firmware which does not work with
default timeout and silently clamping the value will not help them.


- Brijesh
