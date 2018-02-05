Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226j/HEqGIDbLrlV8JOWaBlFX9Fi8PfRUqnOUpWOhKgeMtfF4Ar3D+0JfBU7P/FcyQ4P1lm1
ARC-Seal: i=1; a=rsa-sha256; t=1517855175; cv=none;
        d=google.com; s=arc-20160816;
        b=hV9MNYPBd9kJDDxFgIWMKMRubg3C1gNS+a8Ccc5Tgywf08v3ceFLFgF0anS6VagQUF
         GldfwCdd2AY/dxjdQdjPVtlEn3MqjiMn5E97ba32hkVVl7AcYVPKlSowjPxrx328wtaN
         3bhib1ycBRqrMBV8Sp4qGdwGV9tZAVmCsr+zpjRgrGoKT/Qs3ME0aU0r84M3KT/iFqZv
         0Ajh9Xf1lp+fnozWxXnVGa4hFygD0XqpPJmcsczX3hPrvNYK82r2lr7hGhyoqv+5KAjy
         SvurSzWLT1wchlRNqDsbRuG4GGRbzZPtXDagEeHTjE8fMfazde6N7vsIehpQRKOKmp6W
         hGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sPaXgRs0+e2nmPmqkYEskZf55YXJOSYg/iycc/xZV3M=;
        b=PVs7wyiPoojAukhtv2alI0VO93TO3xx9Qf42HHICK1M09F/ZdfFuPnfHCAqKOpXCEf
         A0761w8fN6GgCa8rBA/8kmjGcBqev/wDDwkpIFdZJKI+W2ZIFl/Mw5qAJPU0haVdv9QL
         vZ8AiXpzc3RxNHHoQ7i9yGpzCXGRxjoRFCQ7buUWePmBToPUEwcdqM+EDgZK1mCpBRny
         drlGGR2DNecQwdClohRWPov0Ps8I9aMUmV+tcwg2EPa8b/KorzyhKkpbxRQCIbHMSG3L
         XWU+tAJU7/5LQRmszPAx9HpB6nTs62e4FqX7C/5aDIN8HbvuR6oU3bvFZvLPSKpyGqV7
         iJcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chun-Yeow Yeoh <yeohchunyeow@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 13/36] mac80211: fix the update of path metric for RANN frame
Date: Mon,  5 Feb 2018 10:23:41 -0800
Message-Id: <20180205182352.318675842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586508577045984?=
X-GMAIL-MSGID: =?utf-8?q?1591586508577045984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chun-Yeow Yeoh <yeohchunyeow@gmail.com>


[ Upstream commit fbbdad5edf0bb59786a51b94a9d006bc8c2da9a2 ]

The previous path metric update from RANN frame has not considered
the own link metric toward the transmitting mesh STA. Fix this.

Reported-by: Michael65535
Signed-off-by: Chun-Yeow Yeoh <yeohchunyeow@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mesh_hwmp.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -763,7 +763,7 @@ static void hwmp_rann_frame_process(stru
 	struct mesh_path *mpath;
 	u8 ttl, flags, hopcount;
 	const u8 *orig_addr;
-	u32 orig_sn, metric, metric_txsta, interval;
+	u32 orig_sn, new_metric, orig_metric, last_hop_metric, interval;
 	bool root_is_gate;
 
 	ttl = rann->rann_ttl;
@@ -774,7 +774,7 @@ static void hwmp_rann_frame_process(stru
 	interval = le32_to_cpu(rann->rann_interval);
 	hopcount = rann->rann_hopcount;
 	hopcount++;
-	metric = le32_to_cpu(rann->rann_metric);
+	orig_metric = le32_to_cpu(rann->rann_metric);
 
 	/*  Ignore our own RANNs */
 	if (ether_addr_equal(orig_addr, sdata->vif.addr))
@@ -791,7 +791,10 @@ static void hwmp_rann_frame_process(stru
 		return;
 	}
 
-	metric_txsta = airtime_link_metric_get(local, sta);
+	last_hop_metric = airtime_link_metric_get(local, sta);
+	new_metric = orig_metric + last_hop_metric;
+	if (new_metric < orig_metric)
+		new_metric = MAX_METRIC;
 
 	mpath = mesh_path_lookup(sdata, orig_addr);
 	if (!mpath) {
@@ -804,7 +807,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	if (!(SN_LT(mpath->sn, orig_sn)) &&
-	    !(mpath->sn == orig_sn && metric < mpath->rann_metric)) {
+	    !(mpath->sn == orig_sn && new_metric < mpath->rann_metric)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -822,7 +825,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	mpath->sn = orig_sn;
-	mpath->rann_metric = metric + metric_txsta;
+	mpath->rann_metric = new_metric;
 	mpath->is_root = true;
 	/* Recording RANNs sender address to send individually
 	 * addressed PREQs destined for root mesh STA */
@@ -842,7 +845,7 @@ static void hwmp_rann_frame_process(stru
 		mesh_path_sel_frame_tx(MPATH_RANN, flags, orig_addr,
 				       orig_sn, 0, NULL, 0, broadcast_addr,
 				       hopcount, ttl, interval,
-				       metric + metric_txsta, 0, sdata);
+				       new_metric, 0, sdata);
 	}
 
 	rcu_read_unlock();
