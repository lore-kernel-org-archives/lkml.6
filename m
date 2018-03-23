Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxAjetW1DeFqrE7bmyeZcsqXAZatXmfgbY9EoJrdDPECVNMD+Y/+lwGIX2XNkijb0EaaFt
ARC-Seal: i=1; a=rsa-sha256; t=1521800126; cv=none;
        d=google.com; s=arc-20160816;
        b=IfRpEKMMUwWJXG6ctWxM7tjXgOmJodQ4xt0/uON7Is1vyAGQv4GRPFYuDjxUoINvkH
         oTRXpIrJl5qaEM+BH7IhftMltYynAcbO3R9vFWIerHVbYYZpP+46U+4pNOYpUkGNQoW8
         ALUUhCF0nfbKY6e0GoSXzNosnLzp633OxfNowWCiMVXHR5QihA7dU59x/jF2drHygb2O
         Ona9rU5CZJDHcywnlXn4ahUz7sGryCRpGqRm32xs9p/MLafRlFEIXK4VS6N4dEfHHE34
         plZjOTjSUJ4mU4MI5xw6tjt+90EXqvAv9qTaqWnXXp6fmeXqsSzq3PW7bC2FrqCvFN4A
         h16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n1Tld1bn6SOL5iK3rRvZP9im8zssS7UNURPIatURLL4=;
        b=tSAa40yYYgF2PvDgM5cHtdrNE65DSSupOhat2q6SST+bgVghvBrVoljh+gGtcsPlsG
         YTAy5pD63AMOXrJi8swU3rmDFIjGs0dMDk8MZsfSL1AHOPf7BDKTtmw3TCSi8lI9vftV
         bsdq0cEiiFXoUP1v17TXPtosCtbMKyYLNF6yoQD5qc3HagvDYGWxNJCB90TmADkFrXua
         D1FlohnNucuJT3o0/lYCUr/G79IObMHD6+CfpJthkjrbWagu338TNKCO9cjEXjN+PTVe
         hud/diBF8pvXHyqcpH/X93WzCKktVxFQZeTeFGkuiJwVRsa/ZUzBu/gKqChN/2eyZoRP
         Dd/g==
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
Subject: [PATCH 4.4 50/97] mac80211: dont parse encrypted management frames in ieee80211_frame_acked
Date: Fri, 23 Mar 2018 10:54:37 +0100
Message-Id: <20180323094200.416615735@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722641313957230?=
X-GMAIL-MSGID: =?utf-8?q?1595723089425393229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
