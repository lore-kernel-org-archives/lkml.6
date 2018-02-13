Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934766AbeBMQrQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:47:16 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40019 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeBMQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:47:14 -0500
X-Google-Smtp-Source: AH8x227/SW0wnegwpPHoeeUL0+2XSjefMZs9Fn20wvetgXrowE/MeGxYw2QDHegZ9EPcz+oNV51uOzMKXeG9/Srrrwo=
MIME-Version: 1.0
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Tue, 13 Feb 2018 16:47:12 +0000
Message-ID: <CALyZvKyQFp0CfwFfBosM=OK5DJgb71bhMAkhLU2Wdv0asTSVZw@mail.gmail.com>
Subject: perf Intel x86_64 : BUG: BRANCH_INSTRUCTIONS / BRANCH_MISSES cannot
 be combined with CACHE_REFERENCES / CACHE_MISSES .
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="001a113e51181ac64405651abf17"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a113e51181ac64405651abf17
Content-Type: text/plain; charset="UTF-8"

Good day -

I'd much appreciate some advice as to why, on my Intel x86_64
( DisplayFamily_DisplayModel : 06_3CH ), running either Linux 4.12.10,
or Linux 3.10.0, any attempt to count all of :
     PERF_COUNT_HW_BRANCH_INSTRUCTIONS
          (or raw config 0xC4) , and
     PERF_COUNT_HW_BRANCH_MISSES
          (or raw config 0xC5), and
     combined with
     PERF_COUNT_HW_CACHE_REFERENCES
         (or raw config 0x4F2E ), and
     PERF_COUNT_HW_CACHE_MISSES
         (or raw config 0x412E) ,
results in ALL COUNTERS BEING 0 in a read of the Group FD or
mmap sample area.

This is demonstrated by the example program, which will
use perf_event_open() to create a Group Leader FD  for the first event,
and associate all other events with that Event Group , so that it
will read all events on the group FD .

The perf_event_open() calls and the ioctl(event_fd, PERF_EVENT_IOC_ID, &id)
calls all return successfully , but if I combine ANY of
( PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
  PERF_COUNT_HW_BRANCH_MISSES
) with any of
( PERF_COUNT_HW_CACHE_REFERENCES,
  PERF_COUNT_HW_CACHE_MISSES
) in the Event Group, ALL events have '0' event->value.

Demo :
1. Compile program to use kernel mapped Generic Events:
  $ gcc -std=gnu11 -o perf_bug perf_bug.c
  Running program shows all counters have 0 values, since both
  CACHE & BRANCH hits+misses are being requested:

  $ ./perf_bug
  EVENT: Branch Instructions : 0
  EVENT: Branch Misses : 0
  EVENT: Instructions : 0
  EVENT: CPU Cycles : 0
  EVENT: Ref. CPU Cycles : 0
  EVENT: Bus Cycles : 0
  EVENT: Cache References : 0
  EVENT: Cache Misses : 0

  NOT registering interest in EITHER the BRANCH counters
  OR the CACHE counters fixes the problem:

  Compile without registering for BRANCH_INSTRUCTIONS
  or BRANCH_MISSES:
  $ gcc -std=gnu11 -DNO_BUG_NO_BRANCH  -o perf_bug perf_bug.c
  $ ./perf_bug
  EVENT: Instructions : 914
  EVENT: CPU Cycles : 4110
  EVENT: Ref. CPU Cycles : 4437
  EVENT: Bus Cycles : 152
  EVENT: Cache References : 1
  EVENT: Cache Misses : 1

  Compile without registering for CACHE_REFERENCES or CACHE_MISSES:
  $ gcc -std=gnu11 -DNO_BUG_NO_CACHE  -o perf_bug perf_bug.c
  $ ./perf_bug
EVENT: Branch Instructions : 106
EVENT: Branch Misses : 6
EVENT: Instructions : 914
EVENT: CPU Cycles : 4132
EVENT: Ref. CPU Cycles : 8526
EVENT: Bus Cycles : 295

The same thing happens if I do not use Generic Events, but rather
"dynamic raw PMU" events, by putting the hex values from
/sys/bus/event_source/devices/cpu/events/? into the perf_event_attr
config, OR'ed with (1<<63), and using the PERF_TYPE_RAW perf_event_attr
type value :

$ gcc -DUSE_RAW_PMU -o perf_bug perf_bug.c
$ ./perf_bug
EVENT: Branch Instructions : 0
EVENT: Branch Misses : 0
EVENT: Instructions : 0
EVENT: CPU Cycles : 0
EVENT: Ref. CPU Cycles : 0
EVENT: Bus Cycles : 0
EVENT: Cache References : 0
EVENT: Cache Misses : 0


$ gcc -DUSE_RAW_PMU -DNO_BUG_NO_BRANCH -o perf_bug perf_bug.c
$ ./perf_bug
EVENT: Instructions : 914
EVENT: CPU Cycles : 4102
EVENT: Ref. CPU Cycles : 4959
EVENT: Bus Cycles : 171
EVENT: Cache References : 2
EVENT: Cache Misses : 2

$ gcc -DUSE_RAW_PMU -DNO_BUG_NO_CACHE -o perf_bug perf_bug.c
$ ./perf_bug
EVENT: Branch Instructions : 106
EVENT: Branch Misses : 6
EVENT: Instructions : 914
EVENT: CPU Cycles : 4108
EVENT: Ref. CPU Cycles : 10817
EVENT: Bus Cycles : 373


The perf tool itself seems to have the same issue:

With CACHE & BRANCH counters does not work :
$ perf stat -e '{r0c4,r0c5,r0c0,r03c,r0300,r013c,r04F2E,r0412E}:SIu' sleep 1

 Performance counter stats for 'sleep 1':

     <not counted>      r0c4
               (0.00%)
     <not counted>      r0c5
               (0.00%)
     <not counted>      r0c0
               (0.00%)
     <not counted>      r03c
               (0.00%)
     <not counted>      r0300
               (0.00%)
     <not counted>      r013c
               (0.00%)
     <not counted>      r04F2E
               (0.00%)
   <not supported>     r0412E

       1.001652932 seconds time elapsed

   Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog

Disabling the NMI watchdog makes no difference .

It is very strange that perf thinks 'r0412E' is not supported :
   $ cat /sys/bus/event_source/devices/cpu/cache_misses
   event=0x2e,umask=0x41

The kernel should not be advertizing an unsupported event
in a  /sys/bus/event_source/devices/cpu/events/ file, should it ?

So perf stat has the same problem - without either Cache or Branch
counters seems to work fine:

without cache:
$ perf stat -e '{r0c4,r0c5,r0c0,r03c,r0300,r013c}:SIu' sleep 1

 Performance counter stats for 'sleep 1':

             37740      r0c4
              3557      r0c5
            188552      r0c0
            311684      r03c
            360963      r0300
             12461      r013c

       1.001508109 seconds time elapsed

without branch:
$ perf stat -e '{r0c0,r03c,r0300,r013c,r04F2E,r0412E}:SIu' sleep 1

 Performance counter stats for 'sleep 1':

            188554      r0c0
            320242      r03c
            452748      r0300
             15633      r013c
              4145      r04F2E
              3022      r0412E

       1.001810421 seconds time elapsed

proving again that perf's claim that 'r0412E' is not supported is bogus.
The Intel SDM's table 19-1 Architectural events, which ALL Intel CPUs
are meant to support, does include  'Event: 2EH | Umask: 4FH : LLC
Reference '  and  'Event: 2EH | Umask: 41H : LLC Miss' , as well as :
'Event : C4H | Umask: 00H : Branch Instructions Retired' and
'Event : C5H | Umask: 00H : Branch Misses Retired' .
So why can't perf count them all in the same group?

Please , can anyone enlighten me as to what is going on here ?

Why can't I count all of
   ( BRANCH_INSTRUCTIONS , BRANCH_MISSES ,
     CACHE_REFERENCES, CACHE_MISSES
  )
in the same Perf Event Group ?

Thanks in advance for any replies,
Best Regards,
Jason

--001a113e51181ac64405651abf17
Content-Type: text/x-csrc; charset="US-ASCII"; name="perf_bug.c"
Content-Disposition: attachment; filename="perf_bug.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

LyogRGVtb25zdHJhdGlvbiBvZiBMaW51eCBQRVJGIGJ1ZzoKICogIExpbnV4IGlzIHVuYWJsZSB0
byBjb3VudCBCUkFOQ0hfSU5TVFJVQ1RJT05TIG9yIEJSQU5DSF9NSVNTRVMgCiAqICBpbiBub24t
c2FtcGxlZCBtb2RlLgogKi8KCiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN0ZGlu
dC5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxz
eXMvc3lzY2FsbC5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxlcnJuby5oPgoj
aW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8bGludXgvcGVy
Zl9ldmVudC5oPgoKc3RhdGljIGludApwZXJmX2V2ZW50X29wZW4KKCBzdHJ1Y3QgcGVyZl9ldmVu
dF9hdHRyICpod19ldmVudCwgcGlkX3QgcGlkLCBpbnQgY3B1LCBpbnQgZ3JvdXBfZmQsIHVuc2ln
bmVkIGxvbmcgZmxhZ3MgKQp7IGludCByZXQ7ICAKICByZXQgPSAoaW50KSBzeXNjYWxsKF9fTlJf
cGVyZl9ldmVudF9vcGVuLCBod19ldmVudCwgcGlkLCBjcHUsIGdyb3VwX2ZkLCBmbGFncyk7CiAg
cmV0dXJuIHJldDsKfQoKaW50IG1haW4oIGludCBhcmdjLCBjb25zdCBjaGFyICpjb25zdCogYXJn
dikKeyBzdHJ1Y3QgcGVyZl9ldmVudF9hdHRyIHBlYSA9IHswfTsKICBzdHJ1Y3QgZXZjZmcKICB7
IHVpbnQ2NF90IHBlcmZfdHlwZTsKICAgIHVpbnQ2NF90IHBlcmZfY2ZnOwogICAgY29uc3QgY2hh
ciAqbmFtZTsKICAgIGludCBmZDsKICAgIHVpbnQ2NF90IGlkOwogIH0gcGUgW10gPSB7CiNpZm5k
ZWYgVVNFX1JBV19QTVUKICAvLyBzbyB3ZSBjYW4gdGVzdCB1c2luZyBHZW5lcmljIEtlcm5lbCBF
dmVudCBtYXBwaW5nOgojaWZuZGVmIE5PX0JVR19OT19CUkFOQ0ggICAgCiAgICB7IFBFUkZfVFlQ
RV9IQVJEV0FSRSAKICAgICwgUEVSRl9DT1VOVF9IV19CUkFOQ0hfSU5TVFJVQ1RJT05TCiAgICAs
ICJCcmFuY2ggSW5zdHJ1Y3Rpb25zIgogICAgLCAtMSwgMAogICAgfQogICwgeyBQRVJGX1RZUEVf
SEFSRFdBUkUgCiAgICAsIFBFUkZfQ09VTlRfSFdfQlJBTkNIX01JU1NFUwogICAgLCAiQnJhbmNo
IE1pc3NlcyIKICAgICwgLTEsIDAKICAgIH0KICAsCiNlbmRpZiAgICAKICAgIHsgUEVSRl9UWVBF
X0hBUkRXQVJFIAogICAgLCBQRVJGX0NPVU5UX0hXX0lOU1RSVUNUSU9OUwogICAgLCAiSW5zdHJ1
Y3Rpb25zIgogICAgLCAtMSwgMAogICAgfSAgICAKICAsIHsgUEVSRl9UWVBFX0hBUkRXQVJFIAog
ICAgLCBQRVJGX0NPVU5UX0hXX0NQVV9DWUNMRVMKICAgICwgIkNQVSBDeWNsZXMiCiAgICAsIC0x
LCAwCiAgICB9CiAgLCB7IFBFUkZfVFlQRV9IQVJEV0FSRSAKICAgICwgUEVSRl9DT1VOVF9IV19S
RUZfQ1BVX0NZQ0xFUwogICAgLCAiUmVmLiBDUFUgQ3ljbGVzIgogICAgLCAtMSwgMAogICAgfSAK
ICAsIHsgUEVSRl9UWVBFX0hBUkRXQVJFIAogICAgLCBQRVJGX0NPVU5UX0hXX0JVU19DWUNMRVMK
ICAgICwgIkJ1cyBDeWNsZXMiICAgICAgCiAgICAsIC0xLCAwICAgICAgCiAgICB9CiNpZm5kZWYg
Tk9fQlVHX05PX0NBQ0hFCiAgLCB7IFBFUkZfVFlQRV9IQVJEV0FSRSAKICAgICwgUEVSRl9DT1VO
VF9IV19DQUNIRV9SRUZFUkVOQ0VTCiAgICAsICJDYWNoZSBSZWZlcmVuY2VzIiAgICAgICAgICAg
IAogICAgLCAtMSwgMAogICAgfSAKICAsIHsgUEVSRl9UWVBFX0hBUkRXQVJFIAogICAgLCBQRVJG
X0NPVU5UX0hXX0NBQ0hFX01JU1NFUwogICAgLCAiQ2FjaGUgTWlzc2VzIiAgICAgICAgICAgICAg
ICAgIAogICAgLCAtMSwgMCAgICAgIAogICAgfQojZW5kaWYgICAgCiNlbHNlCiAgLy8gb3IgdGVz
dCB1c2luZyByYXcgUE1VIGNvZGVzIC0gdGhlc2UgY29tZSBmcm9tIHRoZSBJbnRlbCBTRE0sIENo
YXB0ZXIgMTksIFRhYmxlIDE5LTEsCiAgLy8gYW5kIEkndmUgY2hlY2tlZCB0aGV5IGFyZSBpZGVu
dGljYWwgdG8gdGhlIHZhbHVlcyBpbgogIC8vIC9zeXMvYnVzL2V2ZW50X3NvdXJjZS9kZXZpY2Vz
L2NwdS9ldmVudHMvewojaWZuZGVmIE5PX0JVR19OT19CUkFOQ0gKICAgIHsgUEVSRl9UWVBFX1JB
VyAKICAgICwgKDFVTDw8NjNVKSB8IDB4QzQgICAvLyBicmFuY2hfaW5zdHJ1Y3Rpb25zCiAgICAs
ICJCcmFuY2ggSW5zdHJ1Y3Rpb25zIgogICAgLCAtMSwgMCAgICAgIAogICAgfQogICwgeyBQRVJG
X1RZUEVfUkFXIAogICAgLCAoMVVMPDw2M1UpIHwgMHhDNSAgIC8vIGJyYW5jaF9taXNzZXMKICAg
ICwgIkJyYW5jaCBNaXNzZXMiICAgICAgCiAgICAsIC0xLCAwICAgICAgCiAgICB9CiAgLAojZW5k
aWYKICAgIHsgUEVSRl9UWVBFX1JBVyAKICAgICwgKDFVTDw8NjNVKSB8IDB4QzAgICAvLyBpbnN0
cnVjdGlvbnMKICAgICwgIkluc3RydWN0aW9ucyIKICAgICwgLTEsIDAgICAgICAKICAgIH0gICAg
CiAgLCB7IFBFUkZfVFlQRV9SQVcgCiAgICAsICgxVUw8PDYzVSkgfCAweDNDICAgLy8gY3B1IGN5
Y2xlcwogICAgLCAiQ1BVIEN5Y2xlcyIgICAgICAKICAgICwgLTEsIDAgICAgICAKICAgIH0KICAs
IHsgUEVSRl9UWVBFX1JBVyAKICAgICwgKDFVTDw8NjNVKSB8IDB4MDMwMCAgLy8gcmVmIGNwdSBj
eWNsZXMKICAgICwgIlJlZi4gQ1BVIEN5Y2xlcyIgICAgICAgICAgICAKICAgICwgLTEsIDAgICAg
ICAgICAgIAogICAgfQogICwgeyBQRVJGX1RZUEVfUkFXIAogICAgLCAoMVVMPDw2M1UpIHwgMHgw
MTNDICAvLyBidXMgY3ljbGVzCiAgICAsICJCdXMgQ3ljbGVzIiAgICAgICAgICAgIAogICAgLCAt
MSwgMCAgICAgIAogICAgfQojaWZuZGVmIE5PX0JVR19OT19DQUNIRQogICwgeyBQRVJGX1RZUEVf
UkFXIAogICAgLCAoMVVMPDw2M1UpIHwgMHgwNEYyRSAgLy8gY2FjaGUgcmVmZXJlbmNlcwogICAg
LCAiQ2FjaGUgUmVmZXJlbmNlcyIgCiAgICAsIC0xLCAwICAgICAgICAgICAKICAgIH0KICAsIHsg
UEVSRl9UWVBFX1JBVyAKICAgICwgKDFVTDw8NjNVKSB8IDB4MDQxMkUgIC8vIGNhY2hlIG1pc3Nl
cwogICAgLCAiQ2FjaGUgTWlzc2VzIiAgICAgICAKICAgICwgLTEsIDAgICAgICAKICAgIH0gICAg
CiNlbmRpZgojZW5kaWYKICB9OwojZGVmaW5lIE5fRVYgKHNpemVvZihwZSkvc2l6ZW9mKHN0cnVj
dCBldmNmZykpCiAgaW50IGZkPS0xOwogIGludCBuX2V2PTA7CiAgcGlkX3QgcGlkPWdldHBpZCgp
OwogIGZvcig7IG5fZXYgPCBOX0VWOyBuX2V2ICs9IDEpCiAgeyBtZW1zZXQoJnBlYSwgJ1wwJywg
c2l6ZW9mKHBlYSkpOwogICAgcGVhLnNpemUgICA9IFBFUkZfQVRUUl9TSVpFX1ZFUjU7CiAgICBw
ZWEudHlwZSAgID0gcGVbbl9ldl0ucGVyZl90eXBlOwogICAgcGVhLmNvbmZpZyA9IHBlW25fZXZd
LnBlcmZfY2ZnOwogICAgcGVhLnJlYWRfZm9ybWF0ID0gUEVSRl9GT1JNQVRfR1JPVVAgIHwgUEVS
Rl9GT1JNQVRfSUQgfAogICAgICAgICAgICAgICAgICAgICAgUEVSRl9GT1JNQVRfVE9UQUxfVElN
RV9FTkFCTEVEICB8CiAgICAgICAgICAgICAgICAgICAgICBQRVJGX0ZPUk1BVF9UT1RBTF9USU1F
X1JVTk5JTkcgIDsKICAgIHBlYS5kaXNhYmxlZD0xOwogICAgcGVhLmV4Y2x1ZGVfa2VybmVsID0g
MTsKICAgIHBlYS5leGNsdWRlX2lkbGUgPSAxOwogICAgcGVhLmV4Y2x1ZGVfaHYgPSAxOwogICAg
CiAgICBpZigocGVbbl9ldl0uZmQgPQogICAgICAgIHBlcmZfZXZlbnRfb3BlbiAoICZwZWEsIHBp
ZCwgLTEsIGZkLCAwKQogICAgICAgKSA9PSAtMQogICAgICkKICAgIHsgZnByaW50ZihzdGRlcnIs
InBlcmZfZXZlbnRfb3BlbiBmYWlsZWQgOiAlZCA6ICclcycuXG4iLCBlcnJubywgc3RyZXJyb3Io
ZXJybm8pKTsKICAgICAgcmV0dXJuIDE7CiAgICB9CiAKICAgIGlmKCBmZCA9PSAtMSkKICAgICAg
ZmQgPSBwZVtuX2V2XS5mZDsgLy8gdGhpcyBpcyB0aGUgR3JvdXAgTGVhZGVyIEZECiAgICAKICAg
IGlmKCAwICE9IGlvY3RsKCBwZVtuX2V2XS5mZCwgUEVSRl9FVkVOVF9JT0NfSUQsICZwZVtuX2V2
XS5pZCkpCiAgICB7IGZwcmludGYoc3RkZXJyLCJpb2N0bChmZCwgUEVSRl9FVkVOVF9JT0NfSUQp
IGZhaWxlZCBmb3IgIyVkIDogJWQgOiAnJXMnLlxuIiwgbl9ldiwgZXJybm8sIHN0cmVycm9yKGVy
cm5vKSk7CiAgICAgIHJldHVybiAxOwogICAgfSAgICAKICB9CiAgCiAgaWYoIDAgIT0gaW9jdGwo
IGZkLCBQRVJGX0VWRU5UX0lPQ19SRVNFVCwgUEVSRl9JT0NfRkxBR19HUk9VUCkpCiAgeyBmcHJp
bnRmKHN0ZGVyciwiaW9jdGwoZmQsIFBFUkZfRVZFTlRfSU9DX1JFU0VUKSBmYWlsZWQgOiAlZCA6
ICclcycuXG4iLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKICAgIHJldHVybiAxOwogIH0KICAK
ICAvLyBkbyBzb21ldGhpbmcgdG8gbWVhc3VyZSAtIGxldCdzIHRyeSAxMDAgbG9uZyBkaXZpc2lv
bnM6CiAgdWludDY0X3QgYV9udW0gPSAweDAxMDIwMzA0MDUwNjA3MDg7CiAgdWludDY0X3QgYl9u
dW0gPSB+YV9udW07CiAgaW50IGNudD0xMDA7CiAgaWYoIDAgIT0gaW9jdGwoIGZkLCBQRVJGX0VW
RU5UX0lPQ19FTkFCTEUsIFBFUkZfSU9DX0ZMQUdfR1JPVVApKQogIHsgZnByaW50ZihzdGRlcnIs
ImlvY3RsKGZkLCBQRVJGX0VWRU5UX0lPQ19JRCkgZmFpbGVkIDogJWQgOiAnJXMnLlxuIiwgZXJy
bm8sIHN0cmVycm9yKGVycm5vKSk7CiAgICByZXR1cm4gMTsKICB9CiAgCiAgZG8KICB7IGFfbnVt
PShiX251bSAvPSBhX251bSk7CiAgfSB3aGlsZSgtLWNudCk7CiAgCiAgaWYoIDAgIT0gaW9jdGwo
IGZkLCBQRVJGX0VWRU5UX0lPQ19ESVNBQkxFLCBQRVJGX0lPQ19GTEFHX0dST1VQKSkKICB7IGZw
cmludGYoc3RkZXJyLCJpb2N0bChmZCwgUEVSRl9FVkVOVF9JT0NfSUQpIGZhaWxlZCA6ICVkIDog
JyVzJy5cbiIsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOwogICAgcmV0dXJuIDE7CiAgfSAgCgog
IHN0cnVjdAogIHsgdWludDY0X3QgbnIsIHRpbWVfZW5hYmxlZCwgdGltZV9ydW5uaW5nOwogICAg
c3RydWN0IGV2ZW50CiAgICB7IHVpbnQ2NF90IHZhbHVlLGlkOwogICAgfSBldltOX0VWXTsKICB9
IGV2ZW50czsKCiAgaWYoIHJlYWQoZmQsICZldmVudHMsIHNpemVvZihldmVudHMpKSAhPSBzaXpl
b2YoZXZlbnRzKSkKICB7IGZwcmludGYoc3RkZXJyLCJyZWFkIG9mIGV2ZW50IGdyb3VwIGxlYWRl
ciBGRCBmYWlsZWQgOiAlZCA6ICclcycuXG4iLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKICAg
IHJldHVybiAxOwogIH0KCiAgaWYoIGV2ZW50cy5uciAhPSBOX0VWICkKICB7IGZwcmludGYoc3Rk
ZXJyLCJ1bmV4cGVjdGVkIG51bWJlciBvZiBldmVudHMgcmVhZDogJWx1XG4iLCBldmVudHMubnIp
OwogICAgcmV0dXJuIDE7CiAgfQogIHN0cnVjdCBldmVudCAqZXYgPSAmZXZlbnRzLmV2WzBdOwog
IGJvb2wgbm9uX3plcm9fZXZlbnQ9ZmFsc2U7CiAgZG8KICB7IGJvb2wgZm91bmQ9MDsKICAgIGZv
cihuX2V2PTA7IG5fZXYgPCBOX0VWOyBuX2V2ICs9IDEpCiAgICB7IGlmKCBwZVtuX2V2XS5pZCA9
PSBldi0+aWQgKQogICAgICB7IGZvdW5kID0gdHJ1ZTsKICAgICAgICBicmVhazsKICAgICAgfQog
ICAgfQogICAgaWYoICEgZm91bmQgKQogICAgeyBmcHJpbnRmKHN0ZGVyciwiS2VybmVsIHJldHVy
bmVkIHVua25vd24gZXZlbnQgSUQ6ICVsdSIsIGV2LT5pZCk7CiAgICAgIHJldHVybiAxOwogICAg
fQogICAgcHJpbnRmKCJFVkVOVDogJXMgOiAlbHVcbiIsIHBlW25fZXZdLm5hbWUsIGV2LT52YWx1
ZSk7CiAgICBpZiAoIW5vbl96ZXJvX2V2ZW50KSAKICAgICAgbm9uX3plcm9fZXZlbnQgPSBldi0+
dmFsdWUgIT0gMDsKICAgICsrZXY7CiAgfSB3aGlsZSggLS1ldmVudHMubnIgKTsKICByZXR1cm4g
KG5vbl96ZXJvX2V2ZW50ID8gMCA6IDEpOwp9Cg==
--001a113e51181ac64405651abf17--
