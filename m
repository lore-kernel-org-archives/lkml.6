Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ACqXdWCudEZbEoToMJXJATgJL9fLKfQk+JyjdlkU5Wl9WMHbtKRejB4OWagqYtrVC44C3
ARC-Seal: i=1; a=rsa-sha256; t=1517591574; cv=none;
        d=google.com; s=arc-20160816;
        b=kRV8lMI5f1fqShrp6F53Q0gncKbrlkcK14VCyiX25NOjMj77CvoyKFSO1cL5EcjpBK
         fBgUUa8epoP4baiBCeOGkS4WzB3GYHtZeN9c1XkltUsFCj1TSztcBpxuBDQ/dfaqGuN9
         uni4DTau64GbgOJSjQKmXS9LkE79AP7j/WGAVYrobb5KoTXoknV3YjFItilFBfLu9QEV
         HI1wKgwrLBVAbER+a5+RSrhQT17Nfdi7LDcGQZKnf8zXNOl6tFsZEIYEq4ZJpo7pFj1Z
         DpYRPnUfVdRbBtwan6/OqJDXo54RWHzaa2NXHrnlE6SbbrFQfbCMqIoF8pCIyhAYkpIZ
         3uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ILog2jm4LIT3wJxY5gJEqLek/sorubsj60gXL5gIDdg=;
        b=XV25A51Wmp8igJeRINeKMe/HN7obOMmndtpstkjpysZcSckZruEQJDhoAkWlUag4U4
         5CV9WedWzMnmnoijow5ny9EYxVBaOcj4bojAWSsE/etF9f+i8wQAf4SbJM5hpmcZcTSt
         Gf0hCQPFH6T/LPOunCPdZBWtJi3F9oyTsHlLWmaZkm1P6Aa6HpzPMIWmjEmXOBN0aJ4/
         H2V4k3WRPIATUPNoqJpX9TDfuDjiamO73moEQPGQ6CJjsCAXilE1W7j4jaUtTs6Qj0WS
         cPUtTJYPucRHfe++6N247PvPDR1t7EjRvUEx+kitqn30Oz8UfsVlRrioUrxjOlM9jEv3
         O0Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 126/156] staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID
Date: Fri,  2 Feb 2018 17:58:27 +0100
Message-Id: <20180202140846.076565864@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309406156908442?=
X-GMAIL-MSGID: =?utf-8?q?1591310103375952846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>


[ Upstream commit b77992d2df9e47144354d1b25328b180afa33442 ]

When not associated with an AP, wifi device drivers should respond to the
SIOCGIWESSID ioctl with a zero-length string for the SSID, which is the
behavior expected by dhcpcd.

Currently, this driver returns an error code (-1) from the ioctl call,
which causes dhcpcd to assume that the device is not a wireless interface
and therefore it fails to work correctly with it thereafter.

This problem was reported and tested at
https://github.com/lwfinger/rtl8188eu/issues/234.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1395,19 +1395,13 @@ static int rtw_wx_get_essid(struct net_d
 	if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))) {
 		len = pcur_bss->Ssid.SsidLength;
-
-		wrqu->essid.length = len;
-
 		memcpy(extra, pcur_bss->Ssid.Ssid, len);
-
-		wrqu->essid.flags = 1;
 	} else {
-		ret = -1;
-		goto exit;
+		len = 0;
+		*extra = 0;
 	}
-
-exit:
-
+	wrqu->essid.length = len;
+	wrqu->essid.flags = 1;
 
 	return ret;
 }
