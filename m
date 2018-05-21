Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo9/GC/ooIMFrDGAl9ka8FxEHExBEC4s322ZzmoRydmUlMCl2sohEnYE4O7qZL6ATF+nKD4
ARC-Seal: i=1; a=rsa-sha256; t=1526937773; cv=none;
        d=google.com; s=arc-20160816;
        b=dErpT2wlr7XZNs1RZwcjEpXlbCYuiSDacFDB7eMHQgVN9ossASixjr/Ny/mhux0ndu
         4ghK9e1RaRERWinp31qdE6l2W5NnSbuMABKaqHk22C9VgWwAX10Eom8x052AduPsQ6QK
         7A8RX05zqk6IM3XqLbgjwsjzkA+38GAQ7Fj+U3ZNWEaV+xezQ6TgR91zGRXHW8SZ/Xvt
         WIWepGK1BbhVdFzb9v/MqsJU3Ix9rX/QEQyR+HNwLxpx+eeORMZywdl5beqQWlbQFqm+
         zhtjfDZrvolp0MEl/+cO69CVXdg23RCv+B1XpAlUkmKtDJ8BmjttX3RorgJvQrq0G2Wy
         7SIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=id7i4Zn53uZdjAfMEkOclnchlFoWEYALAD1jRP4ns10=;
        b=KKXGkQ9yCAnxH99aBzc4DHoLNtPOqVSOXMQIkzMvDQozhlvHLdCfs4gyug9PSDzrhE
         /aOb33QfoIwAtW1dT0E44vb3rKQ62JHr9YgjS1v3wCCjljVp3ifWpLn/2FxDGualOcZZ
         yquE/myEVxoHcQ2NV79snlGaKDIS5SDr5jQF87nn8HjHTCshpWVFWcqgyop3ZHfdZ+43
         3p0lh3ti3wsVvi68m+Kp9BfkUbfD/yMf8Ti0o2365/3xHMjEM+qgYCz/HfgxlXo2kBJr
         ngkjYoi1Hm1twVURZuVSormF9wBCtE8NPZNuxG91ztK0XRiXDYgFO7527r8D/uImiXRw
         U5vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=t83VfbfW;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=t83VfbfW;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gabriel Craciunescu <nix.or.die@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.16 020/110] hwmon: (k10temp) Use API function to access System Management Network
Date: Mon, 21 May 2018 23:11:17 +0200
Message-Id: <20180521210505.656961106@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110303218100056?=
X-GMAIL-MSGID: =?utf-8?q?1601110303218100056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 3b031622f598481970400519bd5abc2a16708282 upstream.

The SMN (System Management Network) on Family 17h AMD CPUs is also accessed
from other drivers, specifically EDAC. Accessing it directly is racy.
On top of that, accessing the SMN through root bridge 00:00 is wrong on
multi-die CPUs and may result in reading the temperature from the wrong
die. Use available API functions to fix the problem.

For this to work, add dependency on AMD_NB. Also change the Raven Ridge
PCI device ID to point to Data Fabric Function 3, since this ID is used
by the API functions to find the CPU node.

Cc: stable@vger.kernel.org # v4.16+
Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/Kconfig   |    2 +-
 drivers/hwmon/k10temp.c |   11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -272,7 +272,7 @@ config SENSORS_K8TEMP
 
 config SENSORS_K10TEMP
 	tristate "AMD Family 10h+ temperature sensor"
-	depends on X86 && PCI
+	depends on X86 && PCI && AMD_NB
 	help
 	  If you say yes here you get support for the temperature
 	  sensor(s) inside your CPU. Supported are later revisions of
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <asm/amd_nb.h>
 #include <asm/processor.h>
 
 MODULE_DESCRIPTION("AMD Family 10h+ CPU core temperature monitor");
@@ -40,8 +41,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #endif
 
-#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
-#define PCI_DEVICE_ID_AMD_17H_RR_NB	0x15d0
+#ifndef PCI_DEVICE_ID_AMD_17H_M10H_DF_F3
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3	0x15eb
 #endif
 
 /* CPUID function 0x80000001, ebx */
@@ -136,8 +137,8 @@ static void read_tempreg_nb_f15(struct p
 
 static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
 {
-	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0x60,
-			  F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
+	amd_smn_read(amd_pci_dev_to_node_id(pdev),
+		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
 static ssize_t temp1_input_show(struct device *dev,
@@ -322,7 +323,7 @@ static const struct pci_device_id k10tem
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
