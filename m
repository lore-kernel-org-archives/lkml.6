Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED484C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AB720852
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0YWMvdTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AB720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeHVXli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:41:38 -0400
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:48352
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbeHVXlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjVl6/+/JFZTbmwev15qfXri00JmCq72yUpxxqWBHyc=;
 b=0YWMvdTYQ1kOALP51UT5yBOTu5UUc6Z/GN57J3Ghwwax72vSJN8beWRseUbSy68aJIIlJ6Mk+bzlx0yoH9J0K+84dzSLsJ5OWH6XMluaeStDzqnKaC8H2crEoLWCG45AkCbSVWfSBdrIVIGa2+N8dVwYTMGoY2bHFafd0iuQctM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BN7PR12MB2673.namprd12.prod.outlook.com (2603:10b6:408:29::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Wed, 22 Aug 2018 20:11:23 +0000
Cc:     brijesh.singh@amd.com, Paolo Bonzini <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
 <20180821083911.GF24940@nazgul.tnic>
 <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
 <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic> <20180822150033.GA14200@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4d6ee892-a34f-28b3-18b7-1c663eb281c6@amd.com>
Date:   Wed, 22 Aug 2018 15:11:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822150033.GA14200@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) To BN7PR12MB2673.namprd12.prod.outlook.com
 (2603:10b6:408:29::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317cde58-3e10-4016-7963-08d6086b6f35
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2673;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;3:6SgWYJ88S4P+WlSzfzTEtE5E0lScaixQDchOeNhGhc+q58Za0Oog2yrfs43E12oFhjHvEPt7L97sAZ2X7Vv255b4OpyLlnkwpbtemrFpKr4vVKFGxHqTaJSekxJFpl1+vM8st1nfBFcV9hVglOvAcGGd16Qj4m9Lpj1juJ4Q8fyhSPTlTcoYTOpiU86nUdYLvgL42dZFNyz3/KwA9EJkCAghbsH7ae8yZuUzaWPpgI2n1jFrXPz3yaeuoZotUlgX;25:SY7ZWw/I1XjGi4+E1I4c2+ZIm6hM/5BW0Mtildjt1UWBUVOSObfjVtTA3CuAQbUYTghzQZJ2bZrWDASbKXZBljewJVrxrbnmq44Bnru6z29A6ACQXXAxeCZsWJaFiwEbK18xyS7KcghWKgy9z4Q6ipg+TLiD7TWUCnoNvbEb4wZX9XSgdLyeVafeW6e38GcIbN1wzRmkbmKWHGmTgYvP1oTTczbNxsgsi826SDVFyFVjy77VGHBcc2qJTUsTqEFQcNMdg9PLWXNB8UwLKAFuK0WEOm+pwrYdNXojZ26XZkQe7vFBa9r1BmV+GPzhMKG36uxX0Yg35hcHPRBnOcuUHg==;31:1u5gmvVouAzYxwLN6MUH2RaQHWUmqHgq7QFYJvG2nfkC89qpbDSeWZUY8BQgMmOadUsqpnSDQXMg0/yotQIYml8ktyyq+9GHs7hIN7L2qRFSSHQaHDUQKVdmMU8Fca0xxhuiGRnaYVS0mXWu6dmQogPeycqqjf5Tmb9ODJ+XesrkeDLn0AGSHFlffC7uCwT9h1+wix+oZhYvhUebKEwrmmUD3G8flRXu0YUuw/3/iKY=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2673:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;20:VjRjYqWgM8H3rqL+VbWtBQ/EOowg793wg9t1naHRz/5vGQDH3A3ngoKdSpULwRUkryszaXK9WcxNCyYrwZUsFB3k0QHjoJOlevrKEHQilhCvrw2WBt0mTlASfkMCnr8N2T8RthxDOrLEx3ns3EUveHFmmn5CR0xT9j8V490JMni8h1eOjOcdeekOLOoaxgW2EovDyyznTnzb7g1owcQlvYZZI5n6EXB/gEU6TIqr5GMZ6ThUfHeP93tC4FZjWHONkfSbKDbndSm6grtjHuth5oQtn5LXUfJvzsPfBwkOdE8m17M2a1AgauFVGrruZZdBoxK19wjwHh08H+h0MiFRJogeFu03+muAztZfyQRW5PxXT50QS+NwN7m7kciRzyr4PcLmWlqzGA0HDvD0a4aHZmDIeNCyh+d5VAx3s6O6qIWfxjGlOugPi9wzMK3IhU6xTNtKpBBWxFHpTNGMuxx9u0fMzhelBwPS7SGmGkNYdoHSLJdHDuzqj98SLAHCKixc;4:UqGAuYIbiJubn+FqfwUK/+1oLvwVXybQxQP8RUB0piiFYBFxg+7ABinPDKUNyxOR0YA9fpnCcz1wQ9xW+jlbeFOg1QsfVyUKwqP7dbyghTgZrsnz0bMECyrpCAqTbMX8/MTN07dtDUhlFOwdrhJeIvDlxU0LQJ9vsJBkY3Ca/crG+cALbarhXxfD8GVSfV/mFubBcW7f1YcN0wQYf8vgLsIAie0rleODAke8C9tbADVlH1QjHcxFDAgIPhxr5UlW5z8qdjIKyTjXGyo/vqv6NQ==
X-Microsoft-Antispam-PRVS: <BN7PR12MB26731D923C215BDD99A8E5DBE5300@BN7PR12MB2673.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BN7PR12MB2673;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2673;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(2616005)(31696002)(4326008)(77096007)(68736007)(44832011)(476003)(86362001)(53936002)(8676002)(16576012)(26005)(11346002)(6486002)(67846002)(956004)(53546011)(106356001)(2870700001)(229853002)(446003)(316002)(105586002)(31686004)(386003)(6246003)(6116002)(93886005)(2906002)(3846002)(65806001)(58126008)(110136005)(16526019)(25786009)(52116002)(65826007)(5660300001)(305945005)(486006)(76176011)(47776003)(65956001)(7736002)(81156014)(8936002)(64126003)(186003)(36756003)(66066001)(2486003)(50466002)(23676004)(52146003)(81166006)(478600001)(54906003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2673;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjczOzIzOnR4eGtVUUtkQjltWlFPWkNOdmd2bTVKL2tn?=
 =?utf-8?B?MjVzdXpIOGtkckNjOEZRTDBkRHhSV3YxOXNDaDZPQ0dPam8vZXRFV3IxTHRj?=
 =?utf-8?B?TC9iS1NUT1VaUU9aZ2Y3UmhtYk9LaklvbUdJWmJTVEx2emlmSjFXNnBjcE0y?=
 =?utf-8?B?enExaWkvdXptaFlkOTkwUHBkUjdobDlFcGx4MzZYWndxZ1o2LzlEZUN1bHp4?=
 =?utf-8?B?WFc5V04wOWdFSG9YSEQwY0tvRmFSc1BveFU3Q1ZrclM5TW8xbmh5WVBHRHFC?=
 =?utf-8?B?eGVwVlBYUDBjVmxaemNtZnM5ZFF0bjM1L0syK3IwbTRVREE2TXoxcmZ4Q1hV?=
 =?utf-8?B?NCtOUmFiM1F5aU5VMGVrd0VKTXY0MXBjbXZJQU1OVkFPQ0E2UWQ5dTJOS3lL?=
 =?utf-8?B?Y0lucUtYL0FIbGVTK0QxTDBwZWNrZU1LVWxmMGdBNEU5WjdqYktuTGVRU1pa?=
 =?utf-8?B?SzFFWjBHN1NmT2NERmY4bUdVcG1UcUdtWEh2WnA1eGhadVpZWUV2M2VSM1dY?=
 =?utf-8?B?NUhOb0djMXNFbis1Tzdkc3NvejN6Y0dEVi8zWkV6aU9iL2o3TWxjWjNzc1Bt?=
 =?utf-8?B?WlV2ZkJTTWd0Y0YzazdQeUtWRzFRY0N3bDFxSWJTUWR3K0RFNjl1M21EL2Jh?=
 =?utf-8?B?eGdjSThVb0ZlcURYMmlvaWRFemNHakhFVmF3V01ZN0Y2ckpnRVpPUGlWVW9P?=
 =?utf-8?B?bFg2QVdWeE5ZdXBZcnpJTHV5amY3K2o3QnB6TE9EK0czMlYwTStYdG9FY2xF?=
 =?utf-8?B?UDBFZkdJallaK1RYczJyQXVtOTlWb1ovOXNJdE5ZQzlJaGdyV0o1OFNlblJG?=
 =?utf-8?B?UFFxNGxieW5xUnFsU0lPQ2xjVCtTZTdDSDREc3ZwQmEwbkk5YVNzS2hEOFd3?=
 =?utf-8?B?bkROQmpaRzllS1RqVXVja09vMWVnVGhhRExPaVI2bk1FY2ZaUnlLQmNrTEpI?=
 =?utf-8?B?SE5VMUQ0ZC9ZOXFGRTgzc1pHMmhna3BrazNhWm1RWG5kSjB2U05ZYnBDNjFr?=
 =?utf-8?B?b3lxT0t1UTNrdGFmOU9XSWNiaGZrbVhlYWtVSEptT3dObVRORVNuV0NORVhu?=
 =?utf-8?B?aHM5U3IvcU9LMVVMbVo5Sk95QmpacnNSaFE0eDRvRkMzTFdhWG9RUmQ1UVls?=
 =?utf-8?B?dnpiZlRyME5rcTNEMEo1a21TK2xCdCtpaEIyN29oc0xqOVhhbTkwOWp5Q3VT?=
 =?utf-8?B?Y01uT2REY3dQaFZWMXpQVWl2eVBWNmNYN0lCVjJwSzFJc0RpaGg5MHZyMmtt?=
 =?utf-8?B?S2hqVS83ZUJFUFYyQXU0MGhYZ1BBbFg1L1g2czhFUDFVWlJjdndKZTJNSUxx?=
 =?utf-8?B?S211d3BiUC9OY3hzZ0MzU3daQWk5YVhBMmlXU3NMdzk0NlpZT0pacHFvVndo?=
 =?utf-8?B?d281M3Z5MVZJa2cwYkpaVHp6YXY3UG1ILzYyM1AwaHpUb0ZTU1hrREJFam1p?=
 =?utf-8?B?QzQ5K3RpcUlZd3RJYnkxcXdWODBXRFp2NUplZUc2TTgwWmhBK2VLTndUR2pv?=
 =?utf-8?B?L1NRL3BEeWVzQWNrVVFhS0d6RTNqZ3dsa3RaN21ha0NmbzU0ODNUQkgva0Ir?=
 =?utf-8?B?aWlIenpUNFR3M0ROT0NqMnh5SFZoYjVOaWhhemFPNW43QnFyZDM0dTJBRm9i?=
 =?utf-8?B?YnAveU1QU0xPaE5xbjJwMkRnU0NYOFVpdzRnVDZ2bThXUG5hTFFEYm1pTVB6?=
 =?utf-8?B?d2s1V0pkNnNxNU1nTzZrNldjWm1Fd2c5ZjhobDFOaEh0WEJwRmlQSU9tTUYw?=
 =?utf-8?B?VkFsYnB3OTFhY1Vzb0lpZ1NkNUJFRzdWVS9DSmVJZzhGR2ZlajdnR0pCeWtK?=
 =?utf-8?B?YlYrNUNXTlBGeTAzaUp1alFXamdHUDRIU05GcU1lbnp5VEliOUlEbkl5Z1pN?=
 =?utf-8?B?SHhMT1J5MUdhYjVMNTNDNURpVWlLaTdobWRDekgvTWxRdlQ5UW9mQzBNbHM1?=
 =?utf-8?B?S2cwTFpRck1wVGp1QU40Yng4TU5vVDRwY0VMZUF1TWE1bFZhMzlPRnBzVngr?=
 =?utf-8?Q?r+8bCc?=
X-Microsoft-Antispam-Message-Info: O78bxEd3rq9i5I00kvBhy2Y6aMU7Ez2yRApkjnhj79JmIzgYDYrJvyOTxf60zujxguyaNOi7jAAF9LQyk6w96sOdWT5zsex9OzpXO30G3lvyN9SkobY67fUx0L5zo3bUyBW0iauQVwZnKqwQoN5Hnzkto+omq8LE41Uy/Dw6VX7NEbGTo/0snNGTw+Ec/adTpgtRCMmtDv8/c5mszkF7OlPXRjziDl9yd9M4wUh/lHsbXcmQJthL2LbKvIfuc+TsmPNJv66lUicRwyEzv8/28UQuiQ9zbfxkU8PSmNZaPeeptX4Iu7oKO6nIdfHCssjR3fo4E8+AWRArPHdVQtKFTPPHFwhk/J8wdqj+vAFnHfU=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;6:B5naNXwwJgxSYatjPJpwm5rmZ+j3zGW1IeN9eS38H5kwPXpM4t7ExcsYQ9UFbkfeJsDYjwNkwWZUUzXZX7hS60f1tSa+7153PlhdExfLmq4MQqUQxLtG0gYBISx9Q2yfn9KzxNiZhy24IdrnYOMYzxzcgyyRiGxlQ8LoxwqZqxyaCeAJ7c0w2wyKiJhKAJOaM+nfIqoBbY8pBll+ZwEwD0kqfiwgjQ3moXCeM5RuAXWkXYZxMboD3QZlRqC5SHWT9iVWRFj+Y7xJ9L8agE7YWnGtmYF5TBatYVBebUaq1gxOt9DcH5brq3Fs3xsnXsQS0eoBdmgAyhfGb28t5MQwk23gTLAFCtSOpSbU7+m355rggaKmsVFZbxctFrf5cB6Q8iGq/6eBqKQ9gmdSAjT6eM1e4Kbf8kCoC5iKKFMf+H5Sdc5j8C6+z1fHJou+FYObP/sXW7CuwTnpa3E8neBLwg==;5:669ehQRHYKf0uGdRra/y3jKD4amoGN1g51MahterkoPRZUGauE/sqFz2Jc5hN8BDuDkCeZOlANS0+X8f/44FF6DIv2hX+gYB7bjplzFdzjtXDAYhteLf/K9g9mDTAg/TZ0q23l7Z7qg/4RaKSp1U9xO0+dYdpycStSAojg13zWw=;7:9vECeGPXeH9j5B5XpK+6wu/nMU4Tt7x0cgDUZR9MEbVFao3PBkdt78K1iDv8m1aDDRRJLbrfXFJah+AYoSRnfK/ut0Z9hN85S7yMNRvZ6g/0c49nH3ELqe6RHHD+OlQs8V6QyDUy2+uIN5VIxvnJzIcktrQtZmt17toK8GL9aGQfA53PE51iPVJMzerZjLwUZPDWQdOfqog1la3GWtpihXc1GODo1D7PpLTt+F37mfbtiB+Fp3kX4+Y+fZgzS92j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2673;20:Qb+5x1Bq7cXH4SyKl4Ygm+WBjookQOAymr3xQgGu/a7tUVEJIAtN8Ev3zAv68MMzy4J38BAbRkq1E1AA3LvczULq22doPqqd/qL3WYmnLp2uLOwTiYvFW8gkEbpqmgulkWBiz191/VW4EzLrqjR5zif1yqimvgjwm5/rtByEx9aUgqyujx9+ZL1bRGLWpQc2Q2wkj3wIo6jf12kT4IQHarYBDsTXvJyrsI7k1e7uRj8R1QlLoOQmQfzXEkTZ1mWX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 20:11:23.3767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317cde58-3e10-4016-7963-08d6086b6f35
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,


On 08/22/2018 10:00 AM, Sean Christopherson wrote:
> On Wed, Aug 22, 2018 at 10:14:17AM +0200, Borislav Petkov wrote:
>> Dropping Pavel as it bounces.
>>
>> On Tue, Aug 21, 2018 at 11:07:38AM -0500, Brijesh Singh wrote:
>>> The tsc_early_init() is called before setup_arch() -> init_mem_mapping.
>>
>> Ok, I see it, thanks for explaining.
>>
>> So back to your original ideas - I'm wondering whether we should define
>> a chunk of memory which the hypervisor and guest can share and thus
>> communicate over... Something ala SEV-ES also with strictly defined
>> layout and put all those variables there. And then the guest can map
>> decrypted.
> 
> What about creating a data section specifically for shared memory?
> The section would be PMD aligned and sized so that it could be mapped
> appropriately without having to fracture the page.  Then define a
> macro to easily declare data in the new section, a la __read_mostly.
>   

Yes, this is one of approach I have in mind. It will avoid splitting
the larger pages; I am thinking that early in boot code we can lookup
for this special section and decrypt it in-place and probably maps with
C=0. Only downside, it will increase data section footprint a bit
because we need to align this section to PM_SIZE.



>> There might be something similar though, I dunno.

>>
>> Maybe Paolo has a better idea...
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
>> -- 
