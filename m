Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrL/eHe5pg3IlgUrNbTax377zYOFzgXLALqHMuQkv5wPuXET/l3tNnidA7yKDxDWIXzJ/Z5
ARC-Seal: i=1; a=rsa-sha256; t=1526631455; cv=none;
        d=google.com; s=arc-20160816;
        b=thZ5YJYbYJlEfFNUZSmhlrd50jH6GUTrxrWwxV4dFFOeGyQUkvXrvsqP2tPfyDzk12
         PstGVceRhxud7mB48oK06P7Si98mRrQ/D9flKHfugyvUEwvCh9xddFPBrw1EVtYp0xIN
         CmezAyeanQ11BkfVm+CzskTyW7lLJV9hDaP3rFPlNzL8fkurEeYHU2geh3lX6ykIAmkR
         9adTzWsvnnPWbLp5uzH4LEIZd02h6W9BTqmMaBceOJRCTRe4CCCIQFSv1MeywJu5rwHd
         0LDrCs0l/jffJltYxOYW8oQni+nvpRAVbvXKBVbxEVBFqbwmpEU2ikX/4zI7+pGGkECz
         Tpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=zRgJJbOiOuBggiy8obdElCjlQF38fKsCK/mA36qM4Fo=;
        b=Ryc0sUq/A/B1somI3wEiz4k0sJuiuXVkL0O/3Dd5kW8W5zw2DzapDvBH8NR0H/irV/
         67txHULFWo7iiBq/DJFkrZ4SZOK44kSZv/bPUhC3f7QG8znSy8tw4xYKjUzGtOudDItN
         Gwvr6dOy0eVOjimcIWLl5/WLjxSyfaztdm2XArkZisNmYoA3nWb4E4Exxr44HM5o1tz0
         0UxqKvwjo1E9MPWIPQTpyXOxFDvjk2V3FToo1v7yGRCsBEqzUwDIov1RJoWxs0hN1Ayh
         My5DVUxTWsuZT/Lh6DG+qxrPpvphyZekPVx366GSnsvBn9tUfrqfMVsgwyMaAfDoswI5
         Yksg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UQeG1xU4;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UQeG1xU4;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 27/55] sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
Date: Fri, 18 May 2018 10:15:23 +0200
Message-Id: <20180518081458.792343783@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789105798675271?=
X-GMAIL-MSGID: =?utf-8?q?1600789105798675271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2012,7 +2012,7 @@ static enum sctp_disposition sctp_sf_do_
 		}
 	}
 
-	repl = sctp_make_cookie_ack(new_asoc, chunk);
+	repl = sctp_make_cookie_ack(asoc, chunk);
 	if (!repl)
 		goto nomem;
 
