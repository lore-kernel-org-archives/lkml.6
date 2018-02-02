Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224QuVbF8gGGu79NqKKYvQ2o3tVB6xKh0V5JFabCaVNeOLkmMaF2STmWFOT5Ni/m1KtvmW/A
ARC-Seal: i=1; a=rsa-sha256; t=1517590910; cv=none;
        d=google.com; s=arc-20160816;
        b=wvJrXyJt7aW2p5pwg+Kyb3p8sUwWwRq+eAGQgQKIL+0b/kEyJpZKyBHeHQBX6apv4J
         UH8Ge+sQsdsGWSBLWCRnhCes539gpRiPVDvSJy/KcIb5BwuFXWVoL00zsmQnrtheLL96
         JnVTuuJDPn6WArrWuLN+SVRrmkUCbpdbn7YrQLNnE7DRaJ77L8/KyuGNqsyDMeAiCgE9
         EcwcfpjL795gChK3r2lRH3rntblXdw946agvoho72Pp3q2TEGuyIvJoR8JGO04N/u1dQ
         BL1ymsstNRrZull+VIVdo2Wo28KlPBtDGNg8Sl08ZOCpb0KO7RUstwygFmJmvMsEctNT
         5adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JUN5OmEiFveqs/hzySBkxd78U3zZNFVRvn7zrLacNEk=;
        b=o5kMtifufRZiIMyAcJMJ0uN8EdhG7Umw2tzT4XdC2nEod0z7kxq2NfZ91gRIkGLBPq
         gqilCsTe+jqwRY13mGaXK813k36mcWKxCGYom0kA59SLoFEZrMpLe23SmOghAlGGvkbR
         IiFv6dqMteU0kIIgXg0E5evljhoy7nrrA53SDXrcOZmD1uUzOS95appNrh7g6jp9PrDX
         LUA1fPUYPTm8di5E35EMbRKKK+aYsTDOtCI4ViUNlrvIsR4prO7X2dCuzLjwkOgnk39X
         68RB3jddUihPEe9UOchqEC3YpHzfJh1BcBN8tycLbaeDeJNM0cBltSLrCTAGbLN11FXU
         fCvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 54/67] staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID
Date: Fri,  2 Feb 2018 17:58:23 +0100
Message-Id: <20180202140821.304604726@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309406156908442?=
X-GMAIL-MSGID: =?utf-8?q?1591309406156908442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -1399,19 +1399,13 @@ static int rtw_wx_get_essid(struct net_d
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
