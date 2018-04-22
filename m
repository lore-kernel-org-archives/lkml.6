Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zJHaVI3m1jexye9tFsgkInxRkfWqdHiBI59GQt6jdsOIhzrmQ1AvubJA4ahuYKBEbUUTU
ARC-Seal: i=1; a=rsa-sha256; t=1524405462; cv=none;
        d=google.com; s=arc-20160816;
        b=H/qkaUsuSn5mTpZPZlpSbnKCYWP1zQ1mo/+KAyv8EdjBFvDTNVonEM2xgwHyqFSmy0
         CYqsGqU9LgEhuGGSbJkgmhIAqTTc5WRjrOGMFI1pLh1k2Z64E8gavGM2Bc85/NvSLqQ1
         mlDUsuXsDMP2ii42FTGW0l8vD1tRaK8Aakau14mWwnLLk/BlKpmHqtIOmtiO4OoE6Ljc
         6bWGy158Fws3pYqvAKmHTe/OeoOUWOuy0totPVT8OvQIWYP1e+rTN2ft7hWIyg2fNXpp
         ypZUiUZoaNerDX0CuKRM9fkXZ1XKdEj5poFQ41lyxcO41CUsyrNRuDxRbrtWPAoc6UlE
         zt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DCOJNu7Pjq1adpFZn2KVgv34ZYj7blhekA491N/TXL8=;
        b=ZMkwsZM4ASJ/aBpblhJV6mocHuq8lstyqlJn+w1fxzCTm0AWax2kzwq0tQ9OQLPXhn
         zs9efNQTZVPCE2YAg9PQpNVJSRkwMaga2+GVCbcoEiTYe0JSnajFwiMEJiqDfzwfTwBW
         nzJkl5VB+ZMwE4JAIDwMEXuPjI05xkDIE6trcYRVnuSl7M0Hz05l90Cln5FV9NV6gOtZ
         6jXUmOAwJjRZer6Wo0qJ5+xlWh2/QykuTTnBW5IwZrXVk5KC7luS9QdZpW/gYeIdyRk+
         oaqf38Hsr8nTn56cts0XlTlEx5xHy1QVYMDxwZ2blAPjulWa5U9zN51jDDBmjNMchr+u
         W5Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.16 074/196] ASoC: topology: Fix kcontrol name string handling
Date: Sun, 22 Apr 2018 15:51:34 +0200
Message-Id: <20180422135108.065623981@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454981902494157?=
X-GMAIL-MSGID: =?utf-8?q?1598454981902494157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

commit 267e2c6fd7ca3d4076d20f9d52d49dc91addfe9d upstream.

Fix the topology kcontrol string handling so that string pointer
references are strdup()ed instead of being copied. This fixes issues
with kcontrol templates on the stack or ones that are freed. Remember
and free the strings too when topology is unloaded.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-topology.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -523,6 +523,7 @@ static void remove_widget(struct snd_soc
 				kfree(se->dobj.control.dtexts[j]);
 
 			kfree(se);
+			kfree(w->kcontrol_news[i].name);
 		}
 		kfree(w->kcontrol_news);
 	} else {
@@ -540,6 +541,7 @@ static void remove_widget(struct snd_soc
 			 */
 			kfree((void *)kcontrol->private_value);
 			snd_ctl_remove(card, kcontrol);
+			kfree(w->kcontrol_news[i].name);
 		}
 		kfree(w->kcontrol_news);
 	}
@@ -1233,7 +1235,9 @@ static struct snd_kcontrol_new *soc_tplg
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
-		kc[i].name = mc->hdr.name;
+		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
+		if (kc[i].name == NULL)
+			goto err_str;
 		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
@@ -1278,8 +1282,10 @@ static struct snd_kcontrol_new *soc_tplg
 err_str:
 	kfree(sm);
 err:
-	for (--i; i >= 0; i--)
+	for (--i; i >= 0; i--) {
 		kfree((void *)kc[i].private_value);
+		kfree(kc[i].name);
+	}
 	kfree(kc);
 	return NULL;
 }
@@ -1310,7 +1316,9 @@ static struct snd_kcontrol_new *soc_tplg
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
 
-		kc[i].name = ec->hdr.name;
+		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
+		if (kc[i].name == NULL)
+			goto err_se;
 		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
@@ -1386,6 +1394,7 @@ err_se:
 			kfree(se->dobj.control.dtexts[j]);
 
 		kfree(se);
+		kfree(kc[i].name);
 	}
 err:
 	kfree(kc);
@@ -1424,7 +1433,9 @@ static struct snd_kcontrol_new *soc_tplg
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
-		kc[i].name = be->hdr.name;
+		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
+		if (kc[i].name == NULL)
+			goto err;
 		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
@@ -1454,8 +1465,10 @@ static struct snd_kcontrol_new *soc_tplg
 	return kc;
 
 err:
-	for (--i; i >= 0; i--)
+	for (--i; i >= 0; i--) {
 		kfree((void *)kc[i].private_value);
+		kfree(kc[i].name);
+	}
 
 	kfree(kc);
 	return NULL;
