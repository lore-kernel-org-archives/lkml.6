Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48lYpZtPwR9S4d/19R68oNq+mnaruhAmXXHEAoKXRyOKDBIAK88oh2a23gY6WK55SzGUh90
ARC-Seal: i=1; a=rsa-sha256; t=1523399235; cv=none;
        d=google.com; s=arc-20160816;
        b=o5NLs2A4F/vFgETfWoqz78VO0qFPLCuf7VLb+8ukqDMzdcWYpeb/cnxQtaHzt+wGXn
         5gTEe0C0MKs0EAUGrJnIxEkXUOnRHPg5r/J//PGm9dD7eajjvNARS5AMdtSA8xfoLf3E
         ZgAIzA3Cz+ef86aRmJM6+yaul52RErri5gP5e5nPu45G6PgYNkiJsYcMeuDe0HyO/6Rz
         oawNIoJbBKJH/c/e6F1r7BMLywirWXjU9CXeFAadhaSG6MH7xC26orqdaTpI/UsDdNwL
         z+8z0Z4EJoXaeTnqo/tvPZdeTwyPW2ANspeEYtijWqp/hiiiFPb6iqF1dfnyk1CW2Vmq
         My7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Rb9KpKe0DQnmbjUaxa8sIEn9t05Ya6/KdLLogYNL7fY=;
        b=UKMXfCY3SCbfFU8Q9TK+775Y/RdC/m7CxGogA+Hj0Gb37wVC1wZxzCZSQtgfYoCUqD
         3IFjriW2VDiRzo3V7xQllysV6ZEg5Gl+M9RyDT52hKkRg3pu5SYk07kvBKd4F0Q1Tjdb
         i5AeS3dR78wvi7qVmsfxThIt6AryPkH3qj62MmrGNPEBPjyW+RpxZr9Y5ao0BCPFCBp6
         4AjbXgGZ9ofolQay+7yiV79HDjIueng18/AKTRYbyudaynok7KtQCT2vvIauLy3oEy3I
         eMCvfpyx/YizSoivEkTZTBamX2hSRI6qEW0N5Aqt2pJ5BlofBOW0yJUJMVh10WRv7rvd
         hQBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 016/168] l2tp: fix missing print session offset info
Date: Wed, 11 Apr 2018 00:22:38 +0200
Message-Id: <20180410212800.910643257@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399876281543493?=
X-GMAIL-MSGID: =?utf-8?q?1597399876281543493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>


[ Upstream commit 820da5357572715c6235ba3b3daa2d5b43a1198f ]

Report offset parameter in L2TP_CMD_SESSION_GET command if
it has been configured by userspace

Fixes: 309795f4bec ("l2tp: Add netlink control API for L2TP")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_netlink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -761,6 +761,8 @@ static int l2tp_nl_session_send(struct s
 
 	if ((session->ifname[0] &&
 	     nla_put_string(skb, L2TP_ATTR_IFNAME, session->ifname)) ||
+	    (session->offset &&
+	     nla_put_u16(skb, L2TP_ATTR_OFFSET, session->offset)) ||
 	    (session->cookie_len &&
 	     nla_put(skb, L2TP_ATTR_COOKIE, session->cookie_len,
 		     &session->cookie[0])) ||
