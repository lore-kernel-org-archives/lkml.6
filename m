Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBEE2152C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c0CW9AhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBEE2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeHQShh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:37:37 -0400
Received: from mail-eopbgr80125.outbound.protection.outlook.com ([40.107.8.125]:53248
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeHQShh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCuPvXMzcg69WWR22Z0XvEMGNWQeuqB0KOe1hbk3l6k=;
 b=c0CW9AhKb+qsbFgXTBB7vS4yMt0JCh3t9D4c8vMqqKENnsj4dsJEQbZJeMU6UaRJ8WgHMPWdWELzjK5qkrRpyMD7Pz0GH2zY3WurGXiHmD+2QgQBJbo+5TLVgcRlZik2IkbO1kOrKSxG6H/45XZu3Yjst0/AwBYLxFcscDqFDE0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=eshatokhin@virtuozzo.com; 
Received: from [192.168.0.101] (93.80.97.227) by
 VI1PR0801MB1709.eurprd08.prod.outlook.com (2603:10a6:800:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Fri, 17 Aug
 2018 15:33:43 +0000
Subject: Re: [PATCH v10 00/10] livepatch: Atomic replace feature
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180307082039.10196-1-pmladek@suse.com>
 <d40cb118-97d7-4d2f-4b39-265341bd9dac@virtuozzo.com>
 <20180817145309.a2lqv5borwi5wrej@pathway.suse.cz>
From:   Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Message-ID: <ed223c7d-9347-9d15-7932-531bf344deeb@virtuozzo.com>
Date:   Fri, 17 Aug 2018 18:33:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817145309.a2lqv5borwi5wrej@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [93.80.97.227]
X-ClientProxiedBy: AM6PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:209:15::28) To VI1PR0801MB1709.eurprd08.prod.outlook.com
 (2603:10a6:800:5a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6535172b-6464-4172-5c16-08d60456d0df
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1709;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1709;3:JhlxVPhD2y27D7j/HucaTvp0071r4jCkOc1cuCfQ9VK+Xb4RapY5IdaEWfZKvycIVwtPdWtpOO0nIYl69W52AEdh+in9pQwIy2q/n86zr2sGuwLo0ElX5porCWo2DLeDgLPPUjoD8TrqLE6SHZqAHSri61Hv67HHouXwOkxj0NFNiEad7orHdmYTGFaUW/2g55+lE7KnWMv91+EsubMMO0GdW9IOV5HWh/OhrYx65r1TffArYeW8cg12rx5uQ7xz;25:qNUQbsnPxkyjtQ6gALNtWSJArrFkOrh8MC0Z2pKe6dEdB3mx0VdOVltEuJpSB5MGP2vMXBeq4ooaIMtrckK+rl1gFrtT/bFwYmOaO2D/ZXd1zzCFPNeaovxF56M5R+z9Ktap+fVjgAc4z2KQ1Ro0mvUSgYvAAuxyKc5rPt0JmoPqaxveYnasMiYJjBL0cGFAgJhqno/+IxBfmUNSldIm3sGBpXqEwJ/0bCzb+30qevjv9bs8SaIPwUHvGn9YX5y/olgl3IVjwWyTiM3cMbphbiGN9SuAleMyFsG4Q/QsGFJavzPRJi37VZz9lhP8poKYSgJT6mPxtoRgNVc++5oA5A==;31:+dqO4CYguASnmq5LuF8QoSb6iSH2/sJfu7I80sq1B1CUwGegizVY0UhdYix6n8Xza1a4h9J+qokevcwsUYsGozoh7iiywn/WjLvoIGTEdI6pY4D2ZjXZHxOFiAaYE8KP3tZQfM3QBDfRqrMXNTpCdbGCAylewNUGyOCnPmxyxtxsiZAzKfEmoroeObGCUZyjVa6P92k0Wz3tmkYbbhoLVRcYfeMfzW0uRLcNZa0nHRM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1709:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1709;20:sd0qsSc3VNaG6477oWRTCQ92poPeEXVwGgRf1wNDUCo954D7zFGsfACLWRbK4aB7U52zsG+7WJ7hBVhnJGGQ4MAKtDWCvrsXa73av/xMmPWkKh89y6u3Di8H7cVBNztSM1/sGnG+V6hkk+kMxaeVGCn6Z6YcfyxZY+9L2X+eyhWVwWxvtQC6rKGXdtwDLE5YyvRg3t4V42Tm/iOtDCbeW5fM/Yd1K7MCGH1Dnd+KTk3XibgjIH5rlKllKLJjI1BuDCJFeqr8EdKnadUjeyGbdaYcTNiGOFhnGw8xXic3FpN8T7oEiqnbIQdpF2SWf3POcMAtWF5WaTKZG+sQXxxivnTWalyx0IdpbHpn3VuvOomlIigqYDGR34jh6/0oaG73o5z2XIClw4EXo8Ib7JcdUIzQS6k5219FBrH0a4KACcOiVvuKnCFdKH+/mSGKIAj677EnUrNWGgrcScLRnpG4KBQoOivi5PfAnPzAQBPOZdq5YpZ1yGorRmDhNHeEAEM0;4:FR8+TG1PY4dyEwShalrKgTuVKkGJghCmGvKVV2RPztkD55S1wDy+a+jaZScwEOEVtebrzjiSzqHEXiHZGMMtKAcW8kigyabN2CeBT8VLCa0oIX0L8oZfYFAjgJfYxmgfMLztDKNDq04eS541uB+s2BrtUNzziBVqJ3gCyJgJITsmDSySbGWg1CK7BhQlhx7bDfVcI1XTyYfrCQjuHB+f447V/tzAO5+cUNo1FidRpAZ96lY28KEfGH7Zn9SEf0Ya1Q4bwRzXwsDbtNM8OtC8FjaNPNrpNpP/AwYEDqhvCufZlBBO5AR1i03IlHiJ4dFL
X-Microsoft-Antispam-PRVS: <VI1PR0801MB170904955433831238657918D93D0@VI1PR0801MB1709.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR0801MB1709;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1709;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(136003)(366004)(346002)(376002)(396003)(45074003)(189003)(199004)(86362001)(8676002)(476003)(53936002)(52116002)(2616005)(31696002)(2486003)(956004)(3846002)(31686004)(106356001)(65806001)(65956001)(81156014)(81166006)(6116002)(5660300001)(230700001)(47776003)(66066001)(26005)(478600001)(446003)(2906002)(77096007)(8936002)(386003)(53546011)(11346002)(23676004)(52146003)(68736007)(25786009)(76176011)(186003)(16526019)(117156002)(486006)(6916009)(67846002)(4326008)(97736004)(16576012)(65826007)(6246003)(54906003)(316002)(58126008)(14444005)(7736002)(50466002)(105586002)(36756003)(229853002)(305945005)(6486002)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1709;H:[192.168.0.101];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjE3MDk7MjM6R1ZFTTV3M3N3eEdpbkZkaDB2UFFVN3F0?=
 =?utf-8?B?RURpS3pjMzJCd2VZaFdrS1AycUVpTUR4UW8xNUllRnJaUE1jN1FWNGhnVDZS?=
 =?utf-8?B?d0JrL1JjaTg1TEdpZEtYcG9ZeHduL3lzSis0ZGhXcSs4d3p5VkRuNExXNGto?=
 =?utf-8?B?MFprTjVUdkRzME5XRVBEYm02NFJXQk5ETFlzcGcrZ1NoajZwS3VLSGtNZW1v?=
 =?utf-8?B?OWxXdGg1VVRNOHdncHg5TCtTRzN0TXV6MkMwYXFNY2Rxa3luQ096VUVjbU52?=
 =?utf-8?B?dXhCUHc0NnpvK3lsYXJ4Y04yc1lrWmdSN2dOWUdnSFRtZnJUdnl2Rk9Fek9C?=
 =?utf-8?B?Z1dJT215UWpHMGg1QUxYazJCNUFMMkg3d053eFJWdGxYVm05dHJqTVdEOFFL?=
 =?utf-8?B?TmJlNjZZYWVrUzQyOERCYVpoZzVYNk5mSmk0b3h1eUNrUFh5RU1aUWxoL0k5?=
 =?utf-8?B?SnRBb214d3ZRSitOUmNUUmFNUkdTN3JXb0RaR3BHbDRqd0c4SitZOE45dkJu?=
 =?utf-8?B?K2MwaEoyMXdicEJyOTRNTGRnTFlFVHRRclUyNmJzT3NuT0sybmo0aFdjZ1I3?=
 =?utf-8?B?OHcwK0NnL0tEdXFjelVNY1RyVTUrb0FNM2JOdWJGWE95SERjTi9wa1BUcHdH?=
 =?utf-8?B?dGlna2c3YnJrc0FYakJIQ1ZLWk9LZXFPRHJ2VS9NOFh1U2k2Q2lwaW1oZkRi?=
 =?utf-8?B?T1lwY1kyT2NLcDlPN0MvZ0NKaXMyNm9CK3ZEaXhDWmdiYlc3K1pSeHVUYlNS?=
 =?utf-8?B?dkpYWjkwZ0pvSnBiMjZwVDhmV0dDRHVOZVRYWTVhTDN4bmNNQkVheUErdC85?=
 =?utf-8?B?MDFoWkoyaWFsaVJEOGpxMjc5blc4V1pxd2I2YkNqZi9zanJ5Qk9OVG81cG55?=
 =?utf-8?B?R2w2T2xYUmFFVm15aHhaZHdlamNVYmNqSU5icE9pbzhSVkpmTWlERUk2N3pq?=
 =?utf-8?B?K0ZBWE1wblN0bzVsWmZNY3U0Z3lxK0NGTitTZE4yRmF1SG5pWit4SnBQWG9K?=
 =?utf-8?B?cWE4UHdpV204Y1lGT1FCcHVOWENUTmhuQXRodDZoTmdvSGl1TjRCNC9KWWF4?=
 =?utf-8?B?a3BiRUR0V0dteXJWeWQ3TFN1NkV0RjBySHFYOVd3VURKeVA5Y3JtbnlER3ds?=
 =?utf-8?B?ZDVFVVB1VG11dHRSMGE2VHhMcjRKTWVYQ2hvQW5lejE3cnJYM3A3UWh3THhp?=
 =?utf-8?B?WDBBRkFQTGMxN2hiQWs4MWFFZzk0TXRhNFhzMGdHbFJWbmg3NTVuc1RGZjVz?=
 =?utf-8?B?R1JKbG11SnFzdzcyWDExcDNWaWZYQ05sNzk3dnBWTXFzUDhWLzU2Qm1JU2dN?=
 =?utf-8?B?TGFEeUt4a1lWWm1kTjk0Kzdsb1BYNFJrYnRLbmt4MkQ3V3V1UmQvUnE0Rlp3?=
 =?utf-8?B?MW12TDVQdXkxS0w4YnptOStDL3pPYzh6YzBkYzY5R0xKeGFmank2ck96cGl5?=
 =?utf-8?B?YzNPc3NSRHl2R296dnFhQ01yN09rTEM3N1NzbGMvU1p0RzgyOFp6TlNaOTla?=
 =?utf-8?B?RC9ZR2NOeTdaTFd5MnY5QXhjaWxPbVQ1RkNmRWdCYlJLS3k4UjJXMitCb0lR?=
 =?utf-8?B?Z2daQTl5K0ZGU09SK0RkRzRaUk5OdldzMlJSbGxMbzNFYWVkZ3JkZzR4MG9p?=
 =?utf-8?B?YzB1YStTS1lnSTBMblhnb0pDRlFwNnVsUENBb3lNZExEMVhEbFk1cm4rKzJp?=
 =?utf-8?B?WFBkN3JFSDlNS3JxbzFPK3dwYVpNNEQvSkdpU3pXRldiTzlXbzhud2hSbVhP?=
 =?utf-8?B?U1pMYnNqNE1nSEVTSkMzTGZ1aUVRUVZzTVY2dk9QbjJudVFYMElXczRITGI3?=
 =?utf-8?B?YTVNODg0end3SEs5TlZLL0dCVnJmcGk2VWpHQ3VDU2hSOXpDSzdRZUN5c2pw?=
 =?utf-8?B?U0ZISEFvQWJydTE2S0N3UDFCRWhoc3RzeU03QU5yN0ZXb1hpVEh5YUQ2UVow?=
 =?utf-8?B?R3VzT2tUS01UUWZyYjE0RVNqM2RVMjNJc2svUmNpb0cvaU1YaFZLeTUyUHo0?=
 =?utf-8?B?N21HTVBVbTNiaFc2T2lnSy9FdVVEWXpHbXhuV2Z3PT0=?=
X-Microsoft-Antispam-Message-Info: IAXgcbWVU5XlQoHwXWoDYKvxL3OfwfR35s0X9qLcW4NBkKMzXB6tRL5L4apGmQ7IaGeiP+QvnymnajcuKDWI7lighe8kiZJG3wozENhUfvLLiCNZByuKwNcIqCWwLSFOedHv+9Ua0PDae3e1mnwrv92IbXdN1Zzfp0ooCBes87KNmlixH9LeWqFbnEMG7XJXkpMBG2tCczTmC0NgnBeY9PDIwQqcdwq5K8M8NuF2xE0U3Cb8Yn4/CNlO5fu/BRTG5maT2r/Bek9AoT3uugn3bzC74fhQcG4vAMusoCG4gGJhm9CbPHv9U5wgNRv6lfYzkebo54IU4zSOeIU01JQAIrmQdrTEg6uL7CE+xezF2A0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1709;6:q5TiAgKKJYqQlGARTtbJSd5MfGsHqJR5njC6Rn6X7I149TIkK2Gy+zgy8PVMesGDCsQA6t2syw2iCAqDIOxjsoFevaf+q0J1VTj5n0m/glGVnNlvdI9aj7YjWpKru+NyJ6UJ+vip1GU8pv9K1iCyDJN4qdZ2NbsKmeMF5bp0wyr0/xTV0yUewxrFSuAP17JwNRo82lLvyON2+291appmpTwYpv53OEd+SfjFLao7j7BZ872nHGzywET3R3IJlZCl0zW93uiH7J+bQIJYzSptmKc4wm65XJRl3THe23h/K6nX2MsVT5F7RdxlWlnOiQdLolZfxbhx0R1ZgS+2upbREUK7zGjLPJp03Dp+lfR1I8kKTCKTE8ymLAPgpZu1Jk99wovLVAwkODcNDogDXK12PhpPpeP9BcEPVJquIHyFReu+yx+O8Pua8PuruQ/kPZ3LS26kZj6s0B8zej3h8wpxpw==;5:pYHJRuPimi6/9SjeHNetKJe3rMoHes16CGJ+kLB0Vxt1f56CbQvSVsvJKMBicw2O+RiK4iBQQeF60eFO313IRQK4ML1Ehw5YYGNi0Nuiyr6mEi2rc/+DLTtFhMiLXPa0sT6b566kH8zF08ZygQI7j9zB0IRXEaxDJMgjx4HMbSQ=;7:iScen6uyu6jCzIQsx2MlMDW3vmAU4Q9fkZpMZS39DpsIa6jhcx0fM8WhnkcF4K5q8UOklqX1xJQ9mUh7Y2O9lNZFJ4Zk1ggP5rWWugnIsh3eRWoUSAoVStnAngksd9a7nNqHcbQEZ7NczNtlELn8n7xJyUP170caewheHrZhO5fA4pTNz74Gth/9ZFmh29M2M86vQIq9K8U3D2OLxKtgeB0ABaandfK4A9F1WiZDMVeIAAGC9mV97Gp76U4r45gX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1709;20:z5GcGDQeSuZ7I/Su8hQWULM/WI8GSQriVcD4GJZSBdNwtNh/is9r0M4dQpLma8khNTx1QwbJ5YYhZuYm3klrClhnv31h10r8KPe6vZtRjL9S2E7fT0REJtmH1oCnt66XK12EvHZ512Ilc/Y6qOufzb8zr8w/Stm1lnVCGJ7cQLQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 15:33:43.0155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6535172b-6464-4172-5c16-08d60456d0df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2018 17:53, Petr Mladek wrote:
> On Fri 2018-08-17 13:17:27, Evgenii Shatokhin wrote:
>> Hi,
>>
>> On 07.03.2018 11:20, Petr Mladek wrote:
>>> The atomic replace allows to create cumulative patches. They
>>> are useful when you maintain many livepatches and want to remove
>>> one that is lower on the stack. In addition it is very useful when
>>> more patches touch the same function and there are dependencies
>>> between them.
>>
>> Could you tell me what is the current status of this series? Looks like I
>> lost track of it.
>>
>> Is there anything else that should be done here before this series could be
>> merged?
> 
> I have almost ready the rework suggested by Josh. I still need to
> port the new tests and send.
> 
> Unfortunately I had to put it temporary on hold because of other
> important tasks.
> 
> I am about to leave for vacation (one week off). I will try to
> find some cycles, finish and send it once I am back.

That would be great! Thanks.

> 
> Best Regards,
> Petr
> .
> 

