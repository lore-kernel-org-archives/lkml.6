Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtS8kYWgYGuDGo3gZOYOnuHSRsHvsvBRzDDje8rfmbzg3EUNMiV/OsQXcKyvOpn79BKaR8p
ARC-Seal: i=1; a=rsa-sha256; t=1520451731; cv=none;
        d=google.com; s=arc-20160816;
        b=MvXJRJj+rM/n1XLrtyKOTeXlPT/Zg/wjpjriX/Wld3W5wBSWkg1k16MCVxZ2DxGlOS
         KEQPcXjR2U+P7BPqr5fAu64R/aNx+Kle3tfq5Q7i9Yv58Mdlr+/Cz7eCL+Uaj0mKTLSj
         Pl01oJNN1BZE3uVhV1ib4d6Wis6yAYZWsibp1jcjI+ubhrhGYnCOatO3XTvpovJhgk/6
         eUosPNDkskBqx2iHd/uVtS7heRiLGI4ku87E/XQG/DJqszqfMdgwm7+g7OSmsrNqJlfF
         LWzac4WDc7pmvPMBNcqv9+Sz4+13Pv4l58KK4h1xNDzetMucsy9MbiqeF5XEmH3O0Pwc
         Zwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OkFB7fPPW26ETVNW3/QkEFstsJDzz04Ikeb1wBMhIAU=;
        b=BDYuji6DMYZQUIkUvLyBrs5eVlgFZ+6Y7MSqsHw3cAGq9/OyBp25TA0YIvJnI9icMD
         M8KXkJq+0bb/kq15yu2ucjLRSLcbr7xQWGgM6eUqXaCPeDcA62A4lSaJ4QtT/r/JlpNc
         K1GErq6wkVxSMZZ4wrIK2S5iGnZljBhW/dYiUJopMwefGz7Lcol55CujmbBYxSSvAmJA
         mMDGXIWBL5pMBuKu13xFlQhU0JUfbDBzvrwJUtaO4zdEvc7Dz7+P7vhilcdES7lC86SJ
         +KMaEC+mEUEVlgVl2qXngb+ZFemj5V5OjLfHcq+aZC3xLxSMDkkmkERb/k6X43k1K1Gw
         TGtw==
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
Subject: [PATCH 4.15 037/122] x86/platform/intel-mid: Handle Intel Edison reboot correctly
Date: Wed,  7 Mar 2018 11:37:29 -0800
Message-Id: <20180307191734.481579047@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309195146913046?=
X-GMAIL-MSGID: =?utf-8?q?1594309195146913046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
