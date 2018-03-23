Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvgyp1Vez88C7EmMDQ7Z5Q5ycx66C4vO612duL2AYCo935Ot6ID+zQR0Fj5U1oJ4SRozh0h
ARC-Seal: i=1; a=rsa-sha256; t=1521800155; cv=none;
        d=google.com; s=arc-20160816;
        b=OxGSjjaEdaB08uCRIvov3L56tYTmu1OYiWcq6MPKOrhV0rOgW27LiHS980Y22fpTdv
         Kn9ctlcHqSWsmrT5qJ3N/pW2DzC4LrF1pztgpiwlWeTej1jW/wJP162E6FAwUV3Fk3hH
         GxRNGSRpZfDoaeXy7Wz1ss70u2sxWz6rms4RgzXr8xAdw3uZV/kYrju8RLSODmOBo11V
         NGzjqSbgLO0t618OCZXNPfo8mrYsPRqoMSRL1hrRrEKtnJ6tBWYfKUwb4oxUKYzQAU13
         ZEDAJ4z//fAlgp5kThBtYhywhp1wBmOXKE1DA3AAb7lpIxNxoVo6oEXxIFPzmPtuGTkN
         bSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wdb4YuCSoOznzY9YyxGaq68f1edZJ9hmUldyNOwy1Yo=;
        b=Bpfizf8LEysiynorOTBEY6j55yPqzAEMHzQRIsVyofMzOpKM3TUlS7kCeQcO+1eXXe
         +AKjnINWcDeBD/UUDKMD1p40MnfVw0dBwhLJF8xO7RHf2ikyT+4H4J1fCEJQbyq22a5z
         dt+86+X6/6R3wmV57YRDFOY9j5Ma3GLWRsqK6EBPqMuqO+FjDSrLUQAGcgw4Abijnh7x
         D5CYthHtnrnuodS7PxtNpNQnQVg6zMUd5qesWABbO6BE6Ga6zD0Sl6h6aDDLuIAPX/CC
         yBxzYrTxQc1HH3662XaUCIT9hKRT687AY03YCJkqVon4HmrI6hc1zzV76Ynfd3vA/TSM
         PdlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 55/97] mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a
Date: Fri, 23 Mar 2018 10:54:42 +0100
Message-Id: <20180323094200.742771593@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722681152507399?=
X-GMAIL-MSGID: =?utf-8?q?1595723119799482951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yangbo lu <yangbo.lu@nxp.com>


[ Upstream commit a627f025eb0534052ff451427c16750b3530634c ]

The ls1046a datasheet specified that the max SD clock frequency
for eSDHC SDR104/HS200 was 167MHz, and the ls1012a datasheet
specified it's 125MHz for ls1012a. So this patch is to add the
limitation.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -418,6 +418,20 @@ static void esdhc_of_set_clock(struct sd
 	if (esdhc->vendor_ver < VENDOR_V_23)
 		pre_div = 2;
 
+	/*
+	 * Limit SD clock to 167MHz for ls1046a according to its datasheet
+	 */
+	if (clock > 167000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1046a-esdhc"))
+		clock = 167000000;
+
+	/*
+	 * Limit SD clock to 125MHz for ls1012a according to its datasheet
+	 */
+	if (clock > 125000000 &&
+	    of_find_compatible_node(NULL, NULL, "fsl,ls1012a-esdhc"))
+		clock = 125000000;
+
 	/* Workaround to reduce the clock frequency for p1010 esdhc */
 	if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
 		if (clock > 20000000)
