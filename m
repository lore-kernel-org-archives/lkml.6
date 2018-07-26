Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3A6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E038A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gt4U+hYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E038A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbeGZOa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:30:28 -0400
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:2337
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729948AbeGZOa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/fughKdR0m/S3aiKGBaGnD5q8eO26YPmeBLbVHgVFI=;
 b=gt4U+hYP2b8pTdbyZsqAPDnmtEA4mgVQlsYte5YcpRqguru4GH4gzSZJNzOqnoY6ulFzcE8zGF5MEe6m3VmLmz1OeoRDSQRep6VWPV2m6L4VFnHbYmFslMsaeanVy/B04lobDEDeZkBzi7AcVLYczynvxY48b26HNBUaId+oWkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 DM2PR12MB0169.namprd12.prod.outlook.com (2a01:111:e400:50ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 26 Jul
 2018 13:13:34 +0000
Subject: Re: [PATCH] net: fix amd-xgbe flow-control issue
To:     tli012345@163.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangpengpeng <tangpengpeng@higon.com>
References: <20180726064516.56740-1-tli012345@163.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <2c28089a-7a2b-c279-2905-b6a533b87932@amd.com>
Date:   Thu, 26 Jul 2018 08:13:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726064516.56740-1-tli012345@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:405:3b::39) To DM2PR12MB0169.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88fe37ac-ff55-4ba4-9130-08d5f2f997f2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0169;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;3:MZ8pSm51c4oRbhA/Sk2sp/Ff23BRENcCbIwa1MJ0U0hyfcmRBXurpdglZtEDqT/NSntGzRdpmksbbY7k557fSwy6+QDLaIYpYWQaq5NJV0n0hX7JhfNjJqQ9sgj2yO7TxxrgQx+wRWY5XjvsXghMl9Ja7vx2j8tqkOltNqRyRKJXg30Whs00pQrAKC6iJYQNNmRrmcNGZx87jdG6FRVVXzN/oHttFlZWgo+xwM2s5pCUebXrjmP3uut7QoQbWDgM;25:AS/7CO92GXRfOphMqDYsm6q4wKOUM3UOVtL4IFmS0veBi7CuH5e2gnxkw4ueLV5GO9E76mNetmLnyx7DtrwSmT7Vs+MUf3GdYDrX9HRLIWiQNbBWYDsxAOhy37wjIpCGhajNI9avUGkZCeQ9UxbJ4Dibp34pFn/XyBxt1Yt5m+2/FTLaVtrgmg/oIyZ1LxyFJgomhvZlIw6ItO30mlq+i5KPaqqgwV0bbNvlLU+FEyhteNYIQcM+DlIL/4HX+U2CDyD+YE5P3DWlh9c9HMRk1es5knA3RKImlH/J1Z3bRRJxoxE5Gps5qTMIfEqalbF7fGYBf9sDy8zAn9f6XdVKOA==;31:m4mMCluUo0sy8njHy5IEMT0gWS+8XmQZkXYFNkIAVUZbvJQDOe2UospShkvcdC+c5tdfpAvDVJ2zjCEi3F29REZEwD4wv1wSJK6LIQXZ3pQioK1kD7LKdQ3sxRvaHUx43pqqIw+fecswU1uP8GatoYjkJICmFO2UET9IxnJuGKoTbEHJPWSfUlnrRUbr83A9C377WSXwjHLPdTGcN2/OPklSDlJAbKkDvevjBBdoas0=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0169:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;20:hcx14wTsddBkKRtd3RPOzelWuCICihRec5UYoMniITi3Dhja9DoB8M6k97XiD+ABAJ3RqZpWlWDsKk2Mh0P+DobCsHZqVCJOQp5yCHqt6LcIxx8I6oxUuJmMS0erXoupHVdx2C21ho+NlWyeg74o9d0m2dlA13ibjcDzbJ0wb+AJgwY7u8QA5sLOEytR91Fy3tTGX2iiYE2hxrJGN+uIYFrSmlXIhrdAm8DoA7AkxfoS1VWXnZAwmcB17A6SPhHCobaWFkDM8VW24NFGchKpQ0NABfLgrbtYg9DS+AT1FUxvaF1I0sY+d3Hqhf9kA++pjvyfSPlhJ7tyuDTZJuF6fGiilyfS7qqgt0yXIfocelzbCF9DhMjIoHLWEb7EiaABfwjIcs+poXeQH2xatk20UERvyh7JPhDjIj1M/VTF/LoCTM6vXIUU0wU7BQEWMgkTw7rtSVnbRy+hU1LAmpRZjUEe0pXYZVaWarFlQ0L4WA/W/4G2Sou6xtILZlsxXhNZ;4:Ys219VGImLm7dCOObklkapMsxsr4bBbGDvlbzmhKVGMfZpabdM9JuEcdPbbWxnU7oBBeDacYmLeQrAb//z6Aja8Vtsp5Zxl/jbWVEe2/STBV3c80olqEJLbJ5/N2lnxpt+8SYzERTVmeqycywjkSN5rryz31GsBQFLKtev3i6JFmORs9XRVRhGGKMty0sCrK9cZdZba8lMecVKOyz06WL2apFc4J5V6oeLcYyPIaZALStamXBbzwAdFV04dgMfRJp5AZtVMxcBP/WOre//aRQI7h7lJqFeoXaGrTg45774BnyWm6qyH5SJ6RtOy+OwTHj3a4UYAg2gItpuGFooID4wYkpUOOYMMjgbgocqXFpmA=
X-Microsoft-Antispam-PRVS: <DM2PR12MB0169B3A7475B9C5DD61A2538EC2B0@DM2PR12MB0169.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(130843839470238);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0169;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0169;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(6486002)(31686004)(956004)(68736007)(16526019)(7736002)(36756003)(47776003)(76176011)(65806001)(58126008)(11346002)(186003)(65956001)(305945005)(316002)(66066001)(386003)(53546011)(26005)(77096007)(97736004)(2361001)(105586002)(16576012)(50466002)(6916009)(86362001)(3846002)(52146003)(4326008)(52116002)(23676004)(230700001)(229853002)(25786009)(2486003)(5660300001)(6666003)(65826007)(2906002)(14444005)(64126003)(106356001)(81156014)(2616005)(8936002)(53936002)(3260700006)(476003)(31696002)(2351001)(72206003)(8676002)(6246003)(478600001)(486006)(81166006)(446003)(6116002)(1491003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0169;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTY5OzIzOnRkNHpsOUVBS1d5RWczSDAwTWV1RVh6b0JT?=
 =?utf-8?B?NVllRkRWZ3lQek9BVDRZRm9FZC9sVm43dVBmelpxbkpGSzZoVSs4L0FQVW9Z?=
 =?utf-8?B?aU8vQXlHWW9vbFFLRVc1WDV6QVFuT2ZSaVJLQ0x2ZnN1aTF5eCtDN1JyejBm?=
 =?utf-8?B?MXNkbFhSZWhTUVNCamJacHVoSmFNc2huRXpsWnVVYWdjR1diZWdPTnljN1Qy?=
 =?utf-8?B?NE1PaUE1Sk5hdEdkbnEwaEZWdC9Zb3AxMHVBUWdNSWpOR2JFYlUrbC8reit6?=
 =?utf-8?B?VWFhZHc2V2xVcjRyTFlWUHFROFVocnVzMG01bEdwbXpRVFVIclhHNmtmdlNG?=
 =?utf-8?B?SkF5TytEWE5QZG9OS1phamRSOTJ6WldmcE1wVElsSFJHZ0s3TmVFVGxhZUtB?=
 =?utf-8?B?ZDlJNVA1S01CS0gzYllZZEF5dFR3NldRR0VyWEN2WDY0SXRFcytFd2ZWR1Br?=
 =?utf-8?B?VGlBMGUvaFlzbHdHcXJKWklZUjlqVWVpeTRBVW1weFJTb1Y1UFN5Zy9kaGFk?=
 =?utf-8?B?TURCeXVUai9ib2Q5aXYvQkJyWk1Iek1udXBXU2VFUTZ6WERBbU5hMXVKRXZF?=
 =?utf-8?B?eGhNbit4ay9kVDhkNGpyYmtFN2dFKzcwdk9pa1dYaFdNU2dURnRlcWZybGZF?=
 =?utf-8?B?c1VKMFFlZ29uN2I2THhBa3dWc01nL3VXZXFSdEJNeE5IMDQ3aUkyQVM1d0hX?=
 =?utf-8?B?aXQ4TTg2by9SRURWcXllY2dMeGZhQUtTMStwdkFSeXJEYk01SVIvWENGaDNv?=
 =?utf-8?B?b0FnQ01yN0NJRk1kNkRiNk1sYXh6SFN3dXNyempvWGllQkR5dVkwbS8rZEZ1?=
 =?utf-8?B?clNvb2xCSkEvY1ZZaUNGLzhJTFI3TS80cThWQ1hrSTFCS3JTYnNIcE85bldi?=
 =?utf-8?B?NndpdDFFdWVFNGcrUk1kVll0L1BuQjBrLzY1azVWZFBBNU15eDZlT2Iya1ZX?=
 =?utf-8?B?WmxrTmhIeUs5T0JKWTRjbHBudWFsVjhPY1A0d1UxQVVNa1MyalA3WVc1Q3Jy?=
 =?utf-8?B?OUp2cC9sazAyOWswbXc2N1QzVHU3R21hdTRsdW9kb0dtQ044eXhzREhqUTRj?=
 =?utf-8?B?R0FjeHhmSmRKbVVIYUJqNy9IN1ZyMFNvcldsbEZGN2hkc3VHMnRlbDE5Q0gv?=
 =?utf-8?B?Wms2YzZteUZUaGsveTdUaHNqQVlmb3lFMmZpQjEyM3k1c3lqclkrcjR4OTNz?=
 =?utf-8?B?eE13M0EyM2FiY3JEWTB5ZVZOTFhQRXFhTElxZmxYK1phZDgzNjJGYkl4a08w?=
 =?utf-8?B?QTRYWEdwQW5HYS9hYmtJMk9TZlFidzQ0aGFMdXBUbUxvVDYvWlBLRUpZR29o?=
 =?utf-8?B?YzE5bnE1OU8rd3dITTVCTmh1QUo3WXBGd3dEU0VrQjYrTTRMMDQ5eWFlb1E0?=
 =?utf-8?B?YllJeHYxSjdYZHFZOHd1c095Tys0czcxMHdLdU90V2pnRGU3YStRWWMwUWtO?=
 =?utf-8?B?UExzd2tBRHg0ajl5UGEyZ0ZFelNHR2lObFk0ZjRuUmpaTkowZ3AvSGRQKzhr?=
 =?utf-8?B?SmFqMWJqYmxxSjB5YWlaU20wcTNCRFBERTdUY1ZkS0dhVXBRbnFjOHg5Ulo1?=
 =?utf-8?B?UDJxTG9MTDBmKzF4ZTg1K1J1S2l5SmN4aEt4UStMbDZraENjVnFwUmNFMGFz?=
 =?utf-8?B?QlFYNkVNYWJpY3ZuV1pUdnVQa3RGc3plaFQxc3IvbHRVRUNQOFpoeExDaURn?=
 =?utf-8?B?Y2dHUzFTYWFWc1VtL05IWitDaUZ6MU1JV0NLaXFhOEF1TVUzSTZLb3NQQzBI?=
 =?utf-8?B?cjhUdnVOZnJNNWhTVjJZM1ZudEdqc2xHNExCVlE2MDJhR1o1eFA2cUpLUHAy?=
 =?utf-8?B?RDdEY2tOSlR4cStnRDBQKzdQaGRPU1A4OWUzYWNlL0d5RVd6cUZVZHRXckFS?=
 =?utf-8?B?NHN4Ky84cllIMEVGR2FkYWVMM25MbFFub3cvaWdKMXIvV0JVQ0JFWmFjZk9G?=
 =?utf-8?B?NmN5RHM4ckFKRGgxam9oKzlBNFJYTUpVb1dKYVFEeGNwUkdGNE5JYjdoODlN?=
 =?utf-8?B?b3ZBOWZnanM3TjlyWjBJVndiZ1pyR1RCa0h5eFZOUlpkdTR3Z0pkWkNYeldP?=
 =?utf-8?Q?rewVyugO2aVC3FkLzyuLJOWAn?=
X-Microsoft-Antispam-Message-Info: reyZXyPUt+cmUNdgXwtFC7HxvO2mCYfxVjG41/vzcuO4ntC7OZDv+Y6lPlM/Kcsz/mAqWrbvIfAOnk2EQUpU5s5BBtwX//EvC5L245JRO7jr1/Yd4lDK47zOXERcTO2aKhp5NmM2wUnkvq/91c/kph5JKXgj2UVPY4WI3IIAbQA6G7Qqr4n9uehX/s4pvj8tvoo7quDk1IGdC+Av10YE0wjqF0NdISFuZj6Rv8O7PEltwWPI8gfxcwG67O5ooPJRKcmIIvLQ+oVpPJC73xBEy0EPtc6lMN5C2H2xk470+vsC4ld0AuxDMzGGVM2E2Pfr5BHC8e5Rvzh4OMg94YuMALeI+b0dQWpg4ViwxLvaqe8=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;6:ONj1czKwvsCKFqF8LOKT2NNElSEkCtb1W/Ohse3xK+H0duhgVACV2jr7JC/n97lAlpPsVARSaEm9H3cqBfN7dVdJoKWt1Pu9EcSuhFGsPO0tp29rHEjtlXTla64E5mB4R4E1+AimTZUG3XYDnrx+yrMlPmTegJ1lX1NEMvDhFJY1DasMuxKo3BN7j9qzGPYVj5Q1ND2OKAm9Ume7F0ZQidyU3aFVeaB+hHe8M8Ihg6RvRDYsVlEq4Jso2Qlk6BjBCeYKuFFfRfUQdd8/t3tiRRhhMEjVsr4VlwmbRVvGgwuOwrdf9X782TfBn6S3QHAAXSmjKsAhRHAv0zbVTQ9xPzTzwemP2QlImuIIMzBVMWd/pxuZ0NDcd269zh7s/E9gBOrCLPQN0suBvzztw0ySYBECxgdpZ4CwIVExH8U/Dwjux17P7mOZuWiyQYuI5T+hm/tYfrhHPTgl1YeiH+L1hg==;5:g/0/T5U1Uh1h/Q8qfRpnlZ78fUndggGQW04cfe7SX3v4RWAvK4tW2vnGD+hlb0QkksHC5Ul5gM0ysbOIvbeAh3QreC7upKLwpsJRttFV/CrjVz+/4FsbpJhWE3C5c/1QTi2+B+VFBsNP0VlZappCC7UAqHxFlvJR7bfAAiJ4OEc=;7:/DcalWVLPWkfRsFYalKgt2lAVRSb8Wn8MjXYIrJbBCrvVse9tsr1Lehd4Glr+gQE6fjCDQDzR4trXeVFg1fUqDow/SQSRH57buyP6Z0mNkZyZrv3oDmlTAM9FQ0iFQ6QwQGUTxj51TobrDQL+AKb5XXMwmDfVAMmp8nPSrQG3+dlSjESlIlfEwepQOymPMwQ71fK2HdZUFZbCZRObdJ0zVbHIHekyCoD2/SEGlPzvDghJWupWm8UDXUP37kxqoie
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;20:ykgiW1eET17wKl/7nn0/V4MR66rUAJet94ZCv8xqXuDKUEt+JCHe6aYg52AOJwNBZb0KKYsJxLN7sZ8BuOdbI0ufQ9R6ozZSqG+h/zN6uAMhla6xiQzx9NkjxTJVAa9iBY/O/eu2R2dtDv5clTla6QMG9aOD27wAZDpqkNzHmGfNCZySOm3lvZxL9nHpLXdIAonOeik1F4VhfHaJuTLdkb8v1cYW8HJso056TTUpFEt017RKSOqUeJ3GrTKKAA8b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 13:13:34.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fe37ac-ff55-4ba4-9130-08d5f2f997f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2018 1:45 AM, tli012345@163.com wrote:
> From: tangpengpeng <tangpengpeng@higon.com>
> 
> If we enable or disable xgbe flow-control by ethtool ,
> it does't work.Because the parameter is not properly
> assigned,so we need to adjust the assignment order
> of the parameters.
> 
> Signed-off-by: tangpengpeng <tangpengpeng@higon.com>

You should add a Fixes tag as this bug was introduced with commit:

  c1ce2f77366b ("amd-xgbe: Fix flow control setting logic")

And since that commit was introduced in 4.2, you'll want to ask David to
push this to stable (4.4 and higher).

With that,

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index 4b5d625de8f0..8a3a60bb2688 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -1111,14 +1111,14 @@ static void xgbe_phy_adjust_link(struct xgbe_prv_data *pdata)
>  
>  		if (pdata->tx_pause != pdata->phy.tx_pause) {
>  			new_state = 1;
> -			pdata->hw_if.config_tx_flow_control(pdata);
>  			pdata->tx_pause = pdata->phy.tx_pause;
> +			pdata->hw_if.config_tx_flow_control(pdata);
>  		}
>  
>  		if (pdata->rx_pause != pdata->phy.rx_pause) {
>  			new_state = 1;
> -			pdata->hw_if.config_rx_flow_control(pdata);
>  			pdata->rx_pause = pdata->phy.rx_pause;
> +			pdata->hw_if.config_rx_flow_control(pdata);
>  		}
>  
>  		/* Speed support */
> 
