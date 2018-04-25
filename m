Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbeDYOVy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:21:54 -0400
Received: from mail-co1nam03on0080.outbound.protection.outlook.com ([104.47.40.80]:19536
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753283AbeDYOVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:21:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
Date: Wed, 25 Apr 2018 10:21:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180425135552.GD7592@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::35) To CY4PR1201MB0120.namprd12.prod.outlook.com
 (2603:10b6:910:1c::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0120;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;3:HtY57gWgCzhO55uU+AgsB2jrm+wN93BDlJCSgGVciKgyBFqIXZs4mad3PLuBIX24F9lohwrXJ/otWePEoitzxWQii26vKPZe7kEwPLKLeXL/4FipFHoT7LVX+Z1kbPM0GwVvoodzPykjMaS8+JSCxb23VhZwm9YzwkjAtOG5G3NsOB5KAIqKtkx0E1tc1rGOw+Rxl915NZN6wB5pzDg1VM54X/ZqtL86AaPa/NZcXYeZOn58k593OYaBSqXVCV/C;25:EttjdULYkpuH7JDemxCEdCWKFGlB7YUspiKFU3IKe7vbp6NqvQkYSFTEcPibzg8OizNRLMWSS6RUntzEt1QoSxiuJDWpEyV7NdICGpgzHcNTZDZ5VzpmlcV7KKWcnIO2ybH5wrbOtshOpyV+T5PipT4QnnOdmnptLPdfntY36BKgMEfS29NF4xCBYErGhUHEUdWe+dg6ydvPTMV+ITUh1uFFUlPNGQha2eAK+Fcx6EQYbPeQu1VJnvGwubNcnIhuEMg6PFxvr0yhTj36vbllToQ8ydmg0Prz/zH/I3SKO5NTNtWP4K9qcAbe4xqcpyx7XIkQcEyCveReQM7FNAKktA==;31:iRyFTQMp0aKyYWqvvva0COSJf1O4sJyyw4Qx/tszn5Y7FdnjJuAtk9BSIm3/TTwISwUgvUaFzR1jkX+gs9OLS7uIa9XnHyd1mmcrgnaKK2v/Ol0hyalXVnB6W8bF+IxnE0gmX6NK/RBnH4+hLfIjwku/4wJuCV8KpkVZ0hpiem9wOZig4EAncjmje9mSpMf7NHIthQAwks2tJWsxFvKdVQKJVEKu4PNFv/wofZrvYds=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;20:A1VjuYgTv7x3+kqawIsHqTPcZzc1/k+MOK/SFJM6sQ/vcZl4snj6SbKWENbLJNo1j1GBMyYh3dBBRo6xEc6+ICIvVm8seuXqzzOrOQyta14siAJ+pU1IJT705lGCBNqfELdBVRu0zlqtomHlpKxJtsrJtGHRlVaQ1nu62ozmugAhwHQhsCEWxEyKBOKe6Sre5rzIE2WONADG3Q2ElLV44KVCmmxgwV37S0Bmzp0v5Wq8XY0cLE3S28a+pcREDrf0mI6o9M/uNsmaqFv8XqOGiVrXqDz9XuukxKT0RFWmjLRG3fDVn1as9VmlVqEZDekngS3RhHMpnu7CgIIgip/miaVDbqG4tQVW9xSitcDatp1SwWx3RZOJr1Ee+7I3rc1wPxBc4ZF4cctJrnxlaOJN+1RyAtOajtLFGqQrrdj0NUth6tB3/YbGbuw+XkL9X63CgH43sg5gmdZt9q1C+4UYVq1lkV1dHuX0+8/n4fpcSBRGSJn/aQYNbdjCy5jIYya4;4:IJOz7sJQ8P9NxnxDHrAHEFlqDT8MbJ+98rKwtqs139sXf/yjBvZ+o8dbevV+RTdUH2dEpHLmdFNp0a9meMFWK19+58oTBcYSJ1QkOqlu5M9ecED1SxXpO/chuxNjdGdjJ2NhquuXY3ZMVUyOcbFKftIdpZozOgWVKHkmna1dUaXC5VShmz7rL1UM8AZYkGGa+OevxBP8smTbhMPsDzDuXACuH9SaaBcuRj4O1WMWsaa9jbs1JlbqiZ3in+9h+1IrZ4jLJ9d8DD2wEyUFbJOKgg==
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01207748C6264A3A69F56E85EA8F0@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR1201MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0120;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(366004)(39380400002)(396003)(346002)(189003)(199004)(81156014)(110136005)(316002)(11346002)(81166006)(36756003)(16526019)(53546011)(446003)(229853002)(6486002)(86362001)(486006)(26005)(476003)(53936002)(31696002)(2616005)(186003)(106356001)(25786009)(59450400001)(58126008)(8936002)(6666003)(4326008)(16576012)(77096007)(386003)(5660300001)(64126003)(52146003)(6246003)(65956001)(50466002)(52116002)(47776003)(3846002)(2870700001)(2906002)(97736004)(6116002)(76176011)(65806001)(23676004)(66066001)(956004)(7736002)(2486003)(65826007)(478600001)(67846002)(31686004)(105586002)(68736007)(8676002)(72206003)(93886005)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0120;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjAxMjA7MjM6STlVN2k4dWJSU0hlcUFsWi9XODA0b0hu?=
 =?utf-8?B?VXlaejlhWWhZdXF1b3JVREplYTN2ZVJ5dmg2eXM0alFIU2F4OGV0a3JtSk9Z?=
 =?utf-8?B?YWlIN0RDMzAxT0h5ZEVkRGJTWVo2WTdwblhvM1FFSCtMbTMwT29qWWVaMGxJ?=
 =?utf-8?B?RzFUUUVRNC8ycUhQSGRheGJSblg3S0V3Y3lDcXE1aC9kalZ3c0YvWHFXUUFS?=
 =?utf-8?B?WlJwL1RROWRCS2RpZko3WU9LTjhMUDd3WnFMTnhKOHRSZzZHQ1FJWXBlazEw?=
 =?utf-8?B?V3AxQkVwRXFkbnhXdHY4VUVXN050b2k4TGMwNHJGZ3djT2lQWkIrUUJxZkJQ?=
 =?utf-8?B?QXYrNDVXQ1k2cDNuQUFrKzdtRnhnUWJiOUZ3ZjlFUWR6dFRXaUk5TWV4OGRN?=
 =?utf-8?B?VHBLdVMrRW85Y0ljMkxLdEFMRFh2Ky9HNDR6emQ4QlJLUGpSTlFzdmlmVDI5?=
 =?utf-8?B?bUsxdnpnSUl2dmhxNVJVSmRjTnJoMlhlSXo1YS95bVdGcWU1UDh2MHBVc2x2?=
 =?utf-8?B?bkdFdkprNUxWTTBHTjdxdkpZQW5wUU1PK0cxeDI0dXhZaUFCRVVjb3RyQkRu?=
 =?utf-8?B?d05jNFU1UVhZaVVaRXV4UjFZTGZNa1J1WitXdzUydUZqNytXU0M3T0RNV3FP?=
 =?utf-8?B?MDREczlkUzl5Tk1Ec09zd0tLOWZ6MFFnUlgrQjV6b2RsL21Sdlg1bUltcHB0?=
 =?utf-8?B?am05dkdKOFZnSUpLWGFaTVRkUkhla0hRU2JMWGVMUjBFb1NQRGt1MmFxQk5n?=
 =?utf-8?B?RUw2eHk4TmlZdFZYSjRmbGJNU1RISlk4amhUNG5HVUorVzdWMllZOFVLT2NO?=
 =?utf-8?B?cjY3ZmJNdTVXeTV0TGFMQjgwditMek9HNVFlVHptNytxSnBjbFptaHlyS3JM?=
 =?utf-8?B?eXRSNmtHWXRxbzZxaG9vaExEMjg4aEQ2U2U5ZUxIM1lFSCt4MFRscmFNK3dQ?=
 =?utf-8?B?S1B0TWFwaGF3Y01sU1B1ZXpOWFRxK1NoR2NYYlU4ZkFGWkRDbGlSaTdWRjQ0?=
 =?utf-8?B?c2VmVkF5Y1ZUeFRGMHJmY3JCb1ZLR21BTFZ2Rkkwc2VsY0xXa21UTmU4WWJa?=
 =?utf-8?B?TDZLeFpzNWdDMjEyLzhTVi8xMkZxcUlzSk1nenFjbXZXbDM2TXdGb1U2aUkx?=
 =?utf-8?B?UnFMQnVWSkJIajFBbStyOU9XY0Y2SjlZUmlIWGxRMWJLZzFmUWhoRm82TEpj?=
 =?utf-8?B?NDRERmRwNmtHZ0l6SUNBTG5Zd0tXZDZDbDFqeWZzcE1LZkhXL2swdHVhQ0Ev?=
 =?utf-8?B?M0pEMW5zNzJWZldLR3RjNFVBTUd3RGRLbXBzNG1hM3kwN1ZZWkZVTnBMSGJB?=
 =?utf-8?B?WnViU3ljNGFDRy9NWVpwNVBXeWpXWm05QlRkNWpwdktIK0I0RllvVTlrcVhE?=
 =?utf-8?B?bFVZaDFwZzZTZTZPdDQ2dVhqNjZZbDBiKzJxcGd2emp4NjhRZDVURTU0aGpN?=
 =?utf-8?B?WW1UaWVXeDdsbUE2L0F0Z1lXd29ZWEVPaUxCZ2QyNEtBcXZZbnhuNStxbS9T?=
 =?utf-8?B?WGJ5aW9rMElFVk4ybm5Ec25nV2dwa2VVOVg4Q1IwdURyT0hFTVpJVFE0c0pN?=
 =?utf-8?B?RlJ1bXd1NmRsM1dGRThzaXZVWjd3NUxSbmtZbUdPblliam5sS3NFRFRvS0xv?=
 =?utf-8?B?SFh4cDZtQVptRlo5ZjVHMTg2aEVsbzVabkFJaENkSy80cWxFOUdyamY0QmtW?=
 =?utf-8?B?NDBCeXFqaHVhSnBXbi92S2NJK25oMzd0NDdaV2J1dXVvWmlndldtUGttZmQ5?=
 =?utf-8?B?RzYxVmt4RG13UnJFMlFLZitzREhCZHJGQldXRW1rNU1FeG4rSGl0UWtkdFc5?=
 =?utf-8?B?bHhxKzl2V0tBUEtKWk1RdnFNSGRPekNlSUtiYk8vZkd3alhiQ1Ard29SbDB1?=
 =?utf-8?B?YVRWdWM3eXBPeUJoa0FZM0Z1SXFNMXBYMjkyS2xpSlVjdVJHNXgxTEJyd2xy?=
 =?utf-8?B?dkhsMFA1Nm9zRGJUOU1WVHFpMXNJMnZ2VU1hWjdmMnF4N2lXck0ybTYzQ1Q2?=
 =?utf-8?B?ejAxdUFCWnhRK0hzM04xNUkvZThSaFloeHdYYWd1UU5ROXRSS2wvbnNucVhZ?=
 =?utf-8?Q?hrff/Q=3D?=
X-Microsoft-Antispam-Message-Info: JmlA1/bFIkyPLUo59MNbHjZ2rxUIT95kZm8WyKxaL2/4INKr4/6YAwCYLJg9jFF68KU3rBwPsqLqtVXa/kMfqSeOAz619Rqseip5URejaxgkNaraDoK9ZtxKBYR4zwStIRd7/U2dFk830guhamMYqlOlv/caavGBAcAuj7HfDmduRABt7wFPt8yU+gQ8Od/l
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;6:xNt6W3nL08kpwbgHLBmY3SKG1GmGJCpMqWWp4grkyZ4Jmth6KPbvMzg3QVCHy+MRrif3CaWBrbbFihu5Z0pxBmvNDky+gS+gafZod7H2asEx/5/5HWJ+p84wxVJjj98OCrE+WEakiYQI4X6WPzN3yDY0N708P3ZV00928mdzuOW5D8axjZA0THw1uCTL4NW8aRmKMbIEZqp1i1DjaSFpCGD09DFLEPq+GH6AO0/u+r5TnnY2rqFXZ1mn377uq3Ny2QGxWa7/k6ruLhJEDwIS8FM+2BeFCN5uE1SpMaWnhtwaqHRVGjFkqL47Nnu0E0aTTcrm9IQAW77XXnCf/kttS3FWo3ZFWcZsqfKvoWMUJ6bv318KUFCYftxvNGLsWGbzOHe+pTMSa3vJWtxN66tQlUme3kFVETw8n+H8hSIp8HsInZn9GD8iR7DtimH9tci0YjtG/20dm7qX60uOrnD1TA==;5:JTD3+XyDeXbBSMjPiWjLsZjLU9DAs+a6Zo4WiSopMUz7FVXd+6wkExq9dh5d6cnQ/Y7ZQ2VDHLgXW7cfO5oTQpCGm8Ar3Z8UvmlfK+yudx+ORWwvprtaS/L5WEcuOgWln9uycxR+O6m3e4RFTTkO/mK4gWlS8osugberiWS7F20=;24:yeRkAEE28r7EZ2xntrj48OF0uhke9CoCe29ljwH1MeenO+jnLoxo2MCJ78kieq3DaRvdCGfPUzz1RKueBVSQMVjvPMsoBWxxCJWMwpg4Rew=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;7:VuEy9W5BhsBuahIul2RG0V5u5o0AkLY50QMUayi8D29gkzI6tQgigpfStB9730yyu4LXupfYs8xZ6lRu0p0wgKgjil1n919i1HcZYi94Mw+3Wbmn+5YMWfF/tXvSlfflyE+gv3YdYsNmG66LLALpM2bfYbXtNi8tSVibVJjyya7V1ok04gNg0tcUZ1ksULlOI3ltIzhBKctDRDJFUE4OH+ZH5myGeqMXqEp624NJs9bsnIZrvzVlb6TccdDkihz2;20:kPNn8+EGroRQLBlDtqfgOSavGFqalUIF2WNPUz0QzPvA1r7ql3jILJV9mKT27qwCFfZOKowGFXKnVzNOOZbZS2OYmEMU0J8DLiyrE+zhrv2lzvkAev+kSftnbAsku2cK//876L0Upy+5MMFiEkMuEuWE5fM9jEXeOz/djYSo3OjwN0bkykOl3k3DA8vMSlhsqGSJIzOPKbl3bSrJRBKXREdKhaKAXv8S/PNSwZt/XhsRrqOXJpbodnd6CO+zP/uQ
X-MS-Office365-Filtering-Correlation-Id: cde04d73-1551-48c3-fec9-08d5aab7e2de
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 14:21:49.6201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde04d73-1551-48c3-fec9-08d5aab7e2de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 09:55 AM, Oleg Nesterov wrote:
> On 04/24, Eric W. Biederman wrote:
>> Let me respectfully suggest that the wait_event_killable on that code
>> path is wrong.
> I tend to agree even if I don't know this code.
>
> But if it can be called from f_op->release() then any usage of "current" or
> signals looks suspicious. Simply because "current" can be completely irrelevant
> task which does the last fput(), say, cat /proc/pid/fdinfo/... or even a kernel
> thread.
>
> Oleg.

So what you say is that switching to current->PF_EXITING as indication 
of a reason why I am
here (drm_sched_entity_fini) is also a bad idea, but we still want to be 
able to exit immediately
and not wait for GPU jobs completion when the reason for reaching this 
code is because of KILL
signal to the user process who opened the device file. With termination 
from fput   it seems impossible...
But thinking more about it, any task still referencing this file and 
putting down the reference and is not
exiting due to SIGKILL will just have to go through the  slow path - 
wait for jobs completion on GPU (with some TO).

Andrey

>
