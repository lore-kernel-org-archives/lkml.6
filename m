Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscyP4+r5UL+bJbuD3OcUfJja5brcqoUWDiUL8pE4eUT7DmTI4Taxco+tKsoQOIGjgFRqfR
ARC-Seal: i=1; a=rsa-sha256; t=1519981415; cv=none;
        d=google.com; s=arc-20160816;
        b=M7GS28yO3WolW2kHLfksDRYyGi+7tdbkvpKdVAAFOPEfAvrcqzkWxGgtbGVFfs9lz/
         4kQ4YzCFZWzW1ezLMPJ2VHF1mHQw4umZLn7apKxqDPVN6T1mByYt+R/svxDEfrNTGTuj
         x2wK1S4uy7MBnc9jadA9Smr1ew9NaF6fHUhx6xQu0hpWvkiS6z70GRpKO1fPIOddX1B7
         r0MyXLRx8myT6DFXqx3ZbYI0inPKtrPeGWoK1xHaY5Y0SmooL/HYK/UQ/Je8pb4BukVH
         NJlQVDQVpxqthg63YTZz3PwKXHbOf5ZtpMd2J8qh/K0ok755fPVWt4B9hHIRdiI5o7oV
         wDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NpP8TKgwfxW0RWXl8yO7JOO2NJ2UesUxZdc+40Eyfa0=;
        b=nwdZLnNW1xsfKa8vDC22iZ8ewQXSt+4owqtb0xzQc68dcVi0SriTWVrZ0BZobTvlcI
         jjC3gYjfPSGUHYbnRZHBVqSDV1f71BPzBbLrk44SMTX5UIulBSxgqlFHrNrnqrY+zkZD
         fQvdmRJ8pLVF0dzI2dqbpbsmIQXQNadlUsg5W9IYeKFcIPVzpYHWsU1FY9jQeEp5YtkR
         S75OUoctxu232VoEzZRxHvHkILzSKSqa+UCkHz0pX3RhKy/lgkynsEPDEjetApj751BS
         ZS7frAPQDEzJlvLbSOz9fW/84DSnxJ9klFmvPE4WcZv0ImMU+T0BkyjUrDRdjLQFbiY4
         Q90g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hao Chen <flank3rsky@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 084/115] nl80211: Check for the required netlink attribute presence
Date: Fri,  2 Mar 2018 09:51:27 +0100
Message-Id: <20180302084507.249319749@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815690872102850?=
X-GMAIL-MSGID: =?utf-8?q?1593816032136085974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Chen <flank3rsky@gmail.com>


[ Upstream commit 3ea15452ee85754f70f3b9fa1f23165ef2e77ba7 ]

nl80211_nan_add_func() does not check if the required attribute
NL80211_NAN_FUNC_FOLLOW_UP_DEST is present when processing
NL80211_CMD_ADD_NAN_FUNCTION request. This request can be issued
by users with CAP_NET_ADMIN privilege and may result in NULL dereference
and a system crash. Add a check for the required attribute presence.

Signed-off-by: Hao Chen <flank3rsky@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -11301,7 +11301,8 @@ static int nl80211_nan_add_func(struct s
 		break;
 	case NL80211_NAN_FUNC_FOLLOW_UP:
 		if (!tb[NL80211_NAN_FUNC_FOLLOW_UP_ID] ||
-		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID]) {
+		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID] ||
+		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_DEST]) {
 			err = -EINVAL;
 			goto out;
 		}
