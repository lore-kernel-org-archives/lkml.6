Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx488jB6mc0GGsr+MMXuU5dti6P3leui9KBKLg3naJdzuBoBb/t9y9yjOH/PyBamalBIDfOgc
ARC-Seal: i=1; a=rsa-sha256; t=1524653059; cv=none;
        d=google.com; s=arc-20160816;
        b=lRFqwVocEgiN+pxqQMts68rN256nCv0SSa8KrBLMW6ZVEFXxLw8DNxPX0wieNWKBQ3
         aH31san1BiIvn4n8s1IcE6xv/zi8cdfWtZv/D/eTXTsX60fXyIGR9fF50VcxJbofkwDE
         fBGPU/YroSthEK0GFNxSmwlCQPzTa+v9WJ9pXOkMp65/D4JRMqJq8AeCT5xhCz4BPDdO
         oe+MFS5I9v4yFnuKVROVmkHx063SQfD9AVAq8TWXS2LcYCfb4OShuLnCl+HloRV0CMSd
         S8adj5UXn5H92dy9LsdrSkYHrrpawwjMl+YlQkG3n64R1bQy5fQxGsPtDs/H/5EJp6bS
         T+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1DMaYNFKTQIeLpMBTXoPe2IoK0vTiRKlHO3UajJ9D40=;
        b=i8NKYM5d+v1kJ/igwofDfh67WT+M628sJU+ixTxSd/ntpE2Zbqn0wuTl7n7fffTYFO
         up2zmMXDYsJ30JYrATl64Y8q/aBXsuc9+sMx6JkAlPvMGtSOoooNmza02MkXo8ESA4fr
         usDW8Oqsaq4KvCrnaiXiTXfSj6WdeAG5gVCdP6asBOEY9EI8NTISndAVty5dSu2DiTld
         5fWo4QUnQ2chvntvor+gY09I0MUgdclpwgcIB6pCtyYU9WSx6giu9lOPWZQ6wCuIVfSf
         oJn4l7tYRF1I04AOGy3h6R81HQgm6bSkwtjWphX+mMelcB/1729shIBnpCPqwkmxBLR5
         R5lA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Richter <tmricht@linux.vnet.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 168/183] perf test: Fix test trace+probe_libc_inet_pton.sh for s390x
Date: Wed, 25 Apr 2018 12:36:28 +0200
Message-Id: <20180425103249.273312378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714606439531858?=
X-GMAIL-MSGID: =?utf-8?q?1598714606439531858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.vnet.ibm.com>


[ Upstream commit 7a92453620d42c3a5fea94a864dc6aa04c262b93 ]

On Intel test case trace+probe_libc_inet_pton.sh succeeds and the
output is:

[root@f27 perf]# ./perf trace --no-syscalls
                  -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.037 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.037/0.037/0.037/0.000 ms
     0.000 probe_libc:inet_pton:(7fa40ac618a0))
              __GI___inet_pton (/usr/lib64/libc-2.26.so)
              getaddrinfo (/usr/lib64/libc-2.26.so)
              main (/usr/bin/ping)

The kernel stack unwinder is used, it is specified implicitly
as call-graph=fp (frame pointer).

On s390x only dwarf is available for stack unwinding. It is also
done in user space. This requires different parameter setup
and result checking for s390x and Intel.

This patch adds separate perf trace setup and result checking
for Intel and s390x. On s390x specify this command line to
get a call-graph and handle the different call graph result
checking:

[root@s35lp76 perf]# ./perf trace --no-syscalls
	-e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.041 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.041/0.041/0.041/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb9942060))
            __GI___inet_pton (/usr/lib64/libc-2.26.so)
            gaih_inet (inlined)
            __GI_getaddrinfo (inlined)
            main (/usr/bin/ping)
            __libc_start_main (/usr/lib64/libc-2.26.so)
            _start (/usr/bin/ping)
[root@s35lp76 perf]#

Before:
[root@s8360047 perf]# ./perf test -vv 58
58: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 26349
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.079 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.079/0.079/0.079/0.000 ms
0.000 probe_libc:inet_pton:(3ff925c2060))
test child finished with -1
 ---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!
[root@s8360047 perf]#

After:
[root@s35lp76 perf]# ./perf test -vv 57
57: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 38708
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.038 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.038/0.038/0.038/0.000 ms
0.000 probe_libc:inet_pton:(3ff87342060))
__GI___inet_pton (/usr/lib64/libc-2.26.so)
gaih_inet (inlined)
__GI_getaddrinfo (inlined)
main (/usr/bin/ping)
__libc_start_main (/usr/lib64/libc-2.26.so)
_start (/usr/bin/ping)
test child finished with 0
 ---- end ----
probe libc's inet_pton & backtrace it with ping: Ok
[root@s35lp76 perf]#

On Intel the test case runs unchanged and succeeds.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180117083831.101001-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh |   21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -22,10 +22,23 @@ trace_libc_inet_pton_backtrace() {
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
 	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
-	expected[7]="getaddrinfo[[:space:]]\($libc\)$"
-	expected[8]=".*\(.*/bin/ping.*\)$"
+	case "$(uname -m)" in
+	s390x)
+		eventattr='call-graph=dwarf'
+		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
+		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
+		;;
+	*)
+		eventattr='max-stack=3'
+		expected[7]="getaddrinfo[[:space:]]\($libc\)$"
+		expected[8]=".*\(.*/bin/ping.*\)$"
+		;;
+	esac
 
-	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
+	perf trace --no-syscalls -e probe_libc:inet_pton/$eventattr/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
 		echo $line
 		echo "$line" | egrep -q "${expected[$idx]}"
 		if [ $? -ne 0 ] ; then
@@ -33,7 +46,7 @@ trace_libc_inet_pton_backtrace() {
 			exit 1
 		fi
 		let idx+=1
-		[ $idx -eq 9 ] && break
+		[ -z "${expected[$idx]}" ] && break
 	done
 }
 
