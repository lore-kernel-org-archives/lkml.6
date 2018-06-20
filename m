Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094EE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="TYVyqqJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094EE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754779AbeFTJ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:29:45 -0400
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:59200
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754542AbeFTJ3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l67VKUDf7Qxh6Z5AjFRhugyOL4iU5eUyNIlkwgYBeek=;
 b=TYVyqqJ4K5EPtB77qMjlTdKMxKheK94uQt/wig3susqCHOUNQyK1eRynOCWWjW+FcrOopLXT8umUR1zsl5BZ0KrSLSJTRv8g0Lsfql1kvzUshwIhadQ7lwdkbrkbsk8rYW1iScfXtP7Zbp/O58Gr1/zp8W5bJ51HiLXLDuzuViw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 09:29:34 +0000
Subject: Re: [v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     Jayachandran C <jnair@caviumnetworks.com>,
        George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, pprakash@codeaurora.org
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
 <20180619203846.GA6083@jc-sabre>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <a412e1ff-2c52-6fca-00c3-472b35335c4e@caviumnetworks.com>
Date:   Wed, 20 Jun 2018 14:59:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619203846.GA6083@jc-sabre>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18)
 To SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6d9407-f9b3-4b4e-9139-08d5d6905730
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4926;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;3:vjT1/UlsBgMCmR4ZIB5swPkvhfLjSOGqqvJrksDZ+M5Jq738q3uxinVN7p7UEFY0M7Dd0npJ+NHNq1qJ7rl0PSn3WUkq4JagjYDUZMTNxN6Lv86loWO2d13+P61vIi1P/8uljgIF53jmuD1qDNiDAyNKdf+cgXd9MhlphmXf0rEucTIAl6/zwvkyIsqgrIA4PdjhN4A1kztk+L7BMBfeSCtge4w9cY26xWK78V7S/r6JQ391e4V0GiDcSNvnSSPZ;25:riRBshPfpvRiTymklYwFUJCS6qqDBd2rdDU/p1O9rMcNPHy5pf9B9A8DOao7Sg/qzlMxLlDhhC8vNOGhKGfPAwJr0PBkbfIXahWTFZtANl2VVC/tZu7LiUK1HrBhxT+ei+UrJqi7bAbTpy1YAKu6NAeGTq3tnvEvdFWdaAyrPXWtPju+i0xSFMVtVuncFKkqtojghMg8uDQB6EBXRiF0+MxFfP3G0z0RiJQYuvoBRgAVrA9Zi8LEI0NMgHMLPDxlEd+dLFwuI2rUWeyvByToZxdLTjSkw9tUUHDfFspYKM7TafGmAhsAOJehtNYbQtl3vYR3YGBDyf92Hp2iw/QQmQ==;31:mTwlkH69pgLxd6DQcRUXycTJv/xah82kVGc9AB//vWY9sMXYgQ0owWypKdsXEkxODJ7tL8UQPdyeKBo2meUQNPD6T/epTvVUnXQe24yO54EAjsn0obml2NGBt5m8NtJd3duxr9XXieL9tiIkJHLurF+BhPhfVgpc9ZMcfObTwyaOatbMIVIVNmH6K589jlrhTUfbliWwQ95UV5B38s3ddeuYk0WVdsDxaGDvBKyo718=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;20:jGU7AGcQYfTkQkc0S1SuIV72z5gIt5J/HNVM8XhG2QRFS2pGUsurpdCMuM5fKLqz3Qe1i78DP77qrvyZimb/hSWxDbuWVImnD/1osqzzLR7x9JhysbJRPYhvivHZoIzTSiDj7KqgFk3kkquFSdPvWleDN60s7QtWWXofI+IlAd9mS1ReZdSX4PcLxE16JUOaHvgZk9oM9yclU5qFQ1JvbxJa8PPQcGIIrp9+Ms4FfhFK/uZt6wqlKlx/hv0FUdZg0RJjYRJPUluhVIT0U4+0eX+Zwt+qldlNec8sGut5YHYsbj3ZJIM6N6wvR5pT6kPrvhOOuUO3GvwLNZSFO95kUKk/+j/qAxoRBrMqmDQPob+ACcxVgL7Ef0mghAFQuJxfHfnT71KEwxQuGAMz5KC1kojnVCkfhAllX+IHmZKVEYUtErwNPpi59aMo0yMK7sQ5sZ5x2ladfoDCWRYBIcRGxHeXuYGwy5sNBGtVd49UXoKXjDA/YdJPobPATUQ0LjYWCjCdoT16s3wgzo6HY3zS+VczSVby643P7blEK2lBltTEYCO/d3sdwVqOQkPgFtcLgEXqEkF1gK2dEExZOxCBD2YfONUQrA3Eb7w2VvXiXkM=;4:dhl9iA/W2OmF9u/66TjGEpniNGdu1Msp8io7IY/2o3wuFMY9cRJ7+8zx8jArv7unJTmBpylJ1QHmjJch2MlDL7ygtlDJ/NhipigOevS1u76hYQD0hjn5qjnDzfNV0Fq5B9+0DetBCexOkA2NkIV8smkWPNtQce99r45p/ctTlCEpAx1ETZCON16dFlr+BJ1z+OQmPmJlWtcHe3cF5COsMtNQyUHEYT+jULykKWiw04LcJBdF/fE6dJTxzEd/aGJIGv9FWg/+9xsOu1iNLcB5Q5amotboDVkbEglUR7cW0LsuQ3UzEICySAPMXD/Cm9pS
X-Microsoft-Antispam-PRVS: <SN6PR07MB492625D5E2B7727676D7B0B8F9770@SN6PR07MB4926.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4926;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(51914003)(43544003)(230700001)(11346002)(5009440100003)(5660300001)(476003)(16526019)(31686004)(77096007)(6246003)(53936002)(105586002)(72206003)(186003)(36756003)(106356001)(478600001)(4326008)(25786009)(956004)(6116002)(65826007)(6666003)(2616005)(305945005)(3846002)(26005)(8676002)(229853002)(42882007)(31696002)(81156014)(2906002)(50466002)(97736004)(64126003)(8936002)(81166006)(6486002)(76176011)(486006)(52116002)(52146003)(16576012)(386003)(2486003)(53546011)(110136005)(58126008)(23676004)(67846002)(65806001)(66066001)(65956001)(446003)(316002)(47776003)(68736007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4926;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA3TUI0OTI2OzIzOitYalF1SWUrS256cVlGRmJmMEpYRUUvMzJi?=
 =?utf-8?B?RGVhTnZBL25ubXJWZW90TGxlNzNRc1hiRVVYaW53TmJsa1BiYm1mVW9Kdy9y?=
 =?utf-8?B?R1Nwa1o1cVU0ZURRU2RRVkZ4b3ZmNjYwcFFZR21MSUtzeVd0ZWphM2Y5dGVl?=
 =?utf-8?B?NlE0eGhEZnFUT1pCMnhBNU5mVjMrUTNDckRZQzZGakxsdnFnNjlaYXp6UEdR?=
 =?utf-8?B?bXAybHBSUTBaR1puTzNhd1RxejNKVUZNaHpyL0Z4aStJcUNHcTdiRUdud3BU?=
 =?utf-8?B?Z1NUTGhoRmtHd2MvM1lLSk9pSm5FWXV5bERuTnZUWUJDNDZhSmZ2dnlvclFK?=
 =?utf-8?B?Z2ZWa0R2NzB2Y0NhQTRnMWVaYjlEVWZFQU56VGROb0RQSVM2NEFGWFJmVStP?=
 =?utf-8?B?T2pWM21sZ0pkYS8wbmFNUU5Sc3dpWjBacmIrMm9LNi9wQTZGV0lqY3lpcFFJ?=
 =?utf-8?B?dy9CeFhVZUM5NjZ6T0I1Mi8vT0tmNGJpQ1J0U3BPd1Npc2ZISXV2OWhEbUw4?=
 =?utf-8?B?eXFTaVkwaFJjS0IzcDVTM0hUeElnZ1MvNU5IV3JxbUFxeGE5Q3UwWHVaK3I1?=
 =?utf-8?B?VkpVdHRueVRyYXMvV0JOcTU4Tnd5U2xjUEdCdnlJOE55cE5YUzJrN1RJTFJF?=
 =?utf-8?B?dmlGbHBkUzhoQXZrQTMyeTk2VXAxVzZRTFpPSk5VeU1qak5yVHFEMGYvT1Bx?=
 =?utf-8?B?T0xuWXRQZGJ3bnJvQXpPOU1JR0tiWUpjcnR5ZkFqNm1QREl4NmFEbG8xNVM3?=
 =?utf-8?B?MHJkNFQ4Nk4vOUVxOWx1b09rZGx5OXptOUlIUk9VRmNzczc3UE4yNXIrV3pq?=
 =?utf-8?B?R2JCRGNJdHRxb3RnVDdKaU1iTU16SUZlV3JEN21SQlRrbjh4RTErdXJEMk9R?=
 =?utf-8?B?cml1ZStDNXJTeHZyeEg0RHZoVWVlNFRiZFhzUmpsZXFiN1N6WlJLdTVUaUFp?=
 =?utf-8?B?VTRaVkk3YWFxSDF4RStTZmh3RzgyWWhqbE9SL3NYWVE4ZzI4bnFBTUpmTE03?=
 =?utf-8?B?ZE5wU2gzSEhMclQ2elljTUI4ZC9JNUtiOThFODZxTk91Qkt3bDBOVzFNTktD?=
 =?utf-8?B?ejd4WjlRaHBodklWWjJKK2k3aUVxclM1cnlKZ0ZWVHVrRFhRNTZmOW9NL1F2?=
 =?utf-8?B?Nlo2RjU0WkdiK2t0VFViMEZRY3hnUU9vaWU0NG5tcVBjeGNaTmhmb2NsSUsy?=
 =?utf-8?B?d24vbmFYWDBUUDJxRlZXS09WQVQzWmY5NlJIaGprTlJ1NWd1WDhoWW1vNEpl?=
 =?utf-8?B?VXB2Y3ZmenV2em54REloQkpqTFJqNTJsK1ZCaW1xZDlWNHYrOUNTdXE2UTNv?=
 =?utf-8?B?dXJIRS94S0krQ2FEa1VTTUNBOC9LL0dReklVM3lOQlFnbUlHMVo2UzIramh3?=
 =?utf-8?B?ZDlRWmlid3EzbWhrVjM5OFVDaVZtREJuVUsxbktib2hRZUx4eUhFcTBKbGJ5?=
 =?utf-8?B?RGMyMkZTdk42T1FPYXZVaXlubG1tbGsxcnNXYmRodnZpQks0eElTV2d6WWRT?=
 =?utf-8?B?eWY0ei9YbVBiSlpZcVd2M3BjbFpNUWdJcFBlNm5CTGp1NDViNHNWUHg1L1dS?=
 =?utf-8?B?ZHpaV2xJZHNzK2ViZGZuejE4aEliR2RsMklIMmh3U0tGUXUwWkxjZmExMXVx?=
 =?utf-8?B?aWd6dnQ0aHlhWVJOTGN2dnJ1WTNFTmczMm1raVg1bEFZYjl6WGpSZmU4d2l5?=
 =?utf-8?B?K1ExRC9SSFNpL2crRnFFNmVtMUo5TWVWQUNSbTZtQTFMMUdHaTRzYnAxQ3Zz?=
 =?utf-8?B?anEyTG9xcGxyOXNGeW82b3NCc0NyMTh1MTdPOWorL2puMC9BUEUyOW9nMnVl?=
 =?utf-8?B?QWo5eVZrVmFIRm01ZnpNbGF3WWk5VlRGbE9HRTVXMFNGbjBjS2E1NGNqL3BX?=
 =?utf-8?B?TkUva0k5NTBJUUp2bUZRYVA1cWxhRGVKREs3cFRZUlV1Z3hBa0xValMvbjVB?=
 =?utf-8?B?R0lVTEx5cWQ5SW5yTkdqUEJLZWJqN3QvZHpCVS8rVnhnMkxwckI3VFhyYTdE?=
 =?utf-8?B?d2lyK21vNmJBUytxUEUwMnQvTHgrMkczQjdpVzJERWpSN2pPdWxTeU9mSWlC?=
 =?utf-8?Q?htDcSmw2b4mDTSngPQl+YovSw?=
X-Microsoft-Antispam-Message-Info: Jjc0I92wy9/VjpADuf0VyDcOHbAOdh4D184GMaR/oz6Qd4Z2ndlh/pblSAOFSS9j/TirSC7Z6EPk9FTaAohfAheGDlUmCUZw18feXdRXH/XCSO8CRMHaYtVh29OqgH7UFjtT3too3lqkYHSW5r0F50scIq1dp/EsINwdIOa73I/yyLbCqSk4IJN6zR3RhBuFq4VAJKjk3Kaa0egMTAHIQCYKnQK5622moQUepRW7Zb1Qd/YQjI9nPwNQpckxq6DaWiChsVdhKnepMbw7E5531tllp/0oGDCEmzEYPOAobzwH0OL9nmJSPYllrw6SP+lQ3i2NiMgXrGHCwkTg2BQZGg==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;6:HTDm/AhZUXB7qkTXf2O7A+420XigMJUmYLLQi64xecZ8nvRXfchFipsPrQG/Vg25hCE6vMLBabh5Gff4siuT0xDnBN86vObMCBGNixo1xcNgHJn6ifDagcPKsDBZrwcJAL9h7w00+wb6qJ8vGHF/52FczogdT1Tcr76B6clTGXUtwlc1jO3EldG1xS+gdV6ZXiGpEYZD456TEc0uExXjFWpVVvgqibnTPXZamn7tt+Dyv2DYsvZnID6eyUvmPZ/xeKPAOxGi2g5oPrrD9SmBKp/SrVqYfBEUGycYuhUaMiMm/nV742JwmgDlmY1IwouObfYPSDEW6Yen/NiS6qDpNffbS/PCRv73bwYSh3FoQuS49PyWDR/ZUz9TIMRFNPSWVtPlaws9v2G8x8dHwh2sQm6pm/Hhcby01D0gZ4w5Vtc95HB0GBy5LwNK9CSpWlimXLXkIbpz5rhi8xvNWhmDmQ==;5:OezFd/HRpbrtQS1bdDQS7Mc+RC1DRQSmwnWq/ZgZzqlx77knrzbAGiTRRLUo7zyBx+lt6eqzPkIdU3I0sDhqQRy+wbHGz/ER5zriOB4ld2FqwnTeo+aDy3eewUPWP59QwyYhQFNRZ2KQtYGw72iJGGErscqg8C/WhAiFHtrLFWM=;24:L9R7RiRN52Mg/1N8ua8pBQjTesus0lh+vEAUeF8FNrVLF1jXPYlBwTL3SEHbUctNyLUgZ7oakENA6gPe/AHV78BmEq3uqXPzlD35KZpJouA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;7:pFCliqwq3Of4gXMyZ4LAYl3dAMXy0hr5UzxoODXmaSxI2haq3eMbN8RsNvwYaNshYjRtWokmRa+gcCnWIzU6YrWQBIZjkq8Ithh3yWZZiH26uNHxtkLHvqzup0msjxu0C8G84mo84jnSk3XI54CvUTB0hXEgvyj6HEQWB1L+EynAd+oCR1HluvhSryOnPTP6ILHOtHVIdcywW9NvfWR0Q1umHgKysXxEAq3ik5UHoIyHPlZtUnNoQ3g8AaAMZ/yj
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 09:29:34.3050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d9407-f9b3-4b4e-9139-08d5d6905730
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JC,

Thanks for the review.


On 06/20/2018 02:09 AM, Jayachandran C wrote:
> Hi George,
> 
> Few comments on your patch:
> 
> On Fri, Jun 15, 2018 at 03:03:15AM -0700, George Cherian wrote:
>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>> feedback via set of performance counters. To determine the actual
>> performance level delivered over time, OSPM may read a set of
>> performance counters from the Reference Performance Counter Register
>> and the Delivered Performance Counter Register.
>>
>> OSPM calculates the delivered performance over a given time period by
>> taking a beginning and ending snapshot of both the reference and
>> delivered performance counters, and calculating:
>>
>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>
>> Implement the above and hook this to the cpufreq->get method.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 3464580..3fe7625 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	return ret;
>>   }
>>   
>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>> +				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
>> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
>> +{
>> +	u64 delta_reference, delta_delivered;
>> +	u64 reference_perf, delivered_perf;
>> +
>> +	reference_perf = fb_ctrs_t0.reference_perf;
>> +	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
>> +		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
>> +	} else {
>> +		/*
>> +		 * Counters would have wrapped-around
>> +		 * We also need to find whether the low level fw
>> +		 * maintains 32 bit or 64 bit counters, to calculate
>> +		 * the correct delta.
>> +		 */
>> +		if (fb_ctrs_t0.reference > (~(u32)0))
>> +			delta_reference  = (~((u64)0) - fb_ctrs_t0.reference) +
>> +					fb_ctrs_t1.reference;
>> +		else
>> +			delta_reference  = (~((u32)0) - fb_ctrs_t0.reference) +
>> +					fb_ctrs_t1.reference;
>> +	}
>> +
>> +	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered) {
>> +		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
>> +	} else {
>> +		/*
>> +		 * Counters would have wrapped-around
>> +		 * We also need to find whether the low level fw
>> +		 * maintains 32 bit or 64 bit counters, to calculate
>> +		 * the correct delta.
>> +		 */
>> +		if (fb_ctrs_t0.delivered > (~(u32)0))
>> +			delta_delivered  = (~((u64)0) - fb_ctrs_t0.delivered) +
>> +					fb_ctrs_t1.delivered;
>> +		else
>> +			delta_delivered  = (~((u32)0) - fb_ctrs_t0.delivered) +
>> +					fb_ctrs_t1.delivered;
>> +	}
> 
> Having this code repeated twice does not look great. Also the math here
> is not correct, since (~0 - val2 + val1) is off by one. Because of
> binary representation, unsigned subtraction will work even if
> val2 < val1. So cleaner way would be to do:
> 
> static inline u64 ts_sub(u64 t1, u64 t0)
> {
> 	if (t1 > t0 || t0 > ~(u32)0)
> 		return t1 - t0;
> 
> 	return (u32)t1 - (u32)t0;
> }
> 
> And then use ts_sub in both places above.

I was actually thinking to replace the whole comparison with a single
line irrespective of rollover or not.
It will look something like this.

delta = (u32)(((1UL << 32) - t0) + t1);

This will also take care of the value being off by one.
> 
> JC.
> 

Regards,
-George
