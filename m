Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeDMUrE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 16:47:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58374 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750783AbeDMUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 16:47:02 -0400
Subject: Re: [PATCH] x86/cpufeature: guard asm_volatile_goto usage with
 CC_HAVE_ASM_GOTO
To: Peter Zijlstra <peterz@infradead.org>
References: <20180410204259.3981586-1-yhs@fb.com>
 <20180410210716.GI4082@hirez.programming.kicks-ass.net>
 <552d5866-912e-afde-f25a-77ae8390816d@fb.com>
 <20180413181924.GT4064@hirez.programming.kicks-ass.net>
CC: Yonghong Song <yhs@fb.com>, <mingo@kernel.org>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kernel-team@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, netdev <netdev@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <a65f6542-8754-ea84-d1bf-076349b6b288@fb.com>
Date: Fri, 13 Apr 2018 13:42:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180413181924.GT4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::5:afcb]
X-ClientProxiedBy: HE1PR0701CA0045.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::13) To BYAPR15MB2503.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2503;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;3:BQBJEZI9VTKvNgfMEVWhjeEeHSuTRLlu1eu5+1faGUd2KulpG04YQn75AaKIOgJUYVnzuexLe2UBd8WzrxRdXWQukxRxc2T4uWhqAO+bv5ixLWgiu9cBN9DXPk0T1mQTh81jIoYl+F2XA2Z9fsbqlafs/ZEvWRWWvtW32rDbb6xdFWOfYwLHwOCENT/77cddL7U/qMtxMapZjgrBVIYtoTKaVAwNCmH2B+dZy0uARBxvjgKmfPbM1xROj2PzizkH;25:eqVEH6I9q+ECN3aWRCyZuoSIFMtLjjyXq/Qm7gg5vt38sOAuFosgAR29fwdLnJ8aFQYNLmesgWrPKnwUKoLVglPlg84fBYw28ciuvHeyp9sdR2J2px6ZHQG0qSe/sePwRfNazyRAhqiDz1diFq9FqvzWkg4S+ou4WW5XAP3YzZFqmbrcqMhut/j8rg4SASUxTq8sPGmUE2SpjqVf0LzTiEZDnoxnWjaCcLHDIMlBqlJpzxM+taLFtrt8k0u+dPrEwARyGKwjwU1hh/l5rxneL+OJOk9hmuS2bjkboURGFA4jcuFfOfr8jQv1m8XgZSGQ5YRoLO7CFG7NDMdu9A6k+g==;31:IaIe5XH/AH3pIBDbiy+tbsJv0ePdxy1vm34Z7um/NFlUu1TO2w3klhbDT/P1twOMJe/UZHoYEdidlExY309bVfoQTsCM9E02uSE7l/pqPt/czrlDb653VWNXRCRIX8fiFEgzSxJHJLSW/ThHxLOfQClJI1CbbY5vuqGg/O/nAHKULkPYoucX6WJFIvqa6sditBNqpMVPfR/e7zKczUBs7iKXCjw34u0eiW/BGrCwa1c=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2503:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;20:na9NR8nWXfh4RFhyZtSCcSbKrXfOXI4RmNpVIadQ0yzm3oV9hQ4Hly0ROTejPoQtznaTJKrziHuIfFbUyw08b/my70TC72FVwOGSUz896VKyU2xSpUACQuQaZN+/RkyeCn/7k0H0uCjyT2Z4+GdOVEtH/gUy/X8q1QbKAXxOQ9P9hz21CdqdV7PTwb0qTVYipGnKjfVPjc7ha06nly/eSL0vVdGbjjtY6CT4HFlCgnRMgb7gp97/0ZxHW3a517/jG2uPXwxJDdfvfqA/OzpUf7ZOE8UQpqbsBwaqKbl3ihy3+5Qj5KiJa4zuyyL+ntD0fOekXyNfX/z8li+KTyOiUqeZGJRZxxztJtIDpeSXcwprP/oZ1rAYeecatIqrq5H6LWpNVMIkP1u7SZQrQv7UTOrJdaT1a8gI+k7SaJSARgHyLlmqeT6oiNW78QS8SclOQejsMC8BQOyM495uPrNwgC297M33qqJslUiAYz4/ZdVQNvsucZSatqU51U7+9QEc;4:rjlOFRJxk3inA5SZkxjB9+fOGkz4tnu2T/HRUtTsCU840WdBQr2hnPBm4Dud0/Mdapupa7RNdMZKAlVN5vRkpKvjhFgHNefTl4da5Px8EeYZbbadC7KboZO2iYwWVOdeFDgKUELtJQ6cINOu/wh2lN77A+68IcDFI9xm6U78C1DiG459xtDnetlTcvEf523DpuIdzrJryuDTsxRG1/8F0fx0k8cM1JQEoSll1I/XI37/FPiKFkhlkdPzhQTyrUY2fglQ5PHr9heUeythTbmXgJlURSCFdzeely8qu/Nck45scsSgC17Xen6xFJoHZ6Jj
X-Microsoft-Antispam-PRVS: <BYAPR15MB25035CB098E303E242AE5448D7B30@BYAPR15MB2503.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(11241501184)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR15MB2503;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2503;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39860400002)(39380400002)(199004)(189003)(11346002)(486006)(58126008)(316002)(46003)(50466002)(476003)(93886005)(68736007)(2616005)(54906003)(65826007)(5660300001)(8936002)(31696002)(65956001)(47776003)(86362001)(446003)(23746002)(7736002)(81156014)(81166006)(305945005)(64126003)(53546011)(386003)(8676002)(16526019)(31686004)(6246003)(229853002)(478600001)(65806001)(25786009)(106356001)(6116002)(53936002)(105586002)(6486002)(2906002)(52116002)(76176011)(97736004)(67846002)(36756003)(6666003)(4326008)(230700001)(186003)(52396003)(1706002)(6916009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2503;H:[IPv6:2620:10d:c082:10e2:2009:3797:478:f25e];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BYAPR15MB2503;23:kGXBW1VhGxbr1NcgcFX42ulv/v5HfJndw5QY+?=
 =?Windows-1252?Q?aF/5jj3uQcpBCGa7bHdz4EJ+1+wNCzQRfucMgU9zn6ilWE3YeHw8aMy0?=
 =?Windows-1252?Q?Wktp2XJmnFkXe/o/h62tUDqUeK2l8mdZaxYL5XIM5Y9y4BXsrrlVmhQr?=
 =?Windows-1252?Q?UuvjUpWpSPWxz921GGKrBHfJRGkCExetYyWnywFyXV1WNpBrUmAP9F8+?=
 =?Windows-1252?Q?+bVYfzg7PHtbayGOmBqF5uU4saDJVs0dSLoGtv5yoJ4S7RyfF4+uGASS?=
 =?Windows-1252?Q?eDcj9jtaliVtXNlKNW61WV6J3I1iOcwlvtDxPQIJA2/rL6bAc27UwaF6?=
 =?Windows-1252?Q?C8DlvzGhJGFtsMGXkr1QNB1muKDAtNccogpAHnApRGP+jUKwhwdHVO2c?=
 =?Windows-1252?Q?rIrmvPmEjEHZJdh/C1k3jcmrJ6QlnoSLB3a5N6vNqvncqholyK3n7TZS?=
 =?Windows-1252?Q?FBostYuITmYb7utu53/mkUvYAphy1xfHmOYfHF9VPGmjyHg4nhbxajys?=
 =?Windows-1252?Q?KXhrLONQ6mdTt6UMyUmiqz31B/AJdeUbNh0fwiONMyUqcg/OYGoSBK3M?=
 =?Windows-1252?Q?P57F7esTxjzPy/9WiSRooZHxFP+wutJBiLEhOzogpQCENl/qdmDf8r+7?=
 =?Windows-1252?Q?yhMUWy29YcguMy/aVp+ToYGZbs5vlAEUCrJ6/U0dP2HEbKO0zN5BgLkg?=
 =?Windows-1252?Q?uG6M+AWAc+8U99UI4G9bOnwEyVh1XZ3eizFKDDWiVne8xlLDKeNKGx1h?=
 =?Windows-1252?Q?8OOQliuiX/FDLMnb/kUzp3pVzMp08eDrzXbJLrHXmub23eQRdSLWfiLp?=
 =?Windows-1252?Q?7hpawqGQN9nfa7+nVVDkH3J7JrvuKXvHY8CVwM1DyRvyg0S/7RhJN81x?=
 =?Windows-1252?Q?y212EQfViIMQWOFiAfIyDufQuxioG3mhrJGHVokcURakr7uQkt+pm7gj?=
 =?Windows-1252?Q?IA90l9LVAD18Jd34xn7tse5GzfomhXBO0T3l04QtUwie4SBmybrW8UWO?=
 =?Windows-1252?Q?NSTuFY6FFiUbqGfOlk0LbFZWfRwXbH6REfgBykbLIIFGYBgd9SiOwS3y?=
 =?Windows-1252?Q?d2XelKFjw5aAjjVKsPylsEmd0QwUOxZNL6/4IpIiSZBu+0rjfPLuKs9E?=
 =?Windows-1252?Q?Brb+Si89Kslv/n/ntzDmvsHPwRNPZh7LAya8HL/bCuXhBlsVTgjUSvF6?=
 =?Windows-1252?Q?psbiMVi/VlhfMnvUMsLUq8gSz+tq94XhzNqQg9nuVxhqOHbdsiLrLbLV?=
 =?Windows-1252?Q?a8nIh2p2rMUAcb1PSyDOhbOMAGGZmikyWMVzAB6rahUrs/+Y6xCE6Tck?=
 =?Windows-1252?Q?f4RbhYAv05Vxu92DyBMthnGIuUzr7WmMrafmFOY19O44cbmHHMAMwunK?=
 =?Windows-1252?Q?IV+pHgk031CB2AFv5jyMxTryw12l16Hr7RGabiyxYf9x/fJpmKLkjcI+?=
 =?Windows-1252?Q?M3S6cuAPLQAMVXG4COLcEMgetik/MrDcUyDmPIMVD3uzMuozaxfNCQDO?=
 =?Windows-1252?Q?T6nRzc=3D?=
X-Microsoft-Antispam-Message-Info: 9LXTViCPjXaNHqnNCgdr2afFw+T1vhvQ9lRCkrBUl77HQ5OzA7Cib2AdCQLVygySMfNOUHJB6rFH+phWwGzh0TsxGh1rKS/SLTl1/1L2pw3jUCWOkNcGsFlKEBQbxZRIvMEhK9OIPrih3cqAB3FWvT+OPa7LiW+kYzdxj7l7MXWOZQ6e8vRUuUayRJBA+VM8
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;6:WV5OJTPo9zreoa3J7gPcnKRW6eWB/OA1dyZn0VpTHtVMxgu+H7sp5xqq2A9Y3xxhdL35rvW+CXYKhnLq13Hy9NruVI5hoTjlBV0zLckr7W22ZSa2Fp39qHtk6ClOTBaZT5uE8v1gTAyrl8DWfb//l8RyDimCh6vlAYCQav2Tk8ENo3ZcHPvcUN1H0b6+HJNP7sUjpDtaEzT6UtDJhvBHulenE5zVyn3lKu7XZxoxo341Y4eB3EvAkkQkO0F7BuikmjCwdtxxWQ/+cs3/1xzi57l9Ia1sxq5o0m6X3uiY+DG9jP3DnOTzt8Unr4yLbJIaguieF494IDNBiBGaLt/SsNjBwUFWQDLuu56w4xkyo9/kIek89+v4Ix/EBykICWoSjAi6iFlAG1qXFdv3FauyviAilHTAXjosmH5c84drxEaRXBe16COZ9SjEE+GMJfLt/EPjWgOp/up0dUhHwPKwkw==;5:j0E5tyJ/+kE/hBUMoAAD6fZxs51RsyPW9P0Lnf/xngTs+geA5wfKSFCdjHFx4puaX6YIDRAU2u4D1xBxU+6imWn56eHpaOzP4L+hIQCzR6PcTLpNS8XwGxTF+3nimHhmV2PC442LesZViarKiKBULnnKo2/BYHY4fqjiXIxPdlU=;24:Ui5uR9KHeowfETUWeiLNwwu4dpDapD5c6Gr07tQSFXk0k7Q6C2Hfi3ZTjEPGjuO6hxBEzfDDsTSNFiyocqzDv7M3KhOmGCwIKEPrMmRSTCY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;7:o1LYHivqgk2xhxR1mRSVTRUDwVji/MtkEQQnE7Ti8axRwJZXM5fJXINhP9isPWAIUv2zLROvC+FvO2xIBQrULF+TrAinsSw4jmm/CGmqP3JaLjOArxDyI+w2+gjpfLgOkih3yYNiPdqcZ/CMY4S5FAA7K5VcLsmGXFJHDUP3zfgz2RHC+qmCw459Qe/LB9qtUfy1NGx6r2xaitfJoNqfumz8984xEM/+EmipcDLPOLp91wOFy9gnXoz53TGIMTEQ;20:C5bnmN7+gX0roOLTwa+zbx7kn7kzRpbeKO+1565PomL8NxuCOHGoLRgI8zRxfPT8pEC1FS88w6HmtmVo1zou6OpvcK6oGzLHnuU257cTaVUQzVTYEExCgcghNqj27N89wS5oPWYkg92MnYBSgMMZ+JXHlDa3h6Qy4v6SePQUi7k=
X-MS-Office365-Filtering-Correlation-Id: eeef05ba-c349-47a7-e5b4-08d5a17f1441
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 20:42:26.4949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeef05ba-c349-47a7-e5b4-08d5a17f1441
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/18 11:19 AM, Peter Zijlstra wrote:
> On Tue, Apr 10, 2018 at 02:28:04PM -0700, Alexei Starovoitov wrote:
>> Instead of
>> #ifdef CC_HAVE_ASM_GOTO
>> we can replace it with
>> #ifndef __BPF__
>> or some other name,
>
> I would prefer the BPF specific hack; otherwise we might be encouraging
> people to build the kernel proper without asm-goto.
>

I don't understand this concern.

1.
arch/x86/Makefile does
ifndef CC_HAVE_ASM_GOTO
   $(error Compiler lacks asm-goto support.)
endif

which is pretty strong statement of the kernel direction.

2.
Even with this patch that adds #ifdef CC_HAVE_ASM_GOTO back
the x86 arch still needs asm-goto in the compiler to be built.
As far as I can see there are other places where asm-goto
is open coded.
So there is no 'encouraging'.

Whereas if we do bpf specific marco we'd need to explain that
to all bpf users and they would need to fix their user space scripts.
Amount of user space breakage is unknown at this point.
