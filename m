Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsARgtPgWFo2TQYDveTlkbxHgky+5cbWqI6js8W1MOwozt8ScdihDJhdOCObVWEm9hnZqTU
ARC-Seal: i=1; a=rsa-sha256; t=1520451673; cv=none;
        d=google.com; s=arc-20160816;
        b=C3I3Jw5YdENb9LbG77P96kXNqi2FupmZa/URkqbqzAXsujSh22u29HsTpqL+GA1frB
         M7L2F99Q15eGgg9vyPC3PzlAwDGtoSTLv7YSSXFHSjyCx5XkY7kx+zMDGie2W7l9xMjc
         rXUhuMgOBUZ68Y8PgUygckPsSfRTvHpTPHQ/FRdJgH8pTkFi1wF+rbeZhhMoPIUbeIS6
         jfRU4igptLJgKaw7JhhSQIPNAiZfER78mPqpbWxUvR9QjAYY8TBLd2q5++95O0of1iFX
         xl2SJGrzq8rmrZnH0hnH+j1VJxqc/tKYI9W9EwjqojxF2CQVZExmgeq7YLTDiD/M4wPy
         tCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nf0lqoHxdbxfAdRttvwC6inxGs4TJg3hLGm4h4dZ/bQ=;
        b=Xt9PriuXEAcbb2wFZWb+pMctwKDa0Zt5J941g9sBWXsC6FL4tMf6mSoG0MGn5eExcX
         dQlEfP2lk2SABS4Ai9GjbS1nA0eJAeXOt2E6KFAyPa8nh3SRacNfZw2zjkFNEBtpWwDL
         fUgdUEXxo+wvQW0IdYqR83Nb8VCWBS4oYsE+Pg6LF5VRePQeRx/1SNUL1rgvowEeQLq2
         zFQ5DoVpSwtG9hRma2zSUmJrmeHjwM7RUF5VDHb4DfD4ITb/ECzkiHtnVdJT/KupU010
         E1KwP+wtDXLv8QDo23Gjal69xfdF+0KHD6ngm3Ki0S/mwhM8zyxiaxA8bfXfBc/necmv
         LTrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Kapl <code@rkapl.cz>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 048/122] net: sched: report if filter is too large to dump
Date: Wed,  7 Mar 2018 11:37:40 -0800
Message-Id: <20180307191735.949703125@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309134390300102?=
X-GMAIL-MSGID: =?utf-8?q?1594309134390300102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Kapl <code@rkapl.cz>


[ Upstream commit 5ae437ad5a2ed573b1ebb04e0afa70b8869f88dd ]

So far, if the filter was too large to fit in the allocated skb, the
kernel did not return any error and stopped dumping. Modify the dumper
so that it returns -EMSGSIZE when a filter fails to dump and it is the
first filter in the skb. If we are not first, we will get a next chance
with more room.

I understand this is pretty near to being an API change, but the
original design (silent truncation) can be considered a bug.

Note: The error case can happen pretty easily if you create a filter
with 32 actions and have 4kb pages. Also recent versions of iproute try
to be clever with their buffer allocation size, which in turn leads to

Signed-off-by: Roman Kapl <code@rkapl.cz>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_api.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1054,13 +1054,18 @@ static int tc_dump_tfilter(struct sk_buf
 		    nla_get_u32(tca[TCA_CHAIN]) != chain->index)
 			continue;
 		if (!tcf_chain_dump(chain, q, parent, skb, cb,
-				    index_start, &index))
+				    index_start, &index)) {
+			err = -EMSGSIZE;
 			break;
+		}
 	}
 
 	cb->args[0] = index;
 
 out:
+	/* If we did no progress, the error (EMSGSIZE) is real */
+	if (skb->len == 0 && err)
+		return err;
 	return skb->len;
 }
 
