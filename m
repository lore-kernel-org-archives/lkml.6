Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtVRu/Peds4JNsWidCTvgwVbZsjqjkd+ONRrVvaKfpuDCCUESX0717kwyhB/4jSTWaOu5jl
ARC-Seal: i=1; a=rsa-sha256; t=1521800362; cv=none;
        d=google.com; s=arc-20160816;
        b=ikxTFSaCo5kNPFEkI9seuvNR5b9RoGzyVEhG0o6z8WB7xm/0Qzc67WWOGff9AL3WLb
         sCMvy7Eyr59UmJ/lsBzw4HIUbp6//Ab4rHgtnhbpKNibsIXdHZHpGqJli+cynm/FR5PE
         1osXuQ+BECrJZ/tl67fA6rQFb9Eh+O6HZHLYJ3Mr1hNl5QzOBpFbolEeKgiISJ7hqmE0
         Lf/u0ZJcAlmx8dKAAt8Yn1y5BIl3f8Rbi15CVhvH3BCZvW6PC6BmsjVg5Cs9ER0eFffU
         bCS2OFEkrQv9e6Xn2Qio7m+k1ybTpWW/c3e4tt5njFWswgd6ePUuOBZEATnYWHWBIFme
         NmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sAaMZGBidKpeKjaKbzRyjKTPgzoXuCwdvdkQdXDsW9k=;
        b=y2Y1rMwPjFEvAS2pKts9xiQh6yQxpb1XErRhPtXmdGAJhXee4y8gg4rcp1J1tsXkxS
         zAfdZBMcj4Cv3MtREY/o5QAb6Zs6Ez8bz8Eq21VEdg75kTbKhpFbp7V31fZGmhovcbbB
         1L9v5nEZAX3xLZwNe3RKceZQl+ZWwZD1gjj7A/5uOQgR5Qu2wq/mSX0Igr0qjTfL3TDd
         CGrgFfjhPoa+TWg6bS3JQt6Hw5GdQ356J8C+1zpxxVAHt/oSTa/1nFdRhUpxeojU+3d6
         Hu7AB6F8l40OnvabP5piQE3bHXa1hYQOWaC8vps3ZXj8av4MsWnujFfVAJu142zVnMkY
         lxJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 26/47] mac80211: dont parse encrypted management frames in ieee80211_frame_acked
Date: Fri, 23 Mar 2018 10:55:17 +0100
Message-Id: <20180323094249.235716745@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722641313957230?=
X-GMAIL-MSGID: =?utf-8?q?1595723337132082861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


[ Upstream commit cf147085fdda044622973a12e4e06f1c753ab677 ]

ieee80211_frame_acked is called when a frame is acked by
the peer. In case this is a management frame, we check
if this an SMPS frame, in which case we can update our
antenna configuration.

When we parse the management frame we look at the category
in case it is an action frame. That byte sits after the IV
in case the frame was encrypted. This means that if the
frame was encrypted, we basically look at the IV instead
of looking at the category. It is then theorically
possible that we think that an SMPS action frame was acked
where really we had another frame that was encrypted.

Since the only management frame whose ack needs to be
tracked is the SMPS action frame, and that frame is not
a robust management frame, it will never be encrypted.
The easiest way to fix this problem is then to not look
at frames that were encrypted.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/status.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -194,6 +194,7 @@ static void ieee80211_frame_acked(struct
 	}
 
 	if (ieee80211_is_action(mgmt->frame_control) &&
+	    !ieee80211_has_protected(mgmt->frame_control) &&
 	    mgmt->u.action.category == WLAN_CATEGORY_HT &&
 	    mgmt->u.action.u.ht_smps.action == WLAN_HT_ACTION_SMPS &&
 	    ieee80211_sdata_running(sdata)) {
