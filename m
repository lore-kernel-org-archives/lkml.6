Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuWQwWB00PCDj1nk13JxfGDVBguO8Hl+VZkM1cbSrlrbqg+LlVjOuEva3QQUElvjkk4Fd04
ARC-Seal: i=1; a=rsa-sha256; t=1521800304; cv=none;
        d=google.com; s=arc-20160816;
        b=EHf/R1pp29eVtsQzkpJXbymtgK912JGzj5E1/4dL8iwWjHs1flc0TXLLvVLEQlaAY8
         18RfBHzLDnpCiMnrEHY7SeCOaQ2FDRePJKQh2pfmY/sI4CdyMGAnHSFsxru3v1i2cGJ3
         fB2j8m3pjcYSAdsOQ7SbVYGVtTQAPDrbzJ3MlPNqwkhL3JdRfpQ0OuqLiiUtDEbKEn6b
         dBP+Pj/mtu+hrAoxlCgVw1cIozuXJ3UHB5VaRDTaKc4xOnpXfWonXHH6AWbVhTFOBgEC
         XTM2VljnDqLoR8RFZhndB9s6Qc4Afo1q3rKhM2hDceW7o5lvtPiFSpdPScezX569D2Ys
         FQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1TQoPuRHd/4iDYRFrjy7M+k7/Hgq8NYk/KiaWC8KVvE=;
        b=fh7bKp7bk/DpVr6jL9D61XXQ2Lo1XBcFvU1i2J1jVd3YqZF1keI/7ZQFZoAnLiO3qG
         ErbB95lcF4IEGuThRTzhDqvmroVwCmDXf0qsV8XcKrIl57AJ/oIIfeIKslE6spjvfWsm
         JQYfIYKQcIU85qSKdEtPJcfo6lV/Qn8d/6A4uZpA9vPTxSWvhVIJgENTTHnuJKUtu3bE
         mE8sCDi1E2Q7jQWmXV6lg/T5r53ToZPVPXGSfhERe5ME48ufWSGopiTdEqIFhF6wPSST
         ZuPTmtVxyKtrBCcEZpgwt9ST1iRnAJKxFcb3eY74BP/AC28GrQTBUyKay1TAQfE9MGID
         Zxwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Edgar Cherkasov <echerkasov@dev.rtsoft.ru>,
	Michael Brunner <Michael.Brunner@kontron.com>,
	Viktor Krasnov <vkrasnov@dev.rtsoft.ru>,
	Jean Delvare <jdelvare@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 07/47] i2c: i2c-scmi: add a MS HID
Date: Fri, 23 Mar 2018 10:54:58 +0100
Message-Id: <20180323094248.435128683@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722411556560563?=
X-GMAIL-MSGID: =?utf-8?q?1595723275753310523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>


[ Upstream commit e058e7a4bc89104540a8a303682248614b5df6f1 ]

Description of the problem:
 - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
 - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
   Interface Specification, version 1.0": "Each device must specify
   'SMBUS01' as its _HID and use a unique _UID value";
 - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
   and implement "SMB0001" HID instead of "SMBUS01";
 - I speculate that they do this because only "SMB0001" is hard coded in
   Windows SMBus driver produced by Microsoft.

This leads to following situation:
 - SMBus works out of box in Windows but not in Linux;
 - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
   SMBus work in Linux. Moreover the same board vendors complain that
   tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
   and produce errors.  So they need to constantly patch the compiler for
   each new version of BIOS.

As it is very unlikely that BIOS vendors implement a correct HID in
future, I would propose to consider whether it is possible to work around
the problem by adding MS HID to the Linux i2c-scmi driver.

v2: move the definition of the new HID to the driver itself.

Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-scmi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -18,6 +18,9 @@
 #define ACPI_SMBUS_HC_CLASS		"smbus"
 #define ACPI_SMBUS_HC_DEVICE_NAME	"cmi"
 
+/* SMBUS HID definition as supported by Microsoft Windows */
+#define ACPI_SMBUS_MS_HID		"SMB0001"
+
 ACPI_MODULE_NAME("smbus_cmi");
 
 struct smbus_methods_t {
@@ -51,6 +54,7 @@ static const struct smbus_methods_t ibm_
 static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
 	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
 	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
+	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
