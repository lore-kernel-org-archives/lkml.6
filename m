Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqGpFhNA2asPd+nKPyoBRBCBwDRC9ai2fNK5QxOuy+w7L6Dc8qwwwpMVHb2F6nEZmZtRnJ4
ARC-Seal: i=1; a=rsa-sha256; t=1526937768; cv=none;
        d=google.com; s=arc-20160816;
        b=aAYrRwpYdFoBG1FTjYl8hmvCqu6c3lkn7/yhyyf5PH3aX+ZQGXesNDj3s+ETZkzb55
         lmMogRJNM3c7UNwhcnwOsUPX6386BwLKFALdcz6S6UVyRCIHuKG0xe/hbxStQutHISWV
         mWEDfdBKzdupQkyb0jX3fTCGk4HvUa80X/23rC4IED9Klnde46O4Nyacda4GXwpHG1U1
         ICOcY0OfVNw9IPxQOdQmEbUJSnzZVAUKEpyxQbB0hvUPYn5xLrSL7FDLFDksfnJLwuut
         Bpw09lsuspNaFYJ7NrudQk9F12xr3D08qNbz1mGpYDl6irz3xybp7dGiB84zhTIlYned
         bvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=a3Zy4pJVhRV44sXgbNAn5lV+1tZEHKFzDa6HyDWXjqg=;
        b=tvsP6xjMvbK7PwuOEFgVMs0Sm4A67v6w6CVF/qsv1ssjVL+/ZKpBBNpWWl+OlUFXZ1
         0v5KjBsVK0SGG137NYB3r8xUQ8b9x3r95S59k68kovlHh6SdD8eFfQabWv4B6Xvycsk6
         Ui1uCAzcWOANyxMysdqk44NAklH4fmjqBul7C4v6StMwO6QZA0MCiWgQo6+auHKR7RSz
         P/FTDJb7rmTySQMWISv6ZOISZMX2NkMFqsswNsaSTrPGoAiyEMnMgfML83VikiVvfyPm
         f61/YbbhQKR9BHEv8y00NrNJgTWrLSt7e/el2bhVfY6kbMcSreh+Z1TjPsAzTQ5qmS/c
         g2Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xbLTIoVb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xbLTIoVb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gabriel Craciunescu <nix.or.die@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.16 019/110] hwmon: (k10temp) Fix reading critical temperature register
Date: Mon, 21 May 2018 23:11:16 +0200
Message-Id: <20180521210505.567817304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110297162141760?=
X-GMAIL-MSGID: =?utf-8?q?1601110297162141760?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 40626a1bf657eef557fcee9e1b8ef5b4f5b56dcd upstream.

The HTC (Hardware Temperature Control) register has moved
for recent chips.

Cc: stable@vger.kernel.org # v4.16+
Tested-by: Gabriel Craciunescu <nix.or.die@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -63,10 +63,12 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define  NB_CAP_HTC			0x00000400
 
 /*
- * For F15h M60h, functionality of REG_REPORTED_TEMPERATURE
- * has been moved to D0F0xBC_xD820_0CA4 [Reported Temperature
- * Control]
+ * For F15h M60h and M70h, REG_HARDWARE_THERMAL_CONTROL
+ * and REG_REPORTED_TEMPERATURE have been moved to
+ * D0F0xBC_xD820_0C64 [Hardware Temperature Control]
+ * D0F0xBC_xD820_0CA4 [Reported Temperature Control]
  */
+#define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
 
 /* F17h M01h Access througn SMN */
@@ -74,6 +76,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 struct k10temp_data {
 	struct pci_dev *pdev;
+	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
 	void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
 	int temp_offset;
 	u32 temp_adjust_mask;
@@ -98,6 +101,11 @@ static const struct tctl_offset tctl_off
 	{ 0x17, "AMD Ryzen Threadripper 1910", 10000 },
 };
 
+static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
+{
+	pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
+}
+
 static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
 {
 	pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
@@ -114,6 +122,12 @@ static void amd_nb_index_read(struct pci
 	mutex_unlock(&nb_smu_ind_mutex);
 }
 
+static void read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
+{
+	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
+			  F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
+}
+
 static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 {
 	amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
@@ -160,8 +174,7 @@ static ssize_t show_temp_crit(struct dev
 	u32 regval;
 	int value;
 
-	pci_read_config_dword(data->pdev,
-			      REG_HARDWARE_THERMAL_CONTROL, &regval);
+	data->read_htcreg(data->pdev, &regval);
 	value = ((regval >> 16) & 0x7f) * 500 + 52000;
 	if (show_hyst)
 		value -= ((regval >> 24) & 0xf) * 500;
@@ -181,13 +194,18 @@ static umode_t k10temp_is_visible(struct
 	struct pci_dev *pdev = data->pdev;
 
 	if (index >= 2) {
-		u32 reg_caps, reg_htc;
+		u32 reg;
+
+		if (!data->read_htcreg)
+			return 0;
 
 		pci_read_config_dword(pdev, REG_NORTHBRIDGE_CAPABILITIES,
-				      &reg_caps);
-		pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL,
-				      &reg_htc);
-		if (!(reg_caps & NB_CAP_HTC) || !(reg_htc & HTC_ENABLE))
+				      &reg);
+		if (!(reg & NB_CAP_HTC))
+			return 0;
+
+		data->read_htcreg(data->pdev, &reg);
+		if (!(reg & HTC_ENABLE))
 			return 0;
 	}
 	return attr->mode;
@@ -268,11 +286,13 @@ static int k10temp_probe(struct pci_dev
 
 	if (boot_cpu_data.x86 == 0x15 && (boot_cpu_data.x86_model == 0x60 ||
 					  boot_cpu_data.x86_model == 0x70)) {
+		data->read_htcreg = read_htcreg_nb_f15;
 		data->read_tempreg = read_tempreg_nb_f15;
 	} else if (boot_cpu_data.x86 == 0x17) {
 		data->temp_adjust_mask = 0x80000;
 		data->read_tempreg = read_tempreg_nb_f17;
 	} else {
+		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
 	}
 
