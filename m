Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E659C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DC520844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBj8NttZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DC520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbeGZOc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbeGZOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:32:28 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688FB20673;
        Thu, 26 Jul 2018 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532610937;
        bh=Mvk48vpcVrvowrQezyyAmrFl5noJtRVsXLG9eGPSO3c=;
        h=Date:From:To:Cc:Subject:From;
        b=BBj8NttZejV7/FPHD2C1Nlak+Kp6FHdCdkBOOzSywbt09mBvKv7AtKrAehbeCa9oh
         Uxu+VZvjSHlyfByUpxddujwGUHeyPkxmOB4JkLNRmP5Qpvgwozu7uK5618q5unzXS6
         7mPLzaT41FVZsKpBKxWJWj3WmdRt0RTtSt/5FTCU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 036AF1403B8; Thu, 26 Jul 2018 10:15:34 -0300 (-03)
Date:   Thu, 26 Jul 2018 10:15:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ingo Molnar <mingo@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Clark Williams <williams@redhat.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org
Subject: BPF relocation 'perf test' entries failing was: Re: [GIT PULL 00/27]
 perf/core improvements and fixes
Message-ID: <20180726131534.GD17940@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 25, 2018 at 02:59:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Ingo,
> 
> 	Please consider pulling, I'm now investigating why these failed:
> 
>   38: LLVM search and compile                               :
>   38.1: Basic BPF llvm compile                              : Ok
>   38.2: kbuild searching                                    : Ok
>   38.3: Compile source for BPF prologue generation          : Ok
>   38.4: Compile source for BPF relocation                   : FAILED!
>   40: BPF filter                                            :
>   40.1: Basic BPF filtering                                 : Ok
>   40.2: BPF pinning                                         : Ok
>   40.3: BPF prologue generation                             : Ok
>   40.4: BPF relocation checker                              : FAILED!
> 
> 	I think these failures are not related to changes in this patch
> kit. Details about the test environment, versions, etc.

So, here are more details:

The relevant bit seems to be:

libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522

So this seems to be something that was caught by the kernel verifier and
now is being caught by libbpf, /me goes to read the tools/lib/bpf
changelog...

- Arnaldo

BPF filter subtest 2: Ok
40.3: BPF prologue generation                             :
--- start ---
test child forked, pid 13336
Kernel build dir is set to /lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
set env: KBUILD_DIR=/lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
unset env: KBUILD_OPTS
include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
set env: NR_CPUS=4
set env: LINUX_VERSION_CODE=0x41200
set env: CLANG_EXEC=/usr/lib64/ccache/clang
set env: CLANG_OPTIONS=-xc 
set env: KERNEL_INC_OPTIONS= -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
set env: PERF_BPF_INC_OPTIONS=-I/home/acme/lib/include/perf/bpf
set env: WORKING_DIR=/lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
set env: CLANG_SOURCE=-
llvm compiling command template: echo '/*
 * bpf-script-test-relocation.c
 * Test BPF loader checking relocation
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC("maps") my_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

int this_is_a_global_val;

SEC("func=sys_write")
int bpf_func__sys_write(void *ctx)
{
	int key = 0;
	int value = 0;

	/*
	 * Incorrect relocation. Should not allow this program be
	 * loaded into kernel.
	 */
	bpf_map_update_elem(&this_is_a_global_val, &key, &value, 0);
	return 0;
}
char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf -O2 -o -
llvm compiling command : echo '/*
 * bpf-script-test-relocation.c
 * Test BPF loader checking relocation
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt=-DLINUX_VERSION_CODE=0x40200 into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC(maps) my_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

int this_is_a_global_val;

SEC(func=sys_write)
int bpf_func__sys_write(void *ctx)
{
	int key = 0;
	int value = 0;

	/*
	 * Incorrect relocation. Should not allow this program be
	 * loaded into kernel.
	 */
	bpf_map_update_elem(&this_is_a_global_val, &key, &value, 0);
	return 0;
}
char _license[] SEC(license) = GPL;
int _version SEC(version) = LINUX_VERSION_CODE;
' | /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=4 -DLINUX_VERSION_CODE=0x41200 -xc   -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h  -I/home/acme/lib/include/perf/bpf -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build -c - -target bpf -O2 -o -
libbpf: loading object '[bpf_relocation_test]' from buffer
libbpf: section(1) .strtab, size 115, link 0, flags 0, type=3
libbpf: skip section(1) .strtab
libbpf: section(2) .text, size 0, link 0, flags 6, type=1
libbpf: skip section(2) .text
libbpf: section(3) func=sys_write, size 104, link 0, flags 6, type=1
libbpf: found program func=sys_write
libbpf: section(4) .relfunc=sys_write, size 16, link 8, flags 0, type=9
libbpf: section(5) maps, size 16, link 0, flags 3, type=1
libbpf: section(6) license, size 4, link 0, flags 3, type=1
libbpf: license of [bpf_relocation_test] is GPL
libbpf: section(7) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of [bpf_relocation_test] is 41200
libbpf: section(8) .symtab, size 144, link 1, flags 0, type=2
libbpf: maps in [bpf_relocation_test]: 1 maps in 16 bytes
libbpf: map 0 is "my_table"
libbpf: collecting relocating info for: 'func=sys_write'
libbpf: relo for 5 value 4 name 21
libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522
bpf: failed to load buffer
Compile BPF program failed.
test child finished with 0
---- end ----
BPF filter subtest 3: Ok
40.4: BPF relocation checker                              :
--- start ---
test child forked, pid 13746
test child finished with -1
---- end ----
BPF filter subtest 4: FAILED!
[root@seventh ~]#
