Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755709AbeDWQv4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:51:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755486AbeDWQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:51:54 -0400
Subject: Re: [PATCH v2] x86/cpufeature: guard asm_volatile_goto usage with
 NO_BPF_WORKAROUND
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kernel-team@fb.com>
References: <20180415042738.1788215-1-yhs@fb.com>
 <20180420081936.GD4064@hirez.programming.kicks-ass.net>
 <fd14097e-31c5-0c0e-cbe5-d399299ca489@fb.com>
 <20180423105209.GX4064@hirez.programming.kicks-ass.net>
From: Yonghong Song <yhs@fb.com>
Message-ID: <3a6e6348-fb23-c2f9-5bd8-928b056b4722@fb.com>
Date: Mon, 23 Apr 2018 09:50:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423105209.GX4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::7:d824]
X-ClientProxiedBy: DM5PR21CA0031.namprd21.prod.outlook.com
 (2603:10b6:3:ed::17) To CY1PR15MB0078.namprd15.prod.outlook.com
 (2a01:111:e400:5849::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0078;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;3:LrC/YjODTGytalcgCl6bplHT7or8j/SUXz7j9tdFLM0lyX1LJiKuTketw8owhlIReyvvB04MTbXEutcskPzTVo6+0cbvutSfMpvcGXDnyNpVVak2kjwhG/XIElr3yTQQxl3b98kuOKJJgW1BsSAYI3WOLPkH6jkDpRAplJ4zEzDSYtLiPmS7amBPERIBDD/G5iw8LdP06egX+34UQwlb3bHrG0zo1wwZ8p0K0rTKOfV464PrN+QwSleNGQRnZH+r;25:Bx8zAQlC1xUDEmrYqAYXczcVtsg2CyXTBT31qgUUYv2lwXIjS3tg1wI+LEsS44S+DtgEiLl2YC0kOtBVD8+8dPInrDosh+jJd9Nr+hVcSCqqarbHqPg9nZuD1P/5qlJEBSZOHE3qsaT8u7ObX1njdroLijH2GINtuQ/OasaEpiVawPDQqkh47gskqG4FQfdYizgLXFJ/D/zVTXUYrEGF/Tyt9BjaBmViCoVxAguwM1tADh/m6laMnZOuwmqBEJrS/XxqItWM1+hB3Bq3ls8B2JstAtwzgE68a2u7RoA/U0qePB6StIPjYf9foB8kZvJgMmKcDFkjClA3JQe75nk3dA==;31:m2LgvYhLUgUKjs8uBEwUUrnpaXUT4T2Ow6/OpjTZxMcfofBdbx2//7WOG2XZaD4fYBGDiNDFgVG07fywv52pg0Tn4a2yvznqcSgng8nd/aRr9z6MLgbSmY6yJ3myRhg+jk0MenQ3nDNcPUhsgAsJTAkHiX+YufowmLBaAfoPBX9OifwRjlyF1HaSBbPqq/q6BEYhheskLjR0fV1cfTSJ4Zj1QhM1uG5mj9xzmPtpLMc=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0078:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;20:CF6zsYpDSwXm/mOPqJW1ASQzimC6CDSR8J1lH21ptw09QUxAb9oU5L0+5YqD2YEII3mvZX9iePvOw4vwOTUHJ6Bf9SqrrJh9L8RI0YWO9u3MFSu/6ZB4N8C5EjhNueN7qqb6+2YpcEX04xqHrHDnD25nxi9AcPg7arFMgPUBuAldqndZ64Iv+I4ATiqnWEzlnmmSTPPC8fC09BkSSnNk9NSyfPdhbMafMgjwzEKeb9vVl8APjdySOMZz8ZBNLWfiaXY1aOaTaP/5LS9vvQJdb6iTPKrfByDjUbWX4LP/6O3F8aAh3LUTrgW6REI01mSTmJPfI3mntFCJaJdlnPbmvsc6xcO/38KyiuX3qcXkPZ4mNebbpXxnvDIPHX/hvmWYOFIkx0kDG+e1y6msDYceWnzdZg38BNgnbF7+CZxaozG4wIJuQyq3D58R84yXpdq56eIoMsdBBZQNJXvnXBU9xYORQkQz6CbYLAr/0Y/7aIo2k5HsKQLPFZUPnQc+gFV9;4:v0w2nDC+efD0TqL35syylOh8g4dBdfn4iQL6E+fOcQ55g1FPmSDk3ssTIh5LZiqDJHwsSY4Hpn4jMrqwAVHebfFGCDv/3Rmokly4WCA9KQ2RKnF76sNhJvNVWj4fXnv7JDQgWSe6v7e89qzzi28nSXC88cGSp6BsbE1jtU/G9ts38o9LvfoqoGENdirKuSJWi/9T+F55NXE2hj7K4syFwMs46dWDhqNqN4XoeUQhyh3RKpaihn60JXd0RQpFMBuczHFZyPodEiPJpQFWzZ5yJw==
X-Microsoft-Antispam-PRVS: <CY1PR15MB00780A482080DECB60AD8A41D3890@CY1PR15MB0078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR15MB0078;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0078;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(39380400002)(8936002)(6916009)(93886005)(6512007)(65826007)(6246003)(478600001)(230700001)(6506007)(386003)(2486003)(53546011)(23676004)(52146003)(31686004)(316002)(52396003)(81166006)(86362001)(305945005)(8676002)(4326008)(7736002)(6666003)(53936002)(47776003)(67846002)(50466002)(6486002)(46003)(31696002)(16526019)(229853002)(36756003)(2616005)(446003)(11346002)(476003)(2906002)(5660300001)(6116002)(52116002)(76176011)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0078;H:macbook-pro-52.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjE1TUIwMDc4OzIzOldYa0Jyc3pxbWJmSUZoQnFndGdta3l5UmJh?=
 =?utf-8?B?R0tEVmMyT2hUMm81Nkcwakl2ZHVrdG1rbGJsb1ZYNU11Zy9Cc0JCK2hqUWpY?=
 =?utf-8?B?Q1dabkpCM0NIbGt2WmU3U2tzbW4xaElGUWNXekdqczUrcUhVWGZRSmlSTFpv?=
 =?utf-8?B?ZCtIZ2ErcUhPaVV6djBKdlhqa2hBMkU2TXg0ZEJ5OS83akdsaklNdlVWdFZm?=
 =?utf-8?B?SU92Vnc0N0NZQldIQm9KNFV2UnYwOG0zVWpHUTY4ellhV1RyZjgyY1dZLy96?=
 =?utf-8?B?WllsbVF0VVc5aVZObklMdWtJcjA0c0plaVlBMVZ4UlB4V1Bqc3ZDbjhXZHRn?=
 =?utf-8?B?ZTdrTHVWbjQ1R29YamhIM3NvdUgrdDZ5K0o3YjFma1dsWUhlUGMvbENhcElu?=
 =?utf-8?B?YXJybUpudENWeTEvZWJIY2c4dUFzU3Z2UHBMWGVkaW1PQlVrcTkvZjA0dG9E?=
 =?utf-8?B?L3Q2b05QQmNKdHQvOEtldDJjOVVwOVNYcTdjZWowbWhONUFIWE1QMS9MQmdB?=
 =?utf-8?B?Z0h3RDlMTldqN1kwS0RPSjl5a3dhYW5DalB6WlE0cDF1ejJ4OWw0UjdCdUFv?=
 =?utf-8?B?SnF2dFFReXZqY3dtenNMN2dQOGZHVE05U3NOcE9pVzFtakZ0K3RBTGloMkk1?=
 =?utf-8?B?akp1bVE5b25hQXh5SDhORzlNdVRtZkU0Y3JzanNQRDdSaHgrSzdseEpERWJi?=
 =?utf-8?B?dktCUlFXRkdhYkJzMXhVMVNPTXZCa1UrTkVZcGRQTVVMa005WjFEV21XVjFH?=
 =?utf-8?B?WjhRVTZaSEJkVmJjL0dVRHdxSjRPZ2x5ejRqTDVERFZwMU41YjQydFpLUHJp?=
 =?utf-8?B?bGExd0VRVURTRUl5TkcxdXpWUXZmd2tyMUlWVkxTR2Q2a20rb0EvMjNqSVdK?=
 =?utf-8?B?VStRd3NIRmdBVE00dTkyK1pPRlJteHBDaGQwK0Q4Mzk4YU5VRkg2amF3Sjdk?=
 =?utf-8?B?aEFkTnVIaE0xdzlkU0s0czFyRk1oY0Y0Z0EvNFRva1dxTnpPcnFORnpJTnBS?=
 =?utf-8?B?YWZ1WVpSYnZGV0FOVHpkTTRURzk1Q21jWUk5enJtNHVHV1p6YVB0T2RHWUc0?=
 =?utf-8?B?TnRtRGw1WmJHYW5wWDRZNUdweWszZHZvSDYrTHBNTDR3TTArbTdhS1JBSld3?=
 =?utf-8?B?SGFLWEpzWjNHZlJjSHhFV3U1VFNNOXlPVlpjejE3a2NJT0ltNWdPREhmbkVF?=
 =?utf-8?B?Wno0Nitva0RlRm5YU0kxWjNPWjdCNkcyYk9hbWVMSk5FdGpzdGdmOWdOUG5M?=
 =?utf-8?B?dEdJSDFGU1BwaENmV0hwOUsxb3NKaDg5ZDR2Z2E3YTdNYUhGZE44VjZaakc4?=
 =?utf-8?B?bS8rVGhmeDBEVGZiUUowZ1ZVWTRreVFKbkVUY1NzQ3pUYTUrUTROZUlha1hz?=
 =?utf-8?B?U2JBZTJGMFQ5QUM1bXREN3dLWXpRbnFtQTJIbkdJOW9SOHhHSFhZTG95SU9L?=
 =?utf-8?B?bFcrWXdMSEU4UlpvYS9zVEgwQmQ3QVdjTFFmcnZmVmJtNmFxWE85Tkt1UTE5?=
 =?utf-8?B?c2VENndxbG1KSTlIOWE2REdlT1NvaDlBSnI4dW9saHJLanpNbjdKZkdweStJ?=
 =?utf-8?B?T2pOOUpJRHgzSXFCbSsrSXRzMmVJQmc9PQ==?=
X-Microsoft-Antispam-Message-Info: q5OomqaDf2sijOwHZmFdo+NzEsQKiyMl59TIALzyPhZK9iVLqfQQNm7Wr7JOopQb7tFt+/9mGXTGf86epJGFLPaM9rSOeyhK3rZWUTrqkXNdQHGcAzdBFZWAl1XbTIRMhhOEt3Y/ZpKD/dKA3jDyhmrwtsZpCthNwd3CllTPMB1pCorUBmTrFB03jajtkS3l
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;6:90nqjbmjT1Afcvw6GrSRAGWBH5NE6RTSVhKz4nu2iWybbYwpuwMoYhQbd88kh6kWFvXtAKtTX7I3ZFjFPwRo1+Atd7LFDiY+vBTSUY2Yg0WdpSs0RXKiWm5iYcDvt9mXgF/PvbTYl6zoK1LqYAs5PRHgtcHG2rDKPZVsBizbQ7qUkAZf2s/LH9vKWWDSNGF9GyYNcmX1oU7mUoi15jJcKuG+CDx2gayhhgRWlLYMomd9Xg4I4cueTIiO2RFfDP+h13wYkFPJudaO4pcbO+NZIj2AWSvQH3IvH3IvSMC0tvI5gxvttzmyBMJs3IUu+b1j5S43MxAZKmNBnO4VNFvl5qUHqjppH7H7HEaY0GepBk7+zIqGy5R4jQEIA5CAG4SGq6jch04xPzylY7ScGn5QBeusD7f1vfYFBEzSoOUubgzZuU6H3aB3NE+XOz2dAGxU/IjjIAdzyHf87+7ltKx/Vg==;5:ol/N6G6off0xyp5RY5MqnxlY/C5EVIXDrMYRXGrW35j49xK6FToZLlpFmidGrZFo6ELlCt80SIoxd6Hb7GJFqVUR4ULOV756yuQHXIQwKtU8DGHN69qzni0XYgru9QjKKK0J48M1Mi1E2uHpzfqOUtUGPm+W6HMjkKvXc4RbYSg=;24:Yk3TNHLcbBdUY/BN8lfrIluZZzgd/sqf9CNP65jDvapO5IjVs0S11VWgEkKIja6c+flVUETkFtGF6dQVG//DnKY/w2UGL7koqkHj9h8pR8c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;7:GFtkr779wpNLEuzaQK1LTkkAaxgZRMaZVMKBZKfZeXvOrsY0CnJ5QJoJ1xUCdKbCIehQz2wP0l/opw2jLB716wXFzyIljf1P8TbYWSvcu4fKme5IqCzqoxLW/YmOHTmVO9L1NNIgyjXtSOnGZ0ZcB46i3jhcn2l9qGbnzojVOLZxzbJ/AvXfcYa1oNy2V+Fw73Z9PP1URiNIaIkOx48nQvcSgi0sAinoH47E9ts6szS6TbclQXoOrINKMMF3F/7t;20:MZ00wzRLx88+o3p2UKntsVWg8ngcSQl/AxTpkYwHxXvZNZ5C3TXNsssYCSgYMk1k8YXt8zg8l5loQpTCmihmavz+IUcM0+tvFuFYJlSe+SzIBC8LbtLOk9bf0zG5Hi7/p/vWjYlWZ6Z+gwMrsn4mFIfG7i53V/j/jZphG1/GTJs=
X-MS-Office365-Filtering-Correlation-Id: 38e0562a-6fc6-4654-fdc4-08d5a93a69ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 16:51:08.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e0562a-6fc6-4654-fdc4-08d5a93a69ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

Please see comments below.

On 4/23/18 3:52 AM, Peter Zijlstra wrote:
> On Fri, Apr 20, 2018 at 11:06:03AM -0700, Yonghong Song wrote:
>> On 4/20/18 1:19 AM, Peter Zijlstra wrote:
> 
>>> Hurm, so adding __BPF__ for BPF compiles isn't an option? It seems to me
>>> having a CPP flag to identify BPF compile context might be useful in
>>> general.
>>
>> With "clang -target bpf", we already have __BPF__ defined.
>> For tracing, esp. ptrace.h is included, "clang -target <native_arch>" where
>> "-target <native_arch>" can be omitted, is typically used.
> 
>> The reason is the native architecture header files typically
>> include a lot of various asm related stuff where "-target bpf" cannot
>> really handle. We relay on native clang to flush out all these
>> asm constructs and only bpf program needed stuff survives
>> reach to backend compiler.
> 
> So because 'clang -target bpf' is 'broken', you do a work-around using

'clang -target bpf' is 'broken' in this case because the x86 arch has
a lot of inline asm's in the header file where bpf target cannot handle.
For most networking related bpf programs where `asm` is rarely involved,
`clang -target bpf` works fine most of time.

> 'clang -target <native_arch>'. But because that doesn't set __BPF__ you

`clang -target <native_arch>` should work, regardless of whether __BPF__
macro is setup or not. The reason it doesn't work now is due to its 
lacking asm-goto support. So to use `clang -target <native_arch>` is not
really a workaround for `target bpf`. It by itself should work.

> want to add NO_BPF_WORKAROUND to the kernel instead of adding __BPF__ to
> your build rules to better mimick -target bpf, which you should be
> using.
> 
> How is that sane? Why not use 'clang -target <native_arch> -D__BPF__'

To workaround the asm-goto issue, the suggested macro __BPF__ can be 
added to user space and kernel. But note that `clang -target 
<native_arch>` will not define the macro __BPF__, so this requires
user space change.

Also, to make sure people understand that this is a WORKAROUND for
asm-goto issue and is not a lasting thing we want to support. I have
the following change for cpufeature.h:

diff --git a/arch/x86/include/asm/cpufeature.h 
b/arch/x86/include/asm/cpufeature.h
index b27da9602a6d..c832118defa1 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,6 +140,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, 
unsigned int bit);

  #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)

+#ifndef __BPF_WORKAROUND__
  /*
   * Static testing of CPU features.  Used the same as boot_cpu_has().
   * These will statically patch the target code for additional
@@ -195,6 +196,9 @@ static __always_inline __pure bool 
_static_cpu_has(u16 bit)
                 boot_cpu_has(bit) :                             \
                 _static_cpu_has(bit)                            \
  )
+#else
+#define static_cpu_has(bit)            boot_cpu_has(bit)
+#endif

  #define cpu_has_bug(c, bit)            cpu_has(c, (bit))
  #define set_cpu_bug(c, bit)            set_cpu_cap(c, (bit))
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4d6a6edd4bf6..b229e5090e4a 100644

As mentioned above, user space needs to add this new macro definition.
Specifically for kernel/samples/bpf:
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4d6a6edd4bf6..b229e5090e4a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -255,7 +255,7 @@ $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
  $(obj)/%.o: $(src)/%.c
         $(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) 
-I$(obj) \
                 -I$(srctree)/tools/testing/selftests/bpf/ \
-               -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
+               -D__KERNEL__ -D__BPF_WORKAROUND__ -Wno-unused-value 
-Wno-pointer-sign \
                 -D__TARGET_ARCH_$(ARCH) 
-Wno-compare-distinct-pointer-types \
                 -Wno-gnu-variable-sized-type-not-at-end \
                 -Wno-address-of-packed-member -Wno-tautological-compare \

Please let me know whether this approach is okay to you or not,
whether the name __BPF_WORKAROUND__ is better than __BPF__ or not, or we 
could use the earlier approach which does not require user space change.

Thanks!
