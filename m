Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsDYpsX3rB4OpCUXJ73WdAH4e5f7UoXe6BMyP8h/2pke8+Pvh7o5JJe0nQ91nH9AQnokcp6
ARC-Seal: i=1; a=rsa-sha256; t=1520641272; cv=none;
        d=google.com; s=arc-20160816;
        b=Hvnh6LPYgwbQDwHdgEp3E67EAp3zs9JRAyxMrxOGWKdhiY9i89p/WJfG1Kl+NO6iEk
         tVXgtQT1GBEQnTFfECkwNW42ICQVkwM+hdxBGQg6+ZIRBmPcUsnVZIOG4I0635jdBO0n
         szYOsCHtlpfHGBUe8DQ6YqvybfQzf67bz5s0/Ulgh62v30o15hYIVT/l4sYkivDoWzvZ
         r6pPcECupbfJT7cmyl8a9+8AdX6VTmXSOTMHFVQumZjqyLm5kZfrgQJ03wWo8ZLcQ2HS
         W7hp02Usz51wzOyOMSjMe3kYTG2r+/yJHWfjR9jae7QtDRVd07p8/K26xedurk1oSasQ
         agJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Qtxd+m3LGXcFYl/3PP21Z2vYGeA9rOixbjfvrMf70Ws=;
        b=lA5DYecXySxEdCthMp20QElqFqwEIaw8VYMs7OcvGnGCGo1/Da7CfM/FIZ70Cv1x41
         dw50QTzESkQcusT5hDlRWdZBfyGnSsqwXQGquZ9WSehj4EOl64sKX5vZs7qXfxedcMVx
         +o/NXXapjQjY96szoWJ45ThXRVmQWzh5DvpCW7Q6pkIeucB7W8OUD3oMrHJlQbzrVe2h
         uVbdTvathknkzh4DqLUrPRWXiij9Ny0YvsV11TuUXFpz47FWXvDjhBqZaxLGA/uEvyai
         gtwjSRM7/ltd87zI3bIGp2+a4HZqWIiysGB0RVjbzuD0jxzgMXY7b8iKMDddeBR+vFnq
         bG5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Panceac <sebastian@resin.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4.9 16/65] x86/platform/intel-mid: Handle Intel Edison reboot correctly
Date: Fri,  9 Mar 2018 16:18:16 -0800
Message-Id: <20180310001826.303126005@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507942697323637?=
X-GMAIL-MSGID: =?utf-8?q?1594507942697323637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Panceac <sebastian@resin.io>

commit 028091f82eefd5e84f81cef81a7673016ecbe78b upstream.

When the Intel Edison module is powered with 3.3V, the reboot command makes
the module stuck.  If the module is powered at a greater voltage, like 4.4V
(as the Edison Mini Breakout board does), reboot works OK.

The official Intel Edison BSP sends the IPCMSG_COLD_RESET message to the
SCU by default. The IPCMSG_COLD_BOOT which is used by the upstream kernel
is only sent when explicitely selected on the kernel command line.

Use IPCMSG_COLD_RESET unconditionally which makes reboot work independent
of the power supply voltage.

[ tglx: Massaged changelog ]

Fixes: bda7b072de99 ("x86/platform/intel-mid: Implement power off sequence")
Signed-off-by: Sebastian Panceac <sebastian@resin.io>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1519810849-15131-1-git-send-email-sebastian@resin.io
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/platform/intel-mid/intel-mid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -79,7 +79,7 @@ static void intel_mid_power_off(void)
 
 static void intel_mid_reboot(void)
 {
-	intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
+	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
 static unsigned long __init intel_mid_calibrate_tsc(void)
