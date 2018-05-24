Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZprf7zHYRTj0TaZ2RNPSMh+tjrjxPRls0VXLl2XDEbjPpUNbYBkEdGp33eMt/vAnjtScHgk
ARC-Seal: i=1; a=rsa-sha256; t=1527156253; cv=none;
        d=google.com; s=arc-20160816;
        b=uuMDgXTbBgcoyADjnO+BKlrbZ0f7xy/KjPPPowYk7jINytoJnoOc1Hd6PtRTGluA0G
         sB1R52UplvvxwnVifHd1wH6ZlGZ1AlMh3wn9KG/zUnZ0LjTBCPOSF+6wHfT++hZeUg/u
         mQ3amPDfNO9jut/dVadoReyV9twTGA0FjzxbOq1TLKeVaNqNcT0ycSECQTK7oLWI5iSv
         FCbkCuJgQ9Z6yZli8lYsghKNSO7UEuIF5gY9CFJVELl3jf3qCwrxrxvDHrfy8P/zcVgZ
         6Nr8NW7CP6b18UMQS+UhAdM2F0G1a+d34HXp+qb2G/JPjt1kFDI86bk8zZnqBTScwMf+
         7/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=gPAqGNlijVQ1BHtRHPUL5pRi7YeKCMppSTSIq/coKAg=;
        b=ooxX0RfLtNRqO9F7M4hTWyrxgeb9lwtC3vFnM3Ij2nW16ifIzT4Sjkb0Ashe3VXBj2
         2vZ3ojaoaMJwSaIN/X/feapKOzuUhi/AcWVAFk+nuP3cqNwXHW+5M74r1qBYFYWDjDwc
         oPsACXzDFYpqLVEtndUi2zxxU9E+MEME6ZW8aCQbRszrOH2a+uRRFF7cWXsq87Sbzldd
         vTTjnOVYiur7bmAgi5I90dXgaxuNUJ0xDWBlQn64Xmifz4IJGue3GFFT1TUVgCDrI6Vq
         5qx8ZiHMQrr6tuD/12E5ARmjowDLPTbGdIIdMB+SyZB/7zyuCVj6TyP2S4am+h+EEhpd
         Jaeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BMiD0zC7;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BMiD0zC7;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 119/161] ASoC: topology: create TLV data for dapm widgets
Date: Thu, 24 May 2018 11:39:04 +0200
Message-Id: <20180524093032.551901841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338592412800180?=
X-GMAIL-MSGID: =?utf-8?q?1601339395666532498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit bde8b3887add8368ecf0ca71117baf2fd56a6fc9 ]

This patch adds the change required to create the TLV data
for dapm widget kcontrols from topology. This also fixes the following
TLV read error shown in amixer while showing the card control contents.
"amixer: Control hw:1 element TLV read error: No such device or address"

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/soc-topology.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1276,6 +1276,9 @@ static struct snd_kcontrol_new *soc_tplg
 			kfree(sm);
 			continue;
 		}
+
+		/* create any TLV data */
+		soc_tplg_create_tlv(tplg, &kc[i], &mc->hdr);
 	}
 	return kc;
 
