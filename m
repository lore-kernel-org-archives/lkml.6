Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54BDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D99920827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D99920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbeKFT3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:29:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:13588 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387505AbeKFT3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:29:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 02:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="88934108"
Received: from mke-mobl.ccr.corp.intel.com (HELO [192.168.4.139]) ([10.255.30.228])
  by orsmga006.jf.intel.com with ESMTP; 06 Nov 2018 02:04:52 -0800
Subject: Re: [LKP] [tools/bpf] f6f3bac08f: stderr.failed_to_prepare_for_bpf
To:     Yonghong Song <yhs@fb.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     "lkp@01.org" <lkp@01.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181105053635.GS24195@shao2-debian>
 <ad890bee-0cce-c2fd-c1a4-900c928d82f0@fb.com>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <e91fbb35-0f4f-b2ef-f067-68f6d6116119@intel.com>
Date:   Tue, 6 Nov 2018 18:04:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <ad890bee-0cce-c2fd-c1a4-900c928d82f0@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/2018 9:47 AM, Yonghong Song wrote:
> I cannot reproduce in my local fc28 system with the attached steps.
>
> The netlink_dumper.c file, could you confirm whether the following
> header files are missing form you rhel-7.2 host?
>
> #include <linux/rtnetlink.h>
> #include <linux/tc_act/tc_bpf.h>
>
> I suspect you probably miss linux/tc_act/tc_bpf.h. But could you confirm
> it? If this is the case, I can fix the problem by adding tc_bpf.h into
> tools/include/uapi directory.

we have installed <linux/tc_act/tc_bpf.h>, but it's a bit old

root@lkp-bdw-ep3 ~/linux-f6f3bac08f# diff /usr/include/linux/tc_act/tc_bpf.h ./include/uapi/linux/tc_act/tc_bpf.h -u
--- /usr/include/linux/tc_act/tc_bpf.h	2018-03-02 07:52:22.000000000 +0000
+++ ./include/uapi/linux/tc_act/tc_bpf.h	2018-09-07 05:34:08.000000000 +0000
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
  /*
   * Copyright (c) 2015 Jiri Pirko <jiri@resnulli.us>
   *
@@ -27,6 +28,8 @@
  	TCA_ACT_BPF_FD,
  	TCA_ACT_BPF_NAME,
  	TCA_ACT_BPF_PAD,
+	TCA_ACT_BPF_TAG,
+	TCA_ACT_BPF_ID,
  	__TCA_ACT_BPF_MAX,
  };
  #define TCA_ACT_BPF_MAX (__TCA_ACT_BPF_MAX - 1)

and beside linux/tc_act/tc_bpf.h, it also requires a newer linux/pkt_cls.h to avoid:
root@lkp-bdw-ep3 ~/linux-f6f3bac08f/tools/bpf/bpftool# make V=1
[...snip...]
gcc -O2 -W -Wall -Wextra -Wno-unused-parameter -Wshadow -Wno-missing-field-initializers -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ -I/root/linux-f6f3bac08f/kernel/bpf/ -I/root/linux-f6f3bac08f/tools/include -I/root/linux-f6f3bac08f/tools/include/uapi -I/root/linux-f6f3bac08f/tools/lib/bpf -I/root/linux-f6f3bac08f/tools/perf -DBPFTOOL_VERSION='"4.19.0-rc2"' -DCOMPAT_NEED_REALLOCARRAY   -c -MMD -o netlink_dumper.o netlink_dumper.c
make -C /root/linux-f6f3bac08f/tools/lib/bpf/ OUTPUT= libbpf.a
make[1]: Entering directory '/root/linux-f6f3bac08f/tools/lib/bpf'
netlink_dumper.c: In function 'do_bpf_filter_dump':
netlink_dumper.c:153:9: error: 'TCA_BPF_ID' undeclared (first use in this function)
   if (tb[TCA_BPF_ID])
          ^~~~~~~~~~
netlink_dumper.c:153:9: note: each undeclared identifier is reported only once for each function it appears in
netlink_dumper.c:155:9: error: 'TCA_BPF_TAG' undeclared (first use in this function)
   if (tb[TCA_BPF_TAG])
          ^~~~~~~~~~~
Makefile:96: recipe for target 'netlink_dumper.o' failed
make: *** [netlink_dumper.o] Error 1
make: *** Waiting for unfinished jobs....
make -f /root/linux-f6f3bac08f/tools/build/Makefile.build dir=. obj=libbpf
make[1]: Leaving directory '/root/linux-f6f3bac08f/tools/lib/bpf'


In this case, i'm not clear either i should upgrade system's linux header by myself or fix the tools on you side.


Thanks
Zhijian

  

>
> Thanks,
>
> Yonghong
>
>
> On 11/4/18 9:36 PM, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: f6f3bac08ff9855d803081a353a1fafaa8845739 ("tools/bpf: bpftool: add net support")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: bpf_offload
>> with following parameters:
>>
>> 	ucode: 0xb00002e
>>
>>
>>
>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>>
>>
>> KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7.2-f6f3bac08ff9855d803081a353a1fafaa8845739
>> 2018-11-03 10:11:02 cd /usr/src/linux-selftests-x86_64-rhel-7.2-f6f3bac08ff9855d803081a353a1fafaa8845739/tools/testing/selftests
>> 2018-11-03 10:11:02 ln -sf /usr/bin/clang-7 /usr/bin/clang
>> 2018-11-03 10:11:02 ln -sf /usr/bin/llc-7 /usr/bin/llc
>> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3bac08ff9855d803081a353a1fafaa8845739/tools/bpf'
>>
>> Auto-detecting system features:
>> ...                        libbfd: [ [31mOFF[m ]
>> ...        disassembler-four-args: [ [31mOFF[m ]
>>
>>     CC       bpf_jit_disasm.o
>>     LINK     bpf_jit_disasm
>>     CC       bpf_dbg.o
>>     LINK     bpf_dbg
>>     CC       bpf_asm.o
>>     BISON    bpf_exp.yacc.c
>>     CC       bpf_exp.yacc.o
>>     FLEX     bpf_exp.lex.c
>>     CC       bpf_exp.lex.o
>>     LINK     bpf_asm
>>     DESCEND  bpftool
>> make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3bac08ff9855d803081a353a1fafaa8845739/tools/bpf/bpftool'
>>
>> Auto-detecting system features:
>> ...                        libbfd: [ [31mOFF[m ]
>> ...        disassembler-four-args: [ [31mOFF[m ]
>>
>>     CC       map_perf_ring.o
>>     CC       xlated_dumper.o
>>     CC       perf.o
>>     CC       prog.o
>>     CC       btf_dumper.o
>>     CC       net.o
>>     CC       netlink_dumper.o
>> Makefile:96: recipe for target 'netlink_dumper.o' failed
>> make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3bac08ff9855d803081a353a1fafaa8845739/tools/bpf/bpftool'
>> Makefile:99: recipe for target 'bpftool' failed
>> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3bac08ff9855d803081a353a1fafaa8845739/tools/bpf'
>>
>>
>>
>> To reproduce:
>>
>>           git clone https://github.com/intel/lkp-tests.git
>>           cd lkp-tests
>>           bin/lkp install job.yaml  # job file is attached in this email
>>           bin/lkp run     job.yaml
>>
>>
>>
>> Thanks,
>> Rong Chen
>>
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
