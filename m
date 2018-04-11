Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/dfi0mhynPHpautE3FmtlISvmEu5pZ4IFoVf47LL+DGPjTF1KySEanAq6p1RWl2bOZHiHA
ARC-Seal: i=1; a=rsa-sha256; t=1523472978; cv=none;
        d=google.com; s=arc-20160816;
        b=GJZ5qgUpuuFWP4LvrzMFXs2PvSsgnucig2l22iT3lPDm/An5IE08XpXTqLTHr/Ai1j
         3Xpf/by1zaCq6SD9x82kt30lcOs7JONIpLxWp/ynOrko6zVzZamf0WiyTeP3zyVx9wtP
         MgqkQ+pnC5EL4bbD9T23/EW2D7TJ0QPuXnbvyV4N7qf+HLYBxoGoRTcXRLSHnv8t2ZhH
         iPUNJ/N/p66tpzWc+m24UJlv8TBo7MW0zeWrrjqrYJAxuZxybmekVSdfNobbJ3agGOvM
         r82QIVLYHq6CA+trJbAXWHkMW4kZSM+IdXmKeGU51eIFiRqlrorKzk54aDQt3o+G+C/P
         U89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WdFpS5hCxzXu0DbERmYaU7a30Pdytc70kNym+laUC24=;
        b=U0ut0YWi2bExnSurSxAzGkiJJqGMnzUVJD6N7F4F4B0TaiNNfeNNeUQd2BS0jM5q/c
         XIKK03XqZdmRclXO9vGXaI9EQSR2hIXpkhnf2w9lerka8PvwnfMl7QV2LM70wz6N4q6w
         E575uYC50l4jFsQY5/dHAm2tx18yIMa/DPTdlJdI7GX7TvWdx+qQKjnnLdLQ5sr39RA7
         XvrLhgVMaeYMyBuhNxYKEnM1MPtCH+USovH/3uQAXaMUg4TqKAEWd4hOvC3YRdywxnEW
         h7ybTLyfRkOcRQWdLzdQQVilBP50gyD5smoCBjGUGhFWLSIZauTAu1kOVFR2242JEmh0
         qYzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 085/310] iio: light: rpr0521 poweroff for probe fails
Date: Wed, 11 Apr 2018 20:33:44 +0200
Message-Id: <20180411183625.932290967@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477201959779791?=
X-GMAIL-MSGID: =?utf-8?q?1597477201959779791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>


[ Upstream commit 12d74949133e2450533894ea01ce0c56646ce006 ]

Set sensor measurement off after probe fail in pm_runtime_set_active() or
iio_device_register(). Without this change sensor measurement stays on
even though probe fails on these calls.

This is maybe rare case, but causes constant power drain without any
benefits when it happens. Power drain is 20-500uA, typically 180uA.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/rpr0521.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -510,13 +510,26 @@ static int rpr0521_probe(struct i2c_clie
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		return ret;
+		goto err_poweroff;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	return iio_device_register(indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_pm_disable;
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+err_poweroff:
+	rpr0521_poweroff(data);
+
+	return ret;
 }
 
 static int rpr0521_remove(struct i2c_client *client)
