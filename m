Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66738276AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PXg5iBZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66738276AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967359AbeF1Qpb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:45:31 -0400
Received: from mail-eopbgr30052.outbound.protection.outlook.com ([40.107.3.52]:34669
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934044AbeF1Qp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spSq0D0rFBZF1eiXlHyTMFBeGhrgybwmynpI4d3qGns=;
 b=PXg5iBZ/08qryUBRA7SsL1kOfmR3Yd09rJiYHiEX+TZAgFFHZ9ZLG3bCJfm9el24KO6tXOkMhKtrj1GnCGKhsvPb+6WexmQy9kEmv+Th9Kbu24M4UM4oJCDiPrmW7XTBf6/BwFtBZb91kN1iq/OrIaHPlMq1VvWhe+4/wx+gfKo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sudeep.Holla@arm.com; 
Received: from [10.1.210.28] (217.140.96.140) by
 HE1PR08MB2764.eurprd08.prod.outlook.com (2603:10a6:7:34::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Thu, 28 Jun 2018 16:45:25 +0000
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        Andrew Jones <drjones@redhat.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
 <20180628115748.kprobde6c3joc6ll@kamzik.brq.redhat.com>
 <f9376e47-e2ae-b2f4-db23-07698364f1bb@arm.com>
 <b9b537e7-8f7b-07cc-a99d-bcaa8f5d60d5@arm.com>
 <e5b44e41-6d5b-2587-2628-3bcfbee4e00b@arm.com>
 <20180628145125.2psdmymtuueiv4xn@kamzik.brq.redhat.com>
 <C872769E-A591-4569-9AB9-3EB602D9DCDB@hxt-semitech.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <a3b7e123-7d20-c94c-fe02-64e2b41587d5@arm.com>
Date:   Thu, 28 Jun 2018 17:45:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <C872769E-A591-4569-9AB9-3EB602D9DCDB@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: DB7PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::21) To HE1PR08MB2764.eurprd08.prod.outlook.com
 (2603:10a6:7:34::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2dfc4d6-1e03-4a11-fae4-08d5dd168cac
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB2764;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2764;3:HBRXVRnkXtiJZfjsxNl9v7hN+648AHy3lY7gC4cEfj6fAhtnxmF1BDdKKVSLuH0M8mRoBcrG0PdmOl0j5grBq2ZnMzaqKi5YbFlCidK+FH8EpTaxCIiFWuA6I2xrh607Bn8WwFiX68fkKvS+kxgjWR7s4YgkImhDzMYFbxMDRm0oCHdfNxxh9Yzn35kgMdVWTqOd6QYR2kENMnwXZLyDYBS4QulcuaghBfGu51zemaGs+zeC4kqgg7SwDx71Af6J;25:7Q4KTZoZN6+JSyLDxxmOqz9vXX7J6BjesrmrPz9BKYZYyRjYBMF3w7/WF8YN4BRU8BflAHczJcLUevQ62yzFNtYuNF9z1ToM+0Xu6daVNZXplxuMTCRFvAz6bCts6l82jjjhbKYwmeo0B8Z1mlElmPvjH99hnqlRMTXzypmXogTmR1bAalmv/pfGynMrClhiSqc3JjoMIEFzsseR7JaZCG047+hk7Sk7G5/AXJvlB9iiFRUtFtSIwzEBU12qkpuDlT456zYOski4Ots9ClWdinW0moIjgJMp5/k4nMjIIO7vBBq/lpFV/2C0f6uMxvZd+fbvDKXI+GSjiU2cN1AIPQ==;31:ejSToP74iPTAfNGaqWlGLizpJDBJShFmSgmeN5g7vIK07nB7F65sCq4EL0KchVb98cPB778vu4C3/q2HxkPqDOllDoZBgm6IbLIBx5zcujbQcyh3U+QCrTATj5EotgXeTU2JzgQnLFLeTpdtF7h4PkwsKLxq9vST+NNZTYui9zJOAZA7Ufn5OxSSheTnMRQ7aUBHVzXC44HF8JS3SCemofKnfpCxMsgRzIcEqnRtOOU=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2764:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2764;20:ZTFgeZr9/geQql+VxTzGKa79TIDBkkDMPAPuDR/rP9/zOtn0c7YP7iF2z3qMcf+/Cnq8YD39ItL6YvtAE23vea9doL9W/9OC5Yo8OYZoY4DJ1CVuAj0IOWXXc6UCznljreZWVxirJlkjZjOEY4E6xxAMaqTiqLVwfZyjm/X9B3fMcH9+3tC4kJHls06qoJmFBRFidhMbcyJx+uTk1+mje/8Uh9plt+XJ+JXTynYDtBgOhR3x1qIb4tZ16ri/NNC2cTpeHMtXBqGhuKjlvL44M3AdTfzu+Ypy0G0GbBsymPoP6M+PNinSBxCu04oxFMNih5b1ay95FntjuJhFYTiAduoWnUDWNoVvv0C6P3PJCsPLItMSYS8v0YpCb/CNDE9XgvPxcvpAomjxQquBKyK3PAtdAqDl8VJgEmWppAwMP7/HY/2OY8PfupyIp2SH2HZHYjqy/t9Sm0awDm5u6W3syHt0QTYDgJarr73LriMcvSa8OZmB9WYAKrE6MSvacruQ;4:ifidBiqpQxxk1izhf2v5wjz1iTk0ek3qNGnIS2M4HaKLcOjpcpchstgo/xYtYMpQQ8/A517pFlY0gADVjroDlT6PVkWwbHu1mRYXvYW+qxDPpANK9EYM3ns0kTrk05p9/QtBlnQEmLOrZ154vmXkwX2NAlXStv8ugLA8658fM95bIL+ewEa2FKymtD/r1sileRaVR+EySU5T2CvO/A1iPZQLOUE35t91H0NqsndfXofEo+gQerrtDZlqKrYKZ/jcrNYWHXueWA4VZUWhuPP7GY/90wq/t4wQoDYXd84TX9/dRZFuwkNJ0txRCpINEx65
X-Microsoft-Antispam-PRVS: <HE1PR08MB2764A253416BC3113E4C10DA914F0@HE1PR08MB2764.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(223705240517415);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR08MB2764;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2764;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(51444003)(199004)(40434004)(76176011)(81166006)(54906003)(58126008)(110136005)(478600001)(81156014)(316002)(8676002)(229853002)(16576012)(8936002)(26005)(25786009)(5660300001)(5024004)(64126003)(8746002)(6486002)(31696002)(72206003)(31686004)(86362001)(14444005)(53936002)(3846002)(97736004)(6246003)(44832011)(68736007)(93886005)(36756003)(65826007)(6116002)(50466002)(956004)(7736002)(105586002)(77096007)(106356001)(11346002)(446003)(65956001)(386003)(65806001)(186003)(486006)(2486003)(2906002)(66066001)(2616005)(23676004)(16526019)(476003)(52146003)(36916002)(53546011)(52116002)(47776003)(4326008)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB2764;H:[10.1.210.28];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4TUIyNzY0OzIzOlpPeFREeEpSc0ZRQUJBcFk2Y2NlWWJXTzVC?=
 =?utf-8?B?TWtiTmVISW4zcXJocjBxUDBpaU5HbHFQTHpmRUp6RlVKc1M2c3M4R2VRNWRr?=
 =?utf-8?B?N0RYTi9DY0UxM2hOdVV3VW52SitWZzhXVlJuMzZMVDdJbC9lVkg4bzRreW5i?=
 =?utf-8?B?SG9JaWc1U1Y2NWpxVER0SVlLMXE2RHNuTzZOamhTV3dYWGFjYjRiQzdML1Aw?=
 =?utf-8?B?T2ZwZmFNaVlKcXhKcGkrUVlaWTdxemZOZTFNRmlVUXAwcWdkQUF6cWU4dUtw?=
 =?utf-8?B?cHc0SWIxd0Z3NlN4cE1nanNuNFJxYmxKMi9uZkRxWStDVmdaV1pXTXlWNHRt?=
 =?utf-8?B?bGkvZXIwM2NvTEJWZ0JtYWtUVnR1ZU9mZk9nSDlsUi93VWJLMTV5MThla2sx?=
 =?utf-8?B?UGdXcDRpQnlKQzBHcFozOExXSmR3eDRpZldrNWJGVm9ET2dpYm9SQ0t3M2Zw?=
 =?utf-8?B?cjA2S3B6RXBUWnJ6am1iT3pCNzJyZlArUFp5YVMzVlh0TUx4YkFOelk2d2tp?=
 =?utf-8?B?djZtakxGZTlLQXFaa2hwNVRHNFFyU1c5b0l5RTM1cjZ0NTJTNDhLMXJPS2ZB?=
 =?utf-8?B?MmFTU3dFWkx0VmxzMjgyZ3NxK3ZVZFFadWhPVUpLRVoreXU3bEx5NlR3R2x4?=
 =?utf-8?B?QXR1dG1nU0REYVhwb2czcU1uTm1QV0dBaVZpelNyZWc3R3VZS0xwdmhVcEIy?=
 =?utf-8?B?UC9wLzkzak5DelA1d1d3a2J6a0FWUmVrdUJnNVdCUTVYWU11TDQrakZwQzd4?=
 =?utf-8?B?Y082WGJaZjNGTVNvWGVOakkvS1p6ZXoyN2lwUWJiRzRGOGZob3JlUGQzQ29S?=
 =?utf-8?B?emVFZTNwVW9tVVBOam5TanFwZGhWYlgyclRQWDNVWk9WNW1hRDB4VTZ0cXFP?=
 =?utf-8?B?OXVIVGpRcnBES2FSSktXM1QxS3JISm5TVHN0UjI1MHN4c2MrY2JTTGlkR2Yr?=
 =?utf-8?B?WEs1UGZnQXkrTEhyZkdIOENHcDkyeHNuZzg3cHJFUXNLejdHOC9sYmpPV3Zx?=
 =?utf-8?B?cTV3ZlQzZjByK0tMa2RhVlp1YjJHdjl2alovRVlQN1B0OEQwZEQ1SU9tcUN5?=
 =?utf-8?B?T3lLVDFRSFJVU1doZEIwVDk2TysvQ1BmQjdXM3Q4TGtBUUREVU9Temx3YjZk?=
 =?utf-8?B?SjFTK1d2am02ZWdKNEMzcHRXYzcxNzhYUUpFZnhJTkZQMzJCTUNYcHVqdFZW?=
 =?utf-8?B?OEhUdWpXelA2b0dyOUZSa01WeGpFZ1I3aS84ME0xb0RTUXAyQUpYaTZyQ3pY?=
 =?utf-8?B?K1o2TTlmQnVxSnc2d1FZTWwydExrWDlzWjRBOU41aUVqUzB2UDN0NXYrSDRv?=
 =?utf-8?B?MlFVdlphVTRWWHdsYlZzWGQ4VnUvbXFldzdBak5IUnIybmFLU0l1emU1L3lD?=
 =?utf-8?B?S2xQMUFZSHNQWmlsUjBSeWtYNWM1dit4SDBKUm4zRVorVXNpc3phdnhDMGVo?=
 =?utf-8?B?Q0gzcjhlMTIwNC8ybHJHVWM4NTNaZURrU0I1dDY0dHdoQVR2U2lqVGg0dnFt?=
 =?utf-8?B?c2gwWVNHV2pUT3QvSE5SM01lZjY4VkNBMnN2QXNyU2RYMXpiS2l2TXVubncv?=
 =?utf-8?B?UnpZZCtjcS95YkY3ZUFqY296Q1ZFUFpKMUoyTFIvMUFSY0loa2txajBjVjdT?=
 =?utf-8?B?aVVTOWpuTXBrcW9TcnFSOXVVbUZFSm1nSUlibzVNelF3SHlwRVJ4SzRBdm9p?=
 =?utf-8?B?Tmc0R0hXMFlURVplajVtTUZhSUdaZ0o4dG81RnFPK0hBbGx3WFN4SW1QMXJY?=
 =?utf-8?B?Q1VJbE5YVzBzQ0RtQVhKeDYwOFl4L3BUc0xsYXhBTzVmSTJwRnpVUTZlUEYy?=
 =?utf-8?B?aTRsVnpJWWVHdjJLNU9EM1UybHJReEpGTEhKZDNYR2JCWUJzSVgzdmsyYlha?=
 =?utf-8?B?bjlOWU5LbTR0MDZxMXpuMVhxSk1wMDluZWtBYjYvYUpXakhvWXJrMFg3UDVz?=
 =?utf-8?B?NFlmWlloMUtLVmxnVDZuMTNST2dsUVVNcXVJbXd5VnRualJ4cmFKdEpZWHRU?=
 =?utf-8?B?b1hjczU3VnVXUmtqWnR4QmJXUVd3VnE2R3BxdTR3QWUydDBlUUd3ODljLzZU?=
 =?utf-8?B?VEdPeUhnZ3FTOFFWdjhuUnkzOWlFeTZkQjQrcmhwYzhKeHdrNW4wZ2x3TVgw?=
 =?utf-8?Q?5MBorNjMiCGXKkjyI+drCfs=3D?=
X-Microsoft-Antispam-Message-Info: tTlGGzKMjssLr2XC2x9hlm9FLCNEIGVlXX72tcGcmxWaRye+z15iw+UcrSeQIUfFD6omLC1Il5GJiRhmQM1CVLFiMALpT71yoG2Qmbog39zO6EhsJEv5E9n1yOjnK73pw37D+/njXdzoxnBCI1pJpLeMT7oRiqCN5dJ/FiGfUwzogqXtjPhGQVLj1Jh7Nl6acNGBAXyLtPk2wKTVTWf/dSB1/fNOdQfmQNcFCeaZzHbNnAdK1i9Y0eH887zbesPKrfvctzzUbyW4dGlqkbuy5KaEXY7XaA6nSQTNJ5/ZFGUqXAzWLgn3xO07NaB+7sH69o1blEzBkvyOH3GDpXcIDgRnGajFPcvVX0l4xGKMLpM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2764;6:KnHCDljaE+fZSBo+z7Xi02x/LRpHuJ7DSdsrXTAs431SO0PiS6LGY8U9yLlmm0v3om1UIIdnwEPEW+n7/COpfWgF23/f0tcpcYO8i+H0sYZYhX/BYLAJ29jolhmFGdJz9tv1thI/ewRJaOfilWuzAHiMqn4pOF9dvminU8gCVLEvjldLMTKI++sU5EI3EV2EhWzXACDw6w5W9cqM3RRFZ6YH/sIf/E2ckzLmls0uBfJT34ItQyzt5ciTaDtHB4yaIzgmSJ4B5O81oMAT+Z5YgUSwt1oIlyxIRl64K0hSg7EWqamnCzufLV5yZanHYkU4Jrmdmfn//rmgywunf7EfWIsyRd2oLitT/Bz0mHTFiEtI+K1YxE2+4EFwntfyFUMdxnl4I2BTjHvupSeMscgO4fjETJit/pAMJUEqYRq0VMdsteElPTn5/0dJ1JoriUhlgKj6d9lefDtn1/LSQTNOsQ==;5:hnCUHdt+AT0GQ79Do+fBc7Y93F8OJejT8M7l7FT2RPmyoftnZqheTD2E+rs+ki1k07q4KjHUg/dHJC2YL3y1e8qCmqlI/nobkCmMGC/lZYZc5dyO898ZFC5gTETPhJ4tvLN9QWIyCzxwc9kgGMpB61bLE0cVm7gsmcQ30C+00pE=;24:p+NtTZ3jxn/Q7N+f8dBMzItx1+oUH9NGah6tBYkjByrF/UxvLf7aIjEe8pBZDyfDIPIIJIV5OxXzYbEoOOEnjuBqdal+KNeHJdekDI5t1Wg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2764;7:ATCU7Irwnl/FLWYMXEX4YFGP8yPc0/49BFjqo5TXcurHMwlYQsQ2uGt8v8W+ZjCR3W8DJlblutgBs0bLogWgBEiLCHrCGgenLuppzY1uKIZN1fclM7xIosxgKkm25/9JvnFl2tVjvLqJLIwWi+e6dBCJDKktjyVDKZCoJQ5KP878sFLh7j4REjTCpwx9jQkC1LCN40MHZ8/dRbQQZs7gCFGJMvW/6sTc6FuV7TPyu+TVmBv+7eSGhr8l3PPyOjVo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:45:25.5240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dfc4d6-1e03-4a11-fae4-08d5dd168cac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/18 16:44, Yang, Shunyong wrote:
> Hi, All
>
>> On Jun 28, 2018, at 22:51, Andrew Jones <drjones@redhat.com>
>> wrote:
>>
>>> On Thu, Jun 28, 2018 at 03:09:19PM +0100, Sudeep Holla wrote:
>>>
>>>
>>>> On 28/06/18 14:19, Jeremy Linton wrote: Hi,
>>>>
>>>> On 06/28/2018 07:12 AM, Sudeep Holla wrote:
>>>
>>> [...]
>>>
>>>>>
>>>>> OK sure. I liked the approach in Shunyong's patch. I was
>>>>> thinking if we can avoid the list and dynamic allocation on
>>>>> each addition and make it more simpler.
>>>>>
>>>>
>>>> This one reads simpler, but yes I agree we should try to avoid
>>>> the dynamic allocation.
>>>>
>>>> OTOH, I think that dropping the dynamic allocation leads to an
>>>> algorithm that picks a value and replaces all the matches.
>>>> Which of course is Andrew's patch, although I did have to read
>>>> it a couple times to get a grasp how it works. I'm guessing
>>>> that is due to the fact that he seems to have optimized 3
>>>> double loops into a single loop with two individual nested
>>>> loops. AKA its probably more efficient than the naive
>>>> implementation, but readability seems to have suffered a bit in
>>>> the initial version he posted. I'm not sure the optimization is
>>>> worth it, but I'm guessing there is a middle ground which makes
>>>> it more readable.
>>>>
>>>
>>> Completely agree. RFC from Andrew is not so readable and easy to
>>> understand.
>>
>> Middle ground coming up. At the expense of a triple-nested loop
>> (which will never be N^3 iterations due to conditions at the start
>> of each loop), we can avoid dynamic allocations and list iterations
>> and still gain readability.
>>
>> Thanks, drew
>
> I have a new approach. As we've already got the offset of the node
> with physical package bit set, which is the parent of the cpu we are
> querying. We can iterate from the begining of PPTT to count the nodes
> with physical package bit set till we reach the offset we've got.
> Then, the count value is the package id.

I was thinking of simple solution like add the offset to sorted array
and assign the index to that. In this way if ACPI_PROCESSOR_ID_VALID
flag is set at the package level too and they start and increase
linearly from 0, we are matching them(requires 1 line change I posted in
the other thread)

--
Regards,
Sudeep
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
