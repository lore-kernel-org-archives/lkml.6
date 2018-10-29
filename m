Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7574E2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="bDNb5ZWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7574E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJ2XFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:05:42 -0400
Received: from mail.kdab.com ([176.9.126.58]:27684 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbeJ2XFl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:05:41 -0400
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1540822606; x=1541686607;
 bh=dXtYbeCJac6p1kSNnQVYPPJ7E6fBosnUyKfJD2tGn7Q=; b=bDNb5ZWBZFOS
 1reDDTiUN/qSYHyfZQ63UaybJbjxE4W/gYsooLVH3dTp4E4utUgqUJ58Yc3rcM0J
 0KrRAlFXGOjjqPEy4JUqLC4ZfDpkmKOJGeBRvKsKY8kKKbiIhDzoMdYG1BGKTs+F
 /m14oZCcvqHlv7lU3YHJMd+F9Xp1dxk=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf util: take pgoff into account when reporting elf to
 libdwfl
Date:   Mon, 29 Oct 2018 15:16:44 +0100
Message-Id: <20181029141644.3907-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Libdwfl parses an ELF file itself and creates mappings for the
individual sections. Perf on the other hand sees raw mmap events which
represent individual sections. When we encounter an address pointing
into a mapping with pgoff !=3D 0, we must take that into account and
report the file at the non-offset base address.

This fixes unwinding with libdwfl in some cases. E.g. for a file like:

```
#include <cmath>
#include <complex>
#include <future>
#include <iostream>
#include <mutex>
#include <random>
#include <thread>
#include <vector>

using namespace std;

mutex g_mutex;

double worker()
{
    lock_guard<mutex> guard(g_mutex);
    uniform_real_distribution<double> uniform(-1E5, 1E5);
    default_random_engine engine;
    double s =3D 0;
    for (int i =3D 0; i < 1000; ++i) {
        s +=3D norm(complex<double>(uniform(engine), uniform(engine)));
    }
    cout << s << endl;
    return s;
}

int main()
{
    vector<std::future<double>> results;
    for (int i =3D 0; i < 10000; ++i) {
        results.push_back(async(launch::async, worker));
    }
    return 0;
}
```

Compile it with `g++ -g -O2`, then record it with
`perf record --call-graph dwarf -e sched:sched_switch`.

When you analyze it with `perf script` and libunwind, you should see:

```
cpp-locking 20038 [005] 54830.236589: sched:sched_switch: prev_comm=3Dcpp=
-locking prev_pid=3D20038 prev_prio=3D120 prev_state=3DT =3D=3D> next_com=
m=3Dswapper/5 next_pid=3D0 next_prio=3D120
        ffffffffb166fec5 __sched_text_start+0x545 (/lib/modules/4.14.78-1=
-lts/build/vmlinux)
        ffffffffb166fec5 __sched_text_start+0x545 (/lib/modules/4.14.78-1=
-lts/build/vmlinux)
        ffffffffb1670208 schedule+0x28 (/lib/modules/4.14.78-1-lts/build/=
vmlinux)
        ffffffffb16737cc rwsem_down_read_failed+0xec (/lib/modules/4.14.7=
8-1-lts/build/vmlinux)
        ffffffffb1665e04 call_rwsem_down_read_failed+0x14 (/lib/modules/4=
.14.78-1-lts/build/vmlinux)
        ffffffffb1672a03 down_read+0x13 (/lib/modules/4.14.78-1-lts/build=
/vmlinux)
        ffffffffb106bd85 __do_page_fault+0x445 (/lib/modules/4.14.78-1-lt=
s/build/vmlinux)
        ffffffffb18015f5 page_fault+0x45 (/lib/modules/4.14.78-1-lts/buil=
d/vmlinux)
            7f38e4252591 new_heap+0x101 (/usr/lib/libc-2.28.so)
            7f38e4252d0b arena_get2.part.4+0x2fb (/usr/lib/libc-2.28.so)
            7f38e4255b1c tcache_init.part.6+0xec (/usr/lib/libc-2.28.so)
            7f38e42569e5 __GI___libc_malloc+0x115 (inlined)
            7f38e4241790 __GI__IO_file_doallocate+0x90 (inlined)
            7f38e424fbbf __GI__IO_doallocbuf+0x4f (inlined)
            7f38e424ee47 __GI__IO_file_overflow+0x197 (inlined)
            7f38e424df36 _IO_new_file_xsputn+0x116 (inlined)
            7f38e4242bfb __GI__IO_fwrite+0xdb (inlined)
            7f38e463fa6d std::basic_streambuf<char, std::char_traits<char=
> >::sputn(char const*, long)+0x1cd (inlined)
            7f38e463fa6d std::ostreambuf_iterator<char, std::char_traits<=
char> >::_M_put(char const*, long)+0x1cd (inlined)
            7f38e463fa6d std::ostreambuf_iterator<char, std::char_traits<=
char> > std::__write<char>(std::ostreambuf_iterator<char, std::char_trait=
s<char> >, char const*, int)+0x1cd (inlined)
            7f38e463fa6d std::ostreambuf_iterator<char, std::char_traits<=
char> > std::num_put<char, std::ostreambuf_iterator<char, std::char_trait=
s<char> > >::_M_insert_float<double>(std::ostreambuf_iterator<c>
            7f38e464bd70 std::num_put<char, std::ostreambuf_iterator<char=
, std::char_traits<char> > >::put(std::ostreambuf_iterator<char, std::cha=
r_traits<char> >, std::ios_base&, char, double) const+0x90 (inl>
            7f38e464bd70 std::ostream& std::ostream::_M_insert<double>(do=
uble)+0x90 (/usr/lib/libstdc++.so.6.0.25)
            563b9cb502f7 std::ostream::operator<<(double)+0xb7 (inlined)
            563b9cb502f7 worker()+0xb7 (/ssd/milian/projects/kdab/rnd/hot=
spot/build/tests/test-clients/cpp-locking/cpp-locking)
            563b9cb506fb double std::__invoke_impl<double, double (*)()>(=
std::__invoke_other, double (*&&)())+0x2b (inlined)
            563b9cb506fb std::__invoke_result<double (*)()>::type std::__=
invoke<double (*)()>(double (*&&)())+0x2b (inlined)
            563b9cb506fb decltype (__invoke((_S_declval<0ul>)())) std::th=
read::_Invoker<std::tuple<double (*)()> >::_M_invoke<0ul>(std::_Index_tup=
le<0ul>)+0x2b (inlined)
            563b9cb506fb std::thread::_Invoker<std::tuple<double (*)()> >=
::operator()()+0x2b (inlined)
            563b9cb506fb std::__future_base::_Task_setter<std::unique_ptr=
<std::__future_base::_Result<double>, std::__future_base::_Result_base::_=
Deleter>, std::thread::_Invoker<std::tuple<double (*)()> >, dou>
            563b9cb506fb std::_Function_handler<std::unique_ptr<std::__fu=
ture_base::_Result_base, std::__future_base::_Result_base::_Deleter> (), =
std::__future_base::_Task_setter<std::unique_ptr<std::__future_>
            563b9cb507e8 std::function<std::unique_ptr<std::__future_base=
::_Result_base, std::__future_base::_Result_base::_Deleter> ()>::operator=
()() const+0x28 (inlined)
            563b9cb507e8 std::__future_base::_State_baseV2::_M_do_set(std=
::function<std::unique_ptr<std::__future_base::_Result_base, std::__futur=
e_base::_Result_base::_Deleter> ()>*, bool*)+0x28 (/ssd/milian/>
            7f38e46d24fe __pthread_once_slow+0xbe (/usr/lib/libpthread-2.=
28.so)
            563b9cb51149 __gthread_once+0xe9 (inlined)
            563b9cb51149 void std::call_once<void (std::__future_base::_S=
tate_baseV2::*)(std::function<std::unique_ptr<std::__future_base::_Result=
_base, std::__future_base::_Result_base::_Deleter> ()>*, bool*)>
            563b9cb51149 std::__future_base::_State_baseV2::_M_set_result=
(std::function<std::unique_ptr<std::__future_base::_Result_base, std::__f=
uture_base::_Result_base::_Deleter> ()>, bool)+0xe9 (inlined)
            563b9cb51149 std::__future_base::_Async_state_impl<std::threa=
d::_Invoker<std::tuple<double (*)()> >, double>::_Async_state_impl(std::t=
hread::_Invoker<std::tuple<double (*)()> >&&)::{lambda()#1}::op>
            563b9cb51149 void std::__invoke_impl<void, std::__future_base=
::_Async_state_impl<std::thread::_Invoker<std::tuple<double (*)()> >, dou=
ble>::_Async_state_impl(std::thread::_Invoker<std::tuple<double>
            563b9cb51149 std::__invoke_result<std::__future_base::_Async_=
state_impl<std::thread::_Invoker<std::tuple<double (*)()> >, double>::_As=
ync_state_impl(std::thread::_Invoker<std::tuple<double (*)()> >>
            563b9cb51149 decltype (__invoke((_S_declval<0ul>)())) std::th=
read::_Invoker<std::tuple<std::__future_base::_Async_state_impl<std::thre=
ad::_Invoker<std::tuple<double (*)()> >, double>::_Async_state_>
            563b9cb51149 std::thread::_Invoker<std::tuple<std::__future_b=
ase::_Async_state_impl<std::thread::_Invoker<std::tuple<double (*)()> >, =
double>::_Async_state_impl(std::thread::_Invoker<std::tuple<dou>
            563b9cb51149 std::thread::_State_impl<std::thread::_Invoker<s=
td::tuple<std::__future_base::_Async_state_impl<std::thread::_Invoker<std=
::tuple<double (*)()> >, double>::_Async_state_impl(std::thread>
            7f38e45f0062 execute_native_thread_routine+0x12 (/usr/lib/lib=
stdc++.so.6.0.25)
            7f38e46caa9c start_thread+0xfc (/usr/lib/libpthread-2.28.so)
            7f38e42ccb22 __GI___clone+0x42 (inlined)
```

Before this patch, using libdwfl, you would see:

```
cpp-locking 20038 [005] 54830.236589: sched:sched_switch: prev_comm=3Dcpp=
-locking prev_pid=3D20038 prev_prio=3D120 prev_state=3DT =3D=3D> next_com=
m=3Dswapper/5 next_pid=3D0 next_prio=3D120
        ffffffffb166fec5 __sched_text_start+0x545 (/lib/modules/4.14.78-1=
-lts/build/vmlinux)
        ffffffffb166fec5 __sched_text_start+0x545 (/lib/modules/4.14.78-1=
-lts/build/vmlinux)
        ffffffffb1670208 schedule+0x28 (/lib/modules/4.14.78-1-lts/build/=
vmlinux)
        ffffffffb16737cc rwsem_down_read_failed+0xec (/lib/modules/4.14.7=
8-1-lts/build/vmlinux)
        ffffffffb1665e04 call_rwsem_down_read_failed+0x14 (/lib/modules/4=
.14.78-1-lts/build/vmlinux)
        ffffffffb1672a03 down_read+0x13 (/lib/modules/4.14.78-1-lts/build=
/vmlinux)
        ffffffffb106bd85 __do_page_fault+0x445 (/lib/modules/4.14.78-1-lt=
s/build/vmlinux)
        ffffffffb18015f5 page_fault+0x45 (/lib/modules/4.14.78-1-lts/buil=
d/vmlinux)
            7f38e4252591 new_heap+0x101 (/usr/lib/libc-2.28.so)
        a041161e77950c5c [unknown] ([unknown])
```

With this patch applied, we get a bit further in unwinding:

```
cpp-locking 20038 [005] 54830.236589: sched:sched_switch: prev_comm=3Dcpp=
-locking prev_pid=3D20038 prev_prio=3D120 prev_state=3DT =3D=3D> next_com=
m=3Dswapper/5 next_pid=3D0 next_prio=3D120
        ffffffffb166fec5 __sched_text_start+0x545 (/lib/modules/4.14.78-1=
-lts/build/vmlinux)
        ffffffffb166fec5 __sched_text_start+0x545 (/lib/modules/4.14.78-1=
-lts/build/vmlinux)
        ffffffffb1670208 schedule+0x28 (/lib/modules/4.14.78-1-lts/build/=
vmlinux)
        ffffffffb16737cc rwsem_down_read_failed+0xec (/lib/modules/4.14.7=
8-1-lts/build/vmlinux)
        ffffffffb1665e04 call_rwsem_down_read_failed+0x14 (/lib/modules/4=
.14.78-1-lts/build/vmlinux)
        ffffffffb1672a03 down_read+0x13 (/lib/modules/4.14.78-1-lts/build=
/vmlinux)
        ffffffffb106bd85 __do_page_fault+0x445 (/lib/modules/4.14.78-1-lt=
s/build/vmlinux)
        ffffffffb18015f5 page_fault+0x45 (/lib/modules/4.14.78-1-lts/buil=
d/vmlinux)
            7f38e4252591 new_heap+0x101 (/usr/lib/libc-2.28.so)
            7f38e4252d0b arena_get2.part.4+0x2fb (/usr/lib/libc-2.28.so)
            7f38e4255b1c tcache_init.part.6+0xec (/usr/lib/libc-2.28.so)
            7f38e42569e5 __GI___libc_malloc+0x115 (inlined)
            7f38e4241790 __GI__IO_file_doallocate+0x90 (inlined)
            7f38e424fbbf __GI__IO_doallocbuf+0x4f (inlined)
            7f38e424ee47 __GI__IO_file_overflow+0x197 (inlined)
            7f38e424df36 _IO_new_file_xsputn+0x116 (inlined)
            7f38e4242bfb __GI__IO_fwrite+0xdb (inlined)
            7f38e463fa6d std::basic_streambuf<char, std::char_traits<char=
> >::sputn(char const*, long)+0x1cd (inlined)
            7f38e463fa6d std::ostreambuf_iterator<char, std::char_traits<=
char> >::_M_put(char const*, long)+0x1cd (inlined)
            7f38e463fa6d std::ostreambuf_iterator<char, std::char_traits<=
char> > std::__write<char>(std::ostreambuf_iterator<char, std::char_trait=
s<char> >, char const*, int)+0x1cd (inlined)
            7f38e463fa6d std::ostreambuf_iterator<char, std::char_traits<=
char> > std::num_put<char, std::ostreambuf_iterator<char, std::char_trait=
s<char> > >::_M_insert_float<double>(std::ostreambuf_iterator<c>
            7f38e464bd70 std::num_put<char, std::ostreambuf_iterator<char=
, std::char_traits<char> > >::put(std::ostreambuf_iterator<char, std::cha=
r_traits<char> >, std::ios_base&, char, double) const+0x90 (inl>
            7f38e464bd70 std::ostream& std::ostream::_M_insert<double>(do=
uble)+0x90 (/usr/lib/libstdc++.so.6.0.25)
            563b9cb502f7 std::ostream::operator<<(double)+0xb7 (inlined)
            563b9cb502f7 worker()+0xb7 (/ssd/milian/projects/kdab/rnd/hot=
spot/build/tests/test-clients/cpp-locking/cpp-locking)
        6eab825c1ee3e4ff [unknown] ([unknown])
```

Note that the backtrace is still stopping too early, when
compared to the nice results obtained via libunwind. It's
unclear so far what the reason for that is.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/unwind-libdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
index 6f318b15950e..5eff9bfc5758 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -45,13 +45,13 @@ static int __report_module(struct addr_location *al, =
u64 ip,
 		Dwarf_Addr s;
=20
 		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
-		if (s !=3D al->map->start)
+		if (s !=3D al->map->start - al->map->pgoff)
 			mod =3D 0;
 	}
=20
 	if (!mod)
 		mod =3D dwfl_report_elf(ui->dwfl, dso->short_name,
-				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name)=
, -1, al->map->start,
+				      (dso->symsrc_filename ? dso->symsrc_filename : dso->long_name)=
, -1, al->map->start - al->map->pgoff,
 				      false);
=20
 	return mod && dwfl_addrmodule(ui->dwfl, ip) =3D=3D mod ? 0 : -1;
--=20
2.19.1
