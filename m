Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521079488; cv=none;
        d=google.com; s=arc-20160816;
        b=IlToyUd8E3cT41XHOtRIO/wYZ+PMBY+yA7sRmCwzbdCkuypmjFm6gLUSgDqOBjFgp/
         ErZDiHFnII7o+9B7nwqEQNOLF7EGLlV+HkgqQOdKXC+KDsMU9vkyRn18JHkGEruRuuA1
         8SLZzta5xeyFquvwaZVyisv5ux6UkT7EPlxa7bZV2bdlhJkKGPE/lqlAJ2KyIOLE6vxx
         gLX8M2Del/rhvpvNShCzf6RBHtjz2CfQB+pL/QJkqWLDdqXP1Y+4BxFG6cFUxH1tcYCG
         02PrUcQ/txNZNsdtitLeXYdO+/FIYGQEcMCCY5tRqLAa4kXJ1rKvVDgsGTRWERzLqUuu
         TUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=nrvySmGlEuEePiWNYfaGy0dGhn1+zLZNjC4iKX59MTk=;
        b=wFYZbBAzWPfwiIczh1T2nB8eUWmp3ERPTV9R8Tivmnp0OsVNLUY8MhcgB80DIybrfh
         Ghn8zwe9jiYJ6BWSw6eN10BPwgv1t+U1mtySbUm1RAgRL82g6hZcImEbwAVxs/8gWbt1
         AaqDubNdXuD/6jS5d8xeoshA279WmUEN3hMM1r5uwt4z66VQcD9iW0AjwxFPQtI8E1/3
         oiyTMi3o/q1k934gUhczx3abZp7PBNEcA38uSn+rnr0IBr5XpyqDcChacNnkVWD6XU26
         uYLUA+Uq6iVbeyPqA4+q/n+hmDjybNPYVBUfHXr4PDac1OHixrlv21lrhKbWbZI2cVgw
         mVnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Fzl/0jpe;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Fzl/0jpe;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELu+FV3e4N4PXVlWjExlcnjJsm8s9UpvT9LPdBCMvOZzTLeC8AcIGCVmVS9zBoMrKGHgwB1dzQ==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v3 0/3] Add earlycon support for AMD Carrizo / Stoneyridge
Date: Wed, 14 Mar 2018 20:04:42 -0600
Message-Id: <20180315020445.150604-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594951091006511765?=
X-GMAIL-MSGID: =?utf-8?q?1594967445229527777?=
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
