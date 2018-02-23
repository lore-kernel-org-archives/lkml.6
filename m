Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227TJF+qsGOvF1PF0iQCUdXhRDCiJMA27irAqxyssynPu+pTVl6tHffEQ87jnVuZIe7UAJ4P
ARC-Seal: i=1; a=rsa-sha256; t=1519412209; cv=none;
        d=google.com; s=arc-20160816;
        b=OWuOUiYjS7v5cD3kvrqGAQsWziM/LBZ1/S7cOZPOYKW1p0yaDKG9ilRaRU4UBUhI0S
         ++xHVcr4Fmh3YOaV2uZaIQ9nzmx3ZIWsc0TwlGNLjtvVNnCRfy/35G0g8Mx+bTg9Vo3p
         oKgueyQWsTkEkAoWZktpg/wrj4N5lb/amvQUxG4gadeKgJfpg+ZpsoLIpO4zDDH2l5fw
         SBV29JcmJBDJowIZb7H2alFMeMk28jD6ku4+Xe77g4yW09etoSu26UPrjQCtLtufj2i8
         N8YbKbFClxGzJK/AIiD1uZt3giFoZEUei84IoXfKNdgionp0QXjks51FDOK6zmX8zb1q
         UcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nUX8ZZa7c1xfwz40XpDT/pAnUGs369XxAKsgn5H44ZQ=;
        b=KR0iVb6GWDA29amTD2iJEAVl7Crl3+CNSkeYgjOUXZnGZIzyobnNa3tu9wBqFEyStl
         rscYAOw75+ULQXMSm3IGj93JPMiUL5wPLXa9S2Ltmw8BTt58lPGBluN95n6z71YK+gQl
         vA0mf2PRM3k7vLhTzRTRlqXhiRp60FMtPFuXJNPcXIJOXJaQ6cykdhcP4hMsmXfrC7Ux
         6jwhQFVfo8Yunqq70fjvX6dRbOoQ4nL+KF5C0WhXCdaboCxLlPHdwamUMzh1Qxaihp25
         VCey/iG0PfeQAMaVdkxZ++YM8rE6vmgnyqjxGU8XCZaGzsqTMOy45M+ebQTNOio8npVH
         RImg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nogah Frankel <nogahf@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 112/159] net_sched: red: Avoid devision by zero
Date: Fri, 23 Feb 2018 19:27:00 +0100
Message-Id: <20180223170756.883664333@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217654339528451?=
X-GMAIL-MSGID: =?utf-8?q?1593219176410691108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>


[ Upstream commit 5c472203421ab4f928aa1ae9e1dbcfdd80324148 ]

Do not allow delta value to be zero since it is used as a divisor.

Fixes: 8af2a218de38 ("sch_red: Adaptative RED AQM")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/red.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/red.h
+++ b/include/net/red.h
@@ -179,7 +179,7 @@ static inline void red_set_parms(struct
 	p->qth_max	= qth_max << Wlog;
 	p->Wlog		= Wlog;
 	p->Plog		= Plog;
-	if (delta < 0)
+	if (delta <= 0)
 		delta = 1;
 	p->qth_delta	= delta;
 	if (!max_P) {
