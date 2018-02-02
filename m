Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225aevIYaZCq5kROQcv6O/hdBAHQrnN75e3tLm88TeTSDCcWc+zyrCycZjQyG2luvRhkHUz3
ARC-Seal: i=1; a=rsa-sha256; t=1517591047; cv=none;
        d=google.com; s=arc-20160816;
        b=fijDV6rsIej1RqrVcReK/tc4h5BvATkGuNSkRgVsnqabSLj06dl3JyiiDoYLXaq8NP
         XkNvvJ/GryT8YyXPub7TRXiKCFHwc/W6EQ76qj2w4oGqpVTNa7MPb7aMR1IND2dPugFG
         j+FbUheYDcH/FgpnZEjYYp49dzAox6zh14YnCGzvKLAiQr7HemCBTVsq6uqpaW0iqVtJ
         YdNIBUxBq1Td2A1de/6GjjgY582M8DLwFfEZOBqPnt2haPk+iMY6ayebaPQi1bdta5Th
         iTkH+PHF4EYN3mSq7LzhLQm7hhJTnDwnmHH2xRXuA00/bQ2WtuTyYjupIF6Nx/gVQshv
         CL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rEfluPzm9qZdfCY9rW8JOdxxYdNUf1eWmme9dOyLORk=;
        b=GSN3wPQB6kYnIXtkRgKNA5opypkTQmPXIsqDZwl3VmLioPwn5WD1dkwBNbjswGbSHw
         za0trQRrFg3MSotWnBpvUV07CCCReD+wV+z5uTK4deZ1F3kARY8LrIANAj8loNmTXxP3
         xkLfNJ3LA2zep0TQmWeWuJB58G/WkOIpWnjW5uShKI/a6hA0duoYWoJvmAiTbcxCnaLV
         bHjf+waDeOWmMwTnSdvgidiWA/2ouwzIjFYTRz/QviQ/SHRpFVMk+PuZQurz0EGoBKrj
         b0crhBcRBRQ2yKjDB24SOd6rjywjYT7mO6eoeo0iRxUQ9zdBJMKj21uz6sG/aUrAqVxA
         HbBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chun-Yeow Yeoh <yeohchunyeow@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 33/86] mac80211: fix the update of path metric for RANN frame
Date: Fri,  2 Feb 2018 17:57:53 +0100
Message-Id: <20180202140825.616241476@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309339525012620?=
X-GMAIL-MSGID: =?utf-8?q?1591309550660127803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -788,7 +788,7 @@ static void hwmp_rann_frame_process(stru
 	struct mesh_path *mpath;
 	u8 ttl, flags, hopcount;
 	const u8 *orig_addr;
-	u32 orig_sn, metric, metric_txsta, interval;
+	u32 orig_sn, new_metric, orig_metric, last_hop_metric, interval;
 	bool root_is_gate;
 
 	ttl = rann->rann_ttl;
@@ -799,7 +799,7 @@ static void hwmp_rann_frame_process(stru
 	interval = le32_to_cpu(rann->rann_interval);
 	hopcount = rann->rann_hopcount;
 	hopcount++;
-	metric = le32_to_cpu(rann->rann_metric);
+	orig_metric = le32_to_cpu(rann->rann_metric);
 
 	/*  Ignore our own RANNs */
 	if (ether_addr_equal(orig_addr, sdata->vif.addr))
@@ -816,7 +816,10 @@ static void hwmp_rann_frame_process(stru
 		return;
 	}
 
-	metric_txsta = airtime_link_metric_get(local, sta);
+	last_hop_metric = airtime_link_metric_get(local, sta);
+	new_metric = orig_metric + last_hop_metric;
+	if (new_metric < orig_metric)
+		new_metric = MAX_METRIC;
 
 	mpath = mesh_path_lookup(sdata, orig_addr);
 	if (!mpath) {
@@ -829,7 +832,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	if (!(SN_LT(mpath->sn, orig_sn)) &&
-	    !(mpath->sn == orig_sn && metric < mpath->rann_metric)) {
+	    !(mpath->sn == orig_sn && new_metric < mpath->rann_metric)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -847,7 +850,7 @@ static void hwmp_rann_frame_process(stru
 	}
 
 	mpath->sn = orig_sn;
-	mpath->rann_metric = metric + metric_txsta;
+	mpath->rann_metric = new_metric;
 	mpath->is_root = true;
 	/* Recording RANNs sender address to send individually
 	 * addressed PREQs destined for root mesh STA */
@@ -867,7 +870,7 @@ static void hwmp_rann_frame_process(stru
 		mesh_path_sel_frame_tx(MPATH_RANN, flags, orig_addr,
 				       orig_sn, 0, NULL, 0, broadcast_addr,
 				       hopcount, ttl, interval,
-				       metric + metric_txsta, 0, sdata);
+				       new_metric, 0, sdata);
 	}
 
 	rcu_read_unlock();
