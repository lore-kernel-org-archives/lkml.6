Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeEaDBk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:01:40 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50142 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932633AbeEaDBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:01:36 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org, valentina.manea.m@gmail.com
Cc: gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: add test for USB over IP driver
Date: Wed, 30 May 2018 21:00:57 -0600
Message-Id: <20180531030057.32442-1-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test for USB over IP driver. This test runs several tests on a device
specified in the -b <busid> argument and path to the usbip tools.

usbip_test.sh -b <busid> -p <usbip tools path>

e.g:
cd tools/testing selftests/drivers/usb/usbip
sudo ./usbip_test.sh -b 3-10.2 -p <yoursrctree>/tools/usb/usbip

This test should be run as root and user should build usbip tools before
running the test.

The usbip test isn't included in the Kselftest run as it requires user to
specify a device to run tests on.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 MAINTAINERS                                        |   1 +
 .../selftests/drivers/usb/usbip/usbip_test.sh      | 198 +++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/usb/usbip/usbip_test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index ca4afd68530c..708b681a6fbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14661,6 +14661,7 @@ S:	Maintained
 F:	Documentation/usb/usbip_protocol.txt
 F:	drivers/usb/usbip/
 F:	tools/usb/usbip/
+F:	tools/testing/selftests/drivers/usb/usbip/
 
 USB PEGASUS DRIVER
 M:	Petko Manolov <petkan@nucleusys.com>
diff --git a/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
new file mode 100755
index 000000000000..1893d0f59ad7
--- /dev/null
+++ b/tools/testing/selftests/drivers/usb/usbip/usbip_test.sh
@@ -0,0 +1,198 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+usage() { echo "usbip_test.sh -b <busid> -p <usbip tools path>"; exit 1; }
+
+while getopts "h:b:p:" arg; do
+    case "${arg}" in
+	h)
+	    usage
+	    ;;
+	b)
+	    busid=${OPTARG}
+	    ;;
+	p)
+	    tools_path=${OPTARG}
+	    ;;
+	*)
+	    usage
+	    ;;
+    esac
+done
+shift $((OPTIND-1))
+
+if [ -z "${busid}" ]; then
+	usage
+fi
+
+echo "Running USB over IP Testing on $busid";
+
+test_end_msg="End of USB over IP Testing on $busid"
+
+if [ $UID != 0 ]; then
+	echo "Please run usbip_test as root [SKIP]"
+	echo $test_end_msg
+	exit $ksft_skip
+fi
+
+echo "Load usbip_host module"
+if ! /sbin/modprobe -q -n usbip_host; then
+	echo "usbip_test: module usbip_host is not found [SKIP]"
+	echo $test_end_msg
+	exit $ksft_skip
+fi
+
+if /sbin/modprobe -q usbip_host; then
+	/sbin/modprobe -q -r test_bitmap
+	echo "usbip_test: module usbip_host is loaded [OK]"
+else
+	echo "usbip_test: module usbip_host failed to load [FAIL]"
+	echo $test_end_msg
+	exit 1
+fi
+
+echo "Load vhci_hcd module"
+if /sbin/modprobe -q vhci_hcd; then
+	/sbin/modprobe -q -r test_bitmap
+	echo "usbip_test: module vhci_hcd is loaded [OK]"
+else
+	echo "usbip_test: module vhci_hcd failed to load [FAIL]"
+	echo $test_end_msg
+	exit 1
+fi
+echo "=============================================================="
+
+cd $tools_path;
+
+if [ ! -f src/usbip ]; then
+	echo "Please build usbip tools"
+	echo $test_end_msg
+	exit $ksft_skip
+fi
+
+echo "Expect to see export-able devices";
+src/usbip list -l;
+echo "=============================================================="
+
+echo "Run lsusb to see all usb devices"
+lsusb -t;
+echo "=============================================================="
+
+src/usbipd -D;
+
+echo "Get exported devices from localhost - expect to see none";
+src/usbip list -r localhost;
+echo "=============================================================="
+
+echo "bind devices";
+src/usbip bind -b $busid;
+echo "=============================================================="
+
+echo "Run lsusb - bound devices should be under usbip_host control"
+lsusb -t;
+echo "=============================================================="
+
+echo "bind devices - expect already bound messages"
+src/usbip bind -b $busid;
+echo "=============================================================="
+
+echo "Get exported devices from localhost - expect to see exported devices";
+src/usbip list -r localhost;
+echo "=============================================================="
+
+echo "unbind devices";
+src/usbip unbind -b $busid;
+echo "=============================================================="
+
+echo "Run lsusb - bound devices should be rebound to original drivers"
+lsusb -t;
+echo "=============================================================="
+
+echo "unbind devices - expect no devices bound message";
+src/usbip unbind -b $busid;
+echo "=============================================================="
+
+echo "Get exported devices from localhost - expect to see none";
+src/usbip list -r localhost;
+echo "=============================================================="
+
+echo "List imported devices - expect to see none";
+src/usbip port;
+echo "=============================================================="
+
+echo "Import devices from localhost - should fail with no devices"
+src/usbip attach -r localhost -b $busid;
+echo "=============================================================="
+
+echo "bind devices";
+src/usbip bind -b $busid;
+echo "=============================================================="
+
+echo "List imported devices - expect to see exported devices";
+src/usbip list -r localhost;
+echo "=============================================================="
+
+echo "List imported devices - expect to see none";
+src/usbip port;
+echo "=============================================================="
+
+echo "Import devices from localhost - should work"
+src/usbip attach -r localhost -b $busid;
+echo "=============================================================="
+
+echo "List imported devices - expect to see imported devices";
+src/usbip port;
+echo "=============================================================="
+
+echo "Import devices from localhost - expect already imported messages"
+src/usbip attach -r localhost -b $busid;
+echo "=============================================================="
+
+echo "Un-import devices";
+src/usbip detach -p 00;
+src/usbip detach -p 01;
+echo "=============================================================="
+
+echo "List imported devices - expect to see none";
+src/usbip port;
+echo "=============================================================="
+
+echo "Un-import devices - expect no devices to detach messages";
+src/usbip detach -p 00;
+src/usbip detach -p 01;
+echo "=============================================================="
+
+echo "Detach invalid port tests - expect invalid port error message";
+src/usbip detach -p 100;
+echo "=============================================================="
+
+echo "Expect to see export-able devices";
+src/usbip list -l;
+echo "=============================================================="
+
+echo "Remove usbip_host module";
+rmmod usbip_host;
+
+echo "Run lsusb - bound devices should be rebound to original drivers"
+lsusb -t;
+echo "=============================================================="
+
+echo "Run bind without usbip_host - expect fail"
+src/usbip bind -b $busid;
+echo "=============================================================="
+
+echo "Run lsusb - devices that failed to bind aren't bound to any driver"
+lsusb -t;
+echo "=============================================================="
+
+echo "modprobe usbip_host - does it work?"
+/sbin/modprobe usbip_host
+echo "Should see -busid- is not in match_busid table... skip! dmesg"
+echo "=============================================================="
+dmesg | grep "is not in match_busid table"
+echo "=============================================================="
+
+echo $test_end_msg
-- 
2.14.1
