Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+DZPUU0Pjek41BexTnJgubUiJ0jKRIT8vJWCqyiAN4r5ojhmRLRb4tOABxoF06Co5MlHuB
ARC-Seal: i=1; a=rsa-sha256; t=1524405965; cv=none;
        d=google.com; s=arc-20160816;
        b=MJXMg7VR6e5yGOxn/I4VSxvRadWIczahSncKcnuskU4I5kQhyF1e7XxbsdwDQ3JZT3
         i9l/OS6hvMoDP2LtHVrApL7fZsruqtvoiXbCPG4Kesy+R87PN+VBt70czYqtkO8U1F11
         r0hoKpwWkxBtGKCtEIYhoPVTd3yAvODw5WOcf+fB0OI4v5+ZD8epY56GsaVUYicWmbHT
         LgGfRiOaCG8+PosYTRerpjw7r/Hm7x8GhJb8i7JiWMoitisXMO/6mIvXxknS78x7Hl2n
         W3DCJLhHao1M0EOZpLTIU6v1OKH/p02vdB/aUlcMPw1gfCGXPrPpYIi72bkTAFazfeLG
         S5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JOpf24ZMsig7SSoTCHq0oFRMoNh78HOrY6rnmHjcFGY=;
        b=qZK4/WkkAquBjQ1PJhlzU+QWHbF/0hUHTa4Ht3OdNeq9bRtYzLacVLqm4lqXNaPm51
         rtoZdBtSnetl2T22tL7ggFW2Ldi0jIwmt8+lbIPnMQASEMfR4WTd29xZjgluXb3eshY8
         yoxe6bWviXP6IuQNMwOIFXiF4ODF1EI6kOq7hZdR7RGQQKbvvLvoudrO7662v+EfFCXR
         WZBbdw9E/YqIv7Am99NVLWFFLNYSCna5UQAxp9+8aRydp2X7/kirSvNtzsEY9CP4WiMF
         QXNHo39uANo5wp8CjZuPeiU6Cuvup/BnGAZvBp9tTGF8hta8xluMlbcpM1uHHurBB10u
         Nl+w==
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
Subject: [PATCH 4.14 062/164] ASoC: topology: Fix kcontrol name string handling
Date: Sun, 22 Apr 2018 15:52:09 +0200
Message-Id: <20180422135137.987789996@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454981902494157?=
X-GMAIL-MSGID: =?utf-8?q?1598455510478461333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
