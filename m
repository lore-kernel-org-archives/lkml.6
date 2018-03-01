Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032958AbeCAQfe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:35:34 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:51710 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032742AbeCAQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:35:32 -0500
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Haris Okanovic <haris.okanovic@ni.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
 <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
 <alpine.DEB.2.21.1803011651150.1396@nanos.tec.linutronix.de>
From: Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <01fb746c-8d5a-746a-bd7d-f75eaf06d5d6@ni.com>
Date: Thu, 1 Mar 2018 10:35:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803011651150.1396@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: SN4PR0201CA0009.namprd02.prod.outlook.com
 (2603:10b6:803:2b::19) To MWHPR0401MB3626.namprd04.prod.outlook.com
 (2603:10b6:301:79::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64be63ae-73db-4d94-a921-08d57f926e44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR0401MB3626;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0401MB3626;3:qwZdjqSlx3etWVaE9ULmcWoG9M5LruLFWPRBHnule2HlEFDiG1jVn8+LwVsUIu5pqo1vT+z5oEl6qj8hm61N3yLDj7dKMsx8MVhZ7elymhbwbgCQzpdIsMnBAvKZLl86eit6LMfdjDd3/UTVYB7ovbXqaMBtMqg2fBhglFxB270GCGFSX8YwR6nYByyTP2feaQu3ZrrK+6kOLp+gwQOZPTn8e1hEzdyYkbNZsZWOh/IXy5qUi5fSZVteTMQJhSDP;25:GLh2qRm8d7QcJqxvSGMAdZDOAcBq1NyADHM4dTgL0NiknQye2pgkeHtLzoeir7oav6Tdbh61jPbzXTozziuCpXg0pSdEk1tqeFha/X5CZIRZait9QJXCT1OFOgRc3v3NIAZGp76LAfmzvZxY6E3bOKXBmSvfrNUG/rjY4O1AlA1LxiBLjU2zK9xb4Y+peELxhVc5XwazGxtmRHMXiNv/qLAEEXabFdYIakt4NIsdkF/idQrts4F3IKQMN1aUK1kAOTNDxhoEKFGo4hnWi1Losy6GMUjWpLD34gPNDJbh9DMRSV7oK/oNhlsGmPDDZfvMgadRADPBi+TpmSCGWPHViQ==;31:yoFoyA6Cb/sTc3cgMGK78C6JOw9zP5UMhonpyLPIFqDr1L4BiwOxAAqAErfn4jMr7L0DhTtmnMUbvXAu46OjECSSGHb1xs7wXRDs2j9C6OaacZjULJtwSSEB0ncrwmqVjZHIvS/s9HvsFQMN3yzUABXgskgm/i0EjB858oX3ECTbHsoIsnM24KdtBv/Xim4o50ktxOd85+c78xgqatRODuVjvkkdIgmg1pl1uGVEeuc=
X-MS-TrafficTypeDiagnostic: MWHPR0401MB3626:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0401MB3626;20:cllqclloS0GaKgFamSkCSrqxDVpdT+dp1rgmyWTrKLzEPbWOpYN/0EJ8ifvTw9NlvT0L9TFKpjXkVy/0hZlwnkMM5d6SwkpOY9crMX017dJ4jubm6SXZP89uGn/iDSzLuEFQ2hw1ELr97NicwyWJSreEmMZgOvZtMBmd6Hf/IAyaUcIr4RiF2Qiz30UI1awzcZsy8CfW67N5XttnRvYXIQHfUODrFb/N5AWNwbREUAEov6wUTdS+FV0fGkXpZVRk2n5yo/kVGAarmSSjpmL7+x+MAaSce1/amQkbPCJ45ygDxnWsSL/ntTXJNRTbnxX5EelOfNzk80On68XEuxJWzhp470gzYUXEmelEQo4kO5+EwV3Dd8TGsvmi0rHrZGkCoE5wTuokbSnN7BVfuWYIIWO25XbnniVfMy862cYoN7QY4XJsnK8rsn207FV/ZM2EZmC0luJivEaUNe0ntS+FQSSXtRfrPLeFQVioU6KWiAsRCb5uTgCGn0dub2AkPONbWiHJrkjZKCr7+UxA4cYBzgykBYzOxpqRzuQNjXKLlqofEKKmJprrZF5jgRl01RDYXG8ZVXXDl503hA64lgns2Cg2IfGe/7NsurkaoPZeRBw=;4:SbNwtWNG/hMzxoDwM52cdyghzczXVQbcEt7ezyetWMg+epsfg7wGpco+doiHxG7/ENqEsdbKYWFYpvg433zhsFZGR/EmG/vadjwKAfXM6mx+NeWtFMxjMLqiqeeQn4MVshRR5eVq+dH5xBGFV5awFTsqLwAspK2sMk0Jad8g1fClJ/j1uOVKeD5m9jjJs/sqQa0gk8je3X+Ye4TO32kCSQ5Y2HJhV5mPfbOyspgYoqdYxbB6q7XM9wzDemPYVBk65mRRONVVJACE+cDuaotlfhFgbwj2RTEnSgt9vrwswpSDPrjg1LLTBFrTchXEss70
X-Microsoft-Antispam-PRVS: <MWHPR0401MB3626C763FCC9E57D5718C13FE5C60@MWHPR0401MB3626.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR0401MB3626;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0401MB3626;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(39380400002)(346002)(376002)(199004)(189003)(8676002)(47776003)(316002)(305945005)(7736002)(105586002)(2950100002)(59450400001)(6506007)(4326008)(65806001)(386003)(6916009)(25786009)(6666003)(66066001)(65956001)(58126008)(31696002)(52116002)(23676004)(2486003)(76176011)(52146003)(65826007)(53546011)(478600001)(67846002)(2906002)(6116002)(3846002)(26005)(6246003)(16526019)(6306002)(68736007)(6512007)(230700001)(31686004)(229853002)(6486002)(186003)(97736004)(8936002)(106356001)(5660300001)(86362001)(64126003)(966005)(93886005)(50466002)(81156014)(36756003)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0401MB3626;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA0MDFNQjM2MjY7MjM6ejhNdDZoS2N2TmNpSzI3V3ZkNUY5M3JZ?=
 =?utf-8?B?OGl6WFd5blZkWEF2SVpMbnZaSndHWWdzYnY4am5jTlN6dzM0RmtLNVYxUlcy?=
 =?utf-8?B?MDZYV0NKaEtUOGNLRDZGRVZ6VmU2TVNmVDF4dldpUnJ0SnR3NDhBcDMwcjAw?=
 =?utf-8?B?b0RSbldORTYzRUlKMkFqYnhicEhrWUNxcnNaSG1oSUc1ZHRERWdrQmNOY3p3?=
 =?utf-8?B?QkZrTUNQMHBlYkMxeVo0ZzZhcXMyVFJ2dUpWSHI1SmdxLys0L3ZrQ2dTeTk3?=
 =?utf-8?B?Tm5jYWl5eThsZy9pdlRkVEY3U2tKOWVXSDBObUlaeXdzS0M2aWhxMUM3SHFB?=
 =?utf-8?B?bXh6cEZ2RFlORDJkZXQ4TmpNTnlFNU84YURGODA3N3pTS3o3d245bWVRUWZs?=
 =?utf-8?B?Ti9aaHRrYjF3OXdEVllTRVlzQ242UlVqVUVncFNWZDRkWFNlTHMzU3gxOVBE?=
 =?utf-8?B?U0hSUzFjR3N6RU1XNVBlUDU2SWRwN0xuWno1MmJHVklWQUk2QkdZbzR0Rlgw?=
 =?utf-8?B?WXNKZkZtbmVsRk0xUDlYeFJ4T1I5YVJma1QwVitUc0J6NXRIM1ZkRUtlMWF5?=
 =?utf-8?B?THVtUTVqN1YyYmszMHlydDBSSDh1UnorYmVJTWFyQkpWS0lQV2hSV0FDZVRs?=
 =?utf-8?B?c1VwOTd0NW5vKy9WbjlZd3ZlL2pZZERSYkE3NVUrdkZGZllmOXJ6WjhsMEtX?=
 =?utf-8?B?ZXY5alRGTjQ4cElONjZuajhyWCtNMXRjRVRxNWh6anZ6NHhxWG9lSGdhSVpS?=
 =?utf-8?B?ZnBWMnBORnprVHQrM295clJJa1VNdmhkWWlhWHRhTDRWaDU3SWlXV1JFMEgz?=
 =?utf-8?B?OW41VWF2WVVDMzZqdWRyZUd2S0g1aVd0aFlmemlWWmVqbnIwWTFQZlBwK2dW?=
 =?utf-8?B?WmRKTG5LV0xPa1FId1NjOUN1bGMxNlhEYmRVRFByclVGeEtmQlBEUGluN0ZU?=
 =?utf-8?B?UUtTSFBFTDl2aVZ5L09jbFdRMVEzMjBjT2MzY0dhU0NqTHFRUzBvbzhhU1J4?=
 =?utf-8?B?aXliS3k3OFVwSkt1dUpEV24yNis5R0JZZXJJV3RFMkIvN2ZtZ2xmOUNCK3V5?=
 =?utf-8?B?NlZ1b0kxc3ZjWFhHWktrNURSNlFvSjM4RnYwWXluR3RvTFh6MjEyRzhZSFBs?=
 =?utf-8?B?ZkFxTThQS0Qya3lwZkJpQzdFM3pTR1l3bzMrenFLL1VobnNYZlQ4dlIvOEpU?=
 =?utf-8?B?RTFacVhDZnVLell5QmI3L21Ba2xqWkt6Z2tzNzZlRm9UOEhwS0lBV1ZVbjNm?=
 =?utf-8?B?REkvM3VaWDh6QjFlL0Q5VjRqYUlUN29heWhCekVCcTVnUDJlQSthdTk4a1U4?=
 =?utf-8?B?YjRPZTB2eUVXNGM3L0ljdzc4WTZ3SDNzVWcrRksvTVphcHMvTUpwdjlnNTRL?=
 =?utf-8?B?cS84azUwTEw1RFowWkI1M21PbEYyOUJYVVZsMzgxOExRQ3lrUDNpZDlwWUtx?=
 =?utf-8?B?QWRaUGhKNlkyRHhQNDJJOVpsTFpMU1dyVktZVi9FY2VzQTNXT2Jxc05qaUxm?=
 =?utf-8?B?NmhiWHlFRmxNN3BmbDM2dWJBSmFrekNZZ2x4NThmNGdIaVJlcU9hdmxDTUh6?=
 =?utf-8?B?aEF3RVYxd3ZnUU9PQ0lZb0dZOFJDMzJsazZScVg4RVdGQlZZbVpHY1FwOFNG?=
 =?utf-8?B?Y1dRTndQVXE2UEtDWWU3d1RlaFpOV0MyUVIwWFZxNVYyT0Viay9TZnRuWll1?=
 =?utf-8?B?T3VFb2Y3UkVOUWdoVFhqcWVSVk5qRnE4UlF3Zm5YcEFkNlh6eU9sR2FzRFlz?=
 =?utf-8?B?QnFuZmhvZEwrcXdyTVFSby94MnY0dDUwZWhzaUxkWjJ3UksrNmFHUDRLTFEy?=
 =?utf-8?B?cGZGNUdNcjhFRjFqZmdlVXhrUTVnVU9kUVFSU1N0REhhRGMyMlA1Vy9sUEY0?=
 =?utf-8?B?U05KclZBTVJ4YSs0RHBYNW5GOTlsMnpDNGpaRFZDRFpLRy9nVFRxZ09ONTgy?=
 =?utf-8?B?cVhIYU1kb0dzSWc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0401MB3626;6:uWpnYF+X+ehcZJRoo0S8hVAgNMxgYDld3ZJoSHvsN5WEuR58lUbHYGiE+MW3LPgN31oTfBhz97skZcOZa9HjLz5bstc1JD1qAgjKQl0F+ELeaGT2X7jmvdEfZ7LKpjqgBdG1HARoBDLoy1d6o5B7qKT9i0UUtAbRVby72DGj6RMjC3Qh9dUh/4BgbJKVzJ62p7+ZHXu/iFlvhKcaijl2svV1MvJnvwfeMQ6ExhEpxzSSMn6zyUXQ1q9fovTwssItZyYmSlesu5f/gR+wu+/U4bl/4oMfKCxC0hGdFDs2CM+wFbVitEFAYaLqcm/S9vb4shc5amdvhholLazvewArJw==;5:kIIbuaIFD0SBhqk56UiVjYsKgCVzQNmk926Fl7cSskaU0s+gpAy8VhOZBvQCRn+DSRHyw02Z8SI15pSeXinRlv/YAwHvEVHFk9/G0qcX4va8EzA64VIh8L23uvEyRUjucv50tokSKhgg1ILSDi7KtXgCO7lTfvVzM+KDTZD9IdA=;24:bshjlb7ELyeMAtrnvzAOIx34xSsQ+br2N4FUok29KVtwAAz/BxJ8FLamPJxw0dc2S/rsQvFyGqxHFkyJBfIVn5K4lCKbZkvT2N8HX9N9irw=;7:VFTfmtFixCgXommz/dOvJ1wBbQiZQt4HJ23TUMYWs187QavssK8XGc6K17LroiLRA1w201+gVclNpmffiaMYGKiYtm0zKyTef5oQOnRC8KV43f3rXXeKd+p2CVzHk7z3UHcBQ5mC6e3hHoNCN72JTyLIHYJo39djwyNzBCYucTbytLBf7UL4IoaifMlI28jGXEgXRYSp6cILSDaq58wFgvOob1X/IYJui9U+6cJ41pwqBo2jq/m2tkBSHn5rx1VZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 16:35:22.8176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64be63ae-73db-4d94-a921-08d57f926e44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3626
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=985 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803010206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No problem. I know you've been busy recently. I'll post an update.

-- Haris

On 03/01/2018 09:54 AM, Thomas Gleixner wrote:
> On Thu, 1 Mar 2018, Haris Okanovic wrote:
> 
>> *bump* Has anyone looked into this?
> 
> I have, but it's still in my melted spectrum induced backlog and it does
> not apply anymore :)
> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
