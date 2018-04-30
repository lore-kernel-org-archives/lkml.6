Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpt+08AKIlg59Ai/N3L+tPOrLhcNYIr/KGfehPd4g4IVHa+l+N1EyDa56vtFlZbo2bdfdM2
ARC-Seal: i=1; a=rsa-sha256; t=1525116455; cv=none;
        d=google.com; s=arc-20160816;
        b=MFgqJ33YB2MfCq4T2f18U6f5il4iOqNlq+nYKvjfcGGikMbMvWsfdFLAWI34OPaRvM
         dIt6hnDreOPiqbaVLlP1Lyca4npVRgxzCs/QD9M+2/QMq1o0RGVQDHurzWX6AKn4VTOc
         Dtq77kY2flVNTKmrMsncviTm41AjySQzZE9PEEkyipWX9n6faybZE4dkfGBZOSi1ahsY
         5KdOhgJ78RhS3nTSKao2zkT5RDE+U2GceaK+ejzt4JP+IBqsm9UbOoTOpMm0n9jCBG58
         DUukJ6w2ec64BWuTl4iTIq98XvJ+aSzrgE16IvLW8dUL3TGAkewe/E+gHvMWdij4VlqX
         l5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qNKZRCbxkxcBmq+5QmS7FYkXzOYxHk+1cuEMzG9Vf9U=;
        b=lmPU/53kkEzsfE6lqbQiv2PIgcUDU82fwuQ14RKvidhTCDTkhsZVa2tVqNyOaA8OGq
         QzwWoFFWSr/6iCMXWXuMvWfK0IJJQd2rBpmWcmneLFyfR15sQnXei0qWsNwC2m+LUqSv
         rttsh0HAZPCb2EaUoHhmMWlACgExgo/hzfcOh9OGRtd/CSr7zdr4kBZGzeX38KuHhmEr
         FRBogMhq13Vxtwl/LluHnqmFbGHYbV1hc5ACjLkknVrtC6gkusyV6ZowVm7+6PFcAp0b
         kXS5fkSpiK+aQa8V6rW1b4/IkkSuxifZtBYVPtUf/GwjBuRNRDJdEsQj2v0oALx80XPY
         91PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D2522DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 65/91] ARM: amba: Fix race condition with driver_override
Date: Mon, 30 Apr 2018 12:24:47 -0700
Message-Id: <20180430184007.550418127@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200466223284776?=
X-GMAIL-MSGID: =?utf-8?q?1599200512133921195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6a7228d90d42bcacfe38786756ba62762b91c20a upstream.

The driver_override implementation is susceptible to a race condition
when different threads are reading vs storing a different driver
override.  Add locking to avoid this race condition.

Cfr. commits 6265539776a0810b ("driver core: platform: fix race
condition with driver_override") and 9561475db680f714 ("PCI: Fix race
condition with driver_override").

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -69,8 +69,12 @@ static ssize_t driver_override_show(stru
 				    struct device_attribute *attr, char *buf)
 {
 	struct amba_device *dev = to_amba_device(_dev);
+	ssize_t len;
 
-	return sprintf(buf, "%s\n", dev->driver_override);
+	device_lock(_dev);
+	len = sprintf(buf, "%s\n", dev->driver_override);
+	device_unlock(_dev);
+	return len;
 }
 
 static ssize_t driver_override_store(struct device *_dev,
@@ -78,7 +82,7 @@ static ssize_t driver_override_store(str
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
-	char *driver_override, *old = dev->driver_override, *cp;
+	char *driver_override, *old, *cp;
 
 	if (count > PATH_MAX)
 		return -EINVAL;
@@ -91,12 +95,15 @@ static ssize_t driver_override_store(str
 	if (cp)
 		*cp = '\0';
 
+	device_lock(_dev);
+	old = dev->driver_override;
 	if (strlen(driver_override)) {
 		dev->driver_override = driver_override;
 	} else {
 	       kfree(driver_override);
 	       dev->driver_override = NULL;
 	}
+	device_unlock(_dev);
 
 	kfree(old);
 
