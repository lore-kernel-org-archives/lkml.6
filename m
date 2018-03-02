Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428187AbeCBRcZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:32:25 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:51766 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424427AbeCBRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:32:21 -0500
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
 <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
 <20180301164755.pipco45y5nlvmdsy@linutronix.de>
 <7079102c-f53b-e8ab-c54d-1c40ff21d921@ni.com>
 <20180302145232.anp4hz25uwqygopa@linutronix.de>
 <98f4236e-9863-2af7-1170-51cd118f65bd@ni.com>
 <20180302163900.ldnkhgsvqxlki4ju@linutronix.de>
From: Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <5ad54baa-9019-fdb3-040b-057caf927ca3@ni.com>
Date: Fri, 2 Mar 2018 11:19:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180302163900.ldnkhgsvqxlki4ju@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: SN4PR0401CA0019.namprd04.prod.outlook.com
 (2603:10b6:803:21::29) To CY4PR0401MB3620.namprd04.prod.outlook.com
 (2603:10b6:910:8f::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec4fa84e-3b58-4037-0002-08d58061ce6d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR0401MB3620;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0401MB3620;3:YNLhPJdEnpfkq+m9NhFuNQXWo0A3GtzBe58zZMkrR44BAdIE4xFyJfNv5U11+QIXCOoiotI46yQLsyQV0sNYgafSrSRuwVfkih7L7as/LUd1ljEjQHlu5nmT0W05zr3eazzVqZRt4ap5iktkkjxNYDo37T46nzHRPDtSjHtMkBfFOboZfLLHSbf7+uSLw8rMIEiqL54nwHACJr1keyhC4CJMR/tZVTLvt1MTM1493PRRzF5eQnYx5dTypwuZ2dHM;25:riAhwgNokx8jaxDiUcd3jI4V4la9JQQp1HdqJroSLRPOEOv2DunmSAQfNjEjVQzSH/UEByFZ4jAGRvzwbKQEH+n6iAxsFCH2I1Cq9bdBxsMpyt9iUwfQjLPQXGM7sonmtFm/QRiv1R38GH1X7dHnaT9QTzh3BYX5InOsLG4/wLmD6cGbPBSi4wkjc9NhWoQSH9Wy05pHwUx7IpOvZwHrGY/YTl5lcb301Na0nfkB6xNZRe1nz51jaiftWE7I7W1o1qaOufvnP68As+V25/11F0B7ABY5v6dZydG9d089jHKMJRPBntx4du6zPbHBCPpfm4ZxiGctbtYBE/8SdA09wQ==;31:3+bYp4gw37oNoVKgP0kp0uFdKXp1aJEBhi9Zz4CUMo72bdYt8EnAbNVypbAM1tYigolzdSJi4vVlaiUKwXFzp2W0PYQ/yXRZgOBU1oOI7sM4bAMBCmXiJRj7IxVe3sb8VXVtVyjPRtBR9DCNj6mnScC+JS6rhsjfdagGCeokoQsFIUklt+t7XR1cX+Whm1wlNtn+05CrNpRtsV9BprFYNf0n/TJeWSmDIOTYi1uLM+Q=
X-MS-TrafficTypeDiagnostic: CY4PR0401MB3620:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0401MB3620;20:Dn00KnUZh5obWuM3o3Fzlgj6+ztOU/UOgUAKlzjJi2DNjbOzYc104l6B9PuuCDk25qLerRgLngMzla+zxQLfPRWjNyIFPm/cSJVDZ50RbVfygaLCutnEIAfYmEAS1LtcyyFNo3mZ/emk9NMXS10MIMY9t6bK69UoV41UowCRNDHEkyyF9vGfaiRsT0txXaAniHWtC7Ky9mN3QCbtkGiqEQAGzMjm8uWZU8UbcZMUVT1ZkYP0mzA7gamBw+Kf6HkXv2u5W1N0JmbI9pbxL0d1QMr1S83XbgegAaY3kUoLG8J1q8SocllieswC61wSc4r4Hp3rYAgnqCdySR1rLOZiiCcfYk+RLacG92mN5TeKZsLw++iMaSM4/pGFTxl2ljYed/97pJtAsjCuViVpISenFSuGW9v0j2860Hy+axiI3Rzb5Tp26uU8o7+4oLsdu6ap1Zi3JZyen1YkSN0sXZ+vzVjlpCU/BTc+RjlwqxygRD/AdDEN+KpPLiMmxjAKr/GcJXnJsRDPOLkRKU5IaoSDE3YHqtxyc4feroOzHWZBjjKKaNgxbgl/F8CH4YyNoesC6R+pYR77EfsDztNrdmrB3/36hXPvy2YEq/T1szb7yzU=;4:tER8j5NuXSqgvi1hVADHC8JE9UASyRSnBcQWotIz/XpuVRfQpN83Jg3TpNaxubxjqQz9TtgaIYUykY46xWqd2kxYIiRi1bK/nYGmVVteTFaceqip+fP1FtzmGiqwn7JSc2zwxP6ozE+hUdq7C2IscMoziLtrwTM3IHST4F/8XtTZYSanuc5+Z3+SXiZK0hIasg8kTuYWjjmZAsOCjfCr2V7Z00YGk1kRT2hu+OOvjXdrDmvvSD15i1o3yB3KqkMnYNM22MLJXgB4BTySA/RTlA==
X-Microsoft-Antispam-PRVS: <CY4PR0401MB36204D18D9D1086CB6E8AFA0E5C50@CY4PR0401MB3620.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501236)(52105095)(10201501046)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR0401MB3620;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0401MB3620;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(189003)(199004)(377424004)(55674003)(16526019)(186003)(65826007)(65956001)(65806001)(6512007)(66066001)(105586002)(4326008)(53936002)(76176011)(86362001)(25786009)(386003)(52116002)(52146003)(2486003)(6116002)(67846002)(23676004)(3846002)(2906002)(50466002)(6246003)(6486002)(68736007)(58126008)(26005)(316002)(47776003)(97736004)(64126003)(8936002)(106356001)(31686004)(53546011)(6666003)(31696002)(6506007)(7736002)(2950100002)(6916009)(305945005)(36756003)(229853002)(230700001)(478600001)(8676002)(81156014)(5660300001)(81166006)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0401MB3620;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA0MDFNQjM2MjA7MjM6bW5zVHRYVEJSUnRjN3haOVc4ZG9PdGJR?=
 =?utf-8?B?U0ZSYW1SV0NQc1NvOU50Ti9wUUtab3dOM3cxMjVKYkVwVitpYzFyUVl1cU4y?=
 =?utf-8?B?SUYzQ3AwanJmTG5LeDNXK0JpWkViVERLNjBXem9iMlpvZ1BSMnI1QjcvaDVz?=
 =?utf-8?B?TXJaRW92Mk9BSVFITitqYlhTazF5RTVpSlNCazlqWU9lL2tiS3U4REQ1NThp?=
 =?utf-8?B?SWUraUM5OEV6ZW5na1BYY2VOZXRKcUlKYitTMHJUOFgvbnNENXVRNGZ2bC9h?=
 =?utf-8?B?cGh1RnBmVk4rZzRxR1RWUFNSSTN5b0JJN2YrTVFsbWNFSmNEL0hEZmRPd1E5?=
 =?utf-8?B?azVSTkk1aFFOOTQ1UlV4UStycFY4Vlk2NGtvTXhLTTBUVG1wckYzc2VJRVdv?=
 =?utf-8?B?Qy8ycjZCa3RSZDBtSlZIb3RrbmJOdW9QZFh4VG5WT1RkT2hVWGthWjQwNkFK?=
 =?utf-8?B?S2VLT01sanNueUhYb0dreU1mN3paRVBSNzVXSHVveW5Zd0wrUEhVd2Vnd1lG?=
 =?utf-8?B?aWt0YnAwUHM1UDJzbXdCQ050VThCM3B4bFlQZW1LODhYUW4zR05kanF3N0hV?=
 =?utf-8?B?QmJicExsck04eG5GYndLOWNKa1JUY1ZHaElPZ2VQSFcyVzFhQi94c1FBdk1B?=
 =?utf-8?B?YU9jeXB3Tm1oVmJRWUppeXhpR0o2ZEVPcTJ3UEJ4N3FvKzJaZkNJVTQ0Vmht?=
 =?utf-8?B?RTJXNlVSdWZ4VFovVFJiRzFEcjd2dzJyd0VlS0tQMXFBS0lzeWxFa0ZZU0lX?=
 =?utf-8?B?T3dNd0w0UEV4VjByaWtpU2I4V0g3aDVsMzlKMkIyeTIwcFJRWkl4MGRCdjhW?=
 =?utf-8?B?ZndoY0ZUOGhvV1VnZEZaZEpVZVJpaHdBcGJPaHVteTNqeS9PSld3Q3ZESy9P?=
 =?utf-8?B?WVh4b3g0aGd1ZDR1Mm1XUXM5elFvcmtJOEIrWHo5NVRSWEkzMlQrWTlZNVA0?=
 =?utf-8?B?WFBreXVJaDFvK0s0d1lKSGFoS3piRzZna1k4RG04OGNlZStyQWlYdXVZUkcv?=
 =?utf-8?B?bmRUU2tjbmFRR3B4OG5iU2piMlhRR2VUNGVHdldPZWEwVUNDenZIU25rWmNm?=
 =?utf-8?B?UlVZOXpQVFphSWJ6WDBPd09NTW05VEM1V2NNbmIxSWprM0xId3RjZkJpK3Bh?=
 =?utf-8?B?bHd0OGNyR3hNcCswOFZMT2pydmRRbTE3MUFJd2o3bXFGYlM2RWRnVVc1UWNY?=
 =?utf-8?B?WTZYb0NtWVhNWlBGWngyRXJuYW9qMUJpZWFmVk8rTjNmZjRCc1ZMRWFxV1BU?=
 =?utf-8?B?V25maDZhVGZNSFJ0bzk0YW9XVHRldUhvR1Q4bWJWSUM1dm1SRUhNUFVDUE9K?=
 =?utf-8?B?ajgrSC9SSHkyWksybnFJOWFMdkVJTTRXV1ZZTXZJaHo4RENvVkFscVY4T0Za?=
 =?utf-8?B?VEtYRVBFL0dyTUNWZTRsMk5EVTl4TTVITjYvWFVZbWtueGwvR0QzQ21Feno2?=
 =?utf-8?B?TGZ1L2hTeDh1ZmFwWnlSZ0xaUENLOXppQVlvMXJlajUwVHBkcjFkV3E2R0RN?=
 =?utf-8?B?QzVCWFFUNmlhMTYxN0VyUjlYQXVzajVyQ3lzSGZDcE1zWjhhMmpwN1pJanJC?=
 =?utf-8?B?TkF4dmRPcGJ0NkJ0QkdOMEVMNU5vcDRPWFNPNmlveVdrRysxeTFpdjJHYWVQ?=
 =?utf-8?B?ZFlGWkJkTTRyb1cxTjNoOVFLZXAwU09VaDRDbzV4Y3IrVnNwck1FNmU2ODBM?=
 =?utf-8?B?NTVTbGRMWTFRUVFPcndNdEl2eENqRGp2OTZXRUV2dGJnd05EaVZHTjEwb3Zk?=
 =?utf-8?B?TkJudjlEcG00aVRySnBycXVnd2UrcDR6a2Q3SVBRRDNVbkFtZnJUUTJjb2Zh?=
 =?utf-8?B?cVpTK2xJR3hjd3hwMzNib2x1bzcreGg0anNXUGlCZ0F5VUo0OWJleWV1aWgy?=
 =?utf-8?Q?vTNFA6bODnjxUshZov/H2VuwzfWit7bLqB?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0401MB3620;6:DPsKWx+8nGV1gnNsIbcQS3ZN51Kc/SQWl63W/jxgDesfbnjUi01Qe5JFGcD6epyUm0AT+H1Lh789eufVoiJPomZKQW57SByD/u2DkDfn8mE2cUFC1dQj63T6L/SRBZE704+Mbzn115I7ARJUGKxJBzOujuVRxpu2pElBxFe8mRP2Oy6CkHXQoHInPr62IXfoG+0TTumWXx+lXMQp2A57Hu0L3kAw4uYHonbplD/CzC2Yla/80KQEXTgOD5l01MWbN9ODHD/t6TdWXRYF/XyC4YcvRmYNn+zpdGE4lVY2PwksqTcbP91H9ezSOfM0ntg2b2HynTFOIWonC/oW7tXys0mynGgUjTLCZK+EErPpwls=;5:CRNPZXCvOXeWpOXle9Yyxj/oxO6McI1iXXK2lHO3839sYMtRUCeGG+n3oaM5IORJwMyMRope24Fpo+mrcQ2/hFI2a1U7XTWnsrJkX3BgzhmiUlSGJ35/k3Yai8eWRY8Cs1Bv4OFV4Xw6scnKzX8EF23ygLIXY/uGZUo2OuoLfvI=;24:0s4q76kaCsNzB7iwx6p11D0zhx/kCus4U4IDFusY5XUyhGb2oCPT+wyiy7B6IOm73vbzH8R+ODTeJg3MVqUJJbzDnJlqrCXs5YFcbx/N2Hs=;7:h62M4cXawW5MKTuH3wNz73eVugYse41AXoYIjUSbD5fAj5xYWoeGrHyrjG7yGCjaIMwP+jbdJ2OLROFlVcT66D6TytG/VzIHoqE0Xpo+vi8miV/wU35Sg6f7SWRge5AASNWg/gpYjnAnSkITvsPCdmbPEivjZOOFfpmg+Ql23mDTVt5XFwblR2siK9Q/+HcTrO+k2kZctZpsn6L3zd3IJz7QAwqX7YL2HfdFUYJ0OpcziBNZSXewBNLfrjYQjdXS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 17:19:50.2319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4fa84e-3b58-4037-0002-08d58061ce6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3620
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803020204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2018 10:39 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-02 10:29:56 [-0600], Haris Okanovic wrote:
>>> Could please point me to the code/patches or something?
>>
>> I rebase onto v4.14.20-rt17, running some sanity test before reposting to ml
>> (cyclictest & Anna's timertest). Will post V4 sometime today (US Central
>> Time) if everything goes well.
>>
>> Are you also asking for a 4.9 version? I'm fine leaving it out of 4.9.
> 
> Hmmm. Maybe this is a form of miscommunication here :)

Yea, I agree :) Let me try to summarize: When I originally asked this 
question back in March, rt was on 4.9. I was asking back then to pull 
the V3 revision of my timer patch (replacing the old V2). Given that RT 
already moved to 4.14 in the meantime, backed out V3, and V3 no longer 
applies 4.14, I'm fine leaving everything as-is! I post a V4 (for 4.14) 
when I finish retesting it.

> So my understanding is that you complain/ask why there is an older
> version of the patch still in v4.9-RT:
> 
> |It was added back into 4.9 at some point after v4.9.30-rt20. I see an older
> |version in v4.9.68-rt60, for example, hence my original email. It was dropped
> |sometime thereafter, presumably because it no longer cleanly applies. I don't
> |see it in v4.14.20-rt17, for example.
> 
> So I ask where you see the old version of your patch in v4.9-RT. Yes it
> was added, then removed and it never appeared back in. However, I don't
> see anymore in v4.9.68-rt60.
> 
>> -- Haris
> 
> Sebastian
> 
