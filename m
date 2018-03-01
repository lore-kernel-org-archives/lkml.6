Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161128AbeCATFD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:05:03 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:42932 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161067AbeCATFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:05:00 -0500
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
From: Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <7079102c-f53b-e8ab-c54d-1c40ff21d921@ni.com>
Date: Thu, 1 Mar 2018 12:37:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180301164755.pipco45y5nlvmdsy@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: CY4PR0601CA0092.namprd06.prod.outlook.com
 (2603:10b6:910:88::33) To DM5PR0401MB3623.namprd04.prod.outlook.com
 (2603:10b6:4:79::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b555116-89c0-46b6-8a63-08d57fa38b51
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR0401MB3623;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0401MB3623;3:BV28O9zOQSCLQD5UyCwJPcJURPPzQ3a+fy6G8JkIlLwKC0CBhnhSasgDKHTqJiEziIKkHdJZbBJIlZOFtcziWlirsJnqwG+eCFRFvXlvprwbIDorHAZ9bRuiyY94JGwV0Z1ZLzVdy1kcQNs9qnpYVGunPgS4HeEwot5YEzTcC9sS3vao7eeBl1fRjdVpNtYs4pqzvxG1bQC7BLq64RTPhte9+YiYdDxBDyxHFIsDjlcMl+/3KVqC8nHNFSYk6jwx;25:f7aqBXiRQ6zu0/w4OvgyJza3PSMu3Izn+ghnhdt+sxdql7nA+QnnaLe/GBgEy2sseb1hfZvBwZJMz0qoaVlSED5SkrEFBf6jJ/lfkNyIVPJPsEe7yTCIYk2f6lzRuJ8MwbIVfKTs/STrY3v9CqRWc6hK0lk4xI0fG5SSRqdankxKX0swN6cGQH7aMEwF4a/YeIibMVgHzncHCCCQnohqU2yx+mK6RnwdrAqyEUPC+ujwnHww+vlXPAMJGdCkpeoOva4zolYUxNRZMDXfJvAl3Djo7/aquYhb31jPlVdusfl3/dXVAhejgr4iMJf0opEwY7GVyKadjg7dkyMhCBoOIg==;31:9f7rXpD9ORCjrotzKhnFXcYZr/s1U8bzQCbEL+DEKMtsKWF/4Jkq35sSo+PwEOYSwW3puUw8HLnKG/cOYGsQPm4Cj/1GeFOJyuKxoPijKv8kasVMatBEDrOUb8/kNFKQn6doEzF5y6ynYRqclDp6S1xjTHI939b/XaZ+vavZU0nMK40RaGxx1Z+HDMdgSLk+E+6G4oa4BRkZf6b1BMtMeJpb8JDPC/3Q+V80P0oM4go=
X-MS-TrafficTypeDiagnostic: DM5PR0401MB3623:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0401MB3623;20:vs4q3QphwD9G641B0qwi1vdj4ZHHq5Tf/dMEaCXRy1tyjpqNFsUMg24hkPyn59rUahetCbbtB15DGewUjIMUTqb/q8HMAzSSnZZnWaAhEQqWqzYw+jG7ru2xkn4SWxTtXOIMt6T8fLXFXUpHKpA49+0vMx0tXU2Zv6ITWpnOMlDeLCbOD/tXEJvclMUY9OQ0GNh+VcmqtGcc4EclMhZinqDNl3Wb/TMMGecxFPXW4KqYcRPEA/LHq1opRPWesWFyv+4iJYkq3DB4DBNUzZhhkHck0zjhykwUVDMtkY1ClDSep9RxwJiv4obk2tdFYd5zKRUsPa0RnUFslgIA+cVLfT0Tyqg8USXLzxxbzKY5dSqEdK0tmbB7JoclgbR2vWLMqImocS8f1a3qU6U39hfmOttjyatkkcEMY9GZ9BMed91dLaXOFqLlXwuYIVZV9B17O6VuSV6ljZ++4XSM10sEeKF3DM6/XPtKtMSn9mzz8TIOBxZIHbI/f0CcbF/MSoWfHelYxiwwNSXBbxD/ZqztJMpSs2YgSMC5fsiNvWt8KW8UUNZhiPeb50KT2MoDIDfoJoG4spsVb1O1gt30JrKGp7bpCjwwy6bDx+kbNrW9IHM=;4:ownrgCxiMrO7qVHDLVjZCJcMWh7+QENgI/neS8dP3CfAwiwJ/ZpvMycn56ofsEFJCCsPvXn3wf/Pmk/i59A5Ms3gv2eunu4FlXv+4suyACWdw6o1QXpMzFFFxaEUivwU493Pqf7Y26xCWhnxv3ZuqToORNNN8OWD3ohBxzeCLzdtXecv0WqS30oim3I9dOQdSyjnzFYmB3MTuSHxpe5Xf1pc03tTOom4Jxit1OPHfexh8jK0LQZ0bZ7HpkYPw2gma0eK4mC/vt0SQ6kTl3R6Dw==
X-Microsoft-Antispam-PRVS: <DM5PR0401MB3623ECEFA8446A00445107E6E5C60@DM5PR0401MB3623.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501224)(10201501046)(3002001)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR0401MB3623;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0401MB3623;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39380400002)(39860400002)(189003)(199004)(377424004)(105586002)(64126003)(93886005)(81156014)(81166006)(6116002)(8676002)(8936002)(3846002)(2950100002)(6486002)(229853002)(6916009)(2906002)(97736004)(53936002)(6512007)(86362001)(31696002)(65826007)(50466002)(31686004)(6246003)(68736007)(6666003)(52116002)(36756003)(76176011)(386003)(478600001)(59450400001)(47776003)(186003)(16526019)(67846002)(7736002)(52146003)(2486003)(23676004)(230700001)(106356001)(316002)(25786009)(26005)(4326008)(6506007)(5660300001)(65806001)(65956001)(66066001)(305945005)(53546011)(58126008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0401MB3623;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA0MDFNQjM2MjM7MjM6YkJNNkNIS1JsRUFGdEUybmhnaWF6R0Zo?=
 =?utf-8?B?bDJGL0tKNi9xWUlMVDV5VVRkQVRFdXNaa3VIcTM4bFQxVWF6OE5JR1E5WUZm?=
 =?utf-8?B?YXpZVDBsenFjbUhscjZxbzhqc2cwa0hlNWVvSjJweHdubDEvbzRyMWU0dnRu?=
 =?utf-8?B?alF4S3B4dVV0bjdMWFZISGljYnRCN3pCbVl4bWFFQ1JYSElMYnppVVhFR1BV?=
 =?utf-8?B?Tm02MWRWbHJmeHY5MDlBYm9PaEZZYXdXVXFRODNwMzN1UmMreEV4SWF6VWMr?=
 =?utf-8?B?K0ZORHZieUZydVgxWUh4akxTOWp3dEZKRXpEWHhub1JTbnBqYW9CbWFyMUdl?=
 =?utf-8?B?N2h3VDZBbTAwcGdicW1td2VQcXR5dmtEbVhWVFF5WHF2aXhmUHJtSUlBdEc0?=
 =?utf-8?B?eSt1Z2ZnVzhuSkNIZWlZV3RXc1FNcDQxWEFweFhjY1J1akJpQndvWlRNZTF5?=
 =?utf-8?B?NkprWjlMZXlFV2piOXNuaUErak1kVEMwN1NaemV1Z3lEYUVRUlRuQnI4NG10?=
 =?utf-8?B?N2wrRWFydktsS0R6N0swOXdZOGlWcEQ1OHZ0dHVsZjVReVkva25QajJKajl3?=
 =?utf-8?B?VGx0T1puREZhcmk4b2V3K09xTVNicyt2dFovT3pISkJjWFh3MHdSRCtxd1FQ?=
 =?utf-8?B?Y2RLN0hjUy9lTjlhOGxTSmNqSkhZcVl0RjdNaTBjbHlvdXpTNjExVk5SVDQ5?=
 =?utf-8?B?U3dZNXZ5ellseFk1N2l1ODZKNDUvVSt5Z2lvYXNkWmtWTTFqeWZxMHduTysz?=
 =?utf-8?B?SFpEK0hSaHM0VWluSm0yVVJaM1p3c3huMlB0d0pmVFJtYzFpZ0dXK3pCVi82?=
 =?utf-8?B?OFVoaTc4NlZlZEs2enJhSGhMSjRZdDdhNGR5bVRweWgxZmxwNUY2UkpmTU0v?=
 =?utf-8?B?VjY1VDVrVzJqM3d3S0pNT3VSRUdybFM2bDJDMFJ3N1o3Wmd2S1orb3NIR0FL?=
 =?utf-8?B?QmpucCticitQdWpWOFNhNjg2RjdEUzhvaGt3bVNUSW9nSFZSeDd4ZGpXQmh0?=
 =?utf-8?B?NDhVajhDc3F3MUxWVjYreExraDU5VU5BSjNvM0VTYlp6NGhmMk42T1pGa3hC?=
 =?utf-8?B?WkdhMWNEbVh3K2t6U3RINlVaT0FFdUZhOUE3ckp1V3NIakcvT1J0MHhjSmE1?=
 =?utf-8?B?d3c2WExxVlRrdC90MzFYQTNlaTBjWldteUVONFpuUjdyVWJXTjZ2RGxIeUFs?=
 =?utf-8?B?VXR4WGVWaENxdFgzbW5IQUhVRDJpUjFxc0NUS0VPb1I0M1ZkdGx6VkkxNCtm?=
 =?utf-8?B?Y2Q5ekFpcU9IMHlZSEtKajNqRDVNdlBzRVBSdHBwVFlpR0Nlb0I4QVlpK0tR?=
 =?utf-8?B?b3E2NmlXKzBsd0NVUFlTWEhjR3hPVGg3bWljdWM3c3RCeGRMZFpXY1VlYit2?=
 =?utf-8?B?MDEwbVltSVJZR2FSaThWMU4zOUlVUWlpUEc5dmtVby9NMDlHc2pGMU9iTjVq?=
 =?utf-8?B?R3hBSWZmOFFMd0xwZG5oVzlEcVZHRXk0Skt4ZkxrZlM5ZXlySVU2elVUWTBy?=
 =?utf-8?B?Zkx1eWpUcHhGcEMyQVZzeTBTSVF2RXhjT01nM0pzL2NSSDk4V2NQaXRtWWJo?=
 =?utf-8?B?OVZ6bERlR0lybXJ2eDhJYm1zWWlxUlp5M2o1Z3lNcXNzT1VWYnFYUGN4aVhu?=
 =?utf-8?B?NkZUNGFVOENHWWJmKzVBNS9XYXZXcCtEemVhQzdPTld4eVZtejZ2aTZDWUNh?=
 =?utf-8?B?T1FEc1B2S29vQXlQelZHdkljcEQvYWsvRjZiQXpkSStjaXNKNmM3U0hzV0dy?=
 =?utf-8?B?eE05VnJIU2tPcm1FTTJseXM4b0RjYlo0cHRkVmg3U3ZlaUZHWmpDZG5QeURl?=
 =?utf-8?B?S3JONlVTS1JGZ0d6eFgxdC9sRVFxQk1ieGNZNzRscDAvZFZPejRGdXNzM1hm?=
 =?utf-8?Q?Odv5eVHjay4ghF4giaCjyH4VEBtoVfVnkU?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0401MB3623;6:tqBaA2WLRQaiLrTuwZh2+FAyaw1BsmpOPk3t19uqG/Pjfq6oqwMisfHEdy5z5XDnnaNbThxnHbgtJoszhfo3lNs9E46lqf5/kKTh3RHkodtfs5ZCBu/XpR0+Kp0ghe1o1PAi1IdKXhzNbQwzPJmGUbT7+sNKB75PKZMqEmCWkQUaXfo8+2M61Jw3SQ0QSzCBTlWdCcXHxWqIeoKYObdjo0sl+pWgeRMC3ct6sgm8EFx4cxUr8rCvxTCbwMv2esZ3FcQCRQnaBsdXuAT1qG3M+VqIwHgkaRhMk60TWqrqLIT7NZwtKInqntK1+OTASEoP3qnEzxnue/6hHU82HtiFGCtmGMaiCi4j31FB8Q2Zpzw=;5:YprXD1aZrQOIpcyR/94faYTZc0tYV8OwyiZgJKj09omh70XZc7hat17tK3wyifFp22O/SCEZP88YTCpuXr+KXUoQy70uLHvTDEAYjr35A1SToLD9OihZVMxbHxMcYD7o33psG66vmX7GPTY80qBN9UNvXGIfdKgtGf8Li8zLG+Q=;24:fIsHFyP1wTwXAh40H0+/3kL1E0ADKVoRrWOx68vQWujapDRAnCy1URRky1Z3Q19mYbO6ptHtt7zJfwnBvx6pcXn3q622RtUoIUv/4ATMZAk=;7:BYVwFtP7MkDANEW5WsHHlWMZYPS2AYLPezPORXVZCNoAMZoetwQYR4WgYHWI3KrVpS4zRXMds9Q6524ZrgTustkLBgmszugIoRkKGYOeA0/uj2QNY7nqTToa2+XVPX35H/LCogQ/CHiPRV8OMM3U4MBC0uQdfNgLgQ2ab5FnSTN5BK9netBlBwE7vycbWKkV9PFNkrNjNJYIotJzGBeyhH/tGWUcFkUVM3TzuEaTJ0UEjsAopCzjzxetXZ6Walz+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 18:37:53.2191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b555116-89c0-46b6-8a63-08d57fa38b51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3623
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803010229
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 10:47 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-01 09:49:59 [-0600], Haris Okanovic wrote:
>> *bump* Has anyone looked into this?
> 
> I'm lost.
> It entered the kernel in v4.9.9-rt6 and left in v4.9.30-rt20 once we
> figured out that there is something wrong with it.

It was added back into 4.9 at some point after v4.9.30-rt20. I see an 
older version in v4.9.68-rt60, for example, hence my original email. It 
was dropped sometime thereafter, presumably because it no longer cleanly 
applies. I don't see it in v4.14.20-rt17, for example.

> Is it still in a RT tree somewhere?

I can't draw an exact timeline, since rt history is hard to follow. I 
don't think so.

> Is there a newer patch pending on your side?

Not yet. The latest version on patchwork is OK, just needs to be rebased 
post-4.9. I'll post a new version when I get a chance to build and 
retest it.

> 
> Sebastian
> 
