Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs+Tser777nhrFwc4TSUhbcJZWgzScnXT2IdeEYQIg48UjxWZkAoo/d7QVInE0xMhyk2FNT
ARC-Seal: i=1; a=rsa-sha256; t=1521484066; cv=none;
        d=google.com; s=arc-20160816;
        b=cBveYCToOBU9Ul0I1IVfFNb/BHffgqrfE8qmpmL4NgopzPo9sWnStFeODQ26RV3+u2
         ECoV6KT0sh7n3/4YV8HSragXcgT/95ZnCNSuJ9MjffXvJ4j9P6nKy0cf6IeIJMp5tr8N
         byTWuPcGzwqKANcQj1u6LF0qxOqcFCf6vcjY+o62d93rxRWhgyA9BIpqDmjqbA3xdOka
         1Rl8kOEqiEqmMAIUk3OaZ20i0ogtnyzyQCgmTIYt2ZaQklNnw+4QkFrh0s8rozIv/K8u
         84T4SSVLhPTW8Hl0+vqlibWNtzm8yDfSSQ1w0EsHlgB0WkoDqNyDChlcXAeN2JxZXOuY
         KQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b6sG9zROgwf5f2a5zj2CdZVZHQnFGLLQxAaedlWR+Tc=;
        b=kLCi16xfdl3OMJW3/c3mX70NtbKKWFDRzu8my0vd5m6KO6tE3mj6rgXWgDd9ZWGnU/
         GbIuRLAvccbyQ4KUCBCGSrXFcbl2D53IrVLQ4zO7/IW+cqZo2u0fOPUDcdY0kklKvO11
         Tbe7SENakjXnalRpuRZYk6wNiLse1aWsQaJdrMVKhIt9vs1m0HS7ZzqDlPOf60xQgXPY
         jsE3OvKNqxeLbLzr6s9J0vL/eAvQgJX3t+1+HmR6A2H8RLY4GMEan6zSbkrkVFPoMTkQ
         oM1EaSPaRc4o//xVrasxzsYCgGENWQ7aQ13N1vkJ9S4EkovvrMVvBMaIBTo9aFBmVWsj
         HFmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 184/241] ath10k: update tdls teardown state to target
Date: Mon, 19 Mar 2018 19:07:29 +0100
Message-Id: <20180319180758.766531196@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390927706406809?=
X-GMAIL-MSGID: =?utf-8?q?1595391676805710767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>


[ Upstream commit 424ea0d174e82365f85c6770225dba098b8f1d5f ]

It is required to update the teardown state of the peer when
a tdls link with that peer is terminated. This information is
useful for the target to perform some cleanups wrt the tdls peer.

Without proper cleanup, target assumes that the peer is connected and
blocks future connection requests, updating the teardown state of the
peer addresses the problem.

Tested this change on QCA9888 with 10.4-3.5.1-00018 fw version.

Signed-off-by: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6054,6 +6054,16 @@ static int ath10k_sta_state(struct ieee8
 			   "mac vdev %d peer delete %pM sta %pK (sta gone)\n",
 			   arvif->vdev_id, sta->addr, sta);
 
+		if (sta->tdls) {
+			ret = ath10k_mac_tdls_peer_update(ar, arvif->vdev_id,
+							  sta,
+							  WMI_TDLS_PEER_STATE_TEARDOWN);
+			if (ret)
+				ath10k_warn(ar, "failed to update tdls peer state for %pM state %d: %i\n",
+					    sta->addr,
+					    WMI_TDLS_PEER_STATE_TEARDOWN, ret);
+		}
+
 		ret = ath10k_peer_delete(ar, arvif->vdev_id, sta->addr);
 		if (ret)
 			ath10k_warn(ar, "failed to delete peer %pM for vdev %d: %i\n",
