Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49NztvcCPXEIpdPyI0A6YgulaRe9UdW4TvpkM0dgOZ15Oiay3pa/uPidQKQCCXVZVBKvV7C
ARC-Seal: i=1; a=rsa-sha256; t=1522168318; cv=none;
        d=google.com; s=arc-20160816;
        b=UXThqOBguDU4KoD+dxJ3TyrF3A0/SXVR72ShSojgvVFqseuyIJkMwrUOq/LRe3f+t7
         uEKhC9tpy8/3IXauvNAa8kH2EiRq8XKdG7TLLDDPn0GRFfP8O5gE6ROcWG3CGI/nElvk
         YkpR4nyzYSXxO4MDVXkaqnDyEkjAhbHX8BNErVU2dtNh+Z1O1WZC/INnp8IqPW91EsDX
         QnGPHluY3l0/M69ONdPEve3B5AjKykwH931PGQpdxdfbJzXas+iPyb3VdDqJZo71i751
         pIMGQXtAL2kvJ+b35X57YU+fB/IxQJg9pVKecHJ+QYSun4bmWxbXT/KEJMCnotCJs6ZJ
         yBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BnGjxc2YKBxXIFBsE+pNo+yW4k/OrPqlOwZq/PpFCu8=;
        b=DNA0tg0/uo5lEh8mTr4ew4JRhI+vEh+/dL1K09/I85CWoTfezZGMgCcwXLUD2Cbw11
         GQIdwvlxlfuBX/6vPc653PKDhgeo26X3+lYNIP0w/IEcjDqZ/3EyONP+MpBNhYgYtA/E
         WIW9C6EPuRons1W/uL5cobmfrtZ0M9SrzTr1kOGKiqOZzgXSqgk48ITyxz7pqXVMFyAF
         lTWqnjIAMrtkhkFosd4NDckgCfNsK7uOxrvR1HGXSfll9hmrQnPFXYovzJTT/I2oWgZ3
         FZRQEWGWtig+9QKvuortxosmTDrUx+g5V3SwXY+hrpzG2p7To44xvoh24GqdpLU99bJG
         zU7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	James Cameron <quozl@laptop.org>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 36/67] rtlwifi: rtl8723be: Fix loss of signal
Date: Tue, 27 Mar 2018 18:27:28 +0200
Message-Id: <20180327162728.987281107@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109011873420590?=
X-GMAIL-MSGID: =?utf-8?q?1596109166365571543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 78dc897b7ee67205423dbbc6b56be49fb18d15b5 upstream.

In commit c713fb071edc ("rtlwifi: rtl8821ae: Fix connection lost problem
correctly") a problem in rtl8821ae that caused loss of signal was fixed.
That same problem has now been reported for rtl8723be. Accordingly,
the ASPM L1 latency has been increased from 0 to 7 to fix the instability.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Stable <stable@vger.kernel.org>
Tested-by: James Cameron <quozl@laptop.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -1125,7 +1125,8 @@ static void _rtl8723be_enable_aspm_back_
 
 	/* Configuration Space offset 0x70f BIT7 is used to control L0S */
 	tmp8 = _rtl8723be_dbi_read(rtlpriv, 0x70f);
-	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7));
+	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7) |
+			     ASPM_L1_LATENCY << 3);
 
 	/* Configuration Space offset 0x719 Bit3 is for L1
 	 * BIT4 is for clock request
