Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvm1v4F4TMMs8wjGZYOhcrB2rt3TGN2meX4z1b1Prm95hvYUpUYi4ipPauAzOKtich2c7Le
ARC-Seal: i=1; a=rsa-sha256; t=1519981089; cv=none;
        d=google.com; s=arc-20160816;
        b=ug1GLJEaj8UpDnGBf5Mp869LM1f+5hW4U9lw/G8G9BDB5PUZBxKOPoEnLB3OGmB636
         DcUsNr9UW8Dpr7v3s6SfTLkm37ujComxEC2tBRjaqMwiv454mQnsMNAJS89nRH0k6Ynf
         weEGU5yobE5JpaAOZtC1DPXOL0bNlK5QMPH4c0ZzcO1DG7Zeaj90+sfA9acrZ/5Qk8SX
         FwxmhxonuEE+bQwwihrCNsvOqpSiCpCc5N0tcTEw5RqXIxP/vXQ+UCaabd0q+6Vm3LH4
         l83ViE8cAjXxyW1FjOYEBj11YOANuGUL9i4KzLWL+vL3usAH77hYXMeULPN9Jkm9OfKt
         +G0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3I9goo0zPTTfLZsBq2bI1P9/1RA21OR2hPtHJmauAvo=;
        b=x5C6tKiRFumZE54qUF+iWb4UElTCtgOySij2h6XYf4oYl4qEzLF95o11E3LGndqT3H
         kyTgsoLDKJxqkdJUxADVM3e1aULBTs5gd4T3y0ieN/5bGIQnkG93PvE1NBR9RrAUzVLW
         PoTl/WiDzUfZoewHQ/S11H5BiA9Sjet+g3FpD7pi2vcMT9QguJVHdKY7h4PGQBWSmv2D
         fvJeXVy9HH2KDBLKqftLN1y4vfihAKHGRfc4dngFO5dA4vVjMDi2Pzc2vjt1jKg+uAhi
         3Ou7R30w9ZwCLonfFSYYnoepfXwnfp0vzQ5d8NYUuye+wqy5dj+DG9QtlzbXOJcn5P2W
         QhpA==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 44/56] nl80211: Check for the required netlink attribute presence
Date: Fri,  2 Mar 2018 09:51:30 +0100
Message-Id: <20180302084451.790202702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815690872102850?=
X-GMAIL-MSGID: =?utf-8?q?1593815690872102850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10777,7 +10777,8 @@ static int nl80211_nan_add_func(struct s
 		break;
 	case NL80211_NAN_FUNC_FOLLOW_UP:
 		if (!tb[NL80211_NAN_FUNC_FOLLOW_UP_ID] ||
-		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID]) {
+		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID] ||
+		    !tb[NL80211_NAN_FUNC_FOLLOW_UP_DEST]) {
 			err = -EINVAL;
 			goto out;
 		}
