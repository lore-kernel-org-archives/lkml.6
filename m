Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqHMN1wWtIpX70zhMIoDmzV1hV1sgxQSItZYr8UOYv8AG4lC9Qsq+A7rCcrSQrtJw78hUnv
ARC-Seal: i=1; a=rsa-sha256; t=1525116472; cv=none;
        d=google.com; s=arc-20160816;
        b=ZPaJrBDbOg86ID1EJhdBUeZmAsBSDA6RXsS77Zzq8udXbA6f5tURcw95X9iECuuPp2
         qT5rZeNDQH0POzx115EY15LpICS9PJowEZ1ei5MmoilzvevxtXv5/VmV5eRh4n6viL1V
         6hO+c8CdgBFrzvbnkslZXQb22J/EwFSLW1z1Us7QkTJF7CMi1G4b0X0nL+pmPvMUawD8
         eVXxBkimRC69FnQIOzROpDqbwzyndww4iYe9IsoDdkLIrhwoaS595b8PwNXNY0dljapc
         WF35QLtkRDPqyugiDsI5Gm/XgX8TyL+rAwx0IN/6fFMKW+wSyz4UWnKTyjFrj4AOJUhE
         JEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zeFyEbiJzp5mcQzsGCGVDe5RpVHrq6PS7+a549i5H7I=;
        b=hj2Soh8T/4nE7cSeXSk71+VHzpw4ZH2uBS2XBwIgXDIGk92O+LPbQdKBG9QVhBSfZN
         dUGNEobLdl+FkLmZ1luQTsEuPeWV6wRE5yCMX0DRS6QJmm11koYeFQRX9UkViVl0Rw4B
         DexpH5SOYWfA7E/7xV2dydSG1wdPUK11B6B/KoIut6FWJ/iyxDqF913xvq6soI21ZOtt
         LwJcAzePJ+HgNRd6MaOnZtGLJwcmrR2OD+qJdP+NJadt3f9eTnGxiIkTUgxrO0V1wo/R
         YgRNzo625RFQ+lxTwQXkrkV+cbsq+sCy4gU1vfg2nhyQRTmiGDmCr4X+2mjVKy/eN7pZ
         wBUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A510622DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 64/91] ARM: amba: Make driver_override output consistent with other buses
Date: Mon, 30 Apr 2018 12:24:46 -0700
Message-Id: <20180430184007.499428338@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200414584259129?=
X-GMAIL-MSGID: =?utf-8?q?1599200529972367189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 5f53624662eaac89598641cee6cd54fc192572d9 upstream.

For AMBA devices with unconfigured driver override, the
"driver_override" sysfs virtual file is empty, while it contains
"(null)" for platform and PCI devices.

Make AMBA consistent with other buses by dropping the test for a NULL
pointer.

Note that contrary to popular belief, sprintf() handles NULL pointers
fine; they are printed as "(null)".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -70,9 +70,6 @@ static ssize_t driver_override_show(stru
 {
 	struct amba_device *dev = to_amba_device(_dev);
 
-	if (!dev->driver_override)
-		return 0;
-
 	return sprintf(buf, "%s\n", dev->driver_override);
 }
 
