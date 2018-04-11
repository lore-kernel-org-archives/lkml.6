Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+/tqx/XVEGJwqdBr6tcETsldWgrZA0WPb54QjIu4wcDAEfZEGw31Cv8wkuShtsELHA1VBe
ARC-Seal: i=1; a=rsa-sha256; t=1523472200; cv=none;
        d=google.com; s=arc-20160816;
        b=Uim0yaWDkwepDIM+uF+yO8HJv58axooGVN/4HMdh5ofE259wkPTjwQhVqmkSTdJJSr
         hvoNwgCc6pdsSyDsMJHGmZgfOkIM+DuSOSots8lrC+VhsZ10WbdaDoh+u0ShwGAL5ykF
         nwGXtizCxN9QwgwDjxVQ4/ZdfV/2gj39E0QGjj45WRSd6XGB8QD3Wy0wDErM3zkr2QPJ
         NK6FJGhurMxBReuwh9evo9f1aW/huVksv4oLv6wfbo33MmvnOu0Cf9SThWIhAVPnhnyJ
         MJWjL7QZbethbOYJvzAJLQ/et2VHvKXB4037WPZqMVquJGAN8Hqg3Y2W5Lf/WMz77VjF
         Npjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0O/nEOETKV8Vq8jM4zz3ToqryKOl/MQUpiTZi+tiHUE=;
        b=ky4putbVBoAGjY/2AoGuhl0MzArD3Ph46QAShD9CWAgLOtAOe4gClmh4JHlVrkU7Dk
         gJqO3D8m//PG6Umyskqs0o+/8oFjru4aOmNaPNLaTitIJuGJJh1vGMptLUOLwHaK7hnU
         bD4Xj5R5KK3WV0nA0tojonj6hGkvVQ1d/JJjWK0VOjHZyIasw+Xz8f3JczPAnX18aXbb
         28TJjTDEcemml4TsxnLRo1/LiPkFC1xj+OdCVEraBuhl7ylDcIK6WEtkMjJDpgWmVyit
         wJS5njurKvYhJ4zmBjZXfqPrrx4auftnA+4QVieCsPcz7Uw6hy/QJhyqXypk25MJH+/k
         x9TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 089/121] vxlan: dont migrate permanent fdb entries during learn
Date: Wed, 11 Apr 2018 20:36:32 +0200
Message-Id: <20180411183501.888771580@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476386416293891?=
X-GMAIL-MSGID: =?utf-8?q?1597476386416293891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roopa Prabhu <roopa@cumulusnetworks.com>


[ Upstream commit e0090a9e979de5202c7d16c635dea2f005221073 ]

This patch fixes vxlan_snoop to not move permanent fdb entries
on learn events. This is consistent with the bridge fdb
handling of permanent entries.

Fixes: 26a41ae60438 ("vxlan: only migrate dynamic FDB entries")
Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -985,7 +985,7 @@ static bool vxlan_snoop(struct net_devic
 			return false;
 
 		/* Don't migrate static entries, drop packets */
-		if (f->state & NUD_NOARP)
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
 			return true;
 
 		if (net_ratelimit())
