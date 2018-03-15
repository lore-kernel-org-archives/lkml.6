Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521079481; cv=none;
        d=google.com; s=arc-20160816;
        b=CivXbJeyU4axIIjly154gFv7VZ0RiI0XS/1uMBOJ1xrXdvblc3WSJFH7WIdJqObVFc
         yik6PKJsGyKFQaKIdD6rfWMc3g8oyV5M2JDhKXSyH/k1I90ALWXcROVB5XpT6otoUo4Q
         uzq6c25mRFMVzYx9MxEBBp/R7lImAkEB1BNWgDRVYova42wePej3Oa89/F6xH5dAJlzQ
         En5GhAhAaY2006ygu66bzB9gWdxTmCf2nQ4j3zTZ6cZO1PHWKu1i6YIbVassXIldRDRc
         sB2ebvn861uvQE2qvKFIDHP8RYRes61iFhN7iyt10Olvh493Wfxw1d39Jlfw/tR8PNCc
         jfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=nrvySmGlEuEePiWNYfaGy0dGhn1+zLZNjC4iKX59MTk=;
        b=zH+cvpgOmEyvI9IJ7j+qulH10WfkY8HHM/ihQjINwh3o1A2zwa+FDsIhDkNTkzvCyh
         d5c0HUM9NswpUkDFjODITiMDRWRZp894bRNAUL510L+5zkk0oln6+WxtobjRce8fCG+B
         2V/qDWthWxrPXadBl+8YrFiC3ERG3gomxWR04EUmzPr45n9bcvDvJBOH2OMZyJFaQK4f
         t7y9RMuL0MbfwM9Z+FmrHG+DUT6fDpOHSLspJ/3QpzsSRNCJvGG65i+jfuHIJZyuMQMl
         d7TEEgcLVJUOYlbjM7cXKb/lefZ3uFQgmKWgnGU/se73C2OxgG9WtOhxM3s+TFvRaaPF
         iqHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=XSPheUHh;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=XSPheUHh;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtfQTDizwSnx+AFiaAUvxjNlTwdFkQq2YRszeb4csU722kY280v06W23FDhcJeKmy/93dzbNA==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v3 0/3] Add earlycon support for AMD Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 20:04:33 -0600
Message-Id: <20180315020436.150509-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951091006511765?=
X-GMAIL-MSGID: =?utf-8?q?1594967438719501025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a 48 MHz
input clock.  Currently, there is no way to tell earlycon to use a specific
uart input clock when configuring a baud rate.

Patch 1 adds an earlycon ->setup() callback to set up this clock.  The setup is
triggered on the commandline by specifying "earlycon=amdcz,...".

Patch 2 adds an ACPI SPCR quirk to automatically trigger this hook when the
ACPI SPCR table OEMID field is "AMDCZ ".

Patch 3 adds an additional fix which allows botht the ACPI SPCR quirk and amdcz
->setup() to tell 8250_core to skip initialization of old serial ports that do
not exist on these SoCs.

Daniel Kurtz (3):
  serial: 8250_early: Add earlycon support for AMD Carrizo / Stoneyridge
  ACPI: SPCR: Add support for AMD CT/SZ
  serial: core: Allow skipping old serial port initialization

 drivers/acpi/spcr.c                  | 26 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_core.c  |  6 ++++++
 drivers/tty/serial/8250/8250_early.c | 16 ++++++++++++++++
 include/linux/serial_8250.h          |  2 ++
 4 files changed, 50 insertions(+)

-- 
2.16.2.804.g6dcf76e118-goog
