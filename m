Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrlSZRw/BYicsedsE8gIHbnI/I8BYaUT1izDqwLi3feZWhHqNjZk/bk2djxagUx7NA5zZIJ
ARC-Seal: i=1; a=rsa-sha256; t=1526280752; cv=none;
        d=google.com; s=arc-20160816;
        b=rNaKpp4zk/1Q4mL1M0IvFPWz/D+hvKG6+UZ5RPtbfNga1XpQ9PGEWunso2c87dmVXm
         oPcg3KNftf6Pn8JtW0vOuHiv0ovuYfuGn9SmqHS/1p1yxLkTBqtgDcJ6i89pGYhOwZPV
         UkN+cOEUe2V1a3FNwjh1mkM9OumAVns/PLitsciMRRxyi0d66ul+aSmDxV1LSueFukkj
         488IPxNoAmF+HIZ9dXOT9/btDkcPL0vyWxt+/oXyD9vjIKduHMxoV/TFICGYWCQvUy2W
         WPVJp0C2mPuKVQsz9FCcLeBDpGFu9WwlzjDAMzZUb8gAo1fKte7eJJmCNHLyg7AlyDtd
         ae7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=nMkQiLGP8rQHS+NCZmsLsjwxqLWyHC6nSCfogNsPMt4=;
        b=h26XXYJP5Xdi/fkmpshvkM77RykBWxhEGXnjqM/UDOfbdaQ+AlvFff0BuW2dSXQou+
         bRVReopyeI4rW6fR5T+wnOvrL9+JOlVM/VrhqCfTn9CFmPqJkQ0wwYVxwE+8+c6/cNBz
         9PcX9EuVnRX2oDiI6vreZpGduCvUggodGsp8wry+Cjvj8btLSOJSoVCthK3EK6HF5XDT
         KdSe4OHfgY8qLr8AIQkVaKotMgXEGD1qKPj0e0lWrsIvVrRg5LpprRsk5qwnOIMalVfG
         S8Zzr9giSDllZNR5KhSIrT9Z0w76JddmxkKbY62qpufqYn1EaWDI5QNsVXAL/MGm8mC/
         RYsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=d3JEh795;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=d3JEh795;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 44/56] rfkill: gpio: fix memory leak in probe error path
Date: Mon, 14 May 2018 08:48:49 +0200
Message-Id: <20180514064758.856899514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421258890786882?=
X-GMAIL-MSGID: =?utf-8?q?1600421366856364391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -140,13 +140,18 @@ static int rfkill_gpio_probe(struct plat
 
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
