Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226W2rObVVWTg/t+DDIX0OknOa1Ec5HV65HeITSlQGeD8MzTv62gVwhGwitWOnJ0DVxc5P+C
ARC-Seal: i=1; a=rsa-sha256; t=1517855200; cv=none;
        d=google.com; s=arc-20160816;
        b=0fN6WeflL9LASFnU3dwbAAqnml1LQ22VT7CKfQnovvb2bpi8gvm9/Lo90kzxe9NAIg
         p/G0oUGnHrun0OyOBKxspPrik8lS0auz7YRIgPmXzHgtBcw0YbEvevkCBtWMRLbSQMMX
         JU6jobCjVTJlP8K+G7n2wXb7Mj/yftLI6hLTIXF7G2kyrmZ6GQMN7E0TQl0WnfIrBi0y
         IaOZBFehWJnaDSD2UdraaznPwttMIq/oUDXYmHS8lTTVcapQZECGZvKz5I/BmIvj/uDn
         3MCe6wqWY/xuN0PgSl6T89AX8rQ3MGHneS7xoCgnppvfrOEjjC7GHw/4Twx6Rjd+k7pE
         EGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GbuENqsHb5wtaiLt+l3ztwLtau2zNsEKPAjaSEj+Bd0=;
        b=aR6qdg/9sq2jA/WAoyu4eFzMVF4dnHYXBDpgcww139v35WH/ZJellO1NhfZ89nLHbT
         ERbHF8wZDLB9EKJvi+4AJfhkeF5mefx9uI7bqGWMLY3wDfH3pp5L7vKiUE8g4radHJEb
         2OIvF5ApzdpFU4luckd5aoXLGMvMU40afLdsl3PJA1zPvQHYPc6ossH/T9qkKsUp4DJG
         Cvu6Br2zy23uKPX/Vg++cTfFGn7d4oBV30JCWlRQqDOnoqpoM+9NikA3MhEj7U2VKrWB
         vsxqFHa6sZcv0exdlILMhtlF+QJJ/aaUs7H9IOVU+E0WJxOwgatcatGU/z7jGzfYcRKK
         vCFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 24/36] staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID
Date: Mon,  5 Feb 2018 10:23:52 -0800
Message-Id: <20180205182352.772803284@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586534802592888?=
X-GMAIL-MSGID: =?utf-8?q?1591586534802592888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1396,19 +1396,13 @@ static int rtw_wx_get_essid(struct net_d
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
