Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtBGWv+CnOwj9kqmBewJMLy1MUxiI0YvH+6msRlbNYuHEf2+r/Wc2vIDe7mL440YZojEGkM
ARC-Seal: i=1; a=rsa-sha256; t=1521214954; cv=none;
        d=google.com; s=arc-20160816;
        b=WyBaO6Jz/tRXhgu3cqeAjY0ywaz8F0mxcpJGGsz6tHdcJIUUraLN4SsMrwsxKPbEKd
         yHcGLlHxNFG4RFWMIHyiRi4W14LRWbeRVUnam1sA0V8sstX/ViFjskFgMFuPdpI6H8pb
         0R02lQhvCGEI5oSdEkCFXXMW9hXp20ZQRtCt0OLslyYxqUUGJhV1/Ry7ZtSevimnZFbG
         KqjlPkn5L2ITqSkJG4N+sSrP9hHQJrVZ/gnUXK0gl+Z+LN5iNzhAn68cyrYJRq5tN+G1
         kmp81kI751YcSAno9mjK3oNGTW8u4pMEWLzH7Wx5sWR0YR6UCYAg46aCTzqPfvjo/m+q
         3UnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2lVOVby/CtyFfaha15D1XNgkyu25p90Lhnwgbr6XjvM=;
        b=KiANuu+Tk73oVE8gLAFgGmk23VQWqFAY/4t+49nMX8eoGtqH01Qdg+OV6k2SIRX4g+
         9jkwM6LRqPM8YU+dDQIUpx2zHV42qTK85/ar9T9YLt7cBoK3z3fdjifXsj3dMS2yzpVv
         4Z/iryXvFYvv1EkJB3qxyfcBcaYyo2p4Z5sWFHRti5YL4y9iqGUcHpPH5sUdv6bi1GoF
         l8n6QhuE3Y/EGcHz2AdTHykqzK+8PNzagIIZcBvHEnXkqsTTIxI6saOKLpEku5KX/ovO
         Gy8KCfuIBxOcAs48KVEJMVP0ev/xJa0B/D1aPHZEqeixckC5zWmgKbHA6SqaS+SE/jQ3
         Pqeg==
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
Subject: [PATCH 4.15 075/128] ath10k: update tdls teardown state to target
Date: Fri, 16 Mar 2018 16:23:36 +0100
Message-Id: <20180316152340.426356878@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109120990958333?=
X-GMAIL-MSGID: =?utf-8?q?1595109491934435758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6201,6 +6201,16 @@ static int ath10k_sta_state(struct ieee8
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
