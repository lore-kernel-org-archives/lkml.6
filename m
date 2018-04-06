Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NgecT08GAEP3lmJH+nqRzlhMAHSlKALFz2sdcdzGyRMx4709r3p+mo7BrAp+uI/zk3b9t
ARC-Seal: i=1; a=rsa-sha256; t=1523021610; cv=none;
        d=google.com; s=arc-20160816;
        b=XRR5rdPTbNxg1Zcbk2NseQCDKXYdB+2OdoNc5TGdHtziZ58GippjKF12wZbxIyCMbw
         091VrDQAIsSveHwnVy4jgvzOSI5+SHLq7WlNhiomL3NyqlJW2sZ1kquohD6KFI5ydP3N
         Fe2Auw+4/WFmcZnvdnsp8bCawJbVfe/bGzAMG/sKxJ2beqHrK0adeOmghpRxYSFhUmZL
         QnDly2xmU0ghsJK0doIuR4Bc2rMOckGuC8QFx+4IGiRaXF+MRmGAxmq48ByPjzPSbOR6
         9ujyDMWXTHp/6lo+QH9N5SyI3I6YIS5WErR7inPLKmFuIq3pD32nXNwIAoqbaPb5zR+7
         RqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1GbDfhFxzxSylg99QhlImijOb2VjJRMOHfq+TVkvlrY=;
        b=dNxJmfy+Pm1RAJDT/9pHCdzoegcH3iFgu1v70nGk33cysmMKiHhHUE4ALB8cHVClYI
         3bH5KudXaTRpnyJvVk0/tdd4W9eWKrBihYNX9QdWQxU9ckL1SoI0XD7iB54RBdHhHPDA
         1UBvPQfdx992l4cHLJ/ybjyCpMmKG4eYmhBB+E/VR9mQ7EBAo2R6F24GMlKITQXMS+EK
         Y8CKQzxzjccn+1yc0QemYZlqZdC80HMEW28ipu7MKkZv786xIW+8KiI2Txs2mARBdZVo
         X22Wmb+w3xdpuMeFhtz3rZO9bKX7pA1CUimRNHfX9ADv03rWvQZ72/tTS4y5rpUifPmB
         6TyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 026/102] cfg80211: Fix array-bounds warning in fragment copy
Date: Fri,  6 Apr 2018 15:23:07 +0200
Message-Id: <20180406084335.357988224@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003908379333777?=
X-GMAIL-MSGID: =?utf-8?q?1597003908379333777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit aa1702dd162f420bf85ecef0c77686ef0dbc1496 upstream.

__ieee80211_amsdu_copy_frag intentionally initializes a pointer to
array[-1] to increment it later to valid values. clang rightfully
generates an array-bounds warning on the initialization statement.

Initialize the pointer to array[0] and change the algorithm from
increment before to increment after consume.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/util.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -663,7 +663,7 @@ __ieee80211_amsdu_copy_frag(struct sk_bu
 			    int offset, int len)
 {
 	struct skb_shared_info *sh = skb_shinfo(skb);
-	const skb_frag_t *frag = &sh->frags[-1];
+	const skb_frag_t *frag = &sh->frags[0];
 	struct page *frag_page;
 	void *frag_ptr;
 	int frag_len, frag_size;
@@ -676,10 +676,10 @@ __ieee80211_amsdu_copy_frag(struct sk_bu
 
 	while (offset >= frag_size) {
 		offset -= frag_size;
-		frag++;
 		frag_page = skb_frag_page(frag);
 		frag_ptr = skb_frag_address(frag);
 		frag_size = skb_frag_size(frag);
+		frag++;
 	}
 
 	frag_ptr += offset;
@@ -691,12 +691,12 @@ __ieee80211_amsdu_copy_frag(struct sk_bu
 	len -= cur_len;
 
 	while (len > 0) {
-		frag++;
 		frag_len = skb_frag_size(frag);
 		cur_len = min(len, frag_len);
 		__frame_add_frag(frame, skb_frag_page(frag),
 				 skb_frag_address(frag), cur_len, frag_len);
 		len -= cur_len;
+		frag++;
 	}
 }
 
