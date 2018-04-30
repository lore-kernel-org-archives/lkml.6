Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrpywy41iPi2cN04VEku+516sAAEsWI5HD4mmQgekWFXYywrAw3sFSIFd5mo1K46CquI2+w
ARC-Seal: i=1; a=rsa-sha256; t=1525116361; cv=none;
        d=google.com; s=arc-20160816;
        b=fVlQqQ4VDWHxIdPj8K1ERU69BZMSp9ECsFc6CctM9sq9TMOdut9gl1YkgsTjHx8FAf
         Quz24ZShpv/Z4TH+03F/7xk13y9P7so0whwzP1KkKfj9CIx0kR0/3iW86DNuZG652Rgf
         3nGx345zl3tSeu9rEhmumAEdRxrfynVZtOOsBo54xz0ARDx7/CWBKqHnOdT8yP/mqlQS
         BpbW4BzzGbxZL9G7+5bIOeXRVBQiylTmoHLTzXyb7K4YRouURg5Q04KGOTk6oeFLBDyg
         jLQtLClBEqnW+p4fx+cKacL9Wl4Htn3RLtOYqHpophZm/lnQHMawQvHhZlfe7CUpnJVU
         m8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=BHlguaX30GCCmKyyp9sQSadzRVkLxBq94P6+lBLVpS8=;
        b=tPxetg2UZDJuPsI+ssBWnzdypT3zH3OLxFxYv1SFXprCsTUHjRkqmwk8dYdBcLJKTT
         NcxxJplBzBTKkCMii4eVfIZVvix1piyhZOogiWAZR4jKw1r7l9HwopZGz42ugPYT2Ozj
         TGUD14mMpMqZuq6ThXLX6kpbwqoLJfsqlwlPXvwi5xie6W3P27mOckOa4+rslxs1sajN
         ciBbR1pfKkDfYWbtdg04EWS353UNxmk6O7z1qvHyHH7zaaxmeV2FsxMrgyJNd8XSGSCN
         Ch4gjzDwILbvKAZuiGUXlxVTP/qc2zsucks7MOJCq0+4qa7KvT3jKxa678wTCqg+gvKv
         PXBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3174622DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.4 35/44] ARM: amba: Make driver_override output consistent with other buses
Date: Mon, 30 Apr 2018 12:24:46 -0700
Message-Id: <20180430190947.731985448@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200414584259129?=
X-GMAIL-MSGID: =?utf-8?q?1599200414584259129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -69,9 +69,6 @@ static ssize_t driver_override_show(stru
 {
 	struct amba_device *dev = to_amba_device(_dev);
 
-	if (!dev->driver_override)
-		return 0;
-
 	return sprintf(buf, "%s\n", dev->driver_override);
 }
 
