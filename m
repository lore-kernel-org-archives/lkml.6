Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ejqL4C0LAu7/Iyo0aFqjh4NUv1TmkTm8j2vQ4aq8SVVMH1D9lNXhoBDhvPNXgOqc+mDSR
ARC-Seal: i=1; a=rsa-sha256; t=1517591199; cv=none;
        d=google.com; s=arc-20160816;
        b=HTEisGvvOXgzpFeGV1bkDypPuTMwsQ2mcYyGU2eL5lnXqHbn1p6XUnfihqPt6qJiAj
         7nmgh+A5ABI4QrprcIz4lexE1BddKtlI48As2lWsvTPhxb13PJ7CU37GZewdeGvXzDvq
         moMotWPF88ZEbQxJixExDJJjKjTdoSxf4/wXUqg3qghzjSauuGoonCEtIT3d9v7lTHR0
         9vZP/2AGY0VTBv9zzHQLm2JSmL9JIXvmtZn6S6U0zqXLJuoaLGAHh92rHu0QjXObkPvM
         KUImVuin3t+CldJL2Di2Kk51BsGu13ufhK4LS7Ffwh6cQHQSTMyTmIwDC+mahCjg8E7Y
         jf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A9q+gNfwc81ltM4djc6wOJJ7gs2TeqD+h1+YRcbTvnU=;
        b=GKaLTobf6qw7gLAuMH1hAbXp/3ZVnP/bI2vY1av15tTNqghU54fA3EU7Gv5PDDxhE4
         nx/QqOCC/EufT51HhTocqmXpGTiC1QfjsVuxIsOwcPm0AfgV6rvk5r7rkVGs6FK+HqLl
         3TWPoEK3EyxcG9Rulzr8rNr7C3VbH4poyX5q+UTLdJy2XHUD1R4Zp2ZhHtQnAhDn2Q9Y
         REu+J1x9WI/KysVhhmu3Lp1LW6Hyr9CxtLml3Gfw1JEuIgOh1YV81MlROw6L1yxacF1R
         I+RFtJFwv6bv1siqTwGnG5Rl5SJXXnXIO8y24rUb5s7+XuVVaibD4mwW8q6W2jS7jdNa
         htTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 52/86] SUNRPC: Allow connect to return EHOSTUNREACH
Date: Fri,  2 Feb 2018 17:58:12 +0100
Message-Id: <20180202140827.082398102@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309379764684718?=
X-GMAIL-MSGID: =?utf-8?q?1591309709640625824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 4ba161a793d5f43757c35feff258d9f20a082940 ]

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtsock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2381,6 +2381,7 @@ static void xs_tcp_setup_socket(struct w
 	case -ECONNREFUSED:
 	case -ECONNRESET:
 	case -ENETUNREACH:
+	case -EHOSTUNREACH:
 	case -EADDRINUSE:
 	case -ENOBUFS:
 		/* retry with existing socket, after a delay */
