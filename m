Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 52169C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B4A208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RnhFLJVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B4A208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932900AbeFLShv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:37:51 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:9056
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932343AbeFLSht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYU6QO00974ATpkfDhnNxaStdMNWYwkU/9uxwK6EA6g=;
 b=RnhFLJVpB/+QpOE+1qAxp3AzTWIY62ejoo8TQuVpUIw/nXSpLne4mYm5VSe3K9i30EfFhUemQxc2iTkvn2uGAGobh+hdvGfkwBNUDh2dFCwGFYpTccFCaNB6QFBG0AqQk4MLMSot5+SiDrGfJAB/NQNZqPt6c43kkrUmx4NRjmI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.109.62] (165.204.78.1) by
 CY4PR12MB1447.namprd12.prod.outlook.com (2603:10b6:910:f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Tue, 12 Jun 2018 18:37:47 +0000
Subject: Re: [PATCH v8 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
To:     Greg KH <greg@kroah.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761820371.2654.4551405686504157036.stgit@sosgrh1.amd.com>
 <20180529183917.GA10618@kroah.com>
 <f0780139-5322-a028-0091-3255e0596eff@amd.com>
 <20180605170624.GB10834@kroah.com>
From:   Gary R Hook <gary.hook@amd.com>
Message-ID: <bd3d0561-3326-1468-a7c0-cee601c275a6@amd.com>
Date:   Tue, 12 Jun 2018 13:37:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605170624.GB10834@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:805:8e::38) To CY4PR12MB1447.namprd12.prod.outlook.com
 (2603:10b6:910:f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1447;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;3:zAUQFGCr7Fd8lwKpmbL9Knzhl1zx82RrRrjZYsaGgcy7sCdCO1tUofhXl6xoNkRfYcldYVnw/09hZ8j1Fe3Tnkqi24trTC94j5GwMobFX4vdLuUjSRmHsUv0zHN/GENQslYIICbdSQzL1xjp85Z/hFwTKoCeJQVDd9zWqV/eK0I/2tw0ZTuCCFJg7fkl7bBZSybeXkuNdysP2v9DtwHZ3yDj2RHxBc0bu/W1OamV1x3w6E+05BG4xuBDN6V2UDOi;25:5b1NCrwesPFGBFRNyeDVWa5gY8WEX6vEqeqITW84Dr/kdRFSZTs8zM35oyVbZGiawP+pUU1LON/tpwFhHc7UO7arpjtMazl0DDmV1wpbUgxykkZB1JkyWxnNYKv705Ha6WGFLLqrLxhSbWZuzdGS9P1MBI85F1Xx1oOwA5F6PkESMQe4/81GxANyFZLNHgMxQ/aShR3j7rnhz4a7ZvK06oF9YY0UCp7T6t5Ka6oi/5VansNnHSI0Qw6Vsc39DSdk/JKLv0nIhpKTImJTuQUTjdyXCiRdds1MvzcQkJAagOM2/eGoAlXvxW+YVMWxah207icFKw3hJr5brybgaLpAPA==;31:wgBsAi5Inx9jU724HSBTj5i3yIDMBQQSkdEb+M/yAJ1iWQUP+5b0HVhL9QR943XuM82HSmXKcnm63Ft8TwZ2/QOGIJP8f671CtI3d7u/isjDWX1DE0Ue5OdrPsltun8KkenHoo9HgHKr3G5jj0sliQzFa84xMiMMJiD3D+AlVQ9ep000UljzXVBAnBPXED+G2yBH21xbqq2qLTBg9cpHXcQhaUtjeVOqARqiqkRkbN4=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1447:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;20:7F5gIxT0KPMPli7WSxT+h7sv0NiwGr1e+2b70Z6LaFXkVpznV5eioSuig09WimXJqT+4KcLtJ6v8X2GgzXz3qlqTa1zeqb6sLN8/50aF/p15aSGYwvM1Rbgn2dAHJ/+5xK4aejm8ksjlIbHuGtzkRtxfRsZFvj59Q/PMbC1YH+GMAKldV3crC2OCLdzPlhi2d6WDsOxiN+KeFidQZN8A53GIDpYE7onV4L/wlxVIC1OrPazlmqkl3RJfh9xpcKJnHp6lCgHO0L/MjqVuclHAwZMwxFNcnHotDpF7wlt/lgiTaato4xCmoeQXEDd5HAyADuKJRglQ+hMz7jS5fPRx4pz5mHfWgZjdGQtL0g0RTmHmle6swnesE1jIZANEkVWBCdtloTU+F195CkjwBw3mLUmMw/Rfy9K5br6yFW0FN8XJ/sdcyG6+op7Y6lQVrLlBCjpuIPE0+6V7yFCWrqWVWiqthxoNw94PFiEeqI4dlP3ccp7i9V2UOFqp8Zwtm3Iy;4:BGq3e+lnV5RMqjys+jbBRfds4QgPoEIP+Tp31siEPKf3qvs4qWriXAecmV1DNHvFNL/h98EiDxsVI8y9sbFsB3MxZbitFAWS+UEVm/M8SSu/gqvBypZ6/DA4dh+WPVZoSW+a63x1hA5QtdsRpKZEp1udfXEjiNdtbsMTZfV1rZch7idBDXayIq0N93MFufDtN/TsrPmfjbVYUgvhn7nfPxXwql7j7uRQepshl5egL647VWzBYn4JmsnSBYe0AljzTn7eaMXFRUowZCMjIG6F4fBnktQ3bVRHjko5funRdHNIsZy25z8dK4gWKQmqcixs
X-Microsoft-Antispam-PRVS: <CY4PR12MB1447AC4227A14F59236A0A5CFD7F0@CY4PR12MB1447.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1447;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1447;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6486002)(6116002)(3846002)(229853002)(6916009)(486006)(476003)(64126003)(6666003)(478600001)(11346002)(446003)(230700001)(2616005)(72206003)(86362001)(31696002)(97736004)(8936002)(53936002)(956004)(81156014)(8676002)(81166006)(36756003)(4326008)(6246003)(50466002)(25786009)(47776003)(65806001)(65956001)(66066001)(67846002)(16526019)(26005)(106356001)(2906002)(68736007)(77096007)(16576012)(58126008)(93886005)(31686004)(52116002)(23676004)(2486003)(105586002)(52146003)(316002)(186003)(305945005)(386003)(53546011)(76176011)(65826007)(5660300001)(59450400001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1447;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ3OzIzOlR5RFZpVTRNSW9vT1Y0OGVwZ3kwdC9Fb3Vu?=
 =?utf-8?B?WGg2RlRRZ0c1Wmdkb3NqdUdkQ3FPendYZHpKb25zOXFXTm55OHJsRElUUHZj?=
 =?utf-8?B?MkticDZWdXJ6dEpiL3JnSVFUSGZXUzdhMWVXZU5COWIzYXB1bTQxZnZVSUc5?=
 =?utf-8?B?eEdiUzNnZTJxdlNWQjRHSm1vek5xUE9WcHV1YzVQa1N1akRHaG5sbDBsOFBs?=
 =?utf-8?B?UStkVEY0Vm1weDZpWFFiV1hCM2JPQ0xlczk2azFZMmYwS3UzenZnbTI1UkVH?=
 =?utf-8?B?S3dHTVlkOGtBa2l4TVNTcy9lc0hIcFdKQUI2U1MxQmFkZG9aVVpkWXVHSmNl?=
 =?utf-8?B?QTQ1aENnZU5WSlc4L0tjc2hESGlkeFp1WmY5VFVCam9sMEhDejBtKzhMS0xh?=
 =?utf-8?B?OFNtV3FmZlVTQ3k4Q2FpWEJNaXBiL1lvZWxOcE5LODYzRXJaYnhVOTZibllh?=
 =?utf-8?B?WG54c0V2M3IrNE5Wblg1T2h5ZFNxNmN4M2U1azRFZ1ZjRDF2aXZ5a0F3WG1z?=
 =?utf-8?B?a2EzMlIvQkYwM3lHZFJpeC96VFMzVDZOVnBaV3lMNzZDYm9nYXc4bXVMNzdT?=
 =?utf-8?B?cUMvZGVVbGxjZnNCWURDUVRJSkIvbjl4emxZUnppVVM5UHVvdXhMV0Y1T2Na?=
 =?utf-8?B?dldKUHBZQUpHdjUvbWk5UWlaR0ZudFBZd2lqUUd5ekVsSCttOTdjVWdMQTFr?=
 =?utf-8?B?SDhhZ1pJQzFRTUZXd3NLMGxLcVBZM25nc3ArZVI2aml6a1ZjMDA0elcwcWJr?=
 =?utf-8?B?bkU5dm90TC9BcXh2R3hMa2dpWFcrNFhUcXM5ck5IczZmUFRFOW1jSitUVkQw?=
 =?utf-8?B?WU9VTXF6YmsyUThGTXJMMjFrbTVneVgyTkVzREhqVXplbzI3MEtlZTR0eHhP?=
 =?utf-8?B?bGRwNnVKU1ZBV2xuc1RNVHdreGN3NXJHYlJjZm04UU5NMTZMeW1ISVBhMG9M?=
 =?utf-8?B?T1YxSWI4a2Q3NGQyNWlvZzQvc0p4VjhaNFg1Q3FuQUlFNDlRdkczVFFIcyti?=
 =?utf-8?B?R1RFTVowbGhOblZ5Q3ZvYm44cHl3Mk9zQnF3WWZCSGdHOUU1MzVSZmhZS0RJ?=
 =?utf-8?B?K2FxeDlIeTJlSVdjbXhVRWhxZFdmTzlleTBIM3RQRk9tTWxsalVHRjhjRUtu?=
 =?utf-8?B?TmFER09SclZzTWlNV2YzMVJBbnozQVBaVkhOUjZNTlhUWHV1eFptVUMraDRR?=
 =?utf-8?B?UGFjeEh0UHkyM0M5NVQreDExeTZ5V214NEt0dERIYW05U3o2UDBQMzVGMnM2?=
 =?utf-8?B?Zm5nVGVTNDV2MjIxamtrMGppUW96M09rQWgrWmprSysvQWVqL2wxdjhiNXoy?=
 =?utf-8?B?dXNBTTdHMjh6TzZKdGorWmI3UG1NZk82Z3g2bGFUN1N3ZDJJTmRvUWZFM3VM?=
 =?utf-8?B?MGFqR05mNUk1dFZDaDZLYmR6SHFOTkt5VkNaQlM2ZEJOMUNWMkt1Sng3dnpj?=
 =?utf-8?B?OG4zQ0lyVnF4aVZSMzY2S2pYcDNzUklIYW4zS2R5N0JiS0RHS2FJMTFqQ2FX?=
 =?utf-8?B?bkljaEJWU0tLNU4xc2s3SmlhSUJ1RG1WWWN2dk9CMFZuU2NsNWJldUE5aGFs?=
 =?utf-8?B?dVE1QnpEVVFBdlV1dFZaN3dVQjUzcFVkK3ZEUWZsdmFKQU9vN1oxZlVOZE5i?=
 =?utf-8?B?clJHcHVGMFo5N1ljMWZPRDBsS3pPRXlTUkVXeHk4NDRPcTBTbHBGdzlOd3lp?=
 =?utf-8?B?eWpoNXZiOExsTUFWQkpnKzVweDNhdmdkUFNURVJqd3UwZ0JKUG1DMUlSa0dt?=
 =?utf-8?B?dHhiSklQUnF2QUhkd0pkRW5YcUpMTU5Wdm5vUkREUk1jMW42V0NrbXYrYm51?=
 =?utf-8?B?eEhFSkZ6YWo3bzl4bmVWRnV0dHREaXc5VXVoSFdzbmw3TXRTcGxtZHd1QnFs?=
 =?utf-8?B?OFN1T3JlYktjb1ZoSjBPNTNQSWN4ZWZvelh6L3I2TDBSZmRZZG9yOUdzZ3E1?=
 =?utf-8?B?cWlJdnN6WHdYbktiRFFPUWk0QXRzMXgrV3JNU2pnOGFQb1FRVmlQREg1KzRa?=
 =?utf-8?B?aE1KY3AyMjMwRkFVK3FnN2J1MEtyaHBTVUQrM2JmVStpVmFrWG8yMGM0bDcr?=
 =?utf-8?Q?Rl10=3D?=
X-Microsoft-Antispam-Message-Info: fORM70Ek+nNmY2HmpvMpductwMHn4HMzRPPlTWiiY1niBbappRBaDO7rjOcIN6cHwlx1XQwdFvVYMSnV+nEhxxzzi/OlZ79qRMprDc1VxXTNw5eFzm+9AiuC3nnPBq9VtSGpjLBZBawLgbWPz4Qafedcc885yojL7CdQnT5M6U9dZXj6SSpmniKOw7RrwIK5
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;6:mC70vHr1V3ik9tos9dp8+ukyMgN1q7XKnnPhQ0oe/yYQONSP5onBEQCJ6GXO24vAoiW6XdavZXrKQZPWpGNiF68K9763DO8XVZSmvsJoLSAq7beoYSs0vx6i+IgFabs7q3yQPLXfRQy/24EcMoTwocIhlnRteyE9EvManETyugHk7RPrqcmQTlfidSr2SZ7LRLvUYeNXOX1LjlOhSQVCc5xG+jFc7sOA6C/EFtcpRrnOZ4hiIck2rDE7b+vsdsUuoyx0pbpTl3TuQlC2hcLoeGzbaJz36HLz7MamBUM8zR3Qm99ayLRAXGKxEvhvReH2BldzGXJ6/OhV1Wj+a+/UJ1A8FzrWviWxEA2ANnPbQxfP5qxXJvujc0e8jmQAJwZ5o5xRGuOVbNw24kZ4aK/2005ng29WLG1f6l/eAmKoqMYq/rSZE5TCwum3W9E6gpCpqHSBB89eF7T4yxH0FuV4TQ==;5:sGw/MROB60ok1qTq1Jsy2BT4Kd/jSR/b8lR49UhZX4PVQWrtnL9qXfoho2YVIjRcSmVHinU/U/DzKAKPFA67p3GoSnoPJVyJgFjGCtCzGb6uR9VTW1T4ozElKJyHMokGLFYq0cKQOuokF01OjTP5NTvfNNvQxc9vJL3MHoilyuQ=;24:ugX6AXQUoW3h91iKvBK2IOfKjkL75Mb6yg1uhA0Fx725cWXA53Nkb9Z88Q0y15S7WV6B2AYk1WjPi1bY2llhfJa4WnpvVgHkNArEqYlUe1c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1447;7:daF6Lan+wuDJBajaAACn6G6wB1yq7oEk6h0/UHfcf95tr1LHRkdiccj3RyAgcZjFaVscrtahfVd5kTDpH5SedT4Tscf3LgALVz2cYkFlDO3o6kX22IyyYUsMHxMcZS0a7GwW1aubl9NyVPFBl4Pc0T8ii+S5j0Me9wAQ9K1W9QSNEERcoXQxiRzO/Hy7dEMNtm5sLpKpvlN80irQkXb86omI2h2DTHM3pYF/xEZJ6QpYi9kwokTuZWa+WCN9wlQr;20:GK57I3TAVluOpKaq3zdhAFNCDgZqludql+PHQNYP2v2eKLNyCMOJ/6r/qaLRecdvLmkMbVGMGkI2dUHMa+X/HPmrOn77rwRCbZXzzE4ifvL86aVBmWGscvhG+lGcRuLej6WfpMpI0WV12Qp1AGOcWfwKHlzc4IzC8QMFRyrYetx/7U9tXOaR22z/VnDeURWc6Sql5Jz75fNfelYv9BhkJZy6hmiP8/klBL+FzR3mVII9lI2IlqEU/EpCI3l4F40l
X-MS-Office365-Filtering-Correlation-Id: 6a5887c2-196d-42a9-807a-08d5d0939827
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 18:37:47.1506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5887c2-196d-42a9-807a-08d5d0939827
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 12:06 PM, Greg KH wrote:
> On Tue, Jun 05, 2018 at 11:58:13AM -0500, Gary R Hook wrote:
>> On 05/29/2018 01:39 PM, Greg KH wrote:
>>> On Tue, May 29, 2018 at 01:23:23PM -0500, Gary R Hook wrote:
>>>> Implement a skeleton framework for debugfs support in the
>>>> AMD IOMMU. Add a hidden boolean to Kconfig that is defined
>>>> for the AMD IOMMU when general IOMMY DebugFS support is
>>>> enabled.
>>>>
>>>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>>>> ---
>>>>    drivers/iommu/Kconfig             |    4 ++++
>>>>    drivers/iommu/Makefile            |    1 +
>>>>    drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>>>>    drivers/iommu/amd_iommu_init.c    |    6 ++++--
>>>>    drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>>>>    drivers/iommu/amd_iommu_types.h   |    5 +++++
>>>>    6 files changed, 59 insertions(+), 2 deletions(-)
>>>>    create mode 100644 drivers/iommu/amd_iommu_debugfs.c
>>>>
>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>> index f9af25ac409f..ec223f6f4ad4 100644
>>>> --- a/drivers/iommu/Kconfig
>>>> +++ b/drivers/iommu/Kconfig
>>>> @@ -137,6 +137,10 @@ config AMD_IOMMU
>>>>    	  your BIOS for an option to enable it or if you have an IVRS ACPI
>>>>    	  table.
>>>> +config AMD_IOMMU_DEBUGFS
>>>> +	def_bool y
>>>
>>> Why default y?  Can you not boot a box without this?  If not, it should
>>> not be Y.
>>
>> Again, apologies for not seeing this sooner.
>>
>> Yes, the system can boot without this. The idea of a hidden option was
>> surfaced by Robin, and after my first approach was shot down, I tried this.
>>
>> Logic: If the over-arching IOMMU debugfs option is enabled, then
>> AMD_IOMMU_DEBUGFS gets defined, and AMD IOMMU code gets included.
>>
>> This issue was discussed a few weeks ago. No single approach appears to
>> satisfy everyone. I like this because it depends upon one switch: Do you
>> want DebugFS support enabled in the IOMMU driver, period? Vendor-specific
>> code can then choose to implement support or not, and a builder doesn't have
>> to worry about enabling/disabling multiple Kconfig options.
>>
>> At least, that was my line of reasoning.
>>
>> I'm not married to any approach, and I don't find clever use of Kconfig
>> options too terribly challenging. And I'm not defending, I'm just
>> explaining.
> 
> The issue is, no one sets Kconfig options except a very tiny subset of
> kernel developers.  Distros allways enable everything, as they have to
> do that.
> 
> If you are creating something here that is so dangerous that you spam
> the kernel log with big warning messages, you should not be making it
> easy to enable, let alone be enabled by default :)

Okay, I get that. Totally understand.

> Just make it an option, have it rely on the kernel debugging option, and
> say "DO NOT ENABLE THIS UNLESS YOU REALLY REALLY REALLY KNOW WHAT YOU
> ARE DOING!"

Nah, Randy voted for separate options per device, on top of the IOMMU 
option. So I'll go with that. With loud messages, of course.
