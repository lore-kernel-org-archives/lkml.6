Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpfuC9ZBUbA1c3/lfH1bNt3Wz394hyTEKiDckyBk0DC4J4QCxAZQDQ1xfHxwbf7zyBNnlWE
ARC-Seal: i=1; a=rsa-sha256; t=1526281127; cv=none;
        d=google.com; s=arc-20160816;
        b=1CMKgmdRpgMxqjq+gwBVgEJ9SUd0m1sWMFNIagPhKUioQMZJukSXwhTU80Vu3Lha5K
         9tyR/uXkivDJCDnFLtUmmNA0+gEueCDMgsHv2jbxV+7XGWuczTpK5Hz2ijpbewiK/dkg
         t0rHw9as7+nWjrvP/3nViryX6bmBSXSU0M/SlKPQkcW1dbexoqbu+teZL1VUNR4w26Nm
         BILZLWk9a1DoOXYNOK4HGzPgP/oOzukzEum3iDJ0drJ70gPAmERt/YpgdANhTN6qfbhD
         mai5ljOq9hIlvCVtbdXDvFFVHI1DlZxobZWC4mMoW+cd8ShvE1l/4CthKKMOPkgX+r6X
         cM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Qrczj/3/3St/XuzAeFD0rWh/Ooov5NVhBBiHZaFCU/8=;
        b=jlBC84P59cAhnCUnghXU7zwTCIk8DErBlUY6LQHQ7LUO1Iem3Io9OBZFIkCOqKhUlD
         +xp+3ipeylEcikolAg9NGKjmxfoz3DkgRonoAiVlNQvJCc5tsdDwaJkmgSkr+Qxf2eEB
         fMWcp66NJZvH/LaBnNA9aRT01Xt91kVyYRoqhOK9O4CLP4AjdDdbWWiXeycZFKlC+el6
         t2d1D0VvZBP49vPANjUVR7rYV4OY6iwCwNhOaUCNWDl9puANTZD6QesmFrz1K9Sj7OXO
         zJfVj8+6D9uP9MGzg5mjFYTZOAZp80qsYrjyVmo/uHjmpxeSduFpbnp1d43RDzZaF3LX
         7KUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=d3yMt+91;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=d3yMt+91;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.16 27/72] rfkill: gpio: fix memory leak in probe error path
Date: Mon, 14 May 2018 08:48:44 +0200
Message-Id: <20180514064824.201071738@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421258890786882?=
X-GMAIL-MSGID: =?utf-8?q?1600421759779065993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4bf01ca21e2e0e4561d1a03c48c3d740418702db upstream.

Make sure to free the rfkill device in case registration fails during
probe.

Fixes: 5e7ca3937fbe ("net: rfkill: gpio: convert to resource managed allocation")
Cc: stable <stable@vger.kernel.org>	# 3.13
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rfkill/rfkill-gpio.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -137,13 +137,18 @@ static int rfkill_gpio_probe(struct plat
 
 	ret = rfkill_register(rfkill->rfkill_dev);
 	if (ret < 0)
-		return ret;
+		goto err_destroy;
 
 	platform_set_drvdata(pdev, rfkill);
 
 	dev_info(&pdev->dev, "%s device registered.\n", rfkill->name);
 
 	return 0;
+
+err_destroy:
+	rfkill_destroy(rfkill->rfkill_dev);
+
+	return ret;
 }
 
 static int rfkill_gpio_remove(struct platform_device *pdev)
