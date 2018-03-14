Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521063891; cv=none;
        d=google.com; s=arc-20160816;
        b=KLQ7N0rlaV0Y2jFygag3mFaR7Y4BzliJY3s2Y3WggKgY9SDwVjm7X8ZGeOvA3Olfgw
         ph/Mn0qsWmknVn7z/QnK17n5/Nr5clpJMi6zu1FdglO4A4OgE4AHyN6rG+mUntVnT7RR
         ZN3U+VWoTJCdBJdH0gnzh/I5/E2pMF0Qx2xSkhxoFwSKkwM6mYmAb+p3hualp8qrH7Cf
         ACWpq59RgIfE5LZt8SE2d8e3Ai3B13YWGmsGr2ZyQTC/uhCc4Go86eZAJtlPoPnPWz3W
         /feB6vAS9PyoXCuZDn6woK78XgTKHTfleC70T8tMWbzywwe1xrn4PGkMF+P7ekEzgtUM
         mUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bvb5An+FRd8WBGgHl5jRe+Jtd7dWGgpb2nQ3crP4P2w=;
        b=kqZGDrwBNU8PGDtxfuRA/LPbw7mWWMBxzYmhFs9TkuYM+RLMfkdXBYsMLGEyZrGBnd
         8WCNr+Kz31DmFtet8oKNPy6j3adWjSipIRFVi9bmrZiPxz5+FlJgqjUfp0Vwuw0PFsSy
         RBIZaWShalphCGK/ObwWA8ygNY/KvD3iDeBdkY5oOT22gGTjPcjD72nKC9pteqnh/IAn
         2nyU6g/C6HldL9uoPl+IYu0oYZy2NvCxxjs4soKS/zWpGzO6ObMspRIRuDWgefXx44VO
         Y7PFOXOKlGEj3jALkiKv7Nblr1Z238gDy8Q6WO5B7EDl5Kd5sBmj2SLdQurHluY5ow1n
         NaBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=oKi+lmWN;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=oKi+lmWN;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELt6qnmCUxpJOvYd3p3lbHmDoPSfnUDrgaz+8w4kdcZPcBUAoWp31nhIDW8Zz3AQ3ZO9qJ6J8g==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v2 0/3] Add earlycon support for AMD Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 15:44:35 -0600
Message-Id: <20180314214439.27806-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951091006511765?=
X-GMAIL-MSGID: =?utf-8?q?1594951091006511765?=
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

 drivers/acpi/spcr.c                  | 25 +++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_core.c  |  6 ++++++
 drivers/tty/serial/8250/8250_early.c | 16 ++++++++++++++++
 include/linux/serial_8250.h          |  6 ++++++
 4 files changed, 53 insertions(+)

-- 
2.16.2.804.g6dcf76e118-goog
