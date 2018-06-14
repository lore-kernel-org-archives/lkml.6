Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA505C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8230D208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ZFPF+N0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8230D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755061AbeFNLyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:54:43 -0400
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:58392
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752767AbeFNLyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMx69qs7fnIRDoPCFSiFG0gYG9n/bgxa62urC+hNl0Y=;
 b=ZFPF+N0VgnIoyD+XMX1WvZZ9yUj0K5y+MdZFC3S5xZCWiuNhHBzYyxvOzTfUMtojRAsbwuXRSFlgMaKQy82CKNZJMMCpFplo8FF6vj3uGRgcG5z7J7PvHNSAs35NWxmDyzUdDkMigVh84G67jgcevjLhLehb57KfYQdx9ylhaf0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4591.namprd05.prod.outlook.com (2603:10b6:805:38::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 11:54:32 +0000
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com>
 <20180614113604.GZ12198@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <7eb10c22-57b3-1472-0a77-7f787f612217@vmware.com>
Date:   Thu, 14 Jun 2018 13:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614113604.GZ12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR05CA0381.eurprd05.prod.outlook.com
 (2603:10a6:7:94::40) To SN6PR05MB4591.namprd05.prod.outlook.com
 (2603:10b6:805:38::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ae77aea-ad34-4c7c-a3b8-08d5d1ed99f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4591;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4591;3:An6NS6JQUmqwlf1L8iIP3aQd2J76J3aL9gDoil0HAcKaTwI6wvrTDEs1yJwJnK6/OLzajgevCwk8WNON/gEvzWuXMsspsJ0w9yM7MsegouZPtmSkPiAa2xqBzkdn4t4x8lHVTO059qrdl/koC/UsKNeBRPohffAqgjR7J/Tv33RZ9QamLC/GSJ3jrZHtq0Z2iwpx3SFIUa6cqS+fyVRVPe7e/bUTF9lYKOAV/ZY+Npvj82ry82S8x/l5AOMw2u9n;25:TM1vtGt0Sz3GZC9Sn3v8ZRTytvPX9ROyfVrnLXou2GZ1sPqMEMZdLtgh3YIWP++fOactiB8pMEzQRjjtBGHDlajfepPtkJvIIu/Z4KPGVWLrBfWaiQoWO1v7X9YxhdUqpLomSHZMq4a7dsMAIctQs9jU3jVmSkRvEOetsbAVrK9BOBe2N9vCMEM59RW9FHNgUWbI0F9LLhyeT6YJz2mONKk5zW5hc+nPiJDnOKjLnyrK+ZCFWBzac3nyMW37tWgPpve/LXymUF2TKy6JN4j+icA1vr/GdYBSKmHScIfZrjRFt45BzhRqolLMZ0vAkIVyZJvHTgBTcyz3Ni49JqJK1w==;31:poP5eVwxfE/2IcD2x7g3nwccfUVZQTawdB/hGmANPkAU2soPUb3t2dCj/vtZhp/HG5ARzY+yu+fbm+MvU+Zd/DpMFcThDfWBCe73TknRVsYERsjgmqGFPsCnj95TzhALC+ma80wyszIzC4ggbdLpDkOVufdt6fvLrP6XGhNC+NymrIwIwkBX+K9iemKQmCOnEVGKA75oI9eLcGyEofMivsiMACWP9SXKBzECMq2+f1c=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4591:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4591;20:0+zfuVRtSBPOr0E8SKpp4EhX484M+SRu7/1dqOcKF6mPnYHluRlMesIOknwIN8HQMQuoI+EoRBpMRfSS6ASeCVbULHnT5aZMxDmVo5p/bqiMtbRCZkdAj7YB1brC3TapyEHCvccmMiR5lXJIpPGMjg5Nb80fkLW9HYyLWrm1F7mmmEhJV0WXi2CG/akjlK8/ju6rmCf+wNUYXaHgU2RAZmP8yhWMcWDi/yfpEpbNhL6E4fun+x3pTwHU84otMBVFSuKCyk8JnTJlOzg9MWEjwMrzczjVB8TQW4rVtiB5Pab3B9wX6vWkglErs/xC3J1gUazG1LfFnypkgFRS5+/OTdPUTSnz4oGntnz61Ov2uwGTHIIEMiqvDeN0J1jaCnySVXpzJwr2wZ/exHuVv1pHZQ9UgrhcdaPlCbvF+9RymzXlWOhrEmeP35KX3NLf4vRWdLc+Vu3IuUkrUD+qj8tfPpP8SNxFpBdG+s13nY28eRVeifbLWiEdPDQXByxJ6xQv;4:A2UE9auDBhLuDPYv9lfeTNl2E17IOzrlsPGDvDX/r28ZJEB2kv4SevhB85b0hXa98jJ9P+sUFSZfVdV8k0/bEr0Jvar76/QCk+/fI8AbdQsbeLVm0coXS3nQeufMq5rtuHNqnGlAQvltXPUdcd8vhLayN/cbH7zhtvDpT485IH+k+BhnzbY/TGGhQKjrARd+JYekLVG8VFLfQB9tAcigHWLakUThh/4DIYKjdJ+hazqwVUVOJTFPGgFw2NuKKx7EXCSvz+WCXjTSnNaLBSYH4Q==
X-Microsoft-Antispam-PRVS: <SN6PR05MB459164A29BD21DF93D063E6BA17D0@SN6PR05MB4591.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4591;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4591;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(52116002)(66066001)(316002)(4326008)(65956001)(25786009)(6506007)(53546011)(386003)(59450400001)(106356001)(76176011)(230700001)(86362001)(2486003)(53936002)(6246003)(97736004)(58126008)(54906003)(31696002)(52146003)(105586002)(68736007)(6116002)(47776003)(3846002)(65806001)(36756003)(81156014)(67846002)(50466002)(8936002)(7736002)(81166006)(8676002)(6486002)(5660300001)(26005)(7416002)(64126003)(6512007)(229853002)(551934003)(65826007)(6916009)(2906002)(16526019)(476003)(186003)(956004)(6666003)(2616005)(11346002)(23676004)(305945005)(486006)(478600001)(31686004)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4591;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA1TUI0NTkxOzIzOmdGeFhuZStlWmJGUm1SVWNDbCsvZy8wN1Bm?=
 =?utf-8?B?SmU0SnNrVEZGVnRjUmRjOVllWnNsQmFjU2FMYkx5Smxqd3BzNVJxWENoSllW?=
 =?utf-8?B?NGtmN0U5YTBpc1Q2Vm4xVTROWXJKNUhoLzhscWp3dmt5bFZySjZpSnpTQ1Z2?=
 =?utf-8?B?a01kb3RQZSsrMmluVkc2Y056eVpkL2hLQWV3a2VCSkNFc0ZrVmtybGE1UnNk?=
 =?utf-8?B?bWJ6REc3ZmxrUURjUnMyaXVMSEFNTGZTRWNLSldyMEMwTFF3UXcwSDVoZCtM?=
 =?utf-8?B?YUFXbC9sdnUyUmRMdTE3bXZFQ1o1eWRpcndTYlhQSHVISXl5ZWVHYm01OE9k?=
 =?utf-8?B?eCtDMytDQjZlOHJuUGt2STIrVHo5YTgxNThVMTJCaHBDWWdrMEJvRDBzM0Z1?=
 =?utf-8?B?NG9TM1JPK2JSWmxmOWNiMS94bnRkVDdLcVNacUVSQm5yOXhYVUZpS0kzMlJD?=
 =?utf-8?B?SzU4QjJkeDJVQmtOTFdmVzU3S3kyV1laSnVVNjZMK2pZTDU5eHUxQ3F3b1RQ?=
 =?utf-8?B?ZFh2a2tyUWZFNnR3WDV2N3QyTGIvdHplLytFS293bWU5ZE40R1dScFdJb09P?=
 =?utf-8?B?NGw3b2VDYmtnRkh5N1BEYVpyeFM5ZmdrbFBOY3oyaTBrbVNmdTI2R1Q0SVR4?=
 =?utf-8?B?eWZ0WTFPWTM1WElGSGFuaCtKNHQ1ZmdlT0N6ME9PVUpZNmpjMVVBalJ6WDhn?=
 =?utf-8?B?OWxEQU83cUpRZ1NmR3F3bFJBbVNjK1Y3dU1CQ1VKUXdybHRxSHNZZFhVWGFl?=
 =?utf-8?B?bW11bXhXUmRPTnlZcUpZNEpVaUtTd25XTUVzck1yV0I4YVQ5THdQTllmSDND?=
 =?utf-8?B?bjRNbjZWTWdaUGZ3bHlNbkMyQjJxWkJQT2RxQk8xWStoWS9xenRYSG5SdklD?=
 =?utf-8?B?V3AvVkdyT3BwblBxcnRoRjYvN1pKMFEvaXNrQ3lTVTZxWWMrTTdWaHQwNUNT?=
 =?utf-8?B?NURPMFlOaDhydTNZRW1aQkhpeFg1Y1IzdWZNanlKMjZFTXBiT0xVd2JlTmND?=
 =?utf-8?B?WG1CRHF3SnRnL0ZyRlFiTVBwcWdmeFZpUDJzRjhvTW84WFJQcDFUNWdYd3F5?=
 =?utf-8?B?VVdXNWRZZk1DazJrVVI2amhoaTN5ODJtOTc2WUNYZlRkNDl0aXFjRkNHL3Ns?=
 =?utf-8?B?ZHJHcDhNbWlwc1pvSThqTWM4cWZqOVVlK1VyTDNBbVhLdis0UEhONXArcnhP?=
 =?utf-8?B?YlRnUVFLTVd6NEJxRDU1MUh5RWcyanpWTHRGdS9icHlDb0dhelFKZ0plenhv?=
 =?utf-8?B?N2V5YlM2ZWdRcHRSUWs3VEhVK201c3JBN3ZwbU00SU9rK2VFRzQ2MXBNRnhx?=
 =?utf-8?B?Q2V2TlU2UXBzRm83UXZJK1UzM1hySUpDSkQ4eThtSkNOMWFsb3hXMkxoVVpt?=
 =?utf-8?B?b2R2djIySHBWWE84SkVsWU5ZY3dqZ01UdlBsNEk5UFNwYTh4QnVXR0F4bjE2?=
 =?utf-8?B?dUs0UFlCMmhWcm0xRDJmeUlnNEoyQm1iOXQ3czdLRXlsNit0L1JvdTg0V0s4?=
 =?utf-8?B?WUpuTlBVamNZNmxoVW1xd3BZMGF1eFJrOVAxdlBjVlZMOFdsUUljSG9CSVJv?=
 =?utf-8?B?Rk0rR1VtT25xeHo2UERlRHB5Um5rV3crYjU2SStvZFZQb0U2bCthL1lBa2Ux?=
 =?utf-8?B?M1EydjcrZ0ZPS0dQd3cwa1RCeklNdFlodGkxcDY2eC9ZZ3NXWU9YTUxhMjJ6?=
 =?utf-8?B?UUVmY1hjRzRoWWdzanhLR0t6OE5PSXF2cDBWRUw3S2p6OVdZVE9aWkpsaldK?=
 =?utf-8?B?VmdKY2wyZFlNMmxpTTNCTzRtM25lR0V4QnVvVjV6cE9wRm9TbHUwRjIrdzFB?=
 =?utf-8?B?eUxpOExwMFBTOGxjWTZtcWJ2VUZXNkFyVW1WWDZ0d2xQM1Y1Z2lvQVBXWFF6?=
 =?utf-8?B?MXJERzZUYldGU0ZJN1Y0VzBNTHVMRWg5N09XRmhxV1dodkh5aDZmSmdjNita?=
 =?utf-8?B?cVZRUE9vSU0xa25tdzlyVjdNSkw2bTRucEc2RW1QdXh1VWdmRWZDNjJhLytZ?=
 =?utf-8?B?bVh2eVJhaHFoOUZOLzlta0lwZUxCMlBPUDl2cDBFMU1RT2ppR1lpOWcyTXFM?=
 =?utf-8?Q?H81Pw9D6RxWDSrWtrxgYw//D8?=
X-Microsoft-Antispam-Message-Info: 8xiSCuqnOJ96xoOKhswa3BJs7srM0m7bhNTDXPDprjJPE9GMiNVM3ZLCgYsiQ32DKpxKxcl6WDdMgM6njyujokuoMDvjdwrimaLVo3zvkBX6s4xPOcFf7lr6RD/P9zip2s12jMxHNymuFoS+6zy2e03mlkM2Q7jeFXNiAEu1wTGpCempVY8uEXmMv7q7U1oW
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4591;6:5LMDLZd7kBKhlfhsKEkqnsS0OZS29lnXCnYcxE4nsU9/EAS5U5WOO7LYYzgDcbgEs0hmKILHEs4sEd399QCQQwTzTiGUp3MBM5KGjIG5fpVyRm2CUru90gFtJc6xdagao9RWs6D5zeVuz/ixEaqFPjsRHBshKx10QcP604czjnVvs4P2hbUsRqrtKEEgBu5CCPTt+6QXpIL0xwqHCnpuSLbjZeILr7cOZ3ZrF1PMcybGqVxOJYJHFn0zATJ7IPt0u89BjViAVCLLZBQMewp4mL88PtA8RYDt3aDKWUxJWJV8R218cCjkPOZiBPlNzwoPLdrtggoGAHJmrxPGZmsSx6uslH8H8gOHFHk9rQ0SPQBu/XjvxpsTyO/TRthssmXoIVhYFbjhG8qS4P26eIkSVOtSc/QqSjgZbVF5Ybu+NR2ecWKUv5yOmLRSSvtR1fHRGLWYigHdWntEw1ex0iOeAw==;5:sqVAq3vs0dNWo1VxFofyVJRk0rWJFt+85WjtY6+8D7xhKTmSnNVtuD15bB99XQg6ztmqLBCowP1FSlqZbmdVM6Yio5gT2CrQ/U3vLrvAlH88GQzRm/DQDCdYmYu+f+PeKRwrubZPZl8faWnN9NnQABGXFoHiH7nd1kkNId7G2uQ=;24:7O5G8+ZGCUSFpqvvh6/96G1JLbqnEhiC1O2LM2fr/ttom8pw7Hvh2WQA5SA0Flg1efQQrqRzjAp9HEUq1A0qGb3ehpUUr4ZlddfH9EL7pEs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4591;7:P4ej4RkgFLjzU2F81vufUzh+r/n45wu0OOliKh8scdhlEX06pxWshGTnCEaE3Gm+sSM7tSC+UHEnPniA6iPp4AF5KgpXFe0+XPSk6oNAh6E/0fGkTqi6T6LDdPUn7hUgFA5CZf5kmlZD0KUMp5vu0lrhNy2n4c+QIxscPLQODjJU5aTdsW7s4iDsACavy5IjDQX5AD+38rQiZlpLwEqzdwLWZLezuCjwUSukm+RQmBOGTv3sML5LQI+lmSxmLeAb;20:UJ890v9GEw2rM3qiWqIc4uqev8NU+mL56r3nRM6tRhAtFzvHIt2RLiR5TWBC7XH/WsD+H3/ymyGdJ/YkeoNMfCQXwiWVrw9wiVKdHlC7Z5WKpohaYXESWaip4yCzv0QWag+y08rK7JNbZBgZLTU15iFrPNOqWHuzqgqArSJbqqM=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 11:54:32.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae77aea-ad34-4c7c-a3b8-08d5d1ed99f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4591
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 01:36 PM, Peter Zijlstra wrote:
> On Thu, Jun 14, 2018 at 09:29:21AM +0200, Thomas Hellstrom wrote:
>
>>   __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
>>   {
>>   	struct mutex_waiter *cur;
>> +	unsigned int is_wait_die = ww_ctx->ww_class->is_wait_die;
>>   
>>   	lockdep_assert_held(&lock->wait_lock);
>>   
>> @@ -310,13 +348,14 @@ __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
>>   		if (!cur->ww_ctx)
>>   			continue;
>>   
>> -		if (cur->ww_ctx->acquired > 0 &&
>> +		if (is_wait_die && cur->ww_ctx->acquired > 0 &&
>>   		    __ww_ctx_stamp_after(cur->ww_ctx, ww_ctx)) {
>>   			debug_mutex_wake_waiter(lock, cur);
>>   			wake_up_process(cur->task);
>>   		}
>>   
>> -		break;
>> +		if (is_wait_die || __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
>> +			break;
>>   	}
>>   }
> I ended up with:
>
>
> static void __sched
> __ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
> {
> 	bool is_wait_die = ww_ctx->ww_class->is_wait_die;
> 	struct mutex_waiter *cur;
>
> 	lockdep_assert_held(&lock->wait_lock);
>
> 	list_for_each_entry(cur, &lock->wait_list, list) {
> 		if (!cur->ww_ctx)
> 			continue;
>
> 		if (is_wait_die) {
> 			/*
> 			 * Because __ww_mutex_add_waiter() and
> 			 * __ww_mutex_check_stamp() wake any but the earliest
> 			 * context, this can only affect the first waiter (with
> 			 * a context).
> 			 */
> 			if (cur->ww_ctx->acquired > 0 &&
> 			    __ww_ctx_stamp_after(cur->ww_ctx, ww_ctx)) {
> 				debug_mutex_wake_waiter(lock, cur);
> 				wake_up_process(cur->task);
> 			}
>
> 			break;
> 		}
>
> 		if (__ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
> 			break;
> 	}
> }

Looks OK to me.

>
> Currently you don't allow mixing WD and WW contexts (which is not
> immediately obvious from the above code), and the above hard relies on
> that. Are there sensible use cases for mixing them? IOW will your
> current restriction stand without hassle?

Contexts _must_ agree on the algorithm used to resolve deadlocks. With 
Wait-Die, for example, older transactions will wait if a lock is held by 
a younger transaction and with Wound-Wait, younger transactions will 
wait if a lock is held by an older transaction so there is no way of 
mixing them.

Thanks,

/Thomas


