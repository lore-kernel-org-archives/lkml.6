Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965501AbeBMSXj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:23:39 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46440 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965388AbeBMSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:23:37 -0500
X-Google-Smtp-Source: AH8x2247m0J8HSW3R6o9MvkdJG+M6Ok1Epr/YZLrimvirjvzFuegDzoh9bSrkDQQZhDAYhYcycIl94q+CpCxuvWW2GQ=
MIME-Version: 1.0
In-Reply-To: <CALyZvKyQFp0CfwFfBosM=OK5DJgb71bhMAkhLU2Wdv0asTSVZw@mail.gmail.com>
References: <CALyZvKyQFp0CfwFfBosM=OK5DJgb71bhMAkhLU2Wdv0asTSVZw@mail.gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Tue, 13 Feb 2018 18:23:35 +0000
Message-ID: <CALyZvKy7HVvjhJ5VTKKicvkq98GbJhGfCiMXOHNYseiOGu1T=A@mail.gmail.com>
Subject: Re: perf Intel x86_64 : BUG: BRANCH_INSTRUCTIONS / BRANCH_MISSES
 cannot be combined with CACHE_REFERENCES / CACHE_MISSES .
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="f4030435b440d0823705651c1703"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f4030435b440d0823705651c1703
Content-Type: text/plain; charset="UTF-8"

On 13/02/2018, Jason Vas Dias <jason.vas.dias@gmail.com> wrote:
> Good day -
>
> I'd much appreciate some advice as to why, on my Intel x86_64
> ( DisplayFamily_DisplayModel : 06_3CH ), running either Linux 4.12.10,
> or Linux 3.10.0, any attempt to count all of :
>      PERF_COUNT_HW_BRANCH_INSTRUCTIONS
>           (or raw config 0xC4) , and
>      PERF_COUNT_HW_BRANCH_MISSES
>           (or raw config 0xC5), and
>      combined with
>      PERF_COUNT_HW_CACHE_REFERENCES
>          (or raw config 0x4F2E ), and
>      PERF_COUNT_HW_CACHE_MISSES
>          (or raw config 0x412E) ,
> results in ALL COUNTERS BEING 0 in a read of the Group FD or
> mmap sample area.
>
> This is demonstrated by the example program, which will
> use perf_event_open() to create a Group Leader FD  for the first event,
> and associate all other events with that Event Group , so that it
> will read all events on the group FD .
>
> The perf_event_open() calls and the ioctl(event_fd, PERF_EVENT_IOC_ID, &id)
> calls all return successfully , but if I combine ANY of
> ( PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
>   PERF_COUNT_HW_BRANCH_MISSES
> ) with any of
> ( PERF_COUNT_HW_CACHE_REFERENCES,
>   PERF_COUNT_HW_CACHE_MISSES
> ) in the Event Group, ALL events have '0' event->value.
>
> Demo :
> 1. Compile program to use kernel mapped Generic Events:
>   $ gcc -std=gnu11 -o perf_bug perf_bug.c
>   Running program shows all counters have 0 values, since both
>   CACHE & BRANCH hits+misses are being requested:
>
>   $ ./perf_bug
>   EVENT: Branch Instructions : 0
>   EVENT: Branch Misses : 0
>   EVENT: Instructions : 0
>   EVENT: CPU Cycles : 0
>   EVENT: Ref. CPU Cycles : 0
>   EVENT: Bus Cycles : 0
>   EVENT: Cache References : 0
>   EVENT: Cache Misses : 0
>
>   NOT registering interest in EITHER the BRANCH counters
>   OR the CACHE counters fixes the problem:
>
>   Compile without registering for BRANCH_INSTRUCTIONS
>   or BRANCH_MISSES:
>   $ gcc -std=gnu11 -DNO_BUG_NO_BRANCH  -o perf_bug perf_bug.c
>   $ ./perf_bug
>   EVENT: Instructions : 914
>   EVENT: CPU Cycles : 4110
>   EVENT: Ref. CPU Cycles : 4437
>   EVENT: Bus Cycles : 152
>   EVENT: Cache References : 1
>   EVENT: Cache Misses : 1
>
>   Compile without registering for CACHE_REFERENCES or CACHE_MISSES:
>   $ gcc -std=gnu11 -DNO_BUG_NO_CACHE  -o perf_bug perf_bug.c
>   $ ./perf_bug
> EVENT: Branch Instructions : 106
> EVENT: Branch Misses : 6
> EVENT: Instructions : 914
> EVENT: CPU Cycles : 4132
> EVENT: Ref. CPU Cycles : 8526
> EVENT: Bus Cycles : 295
>
> The same thing happens if I do not use Generic Events, but rather
> "dynamic raw PMU" events, by putting the hex values from
> /sys/bus/event_source/devices/cpu/events/? into the perf_event_attr
> config, OR'ed with (1<<63), and using the PERF_TYPE_RAW perf_event_attr
> type value :
>
> $ gcc -DUSE_RAW_PMU -o perf_bug perf_bug.c
> $ ./perf_bug
> EVENT: Branch Instructions : 0
> EVENT: Branch Misses : 0
> EVENT: Instructions : 0
> EVENT: CPU Cycles : 0
> EVENT: Ref. CPU Cycles : 0
> EVENT: Bus Cycles : 0
> EVENT: Cache References : 0
> EVENT: Cache Misses : 0
>
>
> $ gcc -DUSE_RAW_PMU -DNO_BUG_NO_BRANCH -o perf_bug perf_bug.c
> $ ./perf_bug
> EVENT: Instructions : 914
> EVENT: CPU Cycles : 4102
> EVENT: Ref. CPU Cycles : 4959
> EVENT: Bus Cycles : 171
> EVENT: Cache References : 2
> EVENT: Cache Misses : 2
>
> $ gcc -DUSE_RAW_PMU -DNO_BUG_NO_CACHE -o perf_bug perf_bug.c
> $ ./perf_bug
> EVENT: Branch Instructions : 106
> EVENT: Branch Misses : 6
> EVENT: Instructions : 914
> EVENT: CPU Cycles : 4108
> EVENT: Ref. CPU Cycles : 10817
> EVENT: Bus Cycles : 373
>
>
> The perf tool itself seems to have the same issue:
>
> With CACHE & BRANCH counters does not work :
> $ perf stat -e '{r0c4,r0c5,r0c0,r03c,r0300,r013c,r04F2E,r0412E}:SIu' sleep
> 1
>
>  Performance counter stats for 'sleep 1':
>
>      <not counted>      r0c4
>                (0.00%)
>      <not counted>      r0c5
>                (0.00%)
>      <not counted>      r0c0
>                (0.00%)
>      <not counted>      r03c
>                (0.00%)
>      <not counted>      r0300
>                (0.00%)
>      <not counted>      r013c
>                (0.00%)
>      <not counted>      r04F2E
>                (0.00%)
>    <not supported>     r0412E
>
>        1.001652932 seconds time elapsed
>
>    Some events weren't counted. Try disabling the NMI watchdog:
> 	echo 0 > /proc/sys/kernel/nmi_watchdog
> 	perf stat ...
> 	echo 1 > /proc/sys/kernel/nmi_watchdog
>
> Disabling the NMI watchdog makes no difference .
>
> It is very strange that perf thinks 'r0412E' is not supported :
>    $ cat /sys/bus/event_source/devices/cpu/cache_misses
>    event=0x2e,umask=0x41
>
> The kernel should not be advertizing an unsupported event
> in a  /sys/bus/event_source/devices/cpu/events/ file, should it ?
>
> So perf stat has the same problem - without either Cache or Branch
> counters seems to work fine:
>
> without cache:
> $ perf stat -e '{r0c4,r0c5,r0c0,r03c,r0300,r013c}:SIu' sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>              37740      r0c4
>               3557      r0c5
>             188552      r0c0
>             311684      r03c
>             360963      r0300
>              12461      r013c
>
>        1.001508109 seconds time elapsed
>
> without branch:
> $ perf stat -e '{r0c0,r03c,r0300,r013c,r04F2E,r0412E}:SIu' sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>             188554      r0c0
>             320242      r03c
>             452748      r0300
>              15633      r013c
>               4145      r04F2E
>               3022      r0412E
>
>        1.001810421 seconds time elapsed
>
> proving again that perf's claim that 'r0412E' is not supported is bogus.
> The Intel SDM's table 19-1 Architectural events, which ALL Intel CPUs
> are meant to support, does include  'Event: 2EH | Umask: 4FH : LLC
> Reference '  and  'Event: 2EH | Umask: 41H : LLC Miss' , as well as :
> 'Event : C4H | Umask: 00H : Branch Instructions Retired' and
> 'Event : C5H | Umask: 00H : Branch Misses Retired' .
> So why can't perf count them all in the same group?
>
> Please , can anyone enlighten me as to what is going on here ?
>
> Why can't I count all of
>    ( BRANCH_INSTRUCTIONS , BRANCH_MISSES ,
>      CACHE_REFERENCES, CACHE_MISSES
>   )
> in the same Perf Event Group ?
>
> Thanks in advance for any replies,
> Best Regards,
> Jason
>

Actually, it appears that ONLY the combination of
'BRANCH_MISSES' and 'CACHE_MISSES' makes
all sampled counter values 0 ; if either counter is
not requested, all other counters have non-zero values.
 I've updated the program to reflect this .

And nmi_watchdog=1 DOES make a difference  :
if  nmi_watchdog is > 0 , then ANY combination
of {BRANCH,CACHE}_{REFS,MISSES} makes ALL
sampled counter values be 0, but if nmi_watchdog is 0,
then only the combination of BRANCH_MISSES and
CACHE_MISSES makes all sampled values be 0 .

This is a really nasty bug and makes the Linux PERF facility
rather unusable ; because of this bug, Linux PERF provides
no way of measuring cache and branch prediction performance
at the same time for the same instruction sequence.

Can anyone suggest a valid reason for this ?
Or any workarounds ?

If no-one suggests a workaround or valid reason
I guess I should raise this as a serious bug .

Thanks & Regards,
Jason

--f4030435b440d0823705651c1703
Content-Type: text/x-csrc; charset="US-ASCII"; name="perf_bug.c"
Content-Disposition: attachment; filename="perf_bug.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

LyogRGVtb25zdHJhdGlvbiBvZiBMaW51eCBQRVJGIGJ1ZzoKICogIExpbnV4IGlzIHVuYWJsZSB0
byBjb3VudCBCUkFOQ0hfSU5TVFJVQ1RJT05TIG9yIEJSQU5DSF9NSVNTRVMgCiAqICBhdCB0aGUg
c2FtZSB0aW1lIGFzIENBQ0hFX1JFRkVSRU5DRVMgb3IgQ0FDSEVfTUlTU0VTLgogKi8KCiNpbmNs
dWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkYm9vbC5o
PgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5jbHVkZSA8
c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNs
dWRlIDxzdGRpby5oPgojaW5jbHVkZSA8bGludXgvcGVyZl9ldmVudC5oPgoKc3RhdGljIGludApw
ZXJmX2V2ZW50X29wZW4KKCBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyICpod19ldmVudCwgcGlkX3Qg
cGlkLCBpbnQgY3B1LCBpbnQgZ3JvdXBfZmQsIHVuc2lnbmVkIGxvbmcgZmxhZ3MgKQp7IGludCBy
ZXQ7ICAKICByZXQgPSAoaW50KSBzeXNjYWxsKF9fTlJfcGVyZl9ldmVudF9vcGVuLCBod19ldmVu
dCwgcGlkLCBjcHUsIGdyb3VwX2ZkLCBmbGFncyk7CiAgcmV0dXJuIHJldDsKfQoKaW50IG1haW4o
IGludCBhcmdjLCBjb25zdCBjaGFyICpjb25zdCogYXJndikKeyBzdHJ1Y3QgcGVyZl9ldmVudF9h
dHRyIHBlYSA9IHswfTsKICBzdHJ1Y3QgZXZjZmcKICB7IHVpbnQ2NF90IHBlcmZfdHlwZTsKICAg
IHVpbnQ2NF90IHBlcmZfY2ZnOwogICAgY29uc3QgY2hhciAqbmFtZTsKICAgIGludCBmZDsKICAg
IHVpbnQ2NF90IGlkOwogIH0gcGUgW10gPSB7CiNpZm5kZWYgVVNFX1JBV19QTVUKICAvLyBzbyB3
ZSBjYW4gdGVzdCB1c2luZyBHZW5lcmljIEtlcm5lbCBFdmVudCBtYXBwaW5nOgojaWZuZGVmIE5P
X0JVR19OT19CUkFOQ0gKI2lmbmRlZiBOT19CVUdfTk9fQlJBTkNIX0lOU1QgICAgCiAgICB7IFBF
UkZfVFlQRV9IQVJEV0FSRSAKICAgICwgUEVSRl9DT1VOVF9IV19CUkFOQ0hfSU5TVFJVQ1RJT05T
CiAgICAsICJCcmFuY2ggSW5zdHJ1Y3Rpb25zIgogICAgLCAtMSwgMAogICAgfQojZW5kaWYKI2lm
bmRlZiBOT19CVUdfTk9fQlJBTkNIX01JU1MgICAgCiAgLCB7IFBFUkZfVFlQRV9IQVJEV0FSRSAK
ICAgICwgUEVSRl9DT1VOVF9IV19CUkFOQ0hfTUlTU0VTCiAgICAsICJCcmFuY2ggTWlzc2VzIgog
ICAgLCAtMSwgMAogICAgfQojZW5kaWYgICAgCiAgLAojZW5kaWYgICAgCiAgICB7IFBFUkZfVFlQ
RV9IQVJEV0FSRSAKICAgICwgUEVSRl9DT1VOVF9IV19JTlNUUlVDVElPTlMKICAgICwgIkluc3Ry
dWN0aW9ucyIKICAgICwgLTEsIDAKICAgIH0gICAgCiAgLCB7IFBFUkZfVFlQRV9IQVJEV0FSRSAK
ICAgICwgUEVSRl9DT1VOVF9IV19DUFVfQ1lDTEVTCiAgICAsICJDUFUgQ3ljbGVzIgogICAgLCAt
MSwgMAogICAgfQogICwgeyBQRVJGX1RZUEVfSEFSRFdBUkUgCiAgICAsIFBFUkZfQ09VTlRfSFdf
UkVGX0NQVV9DWUNMRVMKICAgICwgIlJlZi4gQ1BVIEN5Y2xlcyIKICAgICwgLTEsIDAKICAgIH0g
CiAgLCB7IFBFUkZfVFlQRV9IQVJEV0FSRSAKICAgICwgUEVSRl9DT1VOVF9IV19CVVNfQ1lDTEVT
CiAgICAsICJCdXMgQ3ljbGVzIiAgICAgIAogICAgLCAtMSwgMCAgICAgIAogICAgfQojaWZuZGVm
IE5PX0JVR19OT19DQUNIRQojaWZuZGVmIE5PX0JVR19OT19DQUNIRV9SRUYgICAgCiAgLCB7IFBF
UkZfVFlQRV9IQVJEV0FSRSAKICAgICwgUEVSRl9DT1VOVF9IV19DQUNIRV9SRUZFUkVOQ0VTCiAg
ICAsICJDYWNoZSBSZWZlcmVuY2VzIiAgICAgICAgICAgIAogICAgLCAtMSwgMAogICAgfQojZW5k
aWYgICAgCiNpZm5kZWYgTk9fQlVHX05PX0NBQ0hFX01JU1MKICAsIHsgUEVSRl9UWVBFX0hBUkRX
QVJFIAogICAgLCBQRVJGX0NPVU5UX0hXX0NBQ0hFX01JU1NFUwogICAgLCAiQ2FjaGUgTWlzc2Vz
IiAgICAgICAgICAgICAgICAgIAogICAgLCAtMSwgMCAgICAgIAogICAgfQojZW5kaWYgICAKI2Vu
ZGlmICAgIAojZWxzZQogIC8vIG9yIHRlc3QgdXNpbmcgcmF3IFBNVSBjb2RlcyAtIHRoZXNlIGNv
bWUgZnJvbSB0aGUgSW50ZWwgU0RNLCBDaGFwdGVyIDE5LCBUYWJsZSAxOS0xLAogIC8vIGFuZCBJ
J3ZlIGNoZWNrZWQgdGhleSBhcmUgaWRlbnRpY2FsIHRvIHRoZSB2YWx1ZXMgaW4KICAvLyAvc3lz
L2J1cy9ldmVudF9zb3VyY2UvZGV2aWNlcy9jcHUvZXZlbnRzL3sKI2lmbmRlZiBOT19CVUdfTk9f
QlJBTkNICiNpZm5kZWYgTk9fQlVHX05PX0JSQU5DSF9JTlNUICAgICAgICAKICAgIHsgUEVSRl9U
WVBFX1JBVyAKICAgICwgKDFVTDw8NjNVKSB8IDB4QzQgICAvLyBicmFuY2hfaW5zdHJ1Y3Rpb25z
CiAgICAsICJCcmFuY2ggSW5zdHJ1Y3Rpb25zIgogICAgLCAtMSwgMCAgICAgIAogICAgfQojZW5k
aWYKI2lmbmRlZiBOT19CVUdfTk9fQlJBTkNIX01JU1MgICAgICAgCiAgLCB7IFBFUkZfVFlQRV9S
QVcgCiAgICAsICgxVUw8PDYzVSkgfCAweEM1ICAgLy8gYnJhbmNoX21pc3NlcwogICAgLCAiQnJh
bmNoIE1pc3NlcyIgICAgICAKICAgICwgLTEsIDAgICAgICAKICAgIH0KI2VuZGlmCiAgLAojZW5k
aWYKICAgIHsgUEVSRl9UWVBFX1JBVyAKICAgICwgKDFVTDw8NjNVKSB8IDB4QzAgICAvLyBpbnN0
cnVjdGlvbnMKICAgICwgIkluc3RydWN0aW9ucyIKICAgICwgLTEsIDAgICAgICAKICAgIH0gICAg
CiAgLCB7IFBFUkZfVFlQRV9SQVcgCiAgICAsICgxVUw8PDYzVSkgfCAweDNDICAgLy8gY3B1IGN5
Y2xlcwogICAgLCAiQ1BVIEN5Y2xlcyIgICAgICAKICAgICwgLTEsIDAgICAgICAKICAgIH0KICAs
IHsgUEVSRl9UWVBFX1JBVyAKICAgICwgKDFVTDw8NjNVKSB8IDB4MDMwMCAgLy8gcmVmIGNwdSBj
eWNsZXMKICAgICwgIlJlZi4gQ1BVIEN5Y2xlcyIgICAgICAgICAgICAKICAgICwgLTEsIDAgICAg
ICAgICAgIAogICAgfQogICwgeyBQRVJGX1RZUEVfUkFXIAogICAgLCAoMVVMPDw2M1UpIHwgMHgw
MTNDICAvLyBidXMgY3ljbGVzCiAgICAsICJCdXMgQ3ljbGVzIiAgICAgICAgICAgIAogICAgLCAt
MSwgMCAgICAgIAogICAgfQojaWZuZGVmIE5PX0JVR19OT19DQUNIRQojaWZuZGVmIE5PX0JVR19O
T19DQUNIRV9SRUYgICAgICAgIAogICwgeyBQRVJGX1RZUEVfUkFXIAogICAgLCAoMVVMPDw2M1Up
IHwgMHgwNEYyRSAgLy8gY2FjaGUgcmVmZXJlbmNlcwogICAgLCAiQ2FjaGUgUmVmZXJlbmNlcyIg
CiAgICAsIC0xLCAwICAgICAgICAgICAKICAgIH0KI2VuZGlmCiNpZm5kZWYgTk9fQlVHX05PX0NB
Q0hFX01JU1MgICAgICAgICAgICAKICAsIHsgUEVSRl9UWVBFX1JBVyAKICAgICwgKDFVTDw8NjNV
KSB8IDB4MDQxMkUgIC8vIGNhY2hlIG1pc3NlcwogICAgLCAiQ2FjaGUgTWlzc2VzIiAgICAgICAK
ICAgICwgLTEsIDAgICAgICAKICAgIH0KI2VuZGlmICAgIAojZW5kaWYKI2VuZGlmCiAgfTsKI2Rl
ZmluZSBOX0VWIChzaXplb2YocGUpL3NpemVvZihzdHJ1Y3QgZXZjZmcpKQogIGludCBmZD0tMTsK
ICBpbnQgbl9ldj0wOwogIHBpZF90IHBpZD1nZXRwaWQoKTsKICBmb3IoOyBuX2V2IDwgTl9FVjsg
bl9ldiArPSAxKQogIHsgbWVtc2V0KCZwZWEsICdcMCcsIHNpemVvZihwZWEpKTsKICAgIHBlYS5z
aXplICAgPSBQRVJGX0FUVFJfU0laRV9WRVI1OwogICAgcGVhLnR5cGUgICA9IHBlW25fZXZdLnBl
cmZfdHlwZTsKICAgIHBlYS5jb25maWcgPSBwZVtuX2V2XS5wZXJmX2NmZzsKICAgIHBlYS5yZWFk
X2Zvcm1hdCA9IFBFUkZfRk9STUFUX0dST1VQICB8IFBFUkZfRk9STUFUX0lEIHwKICAgICAgICAg
ICAgICAgICAgICAgIFBFUkZfRk9STUFUX1RPVEFMX1RJTUVfRU5BQkxFRCAgfAogICAgICAgICAg
ICAgICAgICAgICAgUEVSRl9GT1JNQVRfVE9UQUxfVElNRV9SVU5OSU5HICA7CiAgICBwZWEuZGlz
YWJsZWQ9MTsKICAgIHBlYS5leGNsdWRlX2tlcm5lbCA9IDE7CiAgICBwZWEuZXhjbHVkZV9pZGxl
ID0gMTsKICAgIHBlYS5leGNsdWRlX2h2ID0gMTsKICAgIAogICAgaWYoKHBlW25fZXZdLmZkID0K
ICAgICAgICBwZXJmX2V2ZW50X29wZW4gKCAmcGVhLCBwaWQsIC0xLCBmZCwgMCkKICAgICAgICkg
PT0gLTEKICAgICApCiAgICB7IGZwcmludGYoc3RkZXJyLCJwZXJmX2V2ZW50X29wZW4gZmFpbGVk
IDogJWQgOiAnJXMnLlxuIiwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CiAgICAgIHJldHVybiAx
OwogICAgfQogCiAgICBpZiggZmQgPT0gLTEpCiAgICAgIGZkID0gcGVbbl9ldl0uZmQ7IC8vIHRo
aXMgaXMgdGhlIEdyb3VwIExlYWRlciBGRAogICAgCiAgICBpZiggMCAhPSBpb2N0bCggcGVbbl9l
dl0uZmQsIFBFUkZfRVZFTlRfSU9DX0lELCAmcGVbbl9ldl0uaWQpKQogICAgeyBmcHJpbnRmKHN0
ZGVyciwiaW9jdGwoZmQsIFBFUkZfRVZFTlRfSU9DX0lEKSBmYWlsZWQgZm9yICMlZCA6ICVkIDog
JyVzJy5cbiIsIG5fZXYsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOwogICAgICByZXR1cm4gMTsK
ICAgIH0gICAgCiAgfQogIAogIGlmKCAwICE9IGlvY3RsKCBmZCwgUEVSRl9FVkVOVF9JT0NfUkVT
RVQsIFBFUkZfSU9DX0ZMQUdfR1JPVVApKQogIHsgZnByaW50ZihzdGRlcnIsImlvY3RsKGZkLCBQ
RVJGX0VWRU5UX0lPQ19SRVNFVCkgZmFpbGVkIDogJWQgOiAnJXMnLlxuIiwgZXJybm8sIHN0cmVy
cm9yKGVycm5vKSk7CiAgICByZXR1cm4gMTsKICB9CiAgCiAgLy8gZG8gc29tZXRoaW5nIHRvIG1l
YXN1cmUgLSBsZXQncyB0cnkgMTAwIGxvbmcgZGl2aXNpb25zOgogIHVpbnQ2NF90IGFfbnVtID0g
MHgwMTAyMDMwNDA1MDYwNzA4OwogIHVpbnQ2NF90IGJfbnVtID0gfmFfbnVtOwogIGludCBjbnQ9
MTAwOwogIGlmKCAwICE9IGlvY3RsKCBmZCwgUEVSRl9FVkVOVF9JT0NfRU5BQkxFLCBQRVJGX0lP
Q19GTEFHX0dST1VQKSkKICB7IGZwcmludGYoc3RkZXJyLCJpb2N0bChmZCwgUEVSRl9FVkVOVF9J
T0NfSUQpIGZhaWxlZCA6ICVkIDogJyVzJy5cbiIsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOwog
ICAgcmV0dXJuIDE7CiAgfQogIAogIGRvCiAgeyBhX251bT0oYl9udW0gLz0gYV9udW0pOwogIH0g
d2hpbGUoLS1jbnQpOwogIAogIGlmKCAwICE9IGlvY3RsKCBmZCwgUEVSRl9FVkVOVF9JT0NfRElT
QUJMRSwgUEVSRl9JT0NfRkxBR19HUk9VUCkpCiAgeyBmcHJpbnRmKHN0ZGVyciwiaW9jdGwoZmQs
IFBFUkZfRVZFTlRfSU9DX0lEKSBmYWlsZWQgOiAlZCA6ICclcycuXG4iLCBlcnJubywgc3RyZXJy
b3IoZXJybm8pKTsKICAgIHJldHVybiAxOwogIH0gIAoKICBzdHJ1Y3QKICB7IHVpbnQ2NF90IG5y
LCB0aW1lX2VuYWJsZWQsIHRpbWVfcnVubmluZzsKICAgIHN0cnVjdCBldmVudAogICAgeyB1aW50
NjRfdCB2YWx1ZSxpZDsKICAgIH0gZXZbTl9FVl07CiAgfSBldmVudHM7CgogIGlmKCByZWFkKGZk
LCAmZXZlbnRzLCBzaXplb2YoZXZlbnRzKSkgIT0gc2l6ZW9mKGV2ZW50cykpCiAgeyBmcHJpbnRm
KHN0ZGVyciwicmVhZCBvZiBldmVudCBncm91cCBsZWFkZXIgRkQgZmFpbGVkIDogJWQgOiAnJXMn
LlxuIiwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7CiAgICByZXR1cm4gMTsKICB9CgogIGlmKCBl
dmVudHMubnIgIT0gTl9FViApCiAgeyBmcHJpbnRmKHN0ZGVyciwidW5leHBlY3RlZCBudW1iZXIg
b2YgZXZlbnRzIHJlYWQ6ICVsdVxuIiwgZXZlbnRzLm5yKTsKICAgIHJldHVybiAxOwogIH0KICBz
dHJ1Y3QgZXZlbnQgKmV2ID0gJmV2ZW50cy5ldlswXTsKICBib29sIG5vbl96ZXJvX2V2ZW50PWZh
bHNlOwogIGRvCiAgeyBib29sIGZvdW5kPTA7CiAgICBmb3Iobl9ldj0wOyBuX2V2IDwgTl9FVjsg
bl9ldiArPSAxKQogICAgeyBpZiggcGVbbl9ldl0uaWQgPT0gZXYtPmlkICkKICAgICAgeyBmb3Vu
ZCA9IHRydWU7CiAgICAgICAgYnJlYWs7CiAgICAgIH0KICAgIH0KICAgIGlmKCAhIGZvdW5kICkK
ICAgIHsgZnByaW50ZihzdGRlcnIsIktlcm5lbCByZXR1cm5lZCB1bmtub3duIGV2ZW50IElEOiAl
bHUiLCBldi0+aWQpOwogICAgICByZXR1cm4gMTsKICAgIH0KICAgIHByaW50ZigiRVZFTlQ6ICVz
IDogJWx1XG4iLCBwZVtuX2V2XS5uYW1lLCBldi0+dmFsdWUpOwogICAgaWYgKCFub25femVyb19l
dmVudCkgCiAgICAgIG5vbl96ZXJvX2V2ZW50ID0gZXYtPnZhbHVlICE9IDA7CiAgICArK2V2Owog
IH0gd2hpbGUoIC0tZXZlbnRzLm5yICk7CiAgcmV0dXJuIChub25femVyb19ldmVudCA/IDAgOiAx
KTsKfQo=
--f4030435b440d0823705651c1703--
