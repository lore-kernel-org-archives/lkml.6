Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpUHqjX1EdbJvK+7vw3yhQuj7umZf9OlFbki0LXNHcSZWFTRLF47NIQsCUn/YArXvjvuEM2
ARC-Seal: i=1; a=rsa-sha256; t=1524838392; cv=none;
        d=google.com; s=arc-20160816;
        b=XGcv8LQ/aKDZ0qbIzQmo/9Re6zBA4LsNpzCUucBz0Ie0X1ZF8h5Jq4kMmubrJO8Gkb
         lfcRZv/MKnBTBsYbg5bSLKCbLc13Mm/cBAU05gW6AJwMIeOu3HqjXeM+VNYejPHGCMq9
         RExUkxn3yFVQWY7xQ3znNn1vVcVMnuMOWTZU7IQ/dEyD77AhscbSUfuDZCQASxDPz4J4
         /t3egfHQHsFEcmZH31slEk0/9Ma4Z2lUMCXpcoBTbxKMWJD4fv7FmVMJe72da/Fbo/un
         jqmypiMykZUqK6M3gEDmCLeziVqJzdHKcOPZRoKDS+MYuU7zSmNo4oBwzjwJ/kRX1JXG
         GKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=gZOJ20C0vHgF4WpZY1IYK5KCUQkkXFrMii4TxLZ5Do4=;
        b=ypcqxSCMKGwH1GXpdxOaIo22TwQsZYUYKsaTX65aAznZ591uf1zVIT1FbO7Ugzq62X
         I/SICEJIaYXj6M4ifmOVO92Pnh8MGe+15rxxSY2VO+QV9hJIY+lP0YId55snpAij/0/o
         ZGKGJFnc55i45TtpFRPVB7q695B1eyHVbZ2nJXGQOKKY9YDJwx5B27BlqRuxXzg6seXW
         4dtCIsoP+YqC2xDWUvIVo2LzQA+t3OnDh/DpWOsTWNEBiWAMqLcfACSohxBZS+D//H1K
         EJRlJdCLEoXG/QwNg7pjpvrNWMTxAopAmSdtJxjOrCmZsAztgbOX0muS0dol7jnrqNCN
         +C6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94794218D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.16 75/81] hwmon: (k10temp) Add support for AMD Ryzen w/ Vega graphics
Date: Fri, 27 Apr 2018 15:59:17 +0200
Message-Id: <20180427135747.622914704@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908942236940259?=
X-GMAIL-MSGID: =?utf-8?q?1598908942236940259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 877d8948d0aa402fbbede138fc73432bb335b65f upstream.

Enable k10temp for AMD Ryzen APUs w/ Vega Mobile Gfx.

Based on patch from René Rebe <rene@exactcode.de>. Dropped temperature
offsets since those are not supposed to apply for the affected CPUs.

Cc: stable@vger.kernel.org # v4.16+
Cc: René Rebe <rene@exactcode.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -40,6 +40,10 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #endif
 
+#ifndef PCI_DEVICE_ID_AMD_17H_RR_NB
+#define PCI_DEVICE_ID_AMD_17H_RR_NB	0x15d0
+#endif
+
 /* CPUID function 0x80000001, ebx */
 #define CPUID_PKGTYPE_MASK	0xf0000000
 #define CPUID_PKGTYPE_F		0x00000000
@@ -298,6 +302,7 @@ static const struct pci_device_id k10tem
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_RR_NB) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
