Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpiOirJnQFwdeyxMD1Px9TxnNNKyyaGX8yuIupUt7QUoIj1sdrF7f3FsS4ojEw1mSmFVX90
ARC-Seal: i=1; a=rsa-sha256; t=1525483120; cv=none;
        d=google.com; s=arc-20160816;
        b=w265EXvAylZ4GJ2LSafm7A2mdaGyA8SiEuzDTgDm6u3i8rHMh3/Hln+6hrB5mC2pVB
         n+6Rxo5uNsvb8lha/0nVg5w1cUvAyA3In+Pe9q3D/BOxVP7ZvTky5FT40djqyTC7EM/e
         Xa8H4gPBcaeqE3IULLR/W8BNBz5vU2RX/LG/fCao5OLx+CbvB5+kaxyrSDIoJS9b5Pqz
         TUOjizumK9lfDDRQZBEN03Ya5qxw4osbnMTGjaGmiI3ous0Y8iH6GC0RsVrUYsi7ACPK
         mp4FahzNFVLkKeEG3TEysYVKXb/V+zAT9ePEGo111CAfrMoYKLM4B/ElfUexclNUDAAF
         KfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RpkM3vf0Bo7PowbEpuM9bozAb++nS31eigdRy9W1glc=;
        b=G3IU7mD7IRGRDWuBqo4l0iPLHRkXftEZrdkb+6GpC6pxSTJnnDcFMI4tIHKOR7eicZ
         jIfaXn8fidCFhOBnpM0qQ2gc2+2WalTz7VO8pBLx3ysTediCgepNM/+tNzmcitfhqSOB
         HSEqsUjSZCVerpY/axst0IPUMZOeoMkZuMpdiw0VR4ebtMmiWlw0IiTTKT5D9olhTf/x
         hFp+Vf1q778qb/ymhsXHXiWQ7KJBOUkFdV8vI5s9mI0gMe6W8lZYgE9k6Oye3xqWwkMM
         Vgb+OAhR38BWk4s/4M4yHOJHpvK3czBYVYECdU2enW2CXWwUIF1G4B4e2z2DNzPnlWNF
         +tsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeEEBS1 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 4 May 2018 21:18:27 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50681 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeEEBSZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 May 2018 21:18:25 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, davem@davemloft.net
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 24/24] selftests: net: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:28 -0600
Message-Id: <20180505011328.32078-24-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599584988425484142?=
X-GMAIL-MSGID: =?utf-8?q?1599584988425484142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When net test is skipped because of unmet dependencies and/or unsupported
configuration, it returns 0 which is treated as a pass by the Kselftest
framework. This leads to false positive result even when the test could
not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Kselftest framework SKIP code is 4 and the framework prints appropriate
messages to indicate that the test is skipped.

Change psock_tpacket to use ksft_exit_skip() when a non-root user runs
the test and add an explicit check for root and a clear message, instead
of failing the test when /sys/power/state file open fails.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/net/fib_tests.sh    |  8 +++++---
 tools/testing/selftests/net/netdevice.sh    | 16 +++++++++------
 tools/testing/selftests/net/pmtu.sh         |  5 ++++-
 tools/testing/selftests/net/psock_tpacket.c |  4 +++-
 tools/testing/selftests/net/rtnetlink.sh    | 31 ++++++++++++++++-------------
 5 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 9164e60d4b66..5baac82b9287 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -5,6 +5,8 @@
 # different events.
 
 ret=0
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
 
 VERBOSE=${VERBOSE:=0}
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
@@ -579,18 +581,18 @@ fib_test()
 
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip;
 fi
 
 if [ ! -x "$(command -v ip)" ]; then
 	echo "SKIP: Could not run test without ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 ip route help 2>&1 | grep -q fibmatch
 if [ $? -ne 0 ]; then
 	echo "SKIP: iproute2 too old, missing fibmatch"
-	exit 0
+	exit $ksft_skip
 fi
 
 # start clean
diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index 903679e0ff31..e3afcb424710 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -8,6 +8,9 @@
 # if not they probably have failed earlier in the boot process and their logged error will be catched by another test
 #
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # this function will try to up the interface
 # if already up, nothing done
 # arg1: network interface name
@@ -18,7 +21,7 @@ kci_net_start()
 	ip link show "$netdev" |grep -q UP
 	if [ $? -eq 0 ];then
 		echo "SKIP: $netdev: interface already up"
-		return 0
+		return $ksft_skip
 	fi
 
 	ip link set "$netdev" up
@@ -61,12 +64,12 @@ kci_net_setup()
 	ip address show "$netdev" |grep '^[[:space:]]*inet'
 	if [ $? -eq 0 ];then
 		echo "SKIP: $netdev: already have an IP"
-		return 0
+		return $ksft_skip
 	fi
 
 	# TODO what ipaddr to set ? DHCP ?
 	echo "SKIP: $netdev: set IP address"
-	return 0
+	return $ksft_skip
 }
 
 # test an ethtool command
@@ -84,6 +87,7 @@ kci_netdev_ethtool_test()
 	if [ $ret -ne 0 ];then
 		if [ $ret -eq "$1" ];then
 			echo "SKIP: $netdev: ethtool $2 not supported"
+			return $ksft_skip
 		else
 			echo "FAIL: $netdev: ethtool $2"
 			return 1
@@ -104,7 +108,7 @@ kci_netdev_ethtool()
 	ethtool --version 2>/dev/null >/dev/null
 	if [ $? -ne 0 ];then
 		echo "SKIP: ethtool not present"
-		return 1
+		return $ksft_skip
 	fi
 
 	TMP_ETHTOOL_FEATURES="$(mktemp)"
@@ -176,13 +180,13 @@ kci_test_netdev()
 #check for needed privileges
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 ip link show 2>/dev/null >/dev/null
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without the ip tool"
-	exit 0
+	exit $ksft_skip
 fi
 
 TMP_LIST_NETDEV="$(mktemp)"
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 1e428781a625..7514f93e1624 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -43,6 +43,9 @@
 #	that MTU is properly calculated instead when MTU is not configured from
 #	userspace
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 tests="
 	pmtu_vti6_exception		vti6: PMTU exceptions
 	pmtu_vti4_exception		vti4: PMTU exceptions
@@ -162,7 +165,7 @@ setup_xfrm6() {
 }
 
 setup() {
-	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return 1
+	[ "$(id -u)" -ne 0 ] && echo "  need to run as root" && return $ksft_skip
 
 	cleanup_done=0
 	for arg do
diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 7f6cd9fdacf3..7ec4fa4d55dc 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -60,6 +60,8 @@
 
 #include "psock_lib.h"
 
+#include "../kselftest.h"
+
 #ifndef bug_on
 # define bug_on(cond)		assert(!(cond))
 #endif
@@ -825,7 +827,7 @@ static int test_tpacket(int version, int type)
 		fprintf(stderr, "test: skip %s %s since user and kernel "
 			"space have different bit width\n",
 			tpacket_str[version], type_str[type]);
-		return 0;
+		return KSFT_SKIP;
 	}
 
 	sock = pfsocket(version);
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index e6f485235435..fb3767844e42 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -7,6 +7,9 @@
 devdummy="test-dummy0"
 ret=0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 # set global exit status, but never reset nonzero one.
 check_err()
 {
@@ -333,7 +336,7 @@ kci_test_vrf()
 	ip link show type vrf 2>/dev/null
 	if [ $? -ne 0 ]; then
 		echo "SKIP: vrf: iproute2 too old"
-		return 0
+		return $ksft_skip
 	fi
 
 	ip link add "$vrfname" type vrf table 10
@@ -409,7 +412,7 @@ kci_test_encap_fou()
 	ip fou help 2>&1 |grep -q 'Usage: ip fou'
 	if [ $? -ne 0 ];then
 		echo "SKIP: fou: iproute2 too old"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns exec "$testns" ip fou add port 7777 ipproto 47 2>/dev/null
@@ -444,7 +447,7 @@ kci_test_encap()
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP encap tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns exec "$testns" ip link set lo up
@@ -469,7 +472,7 @@ kci_test_macsec()
 	ip macsec help 2>&1 | grep -q "^Usage: ip macsec"
 	if [ $? -ne 0 ]; then
 		echo "SKIP: macsec: iproute2 too old"
-		return 0
+		return $ksft_skip
 	fi
 
 	ip link add link "$devdummy" "$msname" type macsec port 42 encrypt on
@@ -511,14 +514,14 @@ kci_test_gretap()
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP gretap tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip link help gretap 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: gretap: iproute2 too old"
 		ip netns del "$testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel
@@ -561,14 +564,14 @@ kci_test_ip6gretap()
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP ip6gretap tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip link help ip6gretap 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: ip6gretap: iproute2 too old"
 		ip netns del "$testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel
@@ -611,13 +614,13 @@ kci_test_erspan()
 	ip link help erspan 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: erspan: iproute2 too old"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP erspan tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel erspan v1
@@ -676,13 +679,13 @@ kci_test_ip6erspan()
 	ip link help ip6erspan 2>&1 | grep -q "^Usage:"
 	if [ $? -ne 0 ];then
 		echo "SKIP: ip6erspan: iproute2 too old"
-		return 1
+		return $ksft_skip
 	fi
 
 	ip netns add "$testns"
 	if [ $? -ne 0 ]; then
 		echo "SKIP ip6erspan tests: cannot add net namespace $testns"
-		return 1
+		return $ksft_skip
 	fi
 
 	# test native tunnel ip6erspan v1
@@ -762,14 +765,14 @@ kci_test_rtnl()
 #check for needed privileges
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
-	exit 0
+	exit $ksft_skip
 fi
 
 for x in ip tc;do
 	$x -Version 2>/dev/null >/dev/null
 	if [ $? -ne 0 ];then
 		echo "SKIP: Could not run test without the $x tool"
-		exit 0
+		exit $ksft_skip
 	fi
 done
 
-- 
2.14.1

