Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2B154C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02D4208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ez7yWQi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02D4208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934179AbeFLOic (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:38:32 -0400
Received: from mail-eopbgr720089.outbound.protection.outlook.com ([40.107.72.89]:19376
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932905AbeFLOi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asPC7Ug+PW4taDCn8mVYzWwzKA0g1/F9KnyyhcwXNig=;
 b=ez7yWQi0TTzpYeNFzgfS5kOyG93spmVi5PLSEiuR4BDPkSxCqI4uV8Py3keKUcCqYjjWwXDLLwZo4r5jRuOQRyXyxupAoRj4c11CS4l+JnoI75cQS3TxN2pIjY7iHRtTP0ORt0K0jXoUiIhBU7nd3SzTmAzHeOZCUZ2gsIVVyiE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 DM2PR12MB0169.namprd12.prod.outlook.com (2a01:111:e400:50ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Tue, 12 Jun
 2018 14:38:23 +0000
Subject: Re: [PATCH v1 3/3] x86/bugs: Switch the selection of mitigation from
 CPU vendor to CPU features
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
 <20180601145921.9500-4-konrad.wilk@oracle.com>
 <2a3e0323-7086-f764-1a3b-7ce4891e8784@amd.com>
 <20180611140116.GA26199@char.us.oracle.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <5090fe69-61fd-99cb-f9d0-908cd6250d25@amd.com>
Date:   Tue, 12 Jun 2018 09:38:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611140116.GA26199@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To DM2PR12MB0169.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0169;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;3:Y8Efyrt1+wLH5RozEgMov0uZUd8iRINWUipAgalQr5O8wbBh/+7kn7xcMBpBVNgYppxTK8K8SZFT1dhzWoFlwS7f9Yw02eC4BQZ35byqJlC+p+XpD8Dkmno9n5VI15j+Crx4clb+KUReb+d6YTCiWEbdyAqgdF+KaiU4l9K2VZJgFIiYKyi2Y+vtF+zYyjKnWHovW4m4pEFEA80jIAjlcWn7CP4dnRl6bEHbdOSzXoyZITxpMKvFUCHEmyj1mY8g;25:eLb313msLY0xyxZwO/uEfppCLViMsTrG2cXUDjU+RACaby6v6qSDDoXA9TRkmDl+EDEHOBry8qmwpOB56rCQxZXcUg1z17E5TiFIXio4RZ94fj+wqePPPt0rTjGIe9aAWeTRVdS2Mo8xWxOJxwCnA3dsFfuIvy7w7k+oWNnp2tarDHiVYmARLpdgkXxe7+owOs0q+a6CZRYKfFMN5Aph9jPSHE4BQUyzxDlCc4ZrxSYCJ4CdtPkGBnswV3yx4q6K0f495lEwI5ZkJvMMzTuu49gDCaEmhA/Bkkm3gGFBbhQ5VvhZGx1ejNojVhDHMNd6kdcUNbpj4lwyHdSpreIwgA==;31:A5XOc6WwFNETUsLJJMILx9q/s5tqfR+mrIUNSD2sLqgUC1JGS4EQqFtxrDt8KVFRC+NgsC+YnolkuEjsJMRvXpoUiNCq5ID4+JT7ZhYbdo4QITIDb/TiGmCozoSuOt9hhjsd2qIyFgMJZ6QOssQ4PGc6nlgIvhSIXXlz14GgZOzpuMz7dTLamLtt4IGKvwC6GOEZP6DDnHG6BmwKcwk9q0TBnz2u+XjbUvBI4U2qk+E=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0169:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;20:x6UoO2a6HtOhuTgWWTQqvu/csc7tvtOBeX3NRNLdwt442ns+YVc7X3yYroNrpsuNtsMXfZ/s8RPJrYs/SaCoA5p1wOp3+pZZnP5vf5Zxrl5qCJ1+rUSCUJD1RH0dMorVQdKkchECZDMlmR6YLDT7nCYZ9yGZbj6k6IInVmdytLqPJ5om8yup9lTsSDmDwPs4vYT6z5GkBRmVI96+YDjb63ajDmQUAW+ULOQrMBipE8QrlMoaF8ENBSQpmAw/ORDAIjA5XbfxcY7+26wEli8LrJ71AAxYrP2Og2RleTW3sierTIr+7etoJaQAc4qK9nlqZrL/tVIhbwTbd+6zKVbHbJwLOMT6Eox4FQG2B4YNowCtPuNkdXNpuZ0YeDXNjjunf7PdS7M5uquEoTYSPIQ/6zu8St+rOxbQmGhxvHI7Hex47oAax+1M6REH8Dkg7DLbLeY3zTw3o37lYAIBGaM1fs+H/2fTt/1bVr1hiC+HZVRYGFwZZcH/Kgx3HRxVKUXL;4:JMgvzSvNSd6K2U2tqPrLYq2d1iMdb6zOjRWtKjR8TovnWEaE+N9X4rCtO95I6feYaj76wK/Mw+mDzeIa0ls+4ahEEmQ/2lZdh40QnU2QA0dzmjYg6Vy0OIvEG5I1F7A3owg8sHNgiGBddaq85qyvuREPYaQfYX1+sATgSAwOqY6j2FY9iGMIq/Ho6OZ3dLIyiM2ynDiagBqGhtJ2W8JcXeR+we/4kQPpf+Fm9w6T5OzBSTVr0x2NTwiJhbRV5h/wJjFiP3YCfUWJEfULviqkbbCaYRV7k4xSqEYEytJqJG6Nnw/5dBH9DgaClkHuTsPeZMK5DKGa6bMRB3FhESeNdsQxlWeE69TUmgZ/r/aKdcQ=
X-Microsoft-Antispam-PRVS: <DM2PR12MB016933B90BA810234FA20B05EC7F0@DM2PR12MB0169.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146755900322472)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0169;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0169;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(199004)(189003)(8666007)(50466002)(64126003)(8936002)(6246003)(68736007)(36756003)(2616005)(106356001)(7416002)(5660300001)(956004)(65806001)(97736004)(47776003)(72206003)(65956001)(486006)(7736002)(2906002)(93886005)(446003)(65826007)(478600001)(305945005)(476003)(2486003)(23676004)(6486002)(81166006)(229853002)(16576012)(186003)(25786009)(16526019)(3846002)(4326008)(6116002)(3260700006)(52146003)(31686004)(31696002)(53936002)(105586002)(386003)(11346002)(76176011)(66066001)(316002)(77096007)(26005)(86362001)(575784001)(53546011)(52116002)(54906003)(6916009)(81156014)(58126008)(230700001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0169;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTY5OzIzOmFyUlNiS1JEbllST3h3VEphWmxkTFBNYlJ4?=
 =?utf-8?B?d3ZqZzQ3dmVUdXBzUkxrWCtsS0pvRVo5bUVxM0xxb3NzbXR2cW5hbCswMjk5?=
 =?utf-8?B?YkViZmM1MHdzSXBFRUwrZVp2MmQ1ZHdGN3VVY2s5TE9UbkhTQzRrSjZERFZU?=
 =?utf-8?B?L3JacUZzNEJBaEZPYlUvS0ZWcmp0bmFGdXBvaUNkZ3RCWDNCZG01Y2ZBK2xt?=
 =?utf-8?B?Mkp5ZGVONjdkQ0c2L2RKbis5UkJZclNNdjBHUzVvSHExZUYxTW1rVFM1KzlT?=
 =?utf-8?B?ZEk3K01UbzVTaCtMVmlxeGoyTVZvSlFMRWdhMU5IVVdUSzRZaVNLUVF3Q2lG?=
 =?utf-8?B?MC9WQXJtOWJSSDZKSXY5VUg5VUptNzBaN0dFdXIzSHArNGZCK2lJblVzQ0ZY?=
 =?utf-8?B?Y2lTUWJiR0w1YXYzVU9hVnEvSlE3UnBKNlRKL0NjUVJkY0V2MXRuZndJaHBo?=
 =?utf-8?B?NTFVRmJvWDBJVEpiclpqekJiRXo2dk5hRWFHWkNESHI0S0EwMjJTOFdsdEpU?=
 =?utf-8?B?UXF3TGxWbU9FTUxHZTFEaTdkNU5NWGRFT2pNazlZWmxIWm0xMkZUanUrUXpZ?=
 =?utf-8?B?RHRMR094N2Y1UFAvaC9nLzZGb0crb2xkcHBBZ0lHWTRPUmRMcVM0R3lxUHIx?=
 =?utf-8?B?SVRJdTBkUmZxYjdvZ09jM2ZXbEZ3bmZRanAzRytnSDBVT2FQNkp0blQ0UU82?=
 =?utf-8?B?MlpVUW5zMVg4UXZWMExBaDJ3YXoyVVhhenE2Q0hyQTU5ZElrSXltczY5Um1m?=
 =?utf-8?B?ZWYyYWtaNFlwVGExcGE4REt3WGRvQlF6dVhQWTZVbzlRTmJIak9TRnZLRHZC?=
 =?utf-8?B?NmxtRWRjVmdkRHc4MXR6KzdYcDkyd282VFZnYVRWRWdZVUMwY0lmS3ZRVmZW?=
 =?utf-8?B?di9QZkFQOTI3ajZpWHdMUlhhTEVXQ3A0MEVUVzRQK2JsdHYxOE1wa3ZHc2d1?=
 =?utf-8?B?SzRFMm9teFJxZlBaTGw1LzFEeWl2M0hzeitKb3FPa0wrNHBWRTIxclFyRHZO?=
 =?utf-8?B?L3BYOVJsTFJFUlFzcGZ2UjNjOWM0eVN0bnYreTBrWTRZdHpmSGtQUnRmcnRu?=
 =?utf-8?B?NDlPWXNJbWxFamdGZlhBcjJ2QWVaaFZsVDgxYkl0Q2ZxNk9TcHJzTlpGTEFi?=
 =?utf-8?B?YnhrZFd2MmhGKzFNM1VJTFBmZlpERmFETnhCZTl1ci9FNnl6bFhWWTNudnNV?=
 =?utf-8?B?V2l0VzRRNllNN1lMcng3MjY2eklKd2gxSFBTWmFKbHluY3VQQUVKMzdpb3dK?=
 =?utf-8?B?QlZHeHowNC84cE96U2tFRGtrejBrVjF3QzNlbXlGakRzMmNvQWhoV25aWjlt?=
 =?utf-8?B?dG5pMkhoNjQ1Wkdtck8rSUVxZ2lrU2U4N0Noc3lTQmdJQVVwQ3g3bHpjeENR?=
 =?utf-8?B?KzJKV0JjZWg3eGxNa3ozNjZTY0JtQUd2R2hzaVBqeTJ3a1U5cGgvZjdIZEFy?=
 =?utf-8?B?RURCb0ZMeGlHODFHTVpHK09tRGFUK0FSc1A2VDVCU0VwSElpS0szaCtHcE1K?=
 =?utf-8?B?aldFYzBUWEtta2lyYVNUMFlsT0xDTTZjUFJuV2FaVlRNdmVKeFNFVDBLMEtO?=
 =?utf-8?B?TFVxYkZNL2VlYVdVb0ZNbDl5N2xHa3dWdGFicW1yc2VaaVpQaUdYS3Y0bU9v?=
 =?utf-8?B?UUk4UnEydVk5MW10Zkg2MWVhOC9rc0hSdXZHbUlPMGRxaXRURTNPWkdOVjha?=
 =?utf-8?B?T0dEOW1Nd3RML1ROMEozNDZzdTR6VWMzejRnOUIvQVRHdTE2Q2dMTXZLeGsy?=
 =?utf-8?B?ODlJcyt1SzJobm9zQjV6dktrTVBUdjVYV3MzdUFKQkFiRm9TMXh4ZjE0UGtV?=
 =?utf-8?B?emlRNXh1cFlpaStrOEYvRVR1czI3K3haMm13bzFrcHFsTkMzL2pCaEI2SVRD?=
 =?utf-8?B?SEUxU3BObWRRR0J0d1B0ZjhTUnE2SXArcnpSRkNRbGxrcDNYUVo0WHdYQ1Fn?=
 =?utf-8?B?QlhsU2lRTS9MdG5hOWR3NFJFZnJCUmgvcERBTFRqRlMyNVpUWjZ4bU96NmNv?=
 =?utf-8?B?dUkrQ1VRbjQ2alNTNVVOVExNSFRMQzNNcUovcytVMWQwWnRQT1AzeEVWT0ph?=
 =?utf-8?B?Wllab1R1Y1c5NzFjcnNweEQwR0crYlVJM2VkSE45cllua3ZleUs4MDd4UHN5?=
 =?utf-8?B?Umc9PQ==?=
X-Microsoft-Antispam-Message-Info: 0OK1kiuP+Y2yEs3pO2kuJ5yZaBvO2PlxGpotayX1M97nsNCD6x1Hxnh2t6Qu8xW1eomLwI4jAq6jWoChV8ltr0gYlaRS4E4akzqi9VQ5rjmnyqrvh5mrw2IEPbLoySFgbQzzQrRlh9m3XTUJmyUtdS3vD3VT1cUYbMldPHCPfnfPqLgblM4AsFB5x94m2FCQ
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;6:W6/zS3sKhsrj60qkXp1Y1zBbuqvCzE+KG/c+I9IWP7RhPZpGBRkuoujN1/wumhvMJiayYNBv/L35d8Af3Cr6Zf9t48OF5r8nZT5xMHskEueStiMtmRAbIbPlyV9t7cC641Cfl0NT+WRHiBIvWHtX9fZY5mhKLk45yxr3Kv0GTBEO2Ff2Ei0kysJlStflhDqMODVCy4/8ycLU/2vHyLOxgowiHxqQfxHk/BuY44fq1Yss/Ul9NBSCMs58b2C3qgaU3o4Xvm1t+K/hrOD1g1uJGf/ITRJbGX++eZicqsI74PBKRXRaJ8k2t2wgayrLv+zng5rWV3ihP22G6lRBK6VjyR7btRFkZUPFFwLSUjdOPQ1DEqdqZrQDL7leegscQ5pyY5n2szo9GKo3MGOGywcmifRaGJoTud0T2V1fa3iPZQGSlE/Ci8X9Ffuj8gAaMQm0DPwMUT4imJ0BRJr2kxi+ug==;5:XWAjfyRMrpJJmQAhvkayCnL8N6HHPWYuBeVvsOF9Z+nSu0FmRKNhoxdwNuqPiFUXvEC2enkn37J8yKz1Cttdm3XByG/hrvAnNGfdPNpO1Kf3QByprCquQCTvAPvfoVHzs/9itX0th6bsPyLqjkY0j4Fpbg809/05EnItn04SUug=;24:FdyH/6lyTzGcJlwYaPAjBu8eTJeYx2VQrl/36Ug9XC7hHrfboo3empqQmuP+kKQnQRksByEFnCWImXWgluRw706N2Y3o28jBJ+0//y3odyk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;7:tBTU5ubk8hAIvBxOkZneaRYQrbAPV7Ut4jxJbH8lCtr6spiD3GI9Lx65iTiGZWARyng45LC+nBYSpbHN4ldpKhDTrdXZO8rUjXvWWnZS75IEKMx0sDkluWH5nvO/XzQ9X5kEk3sbtp7wOmuKQuhtTMu7Kq+zV27a7h/RIIiZYuiEH9KjZvAs0YgRVAiPzMujB8H4QCfVd8oRTVUQY9FC8syi+lcH/IgWe8hM882FcBw1Q8A6aK9BboZneGAhdkzi;20:Kpm+Ou1Vsyng7qttLhyBTYPaXWIJjhSIgap4qBFbqap07PInFFO8Jc5cTY2kRvB85zRZQPNFSJIX90Za5s+0iCABh1B0/eQi6vbRMZUO+PZt9SSAEqTyhHdM7mguBpGJ18IArMRdjy4e/Io+zLdl8iLJW+jvVvW1W6nPKPjtKx8ZxKy3xqSedAhlFN0MGs9upxowSdoqLTd3nMV7uvRTAD1dmfOWe2Rdtg8HsRD0ok+FcYvpg9sExvoIrj5nZARn
X-MS-Office365-Filtering-Correlation-Id: d145fb70-590b-497f-c459-08d5d0722798
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 14:38:23.9424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d145fb70-590b-497f-c459-08d5d0722798
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/2018 9:01 AM, Konrad Rzeszutek Wilk wrote:
> On Fri, Jun 08, 2018 at 04:30:15PM -0500, Tom Lendacky wrote:
>> On 6/1/2018 9:59 AM, Konrad Rzeszutek Wilk wrote:
>>> Both AMD and Intel can have SPEC CTRL MSR for SSBD.
>>>
>>> However AMD also has two more other ways of doing it - which
>>> are !SPEC_CTRL MSR ways.
>>>
>>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>
>>> ---
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Cc: Borislav Petkov <bp@suse.de>
>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: KarimAllah Ahmed <karahmed@amazon.de>
>>> ---
>>>  arch/x86/kernel/cpu/bugs.c | 11 +++--------
>>>  1 file changed, 3 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>>> index 6bea81855cdd..cd0fda1fff6d 100644
>>> --- a/arch/x86/kernel/cpu/bugs.c
>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>> @@ -532,17 +532,12 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
>>>  		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
>>>  		 * use a completely different MSR and bit dependent on family.
>>>  		 */
>>> -		switch (boot_cpu_data.x86_vendor) {
>>> -		case X86_VENDOR_INTEL:
>>> -		case X86_VENDOR_AMD:
>>> -			if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
>>> -				x86_amd_ssb_disable();
>>> -				break;
>>> -			}
>>> +		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>>> +			x86_amd_ssb_disable();
>>> +		else {
>>
>> As I think about this more, I don't think we can do this for AMD.  The
>> X86_FEATURE_SSBD could be true because of the LS_CFG support and not the
>> AMD_SSBD CPUID bit.  But if the IBRS CPUID bit was set, we would now try
>> to use the SPEC_CTRL register for SSBD, which is not valid.
> 
> I was reading the AMD docs and while the SPEC CTRL provides IBRS my understanding
> (from reading between the lines) is that AMD would actually never implement this.
> 
> That is it would have the 'Enhanced IBRS' bit exposed if at all, but nothing else.
> 
> Granted this is tea-reading at its best so, ..
>>
>> I think you will have to keep the case statements and explicitly check for
>> X86_FEATURE_AMD_SSBD before using SPEC_CTRL.
> 
> .. we could or alternatively add an extra check for X86_FEATURE_AMD_SSBD ?

Whichever you feel is best, so long as we only use SPEC_CTRL for SSBD on
AMD when X86_FEATURE_AMD_SSBD is present.

Thanks,
Tom

> 
> 
> I think Thomas already sent this out but it should be no problems to
> add a fix as there is no hardware with this so it isn't like we are
> breaking anything :-)
> 
