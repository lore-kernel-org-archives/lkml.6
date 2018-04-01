Return-Path: <pmenzel@molgen.mpg.de>
X-Google-Smtp-Source: AIpwx4/F83PhMTCgvMte2G7f91moY9D8H3FuSB8LPGssI2mS+/XswJ1Yz2v1U83SymlBK0/7i4++
ARC-Seal: i=1; a=rsa-sha256; t=1522566676; cv=none;
        d=google.com; s=arc-20160816;
        b=LiS5YNIu4cPgAtYdrBzvkGNvOja3ya5bIfETfE2QC9Vd6fLvLsyah3F5hDcsVT2UsG
         IgAUamYVvzABwuUbZIjH2kIYQk3noONaZ7ThnPK9YO49qpHNakT10dC+CSk5LlE2+DZo
         J76fVtqT5PfdiX+LwvMTLtapLBgBl/29IwxP4ZGvYJp987RzOc0utYZBAIILb6gxCk6R
         vpwyUlrgbKSJ9MA2nswfiQudd+LiiylGEAQMJli5DP1Tdf+JHdyW3pa+WKCBVtYBqwYa
         TApIyJFCg+0EsAT4lfg12kB0pjhKMxBIl83vFR5HZhn7yFHdKxBAV8RFbSScrXvxidxo
         3PZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:mime-version:user-agent:date:message-id:cc:to
         :subject:from:arc-authentication-results;
        bh=3RiNBKm5B1A3SLTd2bVszHexBYvR53bbj2EAO600X9k=;
        b=s/EpCZQ7aZRQ+ZpaKPdR6f2oBQTI8WzXr8kxEh6cxgSdGHGRmFNs4pPrwUGd6LINmm
         mYKjyqiXdfIcHdplqM+RL1sYknlqOIEiMq8rDe+EI3SqyHVuzUl0R9ZaClefjL52XQhu
         0CRZG7FAY8ZApJzSTdYznJbUYfUQ9kQ13t9vIhH3ba8CXPtd8epJhaDFjVgK1aAWzKb7
         C0+LOt9dtrNZSE0fPiOOzhgTuif3SUXEruEwTWKmywDEOKbqxfyWaeEDmRF+vzOnDR3n
         W8M4N/sF1U2pmwLLMGmK5g7KA2+AGBYxK3ELAulByU7vw9h0aTZcyUVBzXwNrM7ufdbi
         DPgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pmenzel@molgen.mpg.de designates 141.14.17.11 as permitted sender) smtp.mailfrom=pmenzel@molgen.mpg.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pmenzel@molgen.mpg.de designates 141.14.17.11 as permitted sender) smtp.mailfrom=pmenzel@molgen.mpg.de
From: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Subject: How to move serial8250_init out of the critical path to decrease boot
 time?
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <e086c888-df77-1fde-e3b8-9246c9ab3377@molgen.mpg.de>
Date: Sun, 1 Apr 2018 09:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C55A42C5E8E528F2DC9C503D"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596526875329028979?=
X-GMAIL-MSGID: =?utf-8?q?1596526875329028979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------C55A42C5E8E528F2DC9C503D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


The goal is to boot a *distribution* Linux kernel as fast as possible. 
(The goal is currently 500 ms.)

With Linux 4.16-rc7, `serial8250_init()` takes almost 34 ms according to 
`initcall_debug` on the laptop TUXEDO Book BU1406 with an Intel Kaby 
Lake processor.

```
[    2.657950] calling  serial8250_init+0x0/0x168 @ 1
[    2.657963] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.692598] initcall serial8250_init+0x0/0x168 returned 0 after 33820 
usecs
```

One problem is, that the distributions do not build this as a module, 
despite more and more devices do not actually have serial connectors, 
but the chipset still exposes them.

What options are there?

1.  Try to probe it asynchronously as in the attached patch, which is 
not tested yet.

2.  Where possible try to deactivate this in the firmware?

3.  Recommend to build this as a module? But this would only fix future 
systems?

4.  Avoid the probe, by have an interface to pass the infomr

5.  Add an option to disable the driver, which could be specified on the 
Linux kernel command line? `8250.disable`?


Kind regards,

Paul

--------------C55A42C5E8E528F2DC9C503D
Content-Type: text/x-patch;
 name="0001-tty-serial-8250-Request-driver-probe-from-an-async-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-tty-serial-8250-Request-driver-probe-from-an-async-t.pa";
 filename*1="tch"

>From 536100229e59d9ff7c910d0c26e1c54a56daba81 Mon Sep 17 00:00:00 2001
From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sun, 1 Apr 2018 08:57:53 +0200
Subject: [PATCH] tty/serial/8250: Request driver probe from an async task

Currently, according to `initcall_debug` running `serial8250_init` takes
around 33 ms on a Lenovo X60 and TUXEDO Book BU1406.

As this is in the critical path, and most distributions do *not* build
*8250* as a module, that means `CONFIG_SERIAL_8250=y`, probe the device
asynchronously, so other tasks are not hold up.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..996de9c78001 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -894,6 +894,7 @@ static struct platform_driver serial8250_isa_driver = {
 	.driver		= {
 		.name	= "serial8250",
 	},
+	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 };
 
 /*
-- 
2.14.1


--------------C55A42C5E8E528F2DC9C503D--
