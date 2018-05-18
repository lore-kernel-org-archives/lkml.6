Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqjFydU5Aa0oZz3/5KPty2Nlx36jaJGF+Y6vvQp5VcnaMuv6kKvAYg0o71LKV8YoaZrFZla
ARC-Seal: i=1; a=rsa-sha256; t=1526631701; cv=none;
        d=google.com; s=arc-20160816;
        b=wCHlijaWZqGe3Nf1G6sfgURzU8qqLx6qdnQqDqlnm694Ajjmjj/Bq39bjqt4NTI4wJ
         GzZJZaOBETqnrHNnbbFD/X7wumqTv0X1NgLFT+WFP2Bz5GKvTYU83NOPdbYOofketkCB
         JncUfZE5sN+VADzwsg83rD21oRCoEVhtp9PGpe17BEq6BYyB7YpGbx/Xy6uGM9QZMjt7
         ZoRmG0Ewd4RcjRbFltI6vKWTFIaJMoBwhXlF2HdZNjdvc6Rc9ccsbx6mUXqFNk0rNGf9
         rpOp91AhVmISLzc9p0StkNV1rM1iSDuuChdxxk2emGPsQE9Pbd0+pzVBrVSuWPAnurWu
         Xc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zEQ3ASLjE1F+in1hFglugtCZb8Lj41T0C3rOg+7eRiw=;
        b=bhRQ4wE8nyyrVLyagJv3LEihxxBdTnL2ARvCUw0wozebZFNH3ypE/bd3BT+MKv8mc4
         lDAe97erahaIRnJOUSbp7gHzYOJS0/iW6KM0oWipjbR+wTPtJ9JQ32bnofyLCGusOxi3
         KAuLhUlFOM6IgU3ypZDwJgvnh1Vt+zhJi7mtt1EYuBxYI0EMf2Z1/nS9uZE6hLE0c07H
         q87wBqm36zmA8HptXSRXzHms/AiyQOGwulQNVgg6MOqADmtqqDr8Y/8pp8H8TjKUNf7y
         M14BZYGlBWSfwWAJUsxYcJwWgG4SWWK2H1oK2FR5nAXIY+OJTssWun/zTxWxVYiTcr8l
         gCZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KFJeorpo;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KFJeorpo;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 17/33] sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
Date: Fri, 18 May 2018 10:15:56 +0200
Message-Id: <20180518081535.796055426@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789105798675271?=
X-GMAIL-MSGID: =?utf-8?q?1600789363054731955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 46e16d4b956867013e0bbd7f2bad206f4aa55752 ]

When processing a duplicate cookie-echo chunk, for case 'D', sctp will
not process the param from this chunk. It means old asoc has nothing
to be updated, and the new temp asoc doesn't have the complete info.

So there's no reason to use the new asoc when creating the cookie-ack
chunk. Otherwise, like when auth is enabled for cookie-ack, the chunk
can not be set with auth, and it will definitely be dropped by peer.

This issue is there since very beginning, and we fix it by using the
old asoc instead.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/sm_statefuns.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1959,7 +1959,7 @@ static sctp_disposition_t sctp_sf_do_dup
 		}
 	}
 
-	repl = sctp_make_cookie_ack(new_asoc, chunk);
+	repl = sctp_make_cookie_ack(asoc, chunk);
 	if (!repl)
 		goto nomem;
 
