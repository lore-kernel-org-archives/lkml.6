Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3A810C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C418B208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hfEY0uWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C418B208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935303AbeFMKlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:41:04 -0400
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:2224
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934508AbeFMKlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FuKPS/jppd/QdY2tFEZPZbOSGpWMFk99HE7QW4p04M=;
 b=hfEY0uWofAzHULUgP2KfBJKuRJbgCwWwGH4ba8Jwf5FpPUgvp88YbPaPUkSj6kV+Hp0ikt0vErPWRGyvY0lfkIyE/NOr7xIWqnDjH5aVCzp1m8XQcE1Wwq95LlvP1UunEXFG/aZBGgccuQJUtakSpIhE7k4D9G/H4p0R5lAwu9w=
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4577.namprd05.prod.outlook.com (2603:10b6:406:f2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 10:40:53 +0000
Subject: Re: [PATCH 1/2] locking: Implement an algorithm choice for Wound-Wait
 mutexes
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
References: <20180613074745.14750-1-thellstrom@vmware.com>
 <20180613074745.14750-2-thellstrom@vmware.com>
 <20180613095012.GW12198@hirez.programming.kicks-ass.net>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <69f3dee9-4782-bc90-3ee2-813ac6835c4a@vmware.com>
Date:   Wed, 13 Jun 2018 12:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180613095012.GW12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR09CA0063.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::31) To BN7PR05MB4577.namprd05.prod.outlook.com
 (2603:10b6:406:f2::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10174c9d-3ca4-413f-3a9e-08d5d11a2539
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4577;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;3:GT6EwTf13O1gEOM0+E0UTfUpwIBlJ/kzymwMJDgJ99HAnYy6hnaVWEbTrZh+4d8qlucBMNNAL1Df0XHuG0ntpm0LWrHOcTYU/iBJMNEn7xajKQ9MCjzlzww0WuEP//JyfeBQ86OfqM8J3RC4nPjYeMssOc11R4lkKqDSk9NJJFvacfSEfyup7DNrDc9m2h9er/OmuOmwLBOhdP0FzwutNB3qP3ntHz2K2BRmrPRzF5bK17dBbWac2l6rvCpZ8Dxu;25:G/hnvgbpfL+eglj9ZlkOUlXQgf+WNuyMBEYesin2YPZ/Gqj5oSLBkXdiy3fvt8fnvPwxrzK6kvClJ1VNAYPgvtTe3pxlU5BjuyErYGUp5TK2B1SxIpFwrDCjBWLJL4uoZyz3tG9Y8lkfqMPdqYJUlR857ss62rS38Tv0FNKw4U/JNO3myb30nF1yylsdEJ8pLyZ8AX8XRoM51U4qbLt4wwtILrQCj6SOm/o/X7Pnk1oVIRhNgOV2o+E+ZVHtYvQmcSp2buFoO7xuv98dca7zkB9nT1xS0q4CPC+f75jr8JN/ATWjnbgmumyTgK17I2Abv+JQL/CJxy8Faptf20N+Cg==;31:neT4yTeOtZSEkZ/q1iZjiPQc7NqlopepqD/IQmVZFSvYFfDxarjMMlbVsj3JCT89l0Y2DPGXlI6Rv/9aDO7YSKJNvgiHBr1GfhH0iZGL5SzvEB5FY7qTqHWqkkxNEXspprygdXC9xnRWXp7l/Q/QGy8O4chqG0XKb98oSsTu5MYOGUFhcXmJoFBUxTM8afpLIskmG1dSvWrubKTbfq/3YlrkgIB88TdqluMiE08SHD0=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4577:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;20:weWnZtjH38Yfgu6a47YSE7YaJci1BpqzgXqpVlhkrTDomr0MCM/TLE3RMpCAq5W/C5fd0KMOVoE3jP1bvbGH9DJ4vdcNKpLgapcvoJ6ucYbMGBTvTD+taKfJ+HIk382/O5XYGO3LewRZ0FL0a0dIOUZQ+jfMBHzdbav1xYZmOExPO84byiVZ65aqr960maeaBfM7HigrgxCY8+B/AnTvsC+Z63v9KblGZdNCL/4CijEQEkjbnYWWTt60SwC/U2LYELXRfmVRh90m2vLYRqdlAjSnqnAZlYL/VwN+UbZoFsJvswYzC4oR6WMuXALCBzD3CCJKDuAB1/d3FDXN32+3aktl118VNtXRN901+L+NjeMOO2PdigBdhvU5vafpCUl0VjhNLky82TUh0FaGbMX2aUa5My79007Bi2bItqKc+P+4hqHaFfX3Fhii1HaPH8UboOA90MPQLcmcQtV1HoeZLFUWFr7i3B/usUVxyU9f+NDDuO1CHRpwl8QgN91uuMwg;4:V6zLd99lAeaIuT2hGHJJ95o9zHwFVcWC7+vhpqQlsZblJ6qgqOueubQpoHBNAdOHTLgetqlzd7cLPefKsOsJRNLHKztKtWH4Bo/tbWttdZBQpLtdWNDDhpA+enM2j8RR0+XFwmZYOLK/8FQpMdv5/VsWaqO+9TIg3qpT6hM13tu5wf2ERaRn+Oaebb+7gkTBoiWNFw/O0B/zZLQ5Hig+xypvgJxAlseCb34l3BXg3O6agdjxEFOtrLKb2sW/W3Aae7juxo49TPgsnP4VwTsQHg==
X-Microsoft-Antispam-PRVS: <BN7PR05MB45772E5C2D28781B3AA83A5BA17E0@BN7PR05MB4577.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4577;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4577;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(396003)(39380400002)(366004)(39860400002)(189003)(199004)(51914003)(6486002)(486006)(52116002)(23676004)(31686004)(52146003)(229853002)(105586002)(2486003)(106356001)(25786009)(47776003)(65806001)(65956001)(66066001)(68736007)(186003)(16526019)(36756003)(26005)(8936002)(76176011)(956004)(316002)(2616005)(86362001)(476003)(8676002)(446003)(81156014)(81166006)(11346002)(6506007)(386003)(53546011)(54906003)(31696002)(67846002)(59450400001)(58126008)(6666003)(2906002)(50466002)(6246003)(6512007)(5660300001)(65826007)(230700001)(6116002)(3846002)(7416002)(6916009)(64126003)(7736002)(53936002)(97736004)(4326008)(478600001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4577;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA1TUI0NTc3OzIzOjZhdW52UWU5QjMwa3Z1VWVodHRJeWtFVFB4?=
 =?utf-8?B?OHUzc0xXVHpqVFU2dTZ3cC9zWXQvR2x3cFNOOWFoWk5SSloxUW9aR3d3UjBL?=
 =?utf-8?B?a1ZHdmVoaFBJc21XdUFFZjRVUUJBWDRCUUhmTDc5czQwdkJCWXNYejNUajhH?=
 =?utf-8?B?WjkzRjd2SzVPRnZLdVBONjRZVHZocE1ZZTFwZGhxYlJBcXpFaGVqR1JRbEtD?=
 =?utf-8?B?eW42eHQzZDdjZ2E2eGR6Q2lPN200a2d5YjN1NTYxQjU1K0Q0R09YazZYZWJF?=
 =?utf-8?B?cWdwTGVhSXlqK2RIdXBKWTBycUZUcEdQN3ZRSXRtekFLekdEdkNJVnYrekVs?=
 =?utf-8?B?Zjg4dWthTjczdlZUTnFESHNzbEozc3ZwK2RuQ1ZhTEpvU3hiQ1VuNHdaMW0z?=
 =?utf-8?B?UmxUV3ZDdG1xWldSdEMyTXVnRzNNMjFGdkkxdWg2eDIzSHlTRTlyZGpNVTFz?=
 =?utf-8?B?bTFLeStWWXk0U0w0cEhHUXgrQmpmM2E0eWpiZkd4YmRqM0Y0SHlrTGk3S2Ux?=
 =?utf-8?B?QVI4cFJKTEQ3Sm1WM2h0cWJwbnppVXkrWHBTMS9VcWd0TkdMUnNlcDJ0YzBi?=
 =?utf-8?B?OGtjZnFHc05YaXRpeTdscHBHWW1LdGVzdTgwMlFPbmdLb3RwUVRqZjdua0hu?=
 =?utf-8?B?Z01oU0RHZmNVa1RkZzFuK3kvVTdTbElBQkxLU1B5dDRRQ3lmb1VkTEpuNzJS?=
 =?utf-8?B?QU1VV24vK2FyNHlWWHM1cXZSNy9rQjE0bVM3UFpUN3VXaERyNWI5ajBvK09w?=
 =?utf-8?B?R1ZpNkRXaVRrZTJRYTlNTXRHclRrb2R5WFlZZURjc2NxbGprZEFqdHBrQlpm?=
 =?utf-8?B?eUNrbFl6c3I1SkJKSlJHK0F6VGpobTYxYjA5SU5zaENiVUQ2Y25JdjNJdFBL?=
 =?utf-8?B?Z3o5aFpjdHdZamd4cUtZN3Nsam5JaE9zTUU1S2xTM2VKN21zV3lRUGJFSEta?=
 =?utf-8?B?SlYySUtNQnlaVXp1QTV4clI3YlJvUnBPcWo3Q0Fsby9XamdxbUE4TklPZHZ3?=
 =?utf-8?B?NkJmamZxcHNuMHJCdk1QVkJ6M2JNb2ZyOGxxb2VBNjlCb0ZJWWhIOWpuYkdn?=
 =?utf-8?B?akN4WG5kSGNDU0FrZjlpU1ZOK1o3bnllTnZvb25lUngvdko2KzR3UVd6MGxH?=
 =?utf-8?B?dStnTWdtdkxISVhlSVdVd1FLUEJGbzhIbGNQc3VzdnkwRG53QTRBeVE4dHYx?=
 =?utf-8?B?RlNXd0orMTR3b0c4cXFxZjJibnVvaEtjTC9SalMyN3d0RUFGak9uYSs2ZzFP?=
 =?utf-8?B?U2RLZEtTdk5OblVOd0U0N3dSK25ES2IrQWFLYktCeUtGQ2VwUWltdmxYSy9o?=
 =?utf-8?B?REZ3OGN0Z3FNRXJFTkRCMTdtQ1RBK2ZWaEd0ZnhWR29wSVJDTlcvNG45aVBR?=
 =?utf-8?B?bmhWdkxZRkNRenRHQTZiTU4wbzk3VUpabUplVGVVTnJlTThiV0Y4ZU5PYm9K?=
 =?utf-8?B?N1FPYW5QR3dMaTFxT1ZxM2swL0Jxa3N6andBNER5UHZ4UGEwRW5ZUDlZR1lQ?=
 =?utf-8?B?RjhmK29DZG53Tk1GVWMxdWNWSVhiazRMZDUwTUxOazZMMklLcnlic0xQcTVu?=
 =?utf-8?B?NTM5TnZuR1lpcCtOSFdFdFl0VU5nb3k4bHRCbXc5WGY1SmxOZFBOMzllcUNO?=
 =?utf-8?B?RW9IcjdIS0FNalFSRDA2V1BSUFFJdStKWjJuOGJiYkVHdXNyZ3RseXZYa0Q0?=
 =?utf-8?B?QytNcDVXSEZrVnZoK3BCNEU2R0p5dE5vaXNERXFZaGpRbHN4Y2l3N0NOUzhR?=
 =?utf-8?B?VTJmTEpldVJ6bkJTRi9SendFa3FrTGFnOWcwdGJWUFNrTzg4LytaditxbE9W?=
 =?utf-8?B?VXdZSFBnbDMyalE1WVcxTUgzdERQdWZydVk1aytzaHoxckg3MFJ5RUZSclZk?=
 =?utf-8?B?Wnc4WmVOUGZWSzIxTG5sd1RKRTJ4aldsNHdwRkxGWDdRWVBaU21TYW5tZU9a?=
 =?utf-8?B?ZW1WRmhtc0V6YnJES0lOL1pUTjQyMlRaSUVGZzdkWXFIRUFLY0crc2FydThT?=
 =?utf-8?B?VzhKQzJMK0J2dnlQMVlVajZMNGZEMThJNVY3amhmTWZJRUJWNTBuczBXYXM3?=
 =?utf-8?Q?FD5RCBOPPzhCTRx7sqytsu5wB?=
X-Microsoft-Antispam-Message-Info: BZKti0oAe/qM2RkelCW7j7DyLMeT+xLSIzP58waOzHD6wCvdL+EXmPpKA+uQKALgkONY1iuVp8wJdOjP5HXCc+qp5QemY8rTaKrOmdreimWcWq6uGepR2gLjX1CwEyvHZO/MVIHHq7jAIcZBkwuu7vV86hGrRCgPT/kD7lcmbkzeZIOn0WzY3H50268kNwwF
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;6:IHCLTeU9IkwlWfsMtAyYKYEgWFpRH1hK04gEPwQKYEDnnM/W1nKsvk15+pWPJbma5kh2MmUQESMBMdLOoIwfDvF3RR26ZKjykpNjKumW5lvt5/+EZ/hZxI3lbdZee8JQ2wU9Xr84LmBZUoJdJCy1JUtWlFrRCFDmBgJ6xka1MKYCkLnywoEiU+uQR/Mm3Uw0fuM8FHTwUNWSJlqsaIz1KgxSuM2XwMvX1pDK5Sp88U4Kr5clPuUylDL/dDs0d4QwPbNq48sHdi5A8Bov2QeBc7CwWqKZyhf27b51KRe11nP7Esy56d/SDckx6+fDSg6h8E0H6JBuDcUN006w6EPUyfQjLZCLrb/XNOQMq9RxQ7ygSSZyZA1AX4SuRi6kTsYD8XVZi8E8/teJcvaWFg2dW6YzrFqmesxarRTO2JvyF2qexCKmNJPl3EmvL8eV6iomBJrcnYGBE4fP62y1AlwkhA==;5:7VD9jsdkBji1tcVHhibma+pLwSlFBirqjFdydaX3kFeIg3wdwToL98b/110lJSHH4y/QMvncPQQ2X+YcQR1ATr5Sn5sRKXjH9CSw3KaHay9JvX6QjK+N3K0H0BeZCEDWbML6Xb0Z1V2rhqLAgoCFL/C4V8L3anyWEuyQ+0VKNIc=;24:+EILqhxrbTwFWnaFOCT+L757XT9qRJeEq3e2HE3SQxg69M3i4jxDM28wc2vIDQrdJIR5SgsenteX06jWq2Nf8O7AzQgc36Xe1DDWvSFb4Q4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4577;7:m8AxsQtpVGQiJgQ84MGIQPUUTYtoHO+7uxYM3gFc2kapiLSvfWHwYFsRNef0mfvNY5IzOmoXzLd/4q6mGHUV/3L+Tae9MXEQFWproyEg/BQzNDo5200GoxLMo1xgWoemYaWEKasl1RQoh94+C/Bg3NCVW4hh7ZVVqLoBY694K9MZirHRT8/TxCEYe7TH+Ne90rv4vLwQ8hy1qbjN/h+pYXd049oQwLRCoTJKYiSnpIMV0cZBTRG2kuctfFq8k41n;20:s9QPfQOHxj2ya1riP7J3wLP7wzAUgR8peyMMC4ik08ZK8G585wdOUKsKn3tCX1pfNvpS0PmQnTSHQcu3ja/WOQEOuH84/pGXSs+aHuG45ELqgKwfOpp8fkp/ST3HiyLuhZgDWzDkTZOqjFQskL14P4nLWOXOsbsMM7xMAaCjYUg=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 10:40:53.5092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10174c9d-3ca4-413f-3a9e-08d5d11a2539
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 11:50 AM, Peter Zijlstra wrote:
>
>> +
>> +	lockdep_assert_held(&lock->wait_lock);
>> +
>> +	if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx, ww_ctx) &&
>> +	    ww_ctx->acquired > 0) {
>> +		WRITE_ONCE(hold_ctx->wounded, true);
>> +		if (owner != current) {
>> +			/*
>> +			 * wake_up_process() inserts a write memory barrier to
> It does no such thing. But yes, it does ensure the wakee sees all prior
> stores IFF the wakeup happened.
>
>> +			 * make sure owner sees it is wounded before
>> +			 * TASK_RUNNING in case it's sleeping on another
>> +			 * ww_mutex. Note that owner points to a valid
>> +			 * task_struct as long as we hold the wait_lock.
>> +			 */
> What exactly are you trying to say here ?
>
> I'm thinking this is the pairing barrier to the smp_mb() below, with
> your list_empty() thing? Might make sense to write a single coherent
> comment and refer to the other location.

So what I'm trying to say here is that wake_up_process() ensures that 
the owner, if in !TASK_RUNNING, sees the write to hold_ctx->wounded 
before the transition to TASK_RUNNING. This was how I interpreted "woken 
up" in the wake up process documentation.

>
>> +			wake_up_process(owner);
>> +		}
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   /*
>>    * Wake up any waiters that may have to back off when the lock is held by the
>>    * given context.
>>    *
>>    * Due to the invariants on the wait list, this can only affect the first
>> - * waiter with a context.
>> + * waiter with a context, unless the Wound-Wait algorithm is used where
>> + * also subsequent waiters with a context main wound the lock holder.
>>    *
>>    * The current task must not be on the wait list.
>>    */
>> @@ -303,6 +338,7 @@ static void __sched
>>   __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
>>   {
>>   	struct mutex_waiter *cur;
>> +	bool is_wait_die = ww_ctx->ww_class->is_wait_die;
>>   
>>   	lockdep_assert_held(&lock->wait_lock);
>>   
>> @@ -310,13 +346,14 @@ __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
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
>>   
>> @@ -338,12 +375,17 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
>>   	 * and keep spinning, or it will acquire wait_lock, add itself
>>   	 * to waiter list and sleep.
>>   	 */
>> -	smp_mb(); /* ^^^ */
>> +	smp_mb(); /* See comments above and below. */
>>   
>>   	/*
>> -	 * Check if lock is contended, if not there is nobody to wake up
>> +	 * Check if lock is contended, if not there is nobody to wake up.
>> +	 * Checking MUTEX_FLAG_WAITERS is not enough here,
> That seems like a superfluous thing to say. It makes sense in the
> context of this patch because we change the FLAG check into a list
> check, but the resulting comment/code looks odd.
>
>> 							   since we need to
>> +	 * order against the lock->ctx check in __ww_mutex_wound called from
>> +	 * __ww_mutex_add_waiter. We can use list_empty without taking the
>> +	 * wait_lock, given the memory barrier above and the list_empty
>> +	 * documentation.
> I don't trust documentation. Please reason about implementation.

Will do.

>>   	 */
>> -	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
>> +	if (likely(list_empty(&lock->base.wait_list)))
>>   		return;
>>   
>>   	/*
>> @@ -653,6 +695,17 @@ __ww_mutex_lock_check_stamp(struct mutex *lock, struct mutex_waiter *waiter,
>>   	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
>>   	struct mutex_waiter *cur;
>>   
>> +	/*
>> +	 * If we miss a wounded == true here, we will have a pending
> Explain how we can miss that.

This is actually the pairing location of the wake_up_process() comment / 
code discussed above. Here we should have !TASK_RUNNING, and let's say 
ctx->wounded is set by another process immediately after we've read it 
(we "miss" it). At that point there must be a pending wake-up-process() 
for us and we'll pick up the set value of wounded on the next iteration 
after returning from schedule().

>
>> +	 * TASK_RUNNING and pick it up on the next schedule fall-through.
>> +	 */
>> +	if (!ctx->ww_class->is_wait_die) {
>> +		if (READ_ONCE(ctx->wounded))
>> +			goto deadlock;
>> +		else
>> +			return 0;
>> +	}
>> +
>>   	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
>>   		goto deadlock;
>>   
>> @@ -683,12 +736,15 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>>   {
>>   	struct mutex_waiter *cur;
>>   	struct list_head *pos;
>> +	bool is_wait_die;
>>   
>>   	if (!ww_ctx) {
>>   		list_add_tail(&waiter->list, &lock->wait_list);
>>   		return 0;
>>   	}
>>   
>> +	is_wait_die = ww_ctx->ww_class->is_wait_die;
>> +
>>   	/*
>>   	 * Add the waiter before the first waiter with a higher stamp.
>>   	 * Waiters without a context are skipped to avoid starving
>> @@ -701,7 +757,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>>   
>>   		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
>>   			/* Back off immediately if necessary. */
>> -			if (ww_ctx->acquired > 0) {
>> +			if (is_wait_die && ww_ctx->acquired > 0) {
>>   #ifdef CONFIG_DEBUG_MUTEXES
>>   				struct ww_mutex *ww;
>>   
>> @@ -721,13 +777,26 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
>>   		 * Wake up the waiter so that it gets a chance to back
>>   		 * off.
>>   		 */
>> -		if (cur->ww_ctx->acquired > 0) {
>> +		if (is_wait_die && cur->ww_ctx->acquired > 0) {
>>   			debug_mutex_wake_waiter(lock, cur);
>>   			wake_up_process(cur->task);
>>   		}
>>   	}
>>   
>>   	list_add_tail(&waiter->list, pos);
>> +	if (!is_wait_die) {
>> +		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
>> +
>> +		/*
>> +		 * Make sure a racing lock taker sees a non-empty waiting list
>> +		 * before we read ww->ctx, so that if we miss ww->ctx, the
>> +		 * racing lock taker will call __ww_mutex_wake_up_for_backoff()
>> +		 * and wound itself.
>> +		 */
>> +		smp_mb();
>> +		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -750,6 +819,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>>   	if (use_ww_ctx && ww_ctx) {
>>   		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
>>   			return -EALREADY;
>> +
>> +		/*
>> +		 * Reset the wounded flag after a backoff.
>> +		 * No other process can race and wound us here since they
>> +		 * can't have a valid owner pointer at this time
>> +		 */
>> +		if (ww_ctx->acquired == 0)
>> +			ww_ctx->wounded = false;
>>   	}
>>   
>>   	preempt_disable();
>> @@ -858,6 +935,11 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
>>   acquired:
>>   	__set_current_state(TASK_RUNNING);
>>   
>> +	/* We stole the lock. Need to check wounded status. */
>> +	if (use_ww_ctx && ww_ctx && !ww_ctx->ww_class->is_wait_die &&
>> +	    !__mutex_waiter_is_first(lock, &waiter))
>> +		__ww_mutex_wakeup_for_backoff(lock, ww_ctx);
>> +
>>   	mutex_remove_waiter(lock, &waiter, current);
>>   	if (likely(list_empty(&lock->wait_list)))
>>   		__mutex_clear_flag(lock, MUTEX_FLAGS);
> I can't say I'm a fan. I'm already cursing the ww_mutex stuff every time
> I have to look at it, and you just made it worse spagethi.
>
>

Thanks for the review.

Well, I can't speak for the current ww implementation except I didn't 
think it was too hard to understand for a first time reader.

Admittedly the Wound-Wait path makes it worse since it's a preemptive 
algorithm and we need to touch other processes a acquire contexts and 
worry about ordering.

So, assuming your review comments are fixed up, is that a solid NAK or 
do you have any suggestion that would make you more comfortable with the 
code? like splitting out ww-stuff to a separate file?

/Thomas


