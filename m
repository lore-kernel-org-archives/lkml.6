Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeDJV2y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:28:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751774AbeDJV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:28:52 -0400
Subject: Re: [PATCH] x86/cpufeature: guard asm_volatile_goto usage with
 CC_HAVE_ASM_GOTO
To: Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>
References: <20180410204259.3981586-1-yhs@fb.com>
 <20180410210716.GI4082@hirez.programming.kicks-ass.net>
CC: <mingo@kernel.org>, <daniel@iogearbox.net>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kernel-team@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <552d5866-912e-afde-f25a-77ae8390816d@fb.com>
Date: Tue, 10 Apr 2018 14:28:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180410210716.GI4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::4:d349]
X-ClientProxiedBy: SN4PR0401CA0042.namprd04.prod.outlook.com
 (2603:10b6:803:2a::28) To BYAPR15MB2504.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::12)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2504;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;3:pU65KjiAY8dCWpn31gqzLNG+d4yZY5lvfIi9EIFvHSs8kjfVK/+P27fyLhe/XTc8qJ5UbMxhWBULEhAiqmq2EN6nMZXGShfYPrzA6iUg8QnVAky4yXHHsRJkm/VCtGBxTzlw8lFcog09enLuZjnXO0VYM2R8twri9vz5cSQ7RsD+1mOzqJdYKgwu/8LCDRNcbgxTArVmeDBTT9wNphH3NDf5QPK1jtswsB1mdpgePDQC8Vdi4wOTMToTLAbzoGBX;25:Hveqf16FOqh0q/o0J77FSFDx9Kw6k/2A4hO75ztPMs3IrohR6iWSfXDrIdJnePLJ0inw83sUlp1BzEq7V7hZ2GcYPIiSBGwnsNzPw89fH5MNcGPKN52AIeOagKGCdMW64o7xYpBRGAmEANQsD+xx5Zrg1C/w7gzxbOFcT3ejOvBOPWSoEKh02/0M1nXAkAKkX/5Cl94U6FG00Nz7lydvQPDluwAsb7gin14lncxQli+BrmL+FpAMr2kQXovdyI6GtiLWbZnnNSm2jcJLJyT32J2gRvY2KuvtAkAsrZIkoHaua9SBzR3RBzp89eux6r6jXQyTl4CPWshhesxLnJ++Dw==;31:i1T01Pm7fDhwoTW9mg4YPykki7G/bvMWUGh1nU59GnVaHmd81y7fTaUf1RsPL8QZjG2L/jUT+DP1Xw3S1HeMDoDXI7MhypwR0h8kLcXfYG4SCRTsx0UTz9XYJtifUuQea91Y3NrjT5fd+fvjjVruFkLsvnPEpiyWDQHR+PGux8BjWdXCIQrlMd9VlKUmCKA8QSESUxDuuN/X/qQVETNV2D85Ak0A3GoWQv9MEQE9Y6s=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2504:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;20:rJN0N/d3cR/mGgx7DSMxEl1cJDign78Q7U5Mzby1v8CZAdiotACz/FGmB9dYTLMKqf4ZL7E/z6pXf26qO6CI5klOjRtYNKgywZkQJEkV5mbz/35nYgTicBFNI7lMFrrG84aO3vTSWDmhaqdlqQAl+YIbfR4arrFfEj6ddr/dntnqec+/s6/rwXVv6LgExPuV+YSoZ2rOxFSmjp1gv/f/AvZWGsaMbadIlKSz8AOgeaWU5y4NZAOvIOsZau68/VvlV/N7JJW/SQCl6CQeGhK04CLpYWMfDaPj3eZfgIt/p/XVmKOrN4CqWwRq7qmdJB74612IHXKf/cvMfkeKEnMdIhgaVEB8bttL9qMHW1Z3U0q7LTqfWRIkTnHbxml5mYwAyLn5Q3V+JtAL3Sz0mBgU0DeyJJG3snbpvJjODpcOOP9I7iW5uW04YB51H6GM1gp5w8DTSxuK43u/jZtrLoHqcDxMrUn4dqqehnDGLjqPvFXKcuTa87YD5okMpfYdAsX7;4:iy/3ggz7Rp7MYm2yDfE8QwJ6U6LSgVGjiJ4Wsm7uVjRmfX5v3jDasHZ0cFd+T2IStut7jjuCG7FTflOSFJQiiDddvxG8K7L2Woekt5dSdH0upvzxZbi/SoD6Fs9VfXP0fLhYT3GsmVJTKZoeMflR0qMYL1ZhpIMOSWKCn15ttLBQnsAh/u/34hXBNGo1JnhyhAk7VfHi00zDNSMv6H5sxD7mZG6eUqwarDPZ0m8nVKS+S6Bn+5HH6NT9+ZdU6DXNcHJKuZi/FNEhLFGt31tCtE7/QAQuDF59QlfKzLlTSzs3fshC085PO1/wcbtzvB33
X-Microsoft-Antispam-PRVS: <BYAPR15MB250436FD36B0A253751CB7FBD7BE0@BYAPR15MB2504.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR15MB2504;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2504;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(396003)(366004)(199004)(189003)(1706002)(476003)(2906002)(65956001)(65806001)(47776003)(6116002)(6246003)(6636002)(7736002)(6666003)(52116002)(386003)(2616005)(316002)(53936002)(446003)(5660300001)(76176011)(305945005)(11346002)(65826007)(53546011)(52396003)(64126003)(6486002)(58126008)(81166006)(8676002)(4326008)(81156014)(16526019)(46003)(110136005)(86362001)(68736007)(25786009)(36756003)(186003)(486006)(67846002)(31686004)(97736004)(50466002)(8936002)(230700001)(31696002)(478600001)(105586002)(23746002)(106356001)(229853002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2504;H:[IPv6:2620:10d:c083:1309:2992:ef8a:ea72:1521];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BYAPR15MB2504;23:qp9saZUmana5TVO8MOcmT8Z/8N3zpDastlZBi?=
 =?Windows-1252?Q?XMQ9US73r4PKbMbIZGYejRFT2oY11/DJq13/qTjEbtCs98ieU5p9v+ci?=
 =?Windows-1252?Q?PeYk3hqQ05qj6aM1EVPXPKwqlDm6uAZ2jhJ1NTFzZzD8m1pxknJV/oYK?=
 =?Windows-1252?Q?+DywoNUJS6YfbhgRouJmn0JzVNjtoC704sy1oQao55j0xvHKHV1KtsIg?=
 =?Windows-1252?Q?gOvN639uLUGXzTVM7IYz5Vknr3MoB6/9mbLR7ToND3rJKxZU/ZmfiFhI?=
 =?Windows-1252?Q?NOY9sz/UBMDnBAV9IydWHxZ8Py5xw1Ro3dgwAi8sBO8qclUKJ5bCDmWx?=
 =?Windows-1252?Q?xKGe6bQLTHb7h1qyJCcwsQINfvr1ZN2waB0nW08DH2IjZLZcN2YObCnx?=
 =?Windows-1252?Q?PdzRujUuKl2x/R5OeFBjsXxDAWCvt7Ki/kmm10PCeDwpKKgvDpqLO667?=
 =?Windows-1252?Q?sOefvW9oOxTQSJAP9ercquooYGba5dhZBT93NIyJSvoXXBCh79SjIdCY?=
 =?Windows-1252?Q?r6w54KbOUkuP9vEBZ7/Qrns97sSXRvf2+8He1ulIjw3lvfx/k5l/pCjG?=
 =?Windows-1252?Q?+lcrIxQK0QlXQZj9kmyrtTQj/+MMZJB2BETF6MT2beuGtr1cMBsABEGb?=
 =?Windows-1252?Q?igpez6yHVUY1j49E0xMSaXTNZiCKHl6aqWNa07vFRdN5kEjp3qJgp7sK?=
 =?Windows-1252?Q?1vC0LmZCzJVTljbuGbGdqO5DtEkXE6eN4Bo+aDKImp6aOR39bXBtGf4Q?=
 =?Windows-1252?Q?ncy/BGJHDRVAjibkmvmi4rgGvLyWeaukpu5jFwZU9+RNHKNMXreXLGBf?=
 =?Windows-1252?Q?49kamtV18CId6RUl4R6OyYYPhMbAnIbju2qOGMJr6qdYqKn35Qr470IT?=
 =?Windows-1252?Q?MXzNBc3+geV58VUNbVVTzClVC1TcmFOLNRfCY7PlmISj+oUyTzWgsOIy?=
 =?Windows-1252?Q?yRFfTmRfaJu4BJBJVHs6L6dW4YEFBAtqhupaS34Y0Pc40Nqr+RLomw7r?=
 =?Windows-1252?Q?jtaymMT3kfQwCge+bB3P9c5Lkxb9rM4rjKfepvTcOEHEaAIhtgYOISOq?=
 =?Windows-1252?Q?5UuZEHMKHMGknrlfxNwM/B5/WaCM/K9xZ0LOCdbFSEYmvlHhagLtLcZI?=
 =?Windows-1252?Q?yldARjByYRP6KUx+X5O7ycfdNz0Qbv9jY3CEe1n96BcAuAghYUZ6T0C9?=
 =?Windows-1252?Q?LtDQmmFbJBKLu0zrElcEvU8jG5DJS8XTEQxIzDgWbZKWwhnnN3vYsRl3?=
 =?Windows-1252?Q?yaNSsJBWiB/jQk7xW/DRpz6fs4c8frxIxbry4B0MQK9VsT++LFdOvjTD?=
 =?Windows-1252?Q?g6VJHmQXpvIdSk1CerUKHQ14aO0mjJFxStpOc8583HQHrwn7APWTQMjB?=
 =?Windows-1252?Q?TsUJFWBMtfd9Gf2VSXXS9tVUjylKmCzebRGVgXqeXFv5sQNapUEgrQ0w?=
 =?Windows-1252?Q?I/ERRdwwVh555b/ltNPF9UfYJGxzeY5zyZKG2aG6w=3D=3D?=
X-Microsoft-Antispam-Message-Info: qI6Keeg0FZmeA5BR9H5EM7/2M12gXDTux97wPtMNHI6u491/OVVEIRMNo6stxS6d7eP3jlZCwqu5r6/sZ8EEnlj44xL4I8Ik5wJx1OOp8ng4+oiy/RkxyvfJ3SPSLot5Q29XgWAM892v+aWQYp0OZqdY00v0+G/+Wm3D2+EMv+3mwIz7/WB4iUN+gY1Za0yp
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;6:qdSt18cFqrSKHQj3Cs7OpDx8UVFagYs6CTBX8I42o2h5qmfm1Z+Zl34Fjeo9FuHJFL15N6AMB8oVEYQyNEn8d2VAjzM0i0FmTeOk0kl9zVi5sYvXjsHJDyF40QevvpYui0VZ1Oyrs7GN0hGEDG1680bNjetlx+3PClGcwb0tviSYAjTNxb6EjBdTRYaGazzYL8oIyGVh1Z803FFeTlmbrJRPdVB0pb/HvClwwt/b3jUyfRfXanVNu/KDLFe0J6eg4O74ZoyUJ83JbkF73GFY/aM+KDjh+RAidIzpxvhJw7A2TEvBayPX8lLKzNJ9YJ+9fT7J9AUvTyNbqXaHphF48B5pKiBtHwTg9jRjtbIrOTj0eUhd/clJ7qke2BWabwXmD5ix4mB9iTLBKXb/YN/VnEX3mnmR1E0s0RUtpbx1HI0XJ6KAAe9CSU1b0Ho2MYmCtA4FeBhxMvfuNRiB5uCgYw==;5:yaU/79me1GYhsb/7Vr4eTcKCGVm9TDjWHirQgRC05dpYpTZYKJdhDqjwWACElGdG0LeHXli1jODpxdcx+7r9tSGe0Xke81bRAGdn3yOj3aIg/yFMsOzzGDnsxIkQVaRJADH5bJuMb5BL4FBrIuJjKehk7eE3/FxqLdMtp5bPsKM=;24:sl7geDFIScI9hfm2YaVuDB90aMi3ZpIRr/7oOusUDAqi8T0x1oNT9b3I8bD1ZVp2rqy3UDifFt+XiqnD6KMlOtaBApvOMiyFVq1d8Wi2ajs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;7:44VDFkQu/+QB//QtGhB9geVHnsIDciNHBd67kK9vHZMFK5Z6ZQ5eGPhmBdx9bhYdVKCvuIUQ8TqUsdlxVpMY81CzX423aolhMJcNZR1IHdX4YCIx+ZJVCILp4BqXORphF+5s9JsVysoQxUSPsuq6Grj6npWXFPW/d7lv8wD5Yvz+6z3NV/vrCGxCKpmJGMVbdz0NGaskxloJ+vfgUmXqZz5i6wKv3vNQ9eyQW3gpyG17URLexAtYlAMtpjIkJIdI;20:Xauyf7ILmxQsPwt+BAGmyw+CRnOjPF+Bm6JCjAJmA8un0saky2d8tXJ+Qxxc6o0MtfZbkjCeXl/D8HRopQScxRVAJrtaT0VRn5no3skeF8KFVfwLvWQd2HSWwSzPLeUtBFyQbHVYgtnb27U9Y4Xeyp0yKW72TRqov72dxAYFPAw=
X-MS-Office365-Filtering-Correlation-Id: e1b66412-5b41-4317-8178-08d59f29f5d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 21:28:09.9391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b66412-5b41-4317-8178-08d59f29f5d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/18 2:07 PM, Peter Zijlstra wrote:
> On Tue, Apr 10, 2018 at 01:42:59PM -0700, Yonghong Song wrote:
>> Commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")
>> removed X86_FAST_FEATURE_TESTS and make macro static_cpu_has() always
>> use __always_inline function _static_cpu_has() funciton.
>> The static_cpu_has() uses gcc feature asm_volatile_goto construct,
>> which is not supported by clang.
>
> There will be more unconditional asm-goto usage, clang is in the process
> of growing asm-goto.

Eventually yes, but we need a solution today.
Right now all of bpf based tracing is broken because we have to
compile on the fly with clang.
Instead of
#ifdef CC_HAVE_ASM_GOTO
we can replace it with
#ifndef __BPF__
or some other name,
but it's more hacky, since we'd need add -D__BPF__ to samples/bpf
and to all other places that use native clang to compile.

Whereas with 'ifdef CC_HAVE_ASM_GOTO' everything works as-is.
Top kernel makefile defines it and kernel is still compiled with
asm-goto, whereas native clang path for the purpose of compiling
bpf progs doesn't have this define and also fine.

imo this patch is the best solution _today_.

bpf compilation needs kernel headers only. If later you add
unconditional asm-goto to .c, it's all fine.
