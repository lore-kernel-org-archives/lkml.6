Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuQHnwDPPlMRB4e6S/7kBoYERs5uPVVUVKRrIdfmfEq2STE/Vqyum0aCCMc3Tzg35fyXfI4
ARC-Seal: i=1; a=rsa-sha256; t=1521214600; cv=none;
        d=google.com; s=arc-20160816;
        b=eDlqaawQ6w5aKiNZCOZNzXVW3cEOl3UqCchSqcYjNS453iwmuTwo+uTC+NFTzM//XI
         vRZ/iN47xUPa2zBpbuH67YHi+3CL5xLuXRGq7Tpp2f63SfhTA0onSUthxu1pi8kcebn3
         Y4FmV6xUjAjlP8D1s7yvpZzC6QIvIYQ3UKu9bV39goRsuOeDqrkQgK+FNCNQF9vtdHQj
         8LwI792+efwljjiCXRqsmbuazswwrgGXsvDZUT8ZhWncI8VY8k6S5LZDRwDyu80F3OBw
         CuLR8i57OkaBYVGweodme7ZgXZO8EAEE4/g9/7w0yzl3NtEeKXGtUf7m/BCVfiakiZ9Z
         u0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LtJbozyRLNtkmV+igu8ZsF/10Hm+X3XWxD5xImibHZo=;
        b=MxMoDJMKxYvy3xamyICYEpcyJ4yMgTKjuRPdqXEiNFEfrR45mB6GPsHNt00njk7+Hc
         M7mQQ+i9OeBRIio7h+FHL/jLD0HY/c8t7X5n8yQ6Pvw3T4RMow0Ovf50UBo9J0s2FZO4
         jcHhrqznrDhxy8Wld5OKCLMV7CEZUgrxGS1u0/6ISBEg5ETU067pXJ3nPcHaQKaxjfL9
         qpHmKowZ4Azyh0SpSEyF7VMRcA7K+1Lc/OR9G1iSehRZRDQki5z9G2HhCAU/vLQ25cK3
         F8gMZVJ/35QFm2zu644Dw04pUs42TwvUVKVvLRoCGEO85tU//j/OcyM3betv71MFF1l8
         t2sQ==
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
Subject: [PATCH 4.14 062/109] ath10k: update tdls teardown state to target
Date: Fri, 16 Mar 2018 16:23:31 +0100
Message-Id: <20180316152333.334538628@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109120990958333?=
X-GMAIL-MSGID: =?utf-8?q?1595109120990958333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6183,6 +6183,16 @@ static int ath10k_sta_state(struct ieee8
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
