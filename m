Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+W+97mcft/JZre5EMS97vm6t1RyvQApUM9RsBCZNxAfI9L2e70AmGiut4MBa/ZRt5NhzHS
ARC-Seal: i=1; a=rsa-sha256; t=1524405367; cv=none;
        d=google.com; s=arc-20160816;
        b=xyeoe1SSNAYKwuuhk82s7684sdoYCPnB8yK6qSvlKyj+f2eI7Ap3ichAZjMLeMe75o
         Sp/dysaG4vNmqa+PPVgUcCTCKB11lZDW1R47IbXwxswaVYTWHCY5JrJYhANJ1PcgKshp
         zs4InQu7gRRsG+b+JFt8sijKsCdh5qJB3Y4BGo5l2k/Bq6aWwt3Ne1x21s07jlZX4cd+
         GNaTA1hDa1F+s2hyH1T99areBl9DMFe9zuW0kdYpjL42CA13Ka1ovNsU98ljiFvb5A3W
         iP+HR8j+zUAqU0pxq018mVZf1IpPLl7k5TFJSwyoMh73YDMgd80CxRe0ViBmajYjfZHX
         H2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vOom//KUqaMu47U/mqEZYrdBk5E8FFC5/O43m9EZSCo=;
        b=V7nVKqHenZ5G4TOB6BmIeCN4sRgM2oM4vUqfR6/as9ik3PB33nwwKovsHqjhlPSq33
         W7JmniJe8bTxN9dxHeozA6omeWUSRIU+ijFqyiHjOQZ9tx7sON96S7YDYCyflFs84WFT
         lepwmrC6O6K9it2d875ODheeLd/5n/+Hp22MXl3/S4APqMAtHDNGCmhhyYFu/3OjMiLm
         yTM6fT8IAAfB+Afib7rNKFAY3301tsBdEhizHdY1P0dZajgyJiICnYUnnWxF80dqm79Q
         GVduNuNhS75mn1GUjkDydY1pazCIeALLRYB++vHAb7q5iqrO0Xoy2esZwMLifa+OxZN2
         Vq1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Erik Schmauss <erik.schmauss@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.16 039/196] acpi, nfit: rework NVDIMM leaf method detection
Date: Sun, 22 Apr 2018 15:50:59 +0200
Message-Id: <20180422135106.106592879@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454883075568233?=
X-GMAIL-MSGID: =?utf-8?q?1598454883075568233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 466d1493ea830789a2f063f478aaed2e324f0d3d upstream.

Some BIOSen do not handle 0-byte transfer lengths for the _LSR and _LSW
(label storage read/write) methods. This causes Linux to fallback to the
deprecated _DSM path, or otherwise disable label support.

Introduce acpi_nvdimm_has_method() to detect whether a method is
available rather than calling the method, require _LSI and _LSR to be
paired, and require read support before enabling write support.

Cc: <stable@vger.kernel.org>
Fixes: 4b27db7e26cd ("acpi, nfit: add support for the _LS...")
Suggested-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   41 +++++++++++++++++++++--------------------
 drivers/acpi/nfit/nfit.h |    5 ++---
 2 files changed, 23 insertions(+), 23 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -196,7 +196,7 @@ static int xlat_nvdimm_status(struct nvd
 		 * In the _LSI, _LSR, _LSW case the locked status is
 		 * communicated via the read/write commands
 		 */
-		if (nfit_mem->has_lsi)
+		if (nfit_mem->has_lsr)
 			break;
 
 		if (status >> 16 & ND_CONFIG_LOCKED)
@@ -483,7 +483,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 			min_t(u32, 256, in_buf.buffer.length), true);
 
 	/* call the BIOS, prefer the named methods over _DSM if available */
-	if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE && nfit_mem->has_lsi)
+	if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE && nfit_mem->has_lsr)
 		out_obj = acpi_label_info(handle);
 	else if (nvdimm && cmd == ND_CMD_GET_CONFIG_DATA && nfit_mem->has_lsr) {
 		struct nd_cmd_get_config_data_hdr *p = buf;
@@ -1654,12 +1654,23 @@ static void acpi_nvdimm_notify(acpi_hand
 	device_unlock(dev->parent);
 }
 
+static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
+{
+	acpi_handle handle;
+	acpi_status status;
+
+	status = acpi_get_handle(adev->handle, method, &handle);
+
+	if (ACPI_SUCCESS(status))
+		return true;
+	return false;
+}
+
 static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 		struct nfit_mem *nfit_mem, u32 device_handle)
 {
 	struct acpi_device *adev, *adev_dimm;
 	struct device *dev = acpi_desc->dev;
-	union acpi_object *obj;
 	unsigned long dsm_mask;
 	const guid_t *guid;
 	int i;
@@ -1732,25 +1743,15 @@ static int acpi_nfit_add_dimm(struct acp
 					1ULL << i))
 			set_bit(i, &nfit_mem->dsm_mask);
 
-	obj = acpi_label_info(adev_dimm->handle);
-	if (obj) {
-		ACPI_FREE(obj);
-		nfit_mem->has_lsi = 1;
-		dev_dbg(dev, "%s: has _LSI\n", dev_name(&adev_dimm->dev));
-	}
-
-	obj = acpi_label_read(adev_dimm->handle, 0, 0);
-	if (obj) {
-		ACPI_FREE(obj);
-		nfit_mem->has_lsr = 1;
+	if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
+			&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
 		dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
+		nfit_mem->has_lsr = true;
 	}
 
-	obj = acpi_label_write(adev_dimm->handle, 0, 0, NULL);
-	if (obj) {
-		ACPI_FREE(obj);
-		nfit_mem->has_lsw = 1;
+	if (nfit_mem->has_lsr && acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
 		dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
+		nfit_mem->has_lsw = true;
 	}
 
 	return 0;
@@ -1839,10 +1840,10 @@ static int acpi_nfit_register_dimms(stru
 			cmd_mask |= nfit_mem->dsm_mask & NVDIMM_STANDARD_CMDMASK;
 		}
 
-		if (nfit_mem->has_lsi)
+		if (nfit_mem->has_lsr) {
 			set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
-		if (nfit_mem->has_lsr)
 			set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
+		}
 		if (nfit_mem->has_lsw)
 			set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
 
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -171,9 +171,8 @@ struct nfit_mem {
 	struct resource *flush_wpq;
 	unsigned long dsm_mask;
 	int family;
-	u32 has_lsi:1;
-	u32 has_lsr:1;
-	u32 has_lsw:1;
+	bool has_lsr;
+	bool has_lsw;
 };
 
 struct acpi_nfit_desc {
